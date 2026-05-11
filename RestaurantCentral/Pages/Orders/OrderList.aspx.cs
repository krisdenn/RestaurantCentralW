using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Orders_OrderList : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
            Response.Redirect("~/Login.aspx");

        string role = Convert.ToString(Session["UserRole"]);
        if (role != "Manager" && role != "Waiter" && role != "Chef")
            Response.Redirect("~/Default.aspx");

        if (!IsPostBack)
        {
            if (role == "Manager" || role == "Waiter")
            {
                hlAddOrder.Visible = true;
                hlSearchOrder.Visible = (role == "Manager");
                litTitle.Text = "Orders Board";
                phReadyOrders.Visible = true;
            }
            else if (role == "Chef")
            {
                litTitle.Text = "Kitchen Queue";
                ConfigureChefColumns();
            }

            BindGrid();
        }
    }

    private void ConfigureChefColumns()
    {
        gvOrders.Columns[1].Visible = false;
        ((BoundField)gvOrders.Columns[1]).DataField = ""; 
        
        gvOrders.Columns[3].Visible = false;
        ((BoundField)gvOrders.Columns[3]).DataField = "";
        
        gvOrders.Columns[5].Visible = true;
        gvOrders.Columns[6].Visible = true;
        gvOrders.Columns[7].Visible = true;
    }

    private void BindGrid()
    {
        string role = Convert.ToString(Session["UserRole"]);
        
        try
        {
            if (role == "Chef")
            {
                DataTable dt = DbHelper.ExecuteRawQuery("SELECT * FROM vw_Chef_Queue");
                gvOrders.DataSource = dt;
                gvOrders.DataBind();
                phReadyOrders.Visible = false;
                h4AllOrders.InnerText = "Kitchen Queue";
            }
            else
            {
                DataTable all = DbHelper.ExecuteRawQuery("SELECT * FROM vw_Waiter_Board");
                
                DataView dvReady = new DataView(all);
                dvReady.RowFilter = "order_status = 'Ready'";
                gvReadyOrders.DataSource = dvReady;
                gvReadyOrders.DataBind();

                DataView dvOther = new DataView(all);
                dvOther.RowFilter = "order_status <> 'Ready'";
                gvOrders.DataSource = dvOther;
                gvOrders.DataBind();
                
                phReadyOrders.Visible = true;
                h4AllOrders.InnerText = "Active Orders Board";
            }
        }
        catch (Exception ex)
        {
            lblError.Text = "Error loading orders: " + ex.Message;
        }
    }

    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        BindGrid();
    }

    protected void gvOrders_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvOrders.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    protected void gvOrders_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string status = DataBinder.Eval(e.Row.DataItem, "order_status").ToString();
            DropDownList ddl = (DropDownList)e.Row.FindControl("ddlStatus");
            if (ddl != null && ddl.Items.FindByValue(status) != null)
            {
                ddl.SelectedValue = status;
            }
        }
    }

    protected void btnUpdateStatus_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        
        int orderId = Convert.ToInt32(btn.CommandArgument);
        DropDownList ddlStatus = (DropDownList)row.FindControl("ddlStatus");
        string newStatus = ddlStatus.SelectedValue;

        SqlParameter[] p = {
            new SqlParameter("@customer_order_id", orderId),
            new SqlParameter("@new_status", newStatus),
            new SqlParameter("@triggered_by", Session["EmpID"])
        };

        try
        {
            DbHelper.ExecuteNonQuery("usp_update_order_status", p);
            BindGrid();
            lblError.Text = string.Empty;
        }
        catch (Exception ex)
        {
            lblError.Text = "Failed to update status: " + ex.Message;
        }
    }

    protected void gvOrders_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string role = Convert.ToString(Session["UserRole"]);
        if (role != "Manager" && role != "Waiter")
        {
            lblError.Text = "Only Managers and Waiters can delete orders.";
            return;
        }

        GridView gv = (GridView)sender;
        int orderId = Convert.ToInt32(gv.DataKeys[e.RowIndex].Value);

        SqlParameter[] p = {
            new SqlParameter("@customer_order_id", orderId)
        };

        try
        {
            DbHelper.ExecuteNonQuery("usp_delete_order", p);
            BindGrid();
            lblError.CssClass = "text-success font-weight-bold d-block mb-3";
            lblError.Text = "Order deleted successfully.";
        }
        catch (Exception ex)
        {
            lblError.CssClass = "text-danger font-weight-bold d-block mb-3";
            lblError.Text = "Failed to delete order: " + ex.Message;
        }
    }

    protected void btnDeliver_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        int orderId = Convert.ToInt32(btn.CommandArgument);

        SqlParameter[] p = {
            new SqlParameter("@customer_order_id", orderId),
            new SqlParameter("@new_status", "Delivered"),
            new SqlParameter("@triggered_by", Session["EmpID"])
        };

        try
        {
            DbHelper.ExecuteNonQuery("usp_update_order_status", p);
            BindGrid();
            lblError.Text = string.Empty;
        }
        catch (Exception ex)
        {
            lblError.Text = "Failed to mark as delivered: " + ex.Message;
        }
    }
}
