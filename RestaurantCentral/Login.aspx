<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
    Login - RestaurantCentral
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="row justify-content-center mt-5">
        <div class="col-md-6 col-lg-4">
            <div class="card shadow">
                <div class="card-header text-center">
                    <h4 class="mb-0">Staff Login</h4>
                </div>
                <div class="card-body">
                    <asp:ValidationSummary runat="server" HeaderText="Please correct the following:" CssClass="alert alert-danger" DisplayMode="BulletList" />
                    
                    <asp:Label ID="lblError" runat="server" CssClass="text-danger font-weight-bold d-block mb-3"></asp:Label>
                    
                    <div class="form-group">
                        <label for="<%= txtUsername.ClientID %>">Username</label>
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" ErrorMessage="Username is required." Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                    </div>
                    
                    <div class="form-group">
                        <label for="<%= txtPassword.ClientID %>">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required." Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                    </div>
                    
                    <div class="form-group text-center mt-4">
                        <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary btn-block" OnClick="btnLogin_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
