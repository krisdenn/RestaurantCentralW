<%@ Page Title="Menu Items" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="MenuList.aspx.cs" Inherits="Pages_Menu_MenuList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
    Menu - RestaurantCentral
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="page-header mt-4">
        <h2 class="text-green">Manage Menu</h2>
    </div>

    <asp:Label ID="lblError" runat="server" CssClass="text-danger font-weight-bold d-block mb-3"></asp:Label>

    <div class="mb-3 d-flex justify-content-between align-items-center">
        <div>
            <asp:HyperLink ID="hlAddMenu" runat="server" NavigateUrl="MenuForm.aspx" CssClass="btn btn-primary" Visible="false">Add Menu Item</asp:HyperLink>
            <a href="MenuSearch.aspx" class="btn btn-outline-secondary">Advanced Search</a>
        </div>
        
        <div class="form-inline">
            <label class="mr-2">Category Filter:</label>
            <asp:DropDownList ID="ddlCategoryFilter" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCategoryFilter_SelectedIndexChanged">
            </asp:DropDownList>
        </div>
    </div>

    <div class="table-responsive">
        <asp:GridView ID="gvMenu" runat="server" CssClass="table table-striped table-bordered table-hover" 
            AutoGenerateColumns="False" DataKeyNames="menu_item_id"
            OnRowEditing="gvMenu_RowEditing" 
            OnRowCancelingEdit="gvMenu_RowCancelingEdit" 
            OnRowUpdating="gvMenu_RowUpdating" 
            OnRowDeleting="gvMenu_RowDeleting"
            OnRowDataBound="gvMenu_RowDataBound"
            AllowPaging="True" PageSize="10" OnPageIndexChanging="gvMenu_PageIndexChanging"
            EmptyDataText="No menu items found.">
            
            <Columns>
                <asp:TemplateField HeaderText="Item">
                    <ItemTemplate><%# Eval("item_name") %></ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEditName" runat="server" Text='<%# Bind("item_name") %>' CssClass="form-control" MaxLength="100"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditName" ErrorMessage="*" CssClass="text-danger" Display="Dynamic" />
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="category_name" HeaderText="Category" ReadOnly="True" />
                <asp:TemplateField HeaderText="Price (J$)">
                    <ItemTemplate>
                        <%# Convert.ToDecimal(Eval("regular_price")).ToString("N2") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEditPrice" runat="server" Text='<%# Bind("regular_price") %>' CssClass="form-control" TextMode="Number" step="0.01"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditPrice" ErrorMessage="*" CssClass="text-danger" Display="Dynamic" />
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Qty">
                    <ItemTemplate>
                        <%# Eval("item_quantity") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEditQty" runat="server" Text='<%# Bind("item_quantity") %>' CssClass="form-control" TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditQty" ErrorMessage="*" CssClass="text-danger" Display="Dynamic" />
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Available">
                    <ItemTemplate>
                        <span class='<%# Eval("is_available") != DBNull.Value && Convert.ToBoolean(Eval("is_available")) ? "text-success font-weight-bold" : "text-danger" %>'>
                            <%# Eval("is_available") != DBNull.Value && Convert.ToBoolean(Eval("is_available")) ? "Yes" : "No" %>
                        </span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="chkEditAvailable" runat="server" Checked='<%# Bind("is_available") %>' />
                    </EditItemTemplate>
                </asp:TemplateField>
                
                <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" ControlStyle-CssClass="btn btn-sm btn-outline-dark" />
            </Columns>
            
            <PagerStyle CssClass="pagination-ys" />
        </asp:GridView>
    </div>
</asp:Content>
