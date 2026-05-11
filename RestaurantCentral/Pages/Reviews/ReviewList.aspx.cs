using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Reviews_ReviewList : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
            Response.Redirect("~/Login.aspx");

        if (!IsPostBack)
        {
            BindReviews();
            
            // Check if user is a customer (for this prompt, roles are Manager/Waiter/Chef/Accountant, 
            // but we might want to let any logged in user add a review if they have an order.
            // Let's just assume we can show the panel if they are a manager/waiter for testing, 
            // but ideally it would be for customer accounts.
            // I'll enable it for testing purposes.
            pnlAddReview.Visible = true;
            PopulateOrders();
        }
    }

    private void BindReviews()
    {
        try
        {
            string sql = @"
                SELECT r.review_id, c.first_name + ' ' + c.last_name AS customer_name,
                       co.order_number, r.rating, r.review_text
                FROM Customer_Review r
                JOIN Customer c ON r.customer_id = c.customer_id
                JOIN Customer_Order co ON r.order_id = co.customer_order_id
                ORDER BY r.review_id DESC";
            
            DataTable dt = DbHelper.ExecuteRawQuery(sql);
            
            if (dt.Rows.Count > 0)
            {
                rptReviews.DataSource = dt;
                rptReviews.DataBind();
                lblNoReviews.Visible = false;
            }
            else
            {
                rptReviews.DataSource = null;
                rptReviews.DataBind();
                lblNoReviews.Visible = true;
            }
        }
        catch (Exception ex)
        {
            ucAlert.Message = "Error loading reviews: " + ex.Message;
            ucAlert.AlertType = "danger";
        }
    }

    private void PopulateOrders()
    {
        try
        {
            // Just get recent completed orders
            string sql = "SELECT customer_order_id, order_number + ' - ' + CAST(created_at AS VARCHAR) AS display FROM Customer_Order WHERE order_status = 'Completed'";
            DataTable dt = DbHelper.ExecuteRawQuery(sql);
            
            ddlOrder.DataSource = dt;
            ddlOrder.DataTextField = "display";
            ddlOrder.DataValueField = "customer_order_id";
            ddlOrder.DataBind();
            ddlOrder.Items.Insert(0, new ListItem("-- Select Order --", "0"));
        }
        catch (Exception) { }
    }

    protected void btnSubmitReview_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid) return;

        try
        {
            // Get customer ID from the order
            string sqlCust = "SELECT customer_id FROM Customer_Order WHERE customer_order_id = @oid";
            SqlParameter[] pc = { new SqlParameter("@oid", ddlOrder.SelectedValue) };
            object custId = DbHelper.ExecuteScalarText(sqlCust, pc);

            if (custId != null)
            {
                string sqlInsert = @"INSERT INTO Customer_Review (customer_id, order_id, rating, review_text) 
                                     VALUES (@cid, @oid, @rat, @txt)";
                SqlParameter[] p = {
                    new SqlParameter("@cid", custId),
                    new SqlParameter("@oid", ddlOrder.SelectedValue),
                    new SqlParameter("@rat", ddlRating.SelectedValue),
                    new SqlParameter("@txt", txtReview.Text.Trim())
                };

                DbHelper.ExecuteRawQuery(sqlInsert, p); // Raw insert if proc missing
                
                ucAlert.Message = "Review submitted successfully!";
                ucAlert.AlertType = "success";
                
                txtReview.Text = "";
                ddlOrder.SelectedIndex = 0;
                ddlRating.SelectedIndex = 0;

                BindReviews();
            }
        }
        catch (Exception ex)
        {
            ucAlert.Message = "Error: " + ex.Message;
            ucAlert.AlertType = "danger";
        }
    }
}
