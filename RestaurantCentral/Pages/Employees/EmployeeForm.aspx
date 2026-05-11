<%@ Page Title="Add Employee" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="EmployeeForm.aspx.cs" Inherits="Pages_Employees_EmployeeForm" %>
<%@ Register Src="~/UserControls/AlertMessage.ascx" TagPrefix="uc" TagName="AlertMessage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
    Add Employee - RestaurantCentral
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="page-header mt-4 d-flex justify-content-between align-items-center">
        <h2 class="text-green">Add New Employee</h2>
        <a href="EmployeeList.aspx" class="btn btn-outline-secondary">Back to List</a>
    </div>

    <uc:AlertMessage runat="server" id="ucAlert" />

    <asp:ValidationSummary runat="server" HeaderText="Please correct the following:" CssClass="alert alert-danger mt-3" DisplayMode="BulletList" />

    <div class="card shadow-sm mt-4">
        <div class="card-header">
            <h5 class="mb-0 text-white">Employee Details</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6 form-group">
                    <label>First Name</label>
                    <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtFirstName" ErrorMessage="First name is required." Display="Dynamic" CssClass="text-danger" runat="server"/>
                </div>
                
                <div class="col-md-6 form-group">
                    <label>Last Name</label>
                    <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtLastName" ErrorMessage="Last name is required." Display="Dynamic" CssClass="text-danger" runat="server"/>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 form-group">
                    <label>Role</label>
                    <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control">
                        <asp:ListItem Value="Manager">Manager</asp:ListItem>
                        <asp:ListItem Value="Waiter" Selected="True">Waiter</asp:ListItem>
                        <asp:ListItem Value="Chef">Chef</asp:ListItem>
                        <asp:ListItem Value="Accountant">Accountant</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ControlToValidate="ddlRole" ErrorMessage="Role is required." Display="Dynamic" CssClass="text-danger" runat="server"/>
                </div>
                
                <div class="col-md-6 form-group">
                    <label>Phone Number</label>
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="876-555-1234"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtPhone" ErrorMessage="Phone number is required." Display="Dynamic" CssClass="text-danger" runat="server"/>
                    <asp:RegularExpressionValidator ControlToValidate="txtPhone" ValidationExpression="^\d{3}-\d{3}-\d{4}$" ErrorMessage="Phone must be in format 876-555-1234." Display="Dynamic" CssClass="text-danger" runat="server"/>
                </div>
            </div>
        </div>
    </div>

    <div class="card shadow-sm mt-4 mb-4">
        <div class="card-header bg-dark text-gold">
            <h5 class="mb-0">User Account Setup</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6 form-group">
                    <label>Username (4-20 alphanumeric characters)</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtUsername" ErrorMessage="Username is required." Display="Dynamic" CssClass="text-danger" runat="server"/>
                    <asp:RegularExpressionValidator ControlToValidate="txtUsername" ValidationExpression="^[a-zA-Z0-9]{4,20}$" ErrorMessage="Username must be 4-20 alphanumeric characters." Display="Dynamic" CssClass="text-danger" runat="server"/>
                </div>
                
                <div class="col-md-6 form-group">
                    <label>Password (Min 8 characters, at least 1 number)</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtPassword" ErrorMessage="Password is required." Display="Dynamic" CssClass="text-danger" runat="server"/>
                    <asp:RegularExpressionValidator ControlToValidate="txtPassword" ValidationExpression="^(?=.*\d).{8,}$" ErrorMessage="Password must be at least 8 chars and contain a number." Display="Dynamic" CssClass="text-danger" runat="server"/>
                </div>
            </div>
            
            <div class="mt-4">
                <asp:Button ID="btnSave" runat="server" Text="Create Employee & Account" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary ml-2" CausesValidation="false" OnClick="btnClear_Click" />
            </div>
        </div>
    </div>
</asp:Content>
