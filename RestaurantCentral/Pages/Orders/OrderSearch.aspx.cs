using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Orders_OrderSearch : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null || Convert.ToString(Session["UserRole"]) != "Manager")
            Response.Redirect("~/Default.aspx");
    }

    protected void cvDateRange_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (!string.IsNullOrEmpty(txtFromDate.Text) && !string.IsNullOrEmpty(txtToDate.Text))
        {
            DateTime fromDate, toDate;
            if (DateTime.TryParse(txtFromDate.Text, out fromDate) && DateTime.TryParse(txtToDate.Text, out toDate))
            {
                args.IsValid = fromDate <= toDate;
                return;
            }
        }
        args.IsValid = true;
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            BindSearch();
        }
    }

    private void BindSearch()
    {
        string custLast = txtCustomerLast.Text.Trim();
        string status = ddlStatus.SelectedValue;
        
        DateTime? fromDate = null;
        if (!string.IsNullOrEmpty(txtFromDate.Text))
            fromDate = DateTime.Parse(txtFromDate.Text);
            
        DateTime? toDate = null;
        if (!string.IsNullOrEmpty(txtToDate.Text))
            toDate = DateTime.Parse(txtToDate.Text).AddDays(1).AddTicks(-1);

        SqlParameter[] p = {
            new SqlParameter("@customer_last_name", string.IsNullOrEmpty(custLast) ? (object)DBNull.Value : custLast),
            new SqlParameter("@order_status", string.IsNullOrEmpty(status) ? (object)DBNull.Value : status),
            new SqlParameter("@from_date", fromDate.HasValue ? (object)fromDate.Value : DBNull.Value),
            new SqlParameter("@to_date", toDate.HasValue ? (object)toDate.Value : DBNull.Value)
        };

        try
        {
            DataTable dt = DbHelper.ExecuteDataTable("usp_search_orders", p);
            gvResults.DataSource = dt;
            gvResults.DataBind();
        }
        catch (Exception)
        {
            FallbackSearch(custLast, status, fromDate, toDate);
        }
    }

    private void FallbackSearch(string custLast, string status, DateTime? fromDate, DateTime? toDate)
    {
        string sql = @"
            SELECT co.order_number, c.first_name + ' ' + c.last_name AS customer_name,
                   co.order_status, co.created_at
            FROM Customer_Order co
            JOIN Customer c ON co.customer_id = c.customer_id
            WHERE 1=1";

        if (!string.IsNullOrEmpty(custLast)) sql += " AND c.last_name LIKE '%' + @last + '%'";
        if (!string.IsNullOrEmpty(status)) sql += " AND co.order_status = @status";
        if (fromDate.HasValue) sql += " AND co.created_at >= @from";
        if (toDate.HasValue) sql += " AND co.created_at <= @to";

        try
        {
            SqlParameter[] p = {
                new SqlParameter("@last", custLast),
                new SqlParameter("@status", status),
                new SqlParameter("@from", fromDate.HasValue ? (object)fromDate.Value : DBNull.Value),
                new SqlParameter("@to", toDate.HasValue ? (object)toDate.Value : DBNull.Value)
            };
            
            DataTable dt = DbHelper.ExecuteRawQuery(sql, p);
            gvResults.DataSource = dt;
            gvResults.DataBind();
        }
        catch (Exception) { }
    }

    protected void gvResults_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvResults.PageIndex = e.NewPageIndex;
        BindSearch();
    }
}
