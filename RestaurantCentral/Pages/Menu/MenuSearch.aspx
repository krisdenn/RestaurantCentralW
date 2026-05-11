<%@ Page Title="Menu Search" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="MenuSearch.aspx.cs" Inherits="Pages_Menu_MenuSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
    Menu Search - RestaurantCentral
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="page-header mt-4 d-flex justify-content-between align-items-center">
        <h2 class="text-green">Advanced Menu Search</h2>
        <a href="MenuList.aspx" class="btn btn-outline-secondary">Back to Menu</a>
    </div>

    <div class="card shadow-sm mt-4">
        <div class="card-body">
            <div class="row">
                <div class="col-md-4 form-group">
                    <label>Item Name (partial or full)</label>
                    <asp:TextBox ID="txtSearchName" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                
                <div class="col-md-4 form-group">
                    <label>Category</label>
                    <asp:DropDownList ID="ddlSearchCategory" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                </div>

                <div class="col-md-2 form-group d-flex align-items-end">
                    <div class="custom-control custom-checkbox mb-2">
                        <asp:CheckBox ID="chkAvailableOnly" runat="server" CssClass="custom-control-input" />
                        <label class="custom-control-label" for="<%= chkAvailableOnly.ClientID %>">Available Only</label>
                    </div>
                </div>

                <div class="col-md-2 form-group d-flex align-items-end">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary btn-block" OnClick="btnSearch_Click" />
                </div>
            </div>
        </div>
    </div>

    <div class="mt-5">
        <h4 class="text-green">Search Results</h4>
        <div class="table-responsive">
            <asp:GridView ID="gvResults" runat="server" CssClass="table table-striped table-bordered" 
                AutoGenerateColumns="False" EmptyDataText="No menu items matched your search."
                AllowPaging="True" PageSize="10" OnPageIndexChanging="gvResults_PageIndexChanging">
                
                <Columns>
                    <asp:BoundField DataField="item_name" HeaderText="Item Name" />
                    <asp:BoundField DataField="category_name" HeaderText="Category" />
                    <asp:BoundField DataField="regular_price" HeaderText="Price (J$)" DataFormatString="{0:N2}" />
                    <asp:BoundField DataField="item_quantity" HeaderText="Qty" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class='<%# Eval("is_available") != DBNull.Value && Convert.ToBoolean(Eval("is_available")) ? "text-success" : "text-danger" %>'>
                                <%# Eval("is_available") != DBNull.Value && Convert.ToBoolean(Eval("is_available")) ? "Available" : "Out of Stock" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                
                <HeaderStyle CssClass="bg-dark text-gold" />
                <PagerStyle CssClass="pagination-ys" />
            </asp:GridView>
        </div>
    </div>
</asp:Content>
