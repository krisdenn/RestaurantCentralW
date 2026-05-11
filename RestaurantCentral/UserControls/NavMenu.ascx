<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NavMenu.ascx.cs" Inherits="UserControls_NavMenu" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-success mb-4">
    <a class="navbar-brand font-weight-bold" href="~/Default.aspx" runat="server">Guango's Jerk Restaurant &#127807;</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-collapse="target" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="~/Default.aspx" runat="server">Home</a>
            </li>
            <asp:Panel ID="pnlManager" runat="server" Visible="false" CssClass="d-flex flex-column flex-lg-row">
                <li class="nav-item"><a class="nav-link" href="~/Pages/Customer/CustomerList.aspx" runat="server">Customers</a></li>
                <li class="nav-item"><a class="nav-link" href="~/Pages/Menu/MenuList.aspx" runat="server">Menu</a></li>
                <li class="nav-item"><a class="nav-link" href="~/Pages/Orders/OrderList.aspx" runat="server">Orders</a></li>
                <li class="nav-item"><a class="nav-link" href="~/Pages/Employees/EmployeeList.aspx" runat="server">Employees</a></li>
                <li class="nav-item"><a class="nav-link" href="~/Pages/Reservations/ReservationList.aspx" runat="server">Reservations</a></li>
                <li class="nav-item"><a class="nav-link" href="~/Pages/Reports/ManagerDashboard.aspx" runat="server">Reports</a></li>
                <li class="nav-item"><a class="nav-link" href="~/Pages/Reviews/ReviewList.aspx" runat="server">Reviews</a></li>
            </asp:Panel>
            
            <asp:Panel ID="pnlWaiter" runat="server" Visible="false" CssClass="d-flex flex-column flex-lg-row">
                <li class="nav-item"><a class="nav-link" href="~/Pages/Orders/OrderList.aspx" runat="server">Orders</a></li>
                <li class="nav-item"><a class="nav-link" href="~/Pages/Customer/CustomerList.aspx" runat="server">Customers</a></li>
                <li class="nav-item"><a class="nav-link" href="~/Pages/Reservations/ReservationList.aspx" runat="server">Reservations</a></li>
            </asp:Panel>
            
            <asp:Panel ID="pnlChef" runat="server" Visible="false" CssClass="d-flex flex-column flex-lg-row">
                <li class="nav-item"><a class="nav-link" href="~/Pages/Orders/OrderList.aspx" runat="server">Orders Queue</a></li>
            </asp:Panel>

            <asp:Panel ID="pnlAccountant" runat="server" Visible="false" CssClass="d-flex flex-column flex-lg-row">
                <li class="nav-item"><a class="nav-link" href="~/Pages/Reports/AccountantPayments.aspx" runat="server">Payments</a></li>
                <li class="nav-item"><a class="nav-link" href="~/Pages/Reports/ManagerDashboard.aspx" runat="server">Reports</a></li>
            </asp:Panel>
        </ul>
        
        <ul class="navbar-nav">
            <asp:Panel ID="pnlGuest" runat="server" CssClass="d-flex flex-column flex-lg-row">
                <li class="nav-item">
                    <a class="nav-link" href="~/Login.aspx" runat="server">Login</a>
                </li>
            </asp:Panel>
            <asp:Panel ID="pnlLoggedIn" runat="server" Visible="false" CssClass="d-flex flex-column flex-lg-row align-items-lg-center">
                <li class="nav-item">
                    <span class="navbar-text mr-3 text-gold">
                        Hello, <asp:Literal ID="litUserName" runat="server"></asp:Literal> 
                        (<asp:Literal ID="litRole" runat="server"></asp:Literal>)
                    </span>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="~/Logout.aspx" runat="server">Logout</a>
                </li>
            </asp:Panel>
        </ul>
    </div>
</nav>
