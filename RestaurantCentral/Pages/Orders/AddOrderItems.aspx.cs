using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Orders_AddOrderItems : Page
{
    private int OrderId
    {
        get
        {
            if (Request.QueryString["orderId"] != null)
                return Convert.ToInt32(Request.QueryString["orderId"]);
            return 0;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
            Response.Redirect("~/Login.aspx");

        if (OrderId == 0)
            Response.Redirect("OrderList.aspx");

        if (!IsPostBack)
        {
            litOrderId.Text = OrderId.ToString();
            PopulateMenuItems();
            BindOrderItems();
        }
    }

    private void PopulateMenuItems()
    {
        try
        {
            DataTable dt = DbHelper.ExecuteRawQuery("SELECT menu_item_id, item_name + ' ($' + CAST(regular_price AS VARCHAR) + ')' AS display_name FROM vw_Active_Menu");
            ddlMenuItem.DataSource = dt;
            ddlMenuItem.DataTextField = "display_name";
            ddlMenuItem.DataValueField = "menu_item_id";
            ddlMenuItem.DataBind();
            ddlMenuItem.Items.Insert(0, new ListItem("-- Select Menu Item --", "0"));
        }
        catch (Exception ex)
        {
            ucAlert.Message = "Error loading menu items: " + ex.Message;
            ucAlert.AlertType = "danger";
        }
    }

    private void BindOrderItems()
    {
        try
        {
            string sql = @"SELECT oi.order_item_id, m.item_name, oi.quantity, oi.unit_price, oi.item_notes 
                           FROM Order_Item oi 
                           JOIN Menu_Item m ON oi.menu_item_id = m.menu_item_id 
                           WHERE oi.customer_order_id = @orderId";
            SqlParameter[] p = { new SqlParameter("@orderId", OrderId) };
            DataTable dt = DbHelper.ExecuteRawQuery(sql, p);
            
            rptOrderItems.DataSource = dt;
            rptOrderItems.DataBind();

            btnFinaliseOrder.Enabled = dt.Rows.Count > 0;
        }
        catch (Exception ex)
        {
            ucAlert.Message = "Error loading order items: " + ex.Message;
            ucAlert.AlertType = "danger";
        }
    }

    protected void btnAddItem_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid) return;

        SqlParameter[] p = {
            new SqlParameter("@customer_order_id", OrderId),
            new SqlParameter("@menu_item_id", ddlMenuItem.SelectedValue),
            new SqlParameter("@quantity", txtQuantity.Text),
            new SqlParameter("@item_notes", txtItemNotes.Text.Trim())
        };

        try
        {
            DbHelper.ExecuteNonQuery("usp_add_order_item", p);
            ucAlert.Message = "Item added!";
            ucAlert.AlertType = "success";
            
            ddlMenuItem.SelectedIndex = 0;
            txtQuantity.Text = "1";
            txtItemNotes.Text = "";
            
            BindOrderItems();
        }
        catch (Exception ex)
        {
            ucAlert.Message = "Error adding item: " + ex.Message;
            ucAlert.AlertType = "danger";
        }
    }

    protected void rptOrderItems_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "Remove")
        {
            int orderItemId = Convert.ToInt32(e.CommandArgument);
            string sql = "DELETE FROM Order_Item WHERE order_item_id = @id";
            SqlParameter[] p = { new SqlParameter("@id", orderItemId) };

            try
            {
                DbHelper.ExecuteRawQuery(sql, p);
                BindOrderItems();
            }
            catch (Exception ex)
            {
                ucAlert.Message = "Error removing item: " + ex.Message;
                ucAlert.AlertType = "danger";
            }
        }
    }

    protected void btnFinaliseOrder_Click(object sender, EventArgs e)
    {
        try
        {
            string invoiceNumber = "INV-" + OrderId.ToString() + "-" + DateTime.Now.ToString("mmss");
            SqlParameter[] p = { 
                new SqlParameter("@customer_order_id", OrderId),
                new SqlParameter("@invoice_number", invoiceNumber)
            };
            DbHelper.ExecuteNonQuery("usp_generate_invoice", p);
            
            Response.Redirect("OrderList.aspx");
        }
        catch (Exception ex)
        {
            ucAlert.Message = "Error finalising order: " + ex.Message;
            ucAlert.AlertType = "danger";
        }
    }
}
