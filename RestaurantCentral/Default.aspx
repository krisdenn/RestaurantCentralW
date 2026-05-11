<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
    Home - RestaurantCentral
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="jumbotron mt-4 bg-white shadow-sm border text-center">
        <h1 class="display-4 text-green">Welcome back, <asp:Literal ID="litWelcomeName" runat="server"></asp:Literal>!</h1>
        <p class="lead">Guango's Jerk Restaurant Management System</p>
        <hr class="my-4" style="border-color: var(--rc-gold); border-width: 2px;" />
        
        <div class="row text-center mb-4 justify-content-center">
            <div class="col-md-8">
                <asp:Panel ID="pnlStockWarning" runat="server" CssClass="alert alert-warning" Visible="false">
                    <strong>Stock Warning:</strong> <asp:Literal ID="litLowestQuantity" runat="server"></asp:Literal>
                </asp:Panel>
            </div>
        </div>

        <h3 class="mb-3 text-left">Quick Actions</h3>
        
        <asp:Panel ID="pnlManagerCards" runat="server" Visible="false" CssClass="row text-left">
            <div class="col-md-4 mb-3">
                <div class="card h-100 border-success">
                    <div class="card-body text-center">
                        <h5 class="card-title">Customers</h5>
                        <p class="card-text">Manage customer records.</p>
                        <a href="~/Pages/Customer/CustomerList.aspx" runat="server" class="btn btn-primary">Manage Customers</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card h-100 border-success">
                    <div class="card-body text-center">
                        <h5 class="card-title">Reports</h5>
                        <p class="card-text">View daily revenue and summaries.</p>
                        <a href="~/Pages/Reports/ManagerDashboard.aspx" runat="server" class="btn btn-primary">View Reports</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card h-100 border-success">
                    <div class="card-body text-center">
                        <h5 class="card-title">Menu</h5>
                        <p class="card-text">Update items and pricing.</p>
                        <a href="~/Pages/Menu/MenuList.aspx" runat="server" class="btn btn-primary">Manage Menu</a>
                    </div>
                </div>
            </div>
        </asp:Panel>
        
        <asp:Panel ID="pnlWaiterCards" runat="server" Visible="false" CssClass="row text-left">
            <div class="col-md-4 mb-3">
                <div class="card h-100 border-success">
                    <div class="card-body text-center">
                        <h5 class="card-title">New Order</h5>
                        <p class="card-text">Place a new order for a table.</p>
                        <a href="~/Pages/Orders/OrderForm.aspx" runat="server" class="btn btn-primary">Place Order</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card h-100 border-success">
                    <div class="card-body text-center">
                        <h5 class="card-title">Orders Board</h5>
                        <p class="card-text">View and update order statuses.</p>
                        <a href="~/Pages/Orders/OrderList.aspx" runat="server" class="btn btn-primary">View Orders</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card h-100 border-success">
                    <div class="card-body text-center">
                        <h5 class="card-title">Reservations</h5>
                        <p class="card-text">View upcoming bookings.</p>
                        <a href="~/Pages/Reservations/ReservationList.aspx" runat="server" class="btn btn-primary">Reservations</a>
                    </div>
                </div>
            </div>
        </asp:Panel>
        
        <asp:Panel ID="pnlChefCards" runat="server" Visible="false" CssClass="row text-left">
            <div class="col-md-4 mb-3">
                <div class="card h-100 border-success">
                    <div class="card-body text-center">
                        <h5 class="card-title">Order Queue</h5>
                        <p class="card-text">View pending kitchen orders.</p>
                        <a href="~/Pages/Orders/OrderList.aspx" runat="server" class="btn btn-primary">View Queue</a>
                    </div>
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlAccountantCards" runat="server" Visible="false" CssClass="row text-left">
            <div class="col-md-4 mb-3">
                <div class="card h-100 border-success">
                    <div class="card-body text-center">
                        <h5 class="card-title">Payments</h5>
                        <p class="card-text">Record and view invoice payments.</p>
                        <a href="~/Pages/Reports/AccountantPayments.aspx" runat="server" class="btn btn-primary">View Payments</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card h-100 border-success">
                    <div class="card-body text-center">
                        <h5 class="card-title">Reports</h5>
                        <p class="card-text">View financial summaries.</p>
                        <a href="~/Pages/Reports/ManagerDashboard.aspx" runat="server" class="btn btn-primary">View Reports</a>
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
