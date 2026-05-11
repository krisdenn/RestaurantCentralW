using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Reports_AccountantPayments : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
            Response.Redirect("~/Login.aspx");

        string role = Convert.ToString(Session["UserRole"]);
        if (role != "Accountant" && role != "Manager")
            Response.Redirect("~/Default.aspx");

        if (!IsPostBack)
        {
            PopulateDropdowns();
            BindGrid();
        }
    }

    private void PopulateDropdowns()
    {
        try
        {
            // Unpaid Invoices (Assuming invoices without completed payments are unpaid)
            string sqlInvoices = @"
                SELECT i.invoice_id, i.invoice_number + ' (Order ' + co.order_number + ') - J$' + CAST(i.total_amount AS VARCHAR) AS display 
                FROM Invoice i 
                JOIN Customer_Order co ON i.customer_order_id = co.customer_order_id 
                WHERE NOT EXISTS (SELECT 1 FROM Payment p WHERE p.invoice_id = i.invoice_id AND p.payment_status = 'Completed')";
            
            DataTable dtInv = DbHelper.ExecuteRawQuery(sqlInvoices);
            ddlInvoice.DataSource = dtInv;
            ddlInvoice.DataTextField = "display";
            ddlInvoice.DataValueField = "invoice_id";
            ddlInvoice.DataBind();
            ddlInvoice.Items.Insert(0, new ListItem("-- Select Invoice --", "0"));

            // Customers
            DataTable dtCust = DbHelper.ExecuteRawQuery("SELECT customer_id, first_name + ' ' + last_name AS name FROM Customer WHERE is_active = 1");
            ddlCustomer.DataSource = dtCust;
            ddlCustomer.DataTextField = "name";
            ddlCustomer.DataValueField = "customer_id";
            ddlCustomer.DataBind();
            ddlCustomer.Items.Insert(0, new ListItem("-- Select Customer --", "0"));
            ddlCustomer.Enabled = true; // Prompt allowed choosing it
        }
        catch (Exception) { }
    }

    protected void ddlInvoice_SelectedIndexChanged(object sender, EventArgs e)
    {
        // Auto-select customer and amount if invoice is chosen
        if (ddlInvoice.SelectedValue != "0")
        {
            try
            {
                string sql = "SELECT co.customer_id, i.total_amount FROM Invoice i JOIN Customer_Order co ON i.customer_order_id = co.customer_order_id WHERE i.invoice_id = @id";
                SqlParameter[] p = { new SqlParameter("@id", ddlInvoice.SelectedValue) };
                DataTable dt = DbHelper.ExecuteRawQuery(sql, p);

                if (dt.Rows.Count > 0)
                {
                    ddlCustomer.SelectedValue = dt.Rows[0]["customer_id"].ToString();
                    txtAmount.Text = Convert.ToDecimal(dt.Rows[0]["total_amount"]).ToString("0.00");
                }
            }
            catch (Exception) { }
        }
    }

    private void BindGrid()
    {
        try
        {
            DataTable dt = DbHelper.ExecuteRawQuery("SELECT * FROM vw_Accountant_Payments");
            gvPayments.DataSource = dt;
            gvPayments.DataBind();
        }
        catch (Exception) { }
    }

    protected void btnRecord_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid) return;

        SqlParameter[] p = {
            new SqlParameter("@invoice_id", ddlInvoice.SelectedValue),
            new SqlParameter("@customer_id", ddlCustomer.SelectedValue),
            new SqlParameter("@method", ddlMethod.SelectedValue),
            new SqlParameter("@amount", Convert.ToDecimal(txtAmount.Text)),
            new SqlParameter("@collected_by", Session["EmpID"])
        };

        try
        {
            DbHelper.ExecuteNonQuery("usp_record_payment", p);
            ucAlert.Message = "Payment recorded successfully!";
            ucAlert.AlertType = "success";
            
            // Refresh
            PopulateDropdowns(); // Removes paid invoice
            txtAmount.Text = "";
            BindGrid();
        }
        catch (Exception ex)
        {
            ucAlert.Message = "Error: " + ex.Message;
            ucAlert.AlertType = "danger";
        }
    }

    protected void gvPayments_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvPayments.PageIndex = e.NewPageIndex;
        BindGrid();
    }
}

