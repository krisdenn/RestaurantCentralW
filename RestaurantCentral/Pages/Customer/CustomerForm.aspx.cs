using System;
using System.Data.SqlClient;
using System.Web.UI;

public partial class Pages_Customer_CustomerForm : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
            Response.Redirect("~/Login.aspx");

        string role = Convert.ToString(Session["UserRole"]);
        if (role != "Manager" && role != "Waiter")
            Response.Redirect("~/Default.aspx");
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid) return;

        SqlParameter[] p = {
            new SqlParameter("@first_name", txtFirstName.Text.Trim()),
            new SqlParameter("@last_name", txtLastName.Text.Trim()),
            new SqlParameter("@email", string.IsNullOrEmpty(txtEmail.Text) ? (object)DBNull.Value : txtEmail.Text.Trim()),
            new SqlParameter("@contact_number", string.IsNullOrEmpty(txtContact.Text) ? (object)DBNull.Value : txtContact.Text.Trim()),
            new SqlParameter("@address", string.IsNullOrEmpty(txtAddress.Text) ? (object)DBNull.Value : txtAddress.Text.Trim()),
            new SqlParameter("@date_of_birth", string.IsNullOrEmpty(txtDOB.Text) ? (object)DBNull.Value : DateTime.Parse(txtDOB.Text)),
            new SqlParameter("@is_registered", ddlRegistered.SelectedValue == "1")
        };

        try
        {
            DbHelper.ExecuteNonQuery("usp_insert_customer", p);
            ucAlert.Message = "Customer added successfully!";
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
        txtFirstName.Text = "";
        txtLastName.Text = "";
        txtEmail.Text = "";
        txtContact.Text = "";
        txtAddress.Text = "";
        txtDOB.Text = "";
        ddlRegistered.SelectedIndex = 0;
    }
}
