using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Employees_EmployeeList : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null || Convert.ToString(Session["UserRole"]) != "Manager")
            Response.Redirect("~/Default.aspx");

        if (!IsPostBack)
        {
            BindGrid();
            BindStaffRepeater();
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

            DataTable dt = DbHelper.ExecuteDataTable("usp_select_employee", p);
            gvEmployees.DataSource = dt;
            gvEmployees.DataBind();
        }
        catch (Exception ex)
        {
            lblError.Text = "Error: " + ex.Message;
        }
    }

    private void BindStaffRepeater()
    {
        try
        {
            DataTable dt = DbHelper.ExecuteRawQuery("SELECT * FROM dbo.fn_AllEmployees()");
            rptStaff.DataSource = dt;
            rptStaff.DataBind();
        }
        catch (Exception) { }
    }

    protected void gvEmployees_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvEmployees.EditIndex = e.NewEditIndex;
        BindGrid();
    }

    protected void gvEmployees_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvEmployees.EditIndex = -1;
        BindGrid();
    }

    protected void gvEmployees_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        int employeeId = Convert.ToInt32(gvEmployees.DataKeys[e.RowIndex].Value);
        GridViewRow row = gvEmployees.Rows[e.RowIndex];

        string firstName = (row.FindControl("txtEditFirst") as TextBox).Text;
        string lastName = (row.FindControl("txtEditLast") as TextBox).Text;
        string role = (row.FindControl("ddlEditRole") as DropDownList).SelectedValue;
        string phone = (row.FindControl("txtEditPhone") as TextBox).Text;
        bool isActive = (row.FindControl("chkEditActive") as CheckBox).Checked;

        if (Session["EmpID"] != null && employeeId == Convert.ToInt32(Session["EmpID"]) && !isActive)
        {
            lblError.Text = "Error: You cannot deactivate your own account.";
            return;
        }

        SqlParameter[] p = {
            new SqlParameter("@employee_id", employeeId),
            new SqlParameter("@first_name", firstName),
            new SqlParameter("@last_name", lastName),
            new SqlParameter("@role", role),
            new SqlParameter("@phone", phone),
            new SqlParameter("@is_active", isActive)
        };

        try
        {
            DbHelper.ExecuteNonQuery("usp_update_employee", p);
            gvEmployees.EditIndex = -1;
            BindGrid();
            BindStaffRepeater();
            lblError.Text = string.Empty;
        }
        catch (SqlException ex)
        {
            lblError.Text = "Update Error: " + ex.Message;
        }
    }

    protected void gvEmployees_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int employeeId = Convert.ToInt32(gvEmployees.DataKeys[e.RowIndex].Value);

        if (Session["EmpID"] != null && employeeId == Convert.ToInt32(Session["EmpID"]))
        {
            lblError.Text = "Error: You cannot delete your own account.";
            return;
        }

        SqlParameter[] p = {
            new SqlParameter("@employee_id", employeeId)
        };

        try
        {
            DbHelper.ExecuteNonQuery("usp_delete_employee", p);
            BindGrid();
            BindStaffRepeater();
            lblError.CssClass = "text-success font-weight-bold d-block mb-3";
            lblError.Text = "Employee deactivated successfully.";
        }
        catch (SqlException ex)
        {
            lblError.Text = "Error: " + ex.Message;
        }
    }

    protected void gvEmployees_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvEmployees.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    protected void chkShowInactive_CheckedChanged(object sender, EventArgs e)
    {
        gvEmployees.PageIndex = 0;
        BindGrid();
    }
}
