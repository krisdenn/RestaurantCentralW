using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Reservations_ReservationList : Page
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
            BindGrid();
        }
    }

    private void BindGrid()
    {
        try
        {
            string sql = @"
                SELECT r.reservation_id, c.first_name + ' ' + c.last_name AS customer_name,
                       t.table_number, r.reservation_date, r.party_size, r.status
                FROM Reservation r
                JOIN Customer c ON r.customer_id = c.customer_id
                JOIN Dining_Table t ON r.dining_table_id = t.dining_table_id
                ORDER BY r.reservation_date DESC";

            DataTable dt = DbHelper.ExecuteRawQuery(sql);
            gvReservations.DataSource = dt;
            gvReservations.DataBind();
        }
        catch (Exception ex)
        {
            lblError.Text = "Error: " + ex.Message;
        }
    }

    protected void gvReservations_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvReservations.EditIndex = e.NewEditIndex;
        BindGrid();
    }

    protected void gvReservations_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvReservations.EditIndex = -1;
        BindGrid();
    }

    protected void gvReservations_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        int reservationId = Convert.ToInt32(gvReservations.DataKeys[e.RowIndex].Value);
        GridViewRow row = gvReservations.Rows[e.RowIndex];

        DateTime resDate = Convert.ToDateTime((row.FindControl("txtEditDate") as TextBox).Text);
        int partySize = Convert.ToInt32((row.FindControl("txtEditParty") as TextBox).Text);
        string status = (row.FindControl("ddlEditStatus") as DropDownList).SelectedValue;

        SqlParameter[] p = {
            new SqlParameter("@reservation_id", reservationId),
            new SqlParameter("@reservation_date", resDate),
            new SqlParameter("@party_size", partySize),
            new SqlParameter("@status", status)
        };

        try
        {
            DbHelper.ExecuteNonQuery("usp_update_reservation", p);
            gvReservations.EditIndex = -1;
            BindGrid();
        }
        catch (Exception ex)
        {
            lblError.Text = "Update Error: " + ex.Message;
        }
    }

    protected void gvReservations_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int reservationId = Convert.ToInt32(gvReservations.DataKeys[e.RowIndex].Value);

        SqlParameter[] p = {
            new SqlParameter("@reservation_id", reservationId)
        };

        try
        {
            DbHelper.ExecuteNonQuery("usp_delete_reservation", p);
            BindGrid();
        }
        catch (Exception ex)
        {
            lblError.Text = "Delete Error: " + ex.Message;
        }
    }

    protected void gvReservations_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvReservations.PageIndex = e.NewPageIndex;
        BindGrid();
    }
}

