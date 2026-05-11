<%@ Page Title="Customers" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="CustomerList.aspx.cs" Inherits="Pages_Customer_CustomerList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
    Customers - RestaurantCentral
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="page-header mt-4">
        <h2 class="text-green">Manage Customers</h2>
    </div>

    <asp:Label ID="lblError" runat="server" CssClass="text-danger font-weight-bold d-block mb-3"></asp:Label>

    <div class="mb-3 d-flex justify-content-between align-items-center">
        <div class="d-flex align-items-center">
            <a href="CustomerForm.aspx" class="btn btn-primary mr-3">Add New Customer</a>
            <a href="CustomerSearch.aspx" class="btn btn-outline-secondary">Advanced Search</a>
        </div>
        <div class="form-check">
            <asp:CheckBox ID="chkShowInactive" runat="server" CssClass="form-check-input" AutoPostBack="true" OnCheckedChanged="chkShowInactive_CheckedChanged" />
            <label class="form-check-label ml-2">Show Inactive Customers</label>
        </div>
        <asp:Label ID="lblCount" runat="server" CssClass="font-weight-bold"></asp:Label>
    </div>

    <div class="table-responsive">
        <asp:GridView ID="gvCustomers" runat="server" CssClass="table table-striped table-bordered table-hover" 
            AutoGenerateColumns="False" DataKeyNames="customer_id"
            OnRowEditing="gvCustomers_RowEditing" 
            OnRowCancelingEdit="gvCustomers_RowCancelingEdit" 
            OnRowUpdating="gvCustomers_RowUpdating" 
            OnRowDeleting="gvCustomers_RowDeleting"
            AllowPaging="True" PageSize="10" OnPageIndexChanging="gvCustomers_PageIndexChanging"
            EmptyDataText="No records found.">
            
            <Columns>
                <asp:BoundField DataField="customer_id" HeaderText="Customer ID" ReadOnly="True" />
                <asp:TemplateField HeaderText="First Name">
                    <ItemTemplate>
                        <%# Eval("first_name") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEditFirstName" runat="server" Text='<%# Bind("first_name") %>' CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditFirstName" runat="server" ControlToValidate="txtEditFirstName" ErrorMessage="*" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Last Name">
                    <ItemTemplate>
                        <%# Eval("last_name") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEditLastName" runat="server" Text='<%# Bind("last_name") %>' CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditLastName" runat="server" ControlToValidate="txtEditLastName" ErrorMessage="*" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="email" HeaderText="Email" />
                <asp:BoundField DataField="contact_number" HeaderText="Contact" />
                <asp:TemplateField HeaderText="Registered">
                    <ItemTemplate>
                        <%# Convert.ToBoolean(Eval("is_registered")) ? "Yes" : "No" %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" ControlStyle-CssClass="btn btn-sm btn-outline-dark" />
            </Columns>
            
            <PagerStyle CssClass="pagination-ys" />
        </asp:GridView>
    </div>

    <h4 class="mt-5 text-green">All Customers Summary</h4>
    <div class="table-responsive">
        <asp:GridView ID="gvAllCustomers" runat="server" CssClass="table table-sm table-hover mt-3" 
            AutoGenerateColumns="True" EmptyDataText="No records found.">
            <HeaderStyle CssClass="bg-dark text-gold" />
        </asp:GridView>
    </div>
</asp:Content>
