using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Menu_MenuForm : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null || Convert.ToString(Session["UserRole"]) != "Manager")
            Response.Redirect("~/Default.aspx");

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
            ddlCategory.DataSource = dt;
            ddlCategory.DataTextField = "category_name";
            ddlCategory.DataValueField = "category_id";
            ddlCategory.DataBind();
            
            ddlCategory.Items.Insert(0, new ListItem("-- Select Category --", "0"));
        }
        catch (Exception) { }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid) return;

        SqlParameter[] p = {
            new SqlParameter("@category_id", ddlCategory.SelectedValue),
            new SqlParameter("@item_name", txtItemName.Text.Trim()),
            new SqlParameter("@description", txtDescription.Text.Trim()),
            new SqlParameter("@item_cost", Convert.ToDecimal(txtPrice.Text)),
            new SqlParameter("@item_quantity", Convert.ToInt32(txtQuantity.Text)),
            new SqlParameter("@image_path", "default.png")
        };

        try
        {
            DbHelper.ExecuteNonQuery("usp_insert_menu_item", p);
            ucAlert.Message = "Menu item added successfully!";
            ucAlert.AlertType = "success";
            ClearForm();
        }
        catch (SqlException ex)
        {
            ucAlert.Message = "Error: " + ex.Message;
            ucAlert.AlertType = "danger";
        }
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        ClearForm();
        ucAlert.Message = "";
    }

    private void ClearForm()
    {
        ddlCategory.SelectedIndex = 0;
        txtItemName.Text = "";
        txtDescription.Text = "";
        txtPrice.Text = "";
        txtQuantity.Text = "";
    }

    protected void btnSearchRange_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(txtMinPrice.Text) || string.IsNullOrEmpty(txtMaxPrice.Text))
            return;

        decimal min = Convert.ToDecimal(txtMinPrice.Text);
        decimal max = Convert.ToDecimal(txtMaxPrice.Text);

        string sql = "SELECT * FROM dbo.fn_MenuItemsByCostRange(@min, @max)";
        SqlParameter[] p = {
            new SqlParameter("@min", min),
            new SqlParameter("@max", max)
        };

        try
        {
            DataTable dt = DbHelper.ExecuteRawQuery(sql, p);
            rptPriceRange.DataSource = dt;
            rptPriceRange.DataBind();
        }
        catch (Exception) { }
    }
}
