using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Menu_MenuList : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
            Response.Redirect("~/Login.aspx");

        if (!IsPostBack)
        {
            string role = Convert.ToString(Session["UserRole"]);
            if (role == "Manager")
            {
                hlAddMenu.Visible = true;
            }
            
            PopulateCategories();
            BindGrid();
        }
    }

    private void PopulateCategories()
    {
        try
        {
            DataTable dt = DbHelper.ExecuteRawQuery("SELECT category_id, category_name FROM Menu_Category");
            ddlCategoryFilter.DataSource = dt;
            ddlCategoryFilter.DataTextField = "category_name";
            ddlCategoryFilter.DataValueField = "category_id";
            ddlCategoryFilter.DataBind();
            
            ddlCategoryFilter.Items.Insert(0, new ListItem("All Categories", ""));
        }
        catch (Exception) { }
    }

    private void BindGrid()
    {
        try
        {
            string sql = @"SELECT mi.menu_item_id, mi.item_name, mc.category_name, 
                           mi.item_cost AS regular_price, mi.item_quantity, mi.is_available 
                           FROM Menu_Item mi 
                           JOIN Menu_Category mc ON mi.category_id = mc.category_id";
            
            if (!string.IsNullOrEmpty(ddlCategoryFilter.SelectedValue))
            {
                sql += " WHERE mi.category_id = @catId";
                SqlParameter[] p = { new SqlParameter("@catId", ddlCategoryFilter.SelectedValue) };
                DataTable dt = DbHelper.ExecuteRawQuery(sql, p);
                gvMenu.DataSource = dt;
            }
            else
            {
                DataTable dt = DbHelper.ExecuteRawQuery(sql);
                gvMenu.DataSource = dt;
            }
            
            gvMenu.DataBind();
        }
        catch (Exception ex)
        {
            lblError.Text = "Error: " + ex.Message;
        }
    }

    protected void ddlCategoryFilter_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGrid();
    }

    protected void gvMenu_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string role = Convert.ToString(Session["UserRole"]);
            if (role != "Manager")
            {
                int cmdIndex = gvMenu.Columns.Count - 1;
                e.Row.Cells[cmdIndex].Visible = false;
                gvMenu.Columns[cmdIndex].Visible = false;
            }
        }
    }

    protected void gvMenu_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvMenu.EditIndex = e.NewEditIndex;
        BindGrid();
    }

    protected void gvMenu_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvMenu.EditIndex = -1;
        BindGrid();
    }

    protected void gvMenu_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        int itemId = Convert.ToInt32(gvMenu.DataKeys[e.RowIndex].Value);
        GridViewRow row = gvMenu.Rows[e.RowIndex];

        string itemName = (row.FindControl("txtEditName") as TextBox).Text.Trim();
        decimal price = Convert.ToDecimal((row.FindControl("txtEditPrice") as TextBox).Text);
        int qty = Convert.ToInt32((row.FindControl("txtEditQty") as TextBox).Text);
        bool isAvailable = (row.FindControl("chkEditAvailable") as CheckBox).Checked;

        string sql = "UPDATE Menu_Item SET item_name = @name, item_cost = @price, item_quantity = @qty, is_available = @avail WHERE menu_item_id = @id";
        
        SqlParameter[] p = {
            new SqlParameter("@id", itemId),
            new SqlParameter("@name", itemName),
            new SqlParameter("@price", price),
            new SqlParameter("@qty", qty),
            new SqlParameter("@avail", isAvailable)
        };

        try
        {
            DbHelper.ExecuteRawQuery(sql, p); 
            gvMenu.EditIndex = -1;
            BindGrid();
        }
        catch (Exception ex)
        {
            lblError.Text = "Update Error: " + ex.Message;
        }
    }

    protected void gvMenu_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int itemId = Convert.ToInt32(gvMenu.DataKeys[e.RowIndex].Value);
        string sql = "DELETE FROM Menu_Item WHERE menu_item_id = @id";
        SqlParameter[] p = { new SqlParameter("@id", itemId) };

        try
        {
            DbHelper.ExecuteRawQuery(sql, p);
            BindGrid();
        }
        catch (Exception)
        {
            lblError.Text = "Cannot delete menu item, it might be tied to orders.";
        }
    }

    protected void gvMenu_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvMenu.PageIndex = e.NewPageIndex;
        BindGrid();
    }
}
