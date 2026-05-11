using System;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

public partial class Login : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] != null)
        {
            Response.Redirect("~/Default.aspx");
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid) return;

        string username = txtUsername.Text.Trim();
        string password = txtPassword.Text.Trim();
        
        string hashedPassword = HashPassword(password);

        string sql = @"
            SELECT ua.user_id, ua.employee_id, ua.password_hash, ua.is_locked,
                   e.first_name, e.last_name, e.role
            FROM User_Account ua
            JOIN Employee e ON ua.employee_id = e.employee_id
            WHERE ua.username = @username AND e.is_active = 1";

        SqlParameter[] p = {
            new SqlParameter("@username", username)
        };

        try
        {
            DataTable dt = DbHelper.ExecuteRawQuery(sql, p);

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                bool isLocked = Convert.ToBoolean(row["is_locked"]);

                if (isLocked)
                {
                    lblError.Text = "Account is locked. Please contact the manager.";
                    return;
                }

                string storedHash = row["password_hash"].ToString();

                if (storedHash == hashedPassword)
                {
                    Session["UserID"] = row["user_id"];
                    Session["EmpID"] = row["employee_id"];
                    Session["Username"] = username;
                    Session["FullName"] = row["first_name"].ToString() + " " + row["last_name"].ToString();
                    Session["UserRole"] = row["role"].ToString();

                    Response.Redirect("~/Default.aspx");
                }
                else
                {
                    lblError.Text = "Invalid username or password.";
                }
            }
            else
            {
                lblError.Text = "Invalid username or password.";
            }
        }
        catch (Exception ex)
        {
            try
            {
                string logPath = System.IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "App_Data", "error.log");
                System.IO.Directory.CreateDirectory(System.IO.Path.GetDirectoryName(logPath));
                string entry = string.Format("{0} - Login error: {1}\n{2}\n", DateTime.Now.ToString("u"), ex.Message, ex.StackTrace);
                System.IO.File.AppendAllText(logPath, entry);
            }
            catch { }

            lblError.Text = "A system error occurred. Please try again later.";
        }
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
