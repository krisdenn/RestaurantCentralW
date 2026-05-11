<%@ Page Title="Reviews" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="ReviewList.aspx.cs" Inherits="Pages_Reviews_ReviewList" %>
<%@ Register Src="~/UserControls/AlertMessage.ascx" TagPrefix="uc" TagName="AlertMessage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
    Customer Reviews - RestaurantCentral
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="page-header mt-4">
        <h2 class="text-green">Customer Reviews</h2>
    </div>

    <uc:AlertMessage runat="server" id="ucAlert" />

    <div class="row">
        <!-- Add Review Form (Only visible if the current logged-in user is tied to a customer ID and has completed orders) -->
        <asp:Panel ID="pnlAddReview" runat="server" Visible="false" CssClass="col-md-12 mb-5">
            <div class="card shadow-sm border-warning">
                <div class="card-header bg-warning text-dark">
                    <h5 class="mb-0">Leave a Review</h5>
                </div>
                <div class="card-body">
                    <asp:ValidationSummary runat="server" ValidationGroup="Review" CssClass="alert alert-danger" DisplayMode="BulletList" />
                    
                    <div class="row">
                        <div class="col-md-4 form-group">
                            <label>Completed Order</label>
                            <asp:DropDownList ID="ddlOrder" runat="server" CssClass="form-control">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ValidationGroup="Review" ControlToValidate="ddlOrder" InitialValue="0" ErrorMessage="Select an order." Display="Dynamic" CssClass="text-danger" runat="server"/>
                        </div>
                        
                        <div class="col-md-2 form-group">
                            <label>Rating (1-5)</label>
                            <asp:DropDownList ID="ddlRating" runat="server" CssClass="form-control">
                                <asp:ListItem Value="5">5 - Excellent</asp:ListItem>
                                <asp:ListItem Value="4">4 - Good</asp:ListItem>
                                <asp:ListItem Value="3">3 - Average</asp:ListItem>
                                <asp:ListItem Value="2">2 - Poor</asp:ListItem>
                                <asp:ListItem Value="1">1 - Terrible</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="col-md-6 form-group">
                            <label>Comments</label>
                            <asp:TextBox ID="txtReview" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                            <asp:RequiredFieldValidator ValidationGroup="Review" ControlToValidate="txtReview" ErrorMessage="Comments are required." Display="Dynamic" CssClass="text-danger" runat="server"/>
                        </div>
                    </div>
                    <asp:Button ID="btnSubmitReview" runat="server" Text="Submit Review" ValidationGroup="Review" CssClass="btn btn-primary" OnClick="btnSubmitReview_Click" />
                </div>
            </div>
        </asp:Panel>

        <!-- Reviews List (Repeater) -->
        <div class="col-md-12">
            <div class="row">
                <asp:Repeater ID="rptReviews" runat="server">
                    <ItemTemplate>
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="card h-100 shadow-sm">
                                <div class="card-body">
                                    <h6 class="card-title font-weight-bold text-dark"><%# Eval("customer_name") %> on Order <%# Eval("order_number") %></h6>
                                    <div class="mb-2">
                                        <span class="text-warning lead"><%# new string('\u2605', Convert.ToInt32(Eval("rating"))) %></span>
                                        <span class="text-muted"><%# new string('\u2606', 5 - Convert.ToInt32(Eval("rating"))) %></span>
                                    </div>
                                    <p class="card-text font-italic">"<%# Eval("review_text") %>"</p>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <asp:Label ID="lblNoReviews" runat="server" Visible="false" Text="No reviews have been posted yet." CssClass="alert alert-info d-block"></asp:Label>
        </div>
    </div>
</asp:Content>
