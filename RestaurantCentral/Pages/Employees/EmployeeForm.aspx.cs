using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

public partial class Pages_Employees_EmployeeForm : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null || Convert.ToString(Session["UserRole"]) != "Manager")
            Response.Redirect("~/Default.aspx");
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid) return;

        string passwordHash = HashPassword(txtPassword.Text);

        SqlParameter[] p = {
            new SqlParameter("@first_name", txtFirstName.Text.Trim()),
            new SqlParameter("@last_name", txtLastName.Text.Trim()),
            new SqlParameter("@role", ddlRole.SelectedValue),
            new SqlParameter("@phone", txtPhone.Text.Trim()),
            new SqlParameter("@username", txtUsername.Text.Trim()),
            new SqlParameter("@password_hash", passwordHash)
        };

        try
        {
            DbHelper.ExecuteNonQuery("usp_insert_employee", p);
            ucAlert.Message = "Employee and user account created successfully!";
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
        ddlRole.SelectedIndex = 1;
        txtPhone.Text = "";
        txtUsername.Text = "";
    }

    private string HashPassword(string password)
    {
        using (SHA256 sha256 = SHA256.Create())
        {
            byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
            StringBuilder builder = new StringBuilder();
            for (int i = 0; i < bytes.Length; i++)
            {
                builder.Append(bytes[i].ToString("x2"));
            }
            return builder.ToString();
        }
    }
}
