<%@ Page Title="Customer Search" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="CustomerSearch.aspx.cs" Inherits="Pages_Customer_CustomerSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
    Customer Search - RestaurantCentral
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="page-header mt-4 d-flex justify-content-between align-items-center">
        <h2 class="text-green">Advanced Customer Search</h2>
        <a href="CustomerList.aspx" class="btn btn-outline-secondary">Back to List</a>
    </div>

    <div class="row mt-4">
        <div class="col-md-6">
            <div class="card shadow-sm h-100">
                <div class="card-header">
                    <h5 class="mb-0 text-white">Search by Name</h5>
                </div>
                <div class="card-body">
                    <div class="form-group">
                        <label>First Name</label>
                        <asp:TextBox ID="txtSearchFirst" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Last Name</label>
                        <asp:TextBox ID="txtSearchLast" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <asp:Button ID="btnSearch" runat="server" Text="Search Names" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card shadow-sm h-100">
                <div class="card-header">
                    <h5 class="mb-0 text-white">Search by Birth Range</h5>
                </div>
                <div class="card-body">
                    <asp:ValidationSummary runat="server" ValidationGroup="BirthRange" CssClass="alert alert-danger" DisplayMode="BulletList" />
                    <div class="form-group">
                        <label>DOB From</label>
                        <asp:TextBox ID="txtDOBFrom" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="BirthRange" ControlToValidate="txtDOBFrom" ErrorMessage="From Date is required." Display="Dynamic" CssClass="text-danger" runat="server"/>
                    </div>
                    <div class="form-group">
                        <label>DOB To</label>
                        <asp:TextBox ID="txtDOBTo" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="BirthRange" ControlToValidate="txtDOBTo" ErrorMessage="To Date is required." Display="Dynamic" CssClass="text-danger" runat="server"/>
                    </div>
                    <asp:Button ID="btnBirthRange" runat="server" Text="Search Range" ValidationGroup="BirthRange" CssClass="btn btn-warning" OnClick="btnBirthRange_Click" />
                </div>
            </div>
        </div>
    </div>

    <div class="mt-5">
        <h4 class="text-green">Search Results (Names)</h4>
        <div class="table-responsive">
            <asp:GridView ID="gvResults" runat="server" CssClass="table table-striped table-bordered" 
                AutoGenerateColumns="True" EmptyDataText="No records found." AllowPaging="True" PageSize="10" OnPageIndexChanging="gvResults_PageIndexChanging">
                <HeaderStyle CssClass="bg-dark text-gold" />
                <PagerStyle CssClass="pagination-ys" />
            </asp:GridView>
        </div>
    </div>

    <div class="mt-5 mb-5">
        <h4 class="text-green">Search Results (Birth Range)</h4>
        <div class="table-responsive">
            <asp:Repeater ID="rptBirthResults" runat="server">
                <HeaderTemplate>
                    <table class="table table-striped table-bordered">
                        <thead class="bg-dark text-gold">
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Date of Birth</th>
                                <th>Email</th>
                                <th>Contact</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                            <tr>
                                <td><%# Eval("customer_id") %></td>
                                <td><%# Eval("first_name") %> <%# Eval("last_name") %></td>
                                <td><%# Eval("date_of_birth", "{0:yyyy-MM-dd}") %></td>
                                <td><%# Eval("email") %></td>
                                <td><%# Eval("contact_number") %></td>
                            </tr>
                </ItemTemplate>
                <FooterTemplate>
                        </tbody>
                    </table>
                    <asp:Label ID="lblEmpty" runat="server" Visible='<%# rptBirthResults.Items.Count == 0 %>' Text="No records found." CssClass="d-block mt-2 font-italic"></asp:Label>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
