using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Menu_MenuSearch : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
            Response.Redirect("~/Login.aspx");

        if (!IsPostBack)
        {
            PopulateCategories();
        }
    }

    private void PopulateCategories()
    {
        try
        {
            DataTable dt = DbHelper.ExecuteRawQuery("SELECT category_id, category_name FROM Menu_Category");
            ddlSearchCategory.DataSource = dt;
            ddlSearchCategory.DataTextField = "category_name";
            ddlSearchCategory.DataValueField = "category_id";
            ddlSearchCategory.DataBind();
            
            ddlSearchCategory.Items.Insert(0, new ListItem("-- All Categories --", "0"));
        }
        catch (Exception) { }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindSearch();
    }

    private void BindSearch()
    {
        string name = txtSearchName.Text.Trim();
        int catId = Convert.ToInt32(ddlSearchCategory.SelectedValue);
        bool availOnly = chkAvailableOnly.Checked;

        SqlParameter[] p = {
            new SqlParameter("@item_name", string.IsNullOrEmpty(name) ? (object)DBNull.Value : name),
            new SqlParameter("@category_id", catId == 0 ? (object)DBNull.Value : catId),
            new SqlParameter("@is_available", availOnly ? (object)true : (object)DBNull.Value)
        };

        try
        {
            DataTable dt = DbHelper.ExecuteDataTable("usp_select_menu_item", p);
            gvResults.DataSource = dt;
            gvResults.DataBind();
        }
        catch (Exception)
        {
            FallbackSearch(name, catId, availOnly);
        }
    }

    private void FallbackSearch(string name, int catId, bool availOnly)
    {
        string sql = @"SELECT mi.menu_item_id, mi.item_name, mc.category_name, 
                       mi.item_cost AS regular_price, mi.item_quantity, mi.is_available 
                       FROM Menu_Item mi 
                       JOIN Menu_Category mc ON mi.category_id = mc.category_id 
                       WHERE 1=1";
        
        if (!string.IsNullOrEmpty(name)) sql += " AND mi.item_name LIKE '%' + @name + '%'";
        if (catId > 0) sql += " AND mi.category_id = @cat";
        if (availOnly) sql += " AND mi.is_available = 1";

        try
        {
            SqlParameter[] p = {
                new SqlParameter("@name", name),
                new SqlParameter("@cat", catId)
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
