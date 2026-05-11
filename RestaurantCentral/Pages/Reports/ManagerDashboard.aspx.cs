using System;
using System.Data;
using System.Web.UI;

public partial class Pages_Reports_ManagerDashboard : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
            Response.Redirect("~/Login.aspx");

        string role = Convert.ToString(Session["UserRole"]);
        if (role != "Manager" && role != "Accountant")
            Response.Redirect("~/Default.aspx");

        if (!IsPostBack)
        {
            LoadDailySummary();
            LoadFunctionResults();
            LoadTVFData();
        }
    }

    private void LoadDailySummary()
    {
        try
        {
            DataTable dt = DbHelper.ExecuteRawQuery("SELECT * FROM vw_Manager_Daily_Summary");
            gvDailySummary.DataSource = dt;
            gvDailySummary.DataBind();
        }
        catch (Exception) { }
    }

    private void LoadFunctionResults()
    {
        try
        {
            object lowest = DbHelper.ExecuteScalarText("SELECT dbo.fn_GetLowestItemQuantity()");
            if (lowest != null && lowest != DBNull.Value)
            {
                lblLowest.Text = lowest.ToString() + " units remaining";
            }
        }
        catch (Exception) { }
    }

    private void LoadTVFData()
    {
        try
        {
            DataTable customers = DbHelper.ExecuteRawQuery("SELECT * FROM dbo.fn_AllCustomers()");
            gvAllCustomers.DataSource = customers;
            gvAllCustomers.DataBind();

            DataTable staff = DbHelper.ExecuteRawQuery("SELECT * FROM dbo.fn_AllEmployees()");
            gvAllStaff.DataSource = staff;
            gvAllStaff.DataBind();
        }
        catch (Exception) { }
    }
}
