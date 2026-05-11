<%@ Page Title="Add Items" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="AddOrderItems.aspx.cs" Inherits="Pages_Orders_AddOrderItems" %>
<%@ Register Src="~/UserControls/AlertMessage.ascx" TagPrefix="uc" TagName="AlertMessage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
    Add Items to Order - RestaurantCentral
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="page-header mt-4 d-flex justify-content-between align-items-center">
        <h2 class="text-green">Order #<asp:Literal ID="litOrderId" runat="server"></asp:Literal> - Add Items</h2>
    </div>

    <uc:AlertMessage runat="server" id="ucAlert" />

    <div class="row mt-4">
        <div class="col-md-5">
            <div class="card shadow-sm h-100">
                <div class="card-header bg-dark text-gold">
                    <h5 class="mb-0">Select Item</h5>
                </div>
                <div class="card-body">
                    <asp:ValidationSummary runat="server" ValidationGroup="AddItem" CssClass="alert alert-danger" DisplayMode="BulletList" />

                    <div class="form-group">
                        <label>Menu Item</label>
                        <asp:DropDownList ID="ddlMenuItem" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ValidationGroup="AddItem" ControlToValidate="ddlMenuItem" InitialValue="0" ErrorMessage="Please select a menu item." Display="Dynamic" CssClass="text-danger" runat="server"/>
                    </div>

                    <div class="form-group">
                        <label>Quantity</label>
                        <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control" TextMode="Number" Text="1"></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="AddItem" ControlToValidate="txtQuantity" ErrorMessage="Quantity is required." Display="Dynamic" CssClass="text-danger" runat="server"/>
                        <asp:RangeValidator ValidationGroup="AddItem" ControlToValidate="txtQuantity" Type="Integer" MinimumValue="1" MaximumValue="99" ErrorMessage="Quantity must be between 1 and 99." Display="Dynamic" CssClass="text-danger" runat="server"/>
                    </div>

                    <div class="form-group">
                        <label>Item Notes (e.g. No onions)</label>
                        <asp:TextBox ID="txtItemNotes" runat="server" CssClass="form-control" MaxLength="100"></asp:TextBox>
                    </div>

                    <asp:Button ID="btnAddItem" runat="server" Text="Add to Order" ValidationGroup="AddItem" CssClass="btn btn-primary btn-block" OnClick="btnAddItem_Click" />
                </div>
            </div>
        </div>

        <div class="col-md-7">
            <div class="card shadow-sm h-100">
                <div class="card-header bg-success text-white d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Current Order Items</h5>
                </div>
                <div class="card-body p-0">
                    <asp:Repeater ID="rptOrderItems" runat="server" OnItemCommand="rptOrderItems_ItemCommand">
                        <HeaderTemplate>
                            <table class="table table-striped mb-0">
                                <thead class="thead-light">
                                    <tr>
                                        <th>Item</th>
                                        <th>Qty</th>
                                        <th>Price</th>
                                        <th>Notes</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("item_name") %></td>
                                <td><%# Eval("quantity") %></td>
                                <td><%# Convert.ToDecimal(Eval("unit_price")).ToString("N2") %></td>
                                <td><small class="text-muted"><%# Eval("item_notes") %></small></td>
                                <td>
                                    <asp:Button ID="btnRemove" runat="server" Text="Remove" CommandName="Remove" CommandArgument='<%# Eval("order_item_id") %>' CssClass="btn btn-sm btn-outline-danger" CausesValidation="false" />
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                                </tbody>
                            </table>
                            <div class="p-3">
                                <asp:Label ID="lblEmpty" runat="server" Visible='<%# rptOrderItems.Items.Count == 0 %>' Text="No items added yet." CssClass="font-italic text-muted"></asp:Label>
                            </div>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
                <div class="card-footer bg-light text-right">
                    <asp:Button ID="btnFinaliseOrder" runat="server" Text="Finalise Order" CssClass="btn btn-warning font-weight-bold" OnClick="btnFinaliseOrder_Click" CausesValidation="false" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
