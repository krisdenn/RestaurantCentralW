using System;
using System.Web.UI;

public partial class UserControls_AlertMessage : UserControl
{
    public string Message { get; set; }
    
    // "success", "danger", "warning", "info"
    private string _alertType = "info";
    public string AlertType 
    { 
        get { return _alertType; } 
        set { _alertType = value; } 
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Message))
        {
            litMessage.Text = Message;
            pnlAlert.CssClass = string.Format("alert alert-{0} alert-dismissible fade show mt-3", AlertType);
            pnlAlert.Visible = true;
        }
        else
        {
            pnlAlert.Visible = false;
        }
    }
}
