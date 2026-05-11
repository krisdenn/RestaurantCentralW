<%@ Page Title="Place Order" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="OrderForm.aspx.cs" Inherits="Pages_Orders_OrderForm" %>
<%@ Register Src="~/UserControls/AlertMessage.ascx" TagPrefix="uc" TagName="AlertMessage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
    Place Order - RestaurantCentral
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="page-header mt-4 d-flex justify-content-between align-items-center">
        <h2 class="text-green">Create New Order</h2>
        <a href="OrderList.aspx" class="btn btn-outline-secondary">Back to Orders</a>
    </div>

    <uc:AlertMessage runat="server" id="ucAlert" />

    <asp:ValidationSummary runat="server" HeaderText="Please correct the following:" CssClass="alert alert-danger mt-3" DisplayMode="BulletList" />

    <div class="card shadow-sm mt-4">
        <div class="card-header bg-dark text-gold">
            <h5 class="mb-0">Step 1: Order Details</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-4 form-group">
                    <label>Customer</label>
                    <asp:DropDownList ID="ddlCustomer" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ControlToValidate="ddlCustomer" InitialValue="0" ErrorMessage="Please select a customer." Display="Dynamic" CssClass="text-danger" runat="server"/>
                </div>
                
                <div class="col-md-4 form-group">
                    <label>Dining Table</label>
                    <asp:DropDownList ID="ddlTable" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ControlToValidate="ddlTable" InitialValue="0" ErrorMessage="Please select a table." Display="Dynamic" CssClass="text-danger" runat="server"/>
                </div>

                <div class="col-md-4 form-group">
                    <label>Assign Chef</label>
                    <asp:DropDownList ID="ddlChef" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ControlToValidate="ddlChef" InitialValue="0" ErrorMessage="Please assign a chef." Display="Dynamic" CssClass="text-danger" runat="server"/>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12 form-group">
                    <label>Order Notes (Allergies, requests, etc.)</label>
                    <asp:TextBox ID="txtNotes" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                </div>
            </div>

            <div class="mt-4">
                <asp:Button ID="btnCreateOrder" runat="server" Text="Create Order & Add Items" CssClass="btn btn-primary" OnClick="btnCreateOrder_Click" />
            </div>
        </div>
    </div>
</asp:Content>
