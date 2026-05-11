using System;
using System.Data.SqlClient;
using System.Web.UI;

public partial class _Default : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }

        if (!IsPostBack)
        {
            litWelcomeName.Text = Convert.ToString(Session["FullName"]);
            
            LoadDashboardMetrics();
            SetRoleCards();
        }
    }

    private void LoadDashboardMetrics()
    {
        try
        {
            string sql2 = "SELECT dbo.fn_GetLowestItemQuantity()";
            object lowest = DbHelper.ExecuteScalarText(sql2);
            if (lowest != null && lowest != DBNull.Value)
            {
                int lowestQty = Convert.ToInt32(lowest);
                if (lowestQty < 5)
                {
                    litLowestQuantity.Text = lowestQty + " units remaining.";
                    pnlStockWarning.Visible = true;
                }
            }
        }
        catch (Exception)
        {
        }
    }

    private void SetRoleCards()
    {
        string role = Convert.ToString(Session["UserRole"]);
        
        pnlManagerCards.Visible = (role == "Manager");
        pnlWaiterCards.Visible = (role == "Waiter");
        pnlChefCards.Visible = (role == "Chef");
        pnlAccountantCards.Visible = (role == "Accountant");
    }
}
