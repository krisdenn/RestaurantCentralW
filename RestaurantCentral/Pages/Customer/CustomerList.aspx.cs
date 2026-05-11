using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Customer_CustomerList : Page
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
            BindGrid();
            BindSummaryGrid();
        }
    }

    private void BindGrid()
    {
        try
        {
            SqlParameter[] p = null;
            if (!chkShowInactive.Checked)
            {
                p = new SqlParameter[] { new SqlParameter("@is_active", 1) };
            }

            DataTable dt = DbHelper.ExecuteDataTable("usp_select_customer", p);
            gvCustomers.DataSource = dt;
            gvCustomers.DataBind();
            lblCount.Text = string.Format("Showing {0} customers", dt.Rows.Count);
        }
        catch (Exception ex)
        {
            lblError.CssClass = "text-danger font-weight-bold d-block mb-3";
            lblError.Text = "Error loading customers: " + ex.Message;
        }
    }

    private void BindSummaryGrid()
    {
        try
        {
            DataTable all = DbHelper.ExecuteRawQuery("SELECT * FROM dbo.fn_AllCustomers()");
            gvAllCustomers.DataSource = all;
            gvAllCustomers.DataBind();
        }
        catch (Exception)
        {
        }
    }

    protected void gvCustomers_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvCustomers.EditIndex = e.NewEditIndex;
        BindGrid();
    }

    protected void gvCustomers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvCustomers.EditIndex = -1;
        BindGrid();
    }

    protected void gvCustomers_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        int customerId = Convert.ToInt32(gvCustomers.DataKeys[e.RowIndex].Value);
        GridViewRow row = gvCustomers.Rows[e.RowIndex];

        string firstName = (row.FindControl("txtEditFirstName") as TextBox).Text;
        string lastName = (row.FindControl("txtEditLastName") as TextBox).Text;
        string email = (row.Cells[3].Controls[0] as TextBox).Text.Trim();
        string contact = (row.Cells[4].Controls[0] as TextBox).Text.Trim();

        SqlParameter[] p = {
            new SqlParameter("@customer_id", customerId),
            new SqlParameter("@first_name", firstName),
            new SqlParameter("@last_name", lastName),
            new SqlParameter("@email", string.IsNullOrEmpty(email) ? (object)DBNull.Value : email),
            new SqlParameter("@contact_number", string.IsNullOrEmpty(contact) ? (object)DBNull.Value : contact)
        };

        try
        {
            DbHelper.ExecuteNonQuery("usp_update_customer", p);
            gvCustomers.EditIndex = -1;
            BindGrid();
            lblError.Text = string.Empty;
        }
        catch (SqlException ex)
        {
            lblError.Text = "Update Error: " + ex.Message;
        }
    }

    protected void gvCustomers_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int customerId = Convert.ToInt32(gvCustomers.DataKeys[e.RowIndex].Value);

        SqlParameter[] p = {
            new SqlParameter("@customer_id", customerId)
        };

        try
        {
            DbHelper.ExecuteNonQuery("usp_delete_customer", p);
            BindGrid();
            lblError.CssClass = "text-success font-weight-bold d-block mb-3";
            lblError.Text = "Customer deactivated successfully.";
        }
        catch (SqlException ex)
        {
            lblError.CssClass = "text-danger font-weight-bold d-block mb-3";
            lblError.Text = "Error: " + ex.Message;
        }
    }

    protected void gvCustomers_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvCustomers.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    protected void chkShowInactive_CheckedChanged(object sender, EventArgs e)
    {
        gvCustomers.PageIndex = 0;
        BindGrid();
    }
}
