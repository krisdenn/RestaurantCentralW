using System;
using System.Web.UI;

public partial class UserControls_NavMenu : UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] != null)
        {
            pnlGuest.Visible = false;
            pnlLoggedIn.Visible = true;
            
            litUserName.Text = Convert.ToString(Session["FullName"]);
            string role = Convert.ToString(Session["UserRole"]);
            litRole.Text = role;
            
            pnlManager.Visible = (role == "Manager");
            pnlWaiter.Visible = (role == "Waiter");
            pnlChef.Visible = (role == "Chef");
            pnlAccountant.Visible = (role == "Accountant");
        }
        else
        {
            pnlGuest.Visible = true;
            pnlLoggedIn.Visible = false;
            pnlManager.Visible = false;
            pnlWaiter.Visible = false;
            pnlChef.Visible = false;
            pnlAccountant.Visible = false;
        }
    }
}

