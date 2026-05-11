<%@ Page Title="Orders" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="OrderList.aspx.cs" Inherits="Pages_Orders_OrderList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
    Orders - RestaurantCentral
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="page-header mt-4">
        <h2 class="text-green"><asp:Literal ID="litTitle" runat="server" Text="Orders Board"></asp:Literal></h2>
    </div>

    <asp:Label ID="lblError" runat="server" CssClass="text-danger font-weight-bold d-block mb-3"></asp:Label>

    <div class="mb-3 d-flex justify-content-between align-items-center">
        <div>
            <asp:HyperLink ID="hlAddOrder" runat="server" NavigateUrl="OrderForm.aspx" CssClass="btn btn-primary" Visible="false">New Order</asp:HyperLink>
            <asp:HyperLink ID="hlSearchOrder" runat="server" NavigateUrl="OrderSearch.aspx" CssClass="btn btn-outline-secondary" Visible="false">Advanced Search</asp:HyperLink>
        </div>
        <asp:Button ID="btnRefresh" runat="server" Text="Refresh Queue" CssClass="btn btn-info" OnClick="btnRefresh_Click" />
    </div>
    <asp:PlaceHolder ID="phReadyOrders" runat="server" Visible="false">
        <h4 class="text-success mt-4">Ready for Pickup</h4>
        <div class="table-responsive mb-4">
            <asp:GridView ID="gvReadyOrders" runat="server" CssClass="table table-success table-bordered table-hover" 
                AutoGenerateColumns="False" DataKeyNames="customer_order_id"
                OnRowDataBound="gvOrders_RowDataBound" OnRowDeleting="gvOrders_RowDeleting" EmptyDataText="No orders ready for pickup.">
                <Columns>
                    <asp:BoundField DataField="customer_order_id" HeaderText="Order ID" />
                    <asp:BoundField DataField="customer_name" HeaderText="Customer" />
                    <asp:BoundField DataField="table_number" HeaderText="Table" />
                    <asp:BoundField DataField="waiter_name" HeaderText="Waiter" />
                    <asp:BoundField DataField="created_at" HeaderText="Created At" DataFormatString="{0:g}" />
                    <asp:BoundField DataField="order_status" HeaderText="Status" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnDeliver" runat="server" Text="Mark Delivered" CssClass="btn btn-sm btn-success" 
                                CommandArgument='<%# Eval("customer_order_id") %>' OnClick="btnDeliver_Click" />
                            <asp:LinkButton ID="btnDeleteReady" runat="server" Text="Delete" CommandName="Delete" 
                                OnClientClick="return confirm('Are you sure you want to permanently delete this order?');"
                                CssClass="btn btn-sm btn-outline-danger ml-1" Visible='<%# Convert.ToString(Session["UserRole"]) == "Manager" || Convert.ToString(Session["UserRole"]) == "Waiter" %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="bg-success text-white" />
            </asp:GridView>
        </div>
        <hr />
    </asp:PlaceHolder>

    <h4 id="h4AllOrders" runat="server">All Active Orders</h4>
    <div class="table-responsive">
        <asp:GridView ID="gvOrders" runat="server" CssClass="table table-striped table-bordered table-hover" 
            AutoGenerateColumns="False" DataKeyNames="customer_order_id"
            AllowPaging="True" PageSize="20" OnPageIndexChanging="gvOrders_PageIndexChanging"
            OnRowDataBound="gvOrders_RowDataBound"
            OnRowDeleting="gvOrders_RowDeleting"
            EmptyDataText="No active orders found.">
            
            <Columns>
                <asp:BoundField DataField="customer_order_id" HeaderText="Order ID" />
                
                <asp:BoundField DataField="customer_name" HeaderText="Customer" />
                <asp:BoundField DataField="table_number" HeaderText="Table" />
                <asp:BoundField DataField="waiter_name" HeaderText="Waiter" />
                <asp:BoundField DataField="created_at" HeaderText="Created At" DataFormatString="{0:g}" />
                
                <asp:BoundField DataField="item_name" HeaderText="Item Name" Visible="false" />
                <asp:BoundField DataField="quantity" HeaderText="Qty" Visible="false" />
                <asp:BoundField DataField="item_notes" HeaderText="Notes" Visible="false" />
                
                <asp:BoundField DataField="order_status" HeaderText="Current Status" />
                <asp:TemplateField HeaderText="Update Status">
                    <ItemTemplate>
                        <div class="input-group input-group-sm">
                            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="custom-select custom-select-sm">
                                <asp:ListItem Value="Pending">Pending</asp:ListItem>
                                <asp:ListItem Value="In Progress">In Progress</asp:ListItem>
                                <asp:ListItem Value="Ready">Ready</asp:ListItem>
                                <asp:ListItem Value="Delivered">Delivered</asp:ListItem>
                                <asp:ListItem Value="Completed">Completed</asp:ListItem>
                                <asp:ListItem Value="Cancelled">Cancelled</asp:ListItem>
                            </asp:DropDownList>
                            <div class="input-group-append">
                                <asp:Button ID="btnUpdateStatus" runat="server" Text="Update" CssClass="btn btn-outline-success" 
                                    CommandArgument='<%# Eval("customer_order_id") %>' OnClick="btnUpdateStatus_Click" />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnDelete" runat="server" Text="Delete" CommandName="Delete" 
                            OnClientClick="return confirm('Are you sure you want to permanently delete this order?');"
                            CssClass="btn btn-sm btn-outline-danger" Visible='<%# Convert.ToString(Session["UserRole"]) == "Manager" || Convert.ToString(Session["UserRole"]) == "Waiter" %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            
            <HeaderStyle CssClass="bg-dark text-gold" />
            <PagerStyle CssClass="pagination-ys" />
        </asp:GridView>
    </div>
</asp:Content>
