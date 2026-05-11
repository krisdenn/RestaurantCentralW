<%@ Page Title="Add Menu Item" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="MenuForm.aspx.cs" Inherits="Pages_Menu_MenuForm" %>
<%@ Register Src="~/UserControls/AlertMessage.ascx" TagPrefix="uc" TagName="AlertMessage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
    Add Menu Item - RestaurantCentral
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="page-header mt-4 d-flex justify-content-between align-items-center">
        <h2 class="text-green">Add New Menu Item</h2>
        <a href="MenuList.aspx" class="btn btn-outline-secondary">Back to Menu</a>
    </div>

    <uc:AlertMessage runat="server" id="ucAlert" />

    <asp:ValidationSummary runat="server" HeaderText="Please correct the following:" CssClass="alert alert-danger mt-3" DisplayMode="BulletList" />

    <div class="card shadow-sm mt-4">
        <div class="card-body">
            <div class="row">
                <div class="col-md-6 form-group">
                    <label>Category</label>
                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ControlToValidate="ddlCategory" InitialValue="0" ErrorMessage="Please select a category." Display="Dynamic" CssClass="text-danger" runat="server"/>
                </div>
                
                <div class="col-md-6 form-group">
                    <label>Item Name</label>
                    <asp:TextBox ID="txtItemName" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtItemName" ErrorMessage="Item name is required." Display="Dynamic" CssClass="text-danger" runat="server"/>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 form-group">
                    <label>Price (J$)</label>
                    <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" TextMode="Number" step="0.01"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtPrice" ErrorMessage="Price is required." Display="Dynamic" CssClass="text-danger" runat="server"/>
                    <asp:RangeValidator ControlToValidate="txtPrice" Type="Currency" MinimumValue="1.00" MaximumValue="99999.00" ErrorMessage="Price must be between J$1 and J$99,999." Display="Dynamic" CssClass="text-danger" runat="server"/>
                </div>
                
                <div class="col-md-6 form-group">
                    <label>Initial Quantity</label>
                    <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtQuantity" ErrorMessage="Quantity is required." Display="Dynamic" CssClass="text-danger" runat="server"/>
                    <asp:RangeValidator ControlToValidate="txtQuantity" Type="Integer" MinimumValue="0" MaximumValue="9999" ErrorMessage="Quantity must be between 0 and 9999." Display="Dynamic" CssClass="text-danger" runat="server"/>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12 form-group">
                    <label>Description</label>
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtDescription" ErrorMessage="Description is required." Display="Dynamic" CssClass="text-danger" runat="server"/>
                </div>
            </div>

            <div class="mt-4">
                <asp:Button ID="btnSave" runat="server" Text="Save Item" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary ml-2" CausesValidation="false" OnClick="btnClear_Click" />
            </div>
        </div>
    </div>
    
    <hr class="mt-5 mb-5" />
    
    <div class="card shadow-sm mb-5 bg-light">
        <div class="card-header bg-dark text-gold">
            <h5 class="mb-0">Price Range Search</h5>
        </div>
        <div class="card-body">
            <div class="form-inline mb-4">
                <label class="mr-2">Min Price J$:</label>
                <asp:TextBox ID="txtMinPrice" runat="server" CssClass="form-control mr-3" TextMode="Number" step="0.01"></asp:TextBox>
                
                <label class="mr-2">Max Price J$:</label>
                <asp:TextBox ID="txtMaxPrice" runat="server" CssClass="form-control mr-3" TextMode="Number" step="0.01"></asp:TextBox>
                
                <asp:Button ID="btnSearchRange" runat="server" Text="Search" CssClass="btn btn-warning" CausesValidation="false" OnClick="btnSearchRange_Click" />
            </div>
            
            <asp:Repeater ID="rptPriceRange" runat="server">
                <HeaderTemplate>
                    <table class="table table-sm table-bordered bg-white">
                        <thead class="thead-light">
                            <tr><th>Item Name</th><th>Price (J$)</th></tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("item_name") %></td>
                        <td class="font-weight-bold text-success"><%# Convert.ToDecimal(Eval("price")).ToString("N2") %></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                        </tbody>
                    </table>
                    <asp:Label ID="lblEmpty" runat="server" Visible='<%# rptPriceRange.Items.Count == 0 %>' Text="No items in this range." CssClass="font-italic text-muted"></asp:Label>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
