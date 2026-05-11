using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Orders_OrderForm : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
            Response.Redirect("~/Login.aspx");

        string role = Convert.ToString(Session["UserRole"]);
        if (role != "Manager" && role != "Waiter")
            Response.Redirect("~/Default.aspx");

        if (!IsPostBack)
        {
            PopulateDropdowns();
        }
    }

    private void PopulateDropdowns()
    {
        try
        {
            DataTable dtCust = DbHelper.ExecuteRawQuery("SELECT customer_id, first_name + ' ' + last_name AS name FROM Customer WHERE is_active = 1");
            ddlCustomer.DataSource = dtCust;
            ddlCustomer.DataTextField = "name";
            ddlCustomer.DataValueField = "customer_id";
            ddlCustomer.DataBind();
            ddlCustomer.Items.Insert(0, new ListItem("-- Select Customer --", "0"));

            DataTable dtTable = DbHelper.ExecuteRawQuery("SELECT dining_table_id, 'Table ' + CAST(table_number AS VARCHAR) + ' (Seats ' + CAST(seat_capacity AS VARCHAR) + ')' AS t_name FROM Dining_Table WHERE is_available = 1");
            ddlTable.DataSource = dtTable;
            ddlTable.DataTextField = "t_name";
            ddlTable.DataValueField = "dining_table_id";
            ddlTable.DataBind();
            ddlTable.Items.Insert(0, new ListItem("-- Select Table --", "0"));

            DataTable dtChef = DbHelper.ExecuteRawQuery("SELECT employee_id, first_name + ' ' + last_name AS name FROM Employee WHERE role = 'Chef' AND is_active = 1");
            ddlChef.DataSource = dtChef;
            ddlChef.DataTextField = "name";
            ddlChef.DataValueField = "employee_id";
            ddlChef.DataBind();
            ddlChef.Items.Insert(0, new ListItem("-- Assign Chef --", "0"));
        }
        catch (Exception ex)
        {
            ucAlert.Message = "Could not load form data: " + ex.Message;
            ucAlert.AlertType = "danger";
        }
    }

    protected void btnCreateOrder_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid) return;

        string orderNumber = "ORD-" + DateTime.Now.ToString("yyyyMMddHHmmss");

        SqlParameter[] p = {
            new SqlParameter("@order_number", orderNumber),
            new SqlParameter("@customer_id", ddlCustomer.SelectedValue),
            new SqlParameter("@dining_table_id", ddlTable.SelectedValue),
            new SqlParameter("@waiter_id", Session["EmpID"]),
            new SqlParameter("@chef_id", ddlChef.SelectedValue)
        };

        try
        {
            object objId = DbHelper.ExecuteScalar("usp_place_order", p);

            if (objId != null && objId != DBNull.Value)
            {
                Response.Redirect("AddOrderItems.aspx?orderId=" + objId.ToString());
            }
            else
            {
                ucAlert.Message = "Order created, but could not retrieve ID.";
                ucAlert.AlertType = "warning";
            }
        }
        catch (Exception ex)
        {
            ucAlert.Message = "Error creating order: " + ex.Message;
            ucAlert.AlertType = "danger";
        }
    }
}
