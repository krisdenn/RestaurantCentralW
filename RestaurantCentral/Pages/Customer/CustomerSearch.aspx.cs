using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Customer_CustomerSearch : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
            Response.Redirect("~/Login.aspx");

        string role = Convert.ToString(Session["UserRole"]);
        if (role != "Manager" && role != "Waiter")
            Response.Redirect("~/Default.aspx");
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindNameSearch();
    }

    private void BindNameSearch()
    {
        SqlParameter[] p = {
            new SqlParameter("@first_name", string.IsNullOrEmpty(txtSearchFirst.Text) ? (object)DBNull.Value : txtSearchFirst.Text.Trim()),
            new SqlParameter("@last_name",  string.IsNullOrEmpty(txtSearchLast.Text)  ? (object)DBNull.Value : txtSearchLast.Text.Trim())
        };

        try
        {
            DataTable dt = DbHelper.ExecuteDataTable("usp_select_customer", p);
            gvResults.DataSource = dt;
            gvResults.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    protected void gvResults_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvResults.PageIndex = e.NewPageIndex;
        BindNameSearch();
    }

    protected void btnBirthRange_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid) return;

        string sql = "SELECT * FROM dbo.fn_CustomersByBirthRange(@range1, @range2)";
        SqlParameter[] p2 = {
            new SqlParameter("@range1", DateTime.Parse(txtDOBFrom.Text)),
            new SqlParameter("@range2", DateTime.Parse(txtDOBTo.Text))
        };

        try
        {
            DataTable dt2 = DbHelper.ExecuteRawQuery(sql, p2);
            rptBirthResults.DataSource = dt2;
            rptBirthResults.DataBind();
        }
        catch (Exception ex)
        {
        }
    }
}
