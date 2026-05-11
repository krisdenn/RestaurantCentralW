<%@ Page Title="Add Customer" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="CustomerForm.aspx.cs" Inherits="Pages_Customer_CustomerForm" %>
<%@ Register Src="~/UserControls/AlertMessage.ascx" TagPrefix="uc" TagName="AlertMessage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
    Add Customer - RestaurantCentral
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="page-header mt-4 d-flex justify-content-between align-items-center">
        <h2 class="text-green">Add New Customer</h2>
        <a href="CustomerList.aspx" class="btn btn-outline-secondary">Back to List</a>
    </div>

    <uc:AlertMessage runat="server" id="ucAlert" />

    <asp:ValidationSummary runat="server" HeaderText="Please correct the following:" CssClass="alert alert-danger mt-3" DisplayMode="BulletList" />

    <div class="card shadow-sm mt-4">
        <div class="card-body">
            <div class="row">
                <div class="col-md-6 form-group">
                    <label>First Name</label>
                    <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtFirstName" ErrorMessage="First name is required." Display="Dynamic" CssClass="text-danger" runat="server"/>
                </div>
                
                <div class="col-md-6 form-group">
                    <label>Last Name</label>
                    <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtLastName" ErrorMessage="Last name is required." Display="Dynamic" CssClass="text-danger" runat="server"/>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 form-group">
                    <label>Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RegularExpressionValidator ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Please enter a valid email address." Display="Dynamic" CssClass="text-danger" runat="server"/>
                </div>
                
                <div class="col-md-6 form-group">
                    <label>Contact Number</label>
                    <asp:TextBox ID="txtContact" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12 form-group">
                    <label>Address</label>
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 form-group">
                    <label>Date of Birth</label>
                    <asp:TextBox ID="txtDOB" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                </div>
                
                <div class="col-md-6 form-group">
                    <label>Registered?</label>
                    <asp:DropDownList ID="ddlRegistered" runat="server" CssClass="form-control">
                        <asp:ListItem Value="1" Selected="True">Yes</asp:ListItem>
                        <asp:ListItem Value="0">No</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>

            <div class="mt-4">
                <asp:Button ID="btnSave" runat="server" Text="Save Customer" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary ml-2" CausesValidation="false" OnClick="btnClear_Click" />
            </div>
        </div>
    </div>
</asp:Content>
