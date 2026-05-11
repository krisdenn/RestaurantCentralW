using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Reservations_ReservationForm : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
            Response.Redirect("~/Login.aspx");

        string role = Convert.ToString(Session["UserRole"]);
        if (role != "Manager" && role != "Waiter")
            Response.Redirect("~/Default.aspx");

        if (!IsPostBack)
        {
            PopulateDropdowns();
        }
    }

    private void PopulateDropdowns()
    {
        try
        {
            // Customers
            DataTable dtCust = DbHelper.ExecuteRawQuery("SELECT customer_id, first_name + ' ' + last_name AS name FROM Customer WHERE is_active = 1");
            ddlCustomer.DataSource = dtCust;
            ddlCustomer.DataTextField = "name";
            ddlCustomer.DataValueField = "customer_id";
            ddlCustomer.DataBind();
            ddlCustomer.Items.Insert(0, new ListItem("-- Select Customer --", "0"));

            // Tables
            DataTable dtTable = DbHelper.ExecuteRawQuery("SELECT table_id, 'Table ' + CAST(table_number AS VARCHAR) + ' (Seats ' + CAST(seating_capacity AS VARCHAR) + ')' AS t_name FROM Dining_Table WHERE is_available = 1");
            ddlTable.DataSource = dtTable;
            ddlTable.DataTextField = "t_name";
            ddlTable.DataValueField = "table_id";
            ddlTable.DataBind();
            ddlTable.Items.Insert(0, new ListItem("-- Select Table --", "0"));
        }
        catch (Exception) { }
    }

    protected void cvFutureDate_ServerValidate(object source, ServerValidateEventArgs args)
    {
        DateTime d;
        args.IsValid = DateTime.TryParse(args.Value, out d) && d > DateTime.Now;
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid) return;

        SqlParameter[] p = {
            new SqlParameter("@customer_id", ddlCustomer.SelectedValue),
            new SqlParameter("@table_id", ddlTable.SelectedValue),
            new SqlParameter("@reservation_date", DateTime.Parse(txtResDate.Text)),
            new SqlParameter("@party_size", Convert.ToInt32(txtPartySize.Text)),
            new SqlParameter("@special_requests", txtNotes.Text.Trim())
        };

        try
        {
            DbHelper.ExecuteNonQuery("usp_insert_reservation", p);
            ucAlert.Message = "Reservation confirmed!";
            ucAlert.AlertType = "success";
            ClearForm();
        }
        catch (Exception ex)
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
        ddlCustomer.SelectedIndex = 0;
        ddlTable.SelectedIndex = 0;
        txtResDate.Text = "";
        txtPartySize.Text = "";
        txtNotes.Text = "";
    }
}

