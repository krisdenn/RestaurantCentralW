<%@ Page Title="Order Search" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="OrderSearch.aspx.cs" Inherits="Pages_Orders_OrderSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
    Order Search - RestaurantCentral
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="page-header mt-4 d-flex justify-content-between align-items-center">
        <h2 class="text-green">Advanced Order Search</h2>
        <a href="OrderList.aspx" class="btn btn-outline-secondary">Back to Orders</a>
    </div>

    <div class="card shadow-sm mt-4">
        <div class="card-body">
            <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" />
            
            <div class="row">
                <div class="col-md-3 form-group">
                    <label>Customer Last Name</label>
                    <asp:TextBox ID="txtCustomerLast" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                
                <div class="col-md-3 form-group">
                    <label>Order Status</label>
                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                        <asp:ListItem Value="">-- Any Status --</asp:ListItem>
                        <asp:ListItem Value="Pending">Pending</asp:ListItem>
                        <asp:ListItem Value="In Progress">In Progress</asp:ListItem>
                        <asp:ListItem Value="Ready">Ready</asp:ListItem>
                        <asp:ListItem Value="Delivered">Delivered</asp:ListItem>
                        <asp:ListItem Value="Completed">Completed</asp:ListItem>
                        <asp:ListItem Value="Cancelled">Cancelled</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="col-md-2 form-group">
                    <label>From Date</label>
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    <asp:RangeValidator runat="server" ControlToValidate="txtFromDate" Type="Date" MinimumValue="2000-01-01" MaximumValue="2050-12-31" ErrorMessage="Invalid From Date range." Display="Dynamic" CssClass="text-danger" />
                </div>

                <div class="col-md-2 form-group">
                    <label>To Date</label>
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    <asp:RangeValidator runat="server" ControlToValidate="txtToDate" Type="Date" MinimumValue="2000-01-01" MaximumValue="2050-12-31" ErrorMessage="Invalid To Date range." Display="Dynamic" CssClass="text-danger" />
                </div>

                <div class="col-md-2 form-group d-flex align-items-end">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary btn-block" OnClick="btnSearch_Click" />
                </div>
            </div>
            
            <asp:CustomValidator ID="cvDateRange" runat="server" ErrorMessage="From Date must be less than or equal to To Date." Display="Dynamic" CssClass="text-danger font-weight-bold" OnServerValidate="cvDateRange_ServerValidate"></asp:CustomValidator>
        </div>
    </div>

    <div class="mt-5">
        <h4 class="text-green">Search Results</h4>
        <div class="table-responsive">
            <asp:GridView ID="gvResults" runat="server" CssClass="table table-striped table-bordered table-hover" 
                AutoGenerateColumns="False" EmptyDataText="No orders matched your search criteria."
                AllowPaging="True" PageSize="15" OnPageIndexChanging="gvResults_PageIndexChanging">
                
                <Columns>
                    <asp:BoundField DataField="order_number" HeaderText="Order #" />
                    <asp:BoundField DataField="customer_name" HeaderText="Customer" />
                    <asp:BoundField DataField="order_status" HeaderText="Status" />
                    <asp:BoundField DataField="created_at" HeaderText="Date" DataFormatString="{0:g}" />
                </Columns>
                
                <HeaderStyle CssClass="bg-dark text-gold" />
                <PagerStyle CssClass="pagination-ys" />
            </asp:GridView>
        </div>
    </div>
</asp:Content>
