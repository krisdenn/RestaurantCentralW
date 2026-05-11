<%@ Page Title="Employees" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeFile="EmployeeList.aspx.cs" Inherits="Pages_Employees_EmployeeList" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
        Employees - RestaurantCentral
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
    </asp:Content>

    <asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
        <div class="page-header mt-4">
            <h2 class="text-green">Manage Employees</h2>
        </div>

        <asp:Label ID="lblError" runat="server" CssClass="text-danger font-weight-bold d-block mb-3"></asp:Label>

        <div class="mb-3 d-flex justify-content-between align-items-center">
            <a href="EmployeeForm.aspx" class="btn btn-primary">Add New Employee</a>
            <div class="form-check">
                <asp:CheckBox ID="chkShowInactive" runat="server" CssClass="form-check-input" AutoPostBack="true"
                    OnCheckedChanged="chkShowInactive_CheckedChanged" />
                <label class="form-check-label ml-2">Show Inactive Employees</label>
            </div>
        </div>

        <div class="table-responsive">
            <asp:GridView ID="gvEmployees" runat="server" CssClass="table table-striped table-bordered table-hover"
                AutoGenerateColumns="False" DataKeyNames="employee_id" OnRowEditing="gvEmployees_RowEditing"
                OnRowCancelingEdit="gvEmployees_RowCancelingEdit" OnRowUpdating="gvEmployees_RowUpdating"
                OnRowDeleting="gvEmployees_RowDeleting" AllowPaging="True" PageSize="10"
                OnPageIndexChanging="gvEmployees_PageIndexChanging" EmptyDataText="No records found.">

                <Columns>
                    <asp:BoundField DataField="employee_id" HeaderText="ID" ReadOnly="True" />
                    <asp:TemplateField HeaderText="First Name">
                        <ItemTemplate>
                            <%# Eval("first_name") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditFirst" runat="server" Text='<%# Bind("first_name") %>'
                                CssClass="form-control" MaxLength="50"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditFirst" ErrorMessage="*"
                                CssClass="text-danger" Display="Dynamic" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Last Name">
                        <ItemTemplate>
                            <%# Eval("last_name") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditLast" runat="server" Text='<%# Bind("last_name") %>'
                                CssClass="form-control" MaxLength="50"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEditLast" ErrorMessage="*"
                                CssClass="text-danger" Display="Dynamic" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Role">
                        <ItemTemplate>
                            <%# Eval("role") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlEditRole" runat="server" CssClass="form-control"
                                SelectedValue='<%# Bind("role") %>'>
                                <asp:ListItem Value="Manager">Manager</asp:ListItem>
                                <asp:ListItem Value="Waiter">Waiter</asp:ListItem>
                                <asp:ListItem Value="Chef">Chef</asp:ListItem>
                                <asp:ListItem Value="Accountant">Accountant</asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Phone">
                        <ItemTemplate>
                            <%# Eval("phone") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditPhone" runat="server" Text='<%# Bind("phone") %>'
                                CssClass="form-control" MaxLength="15"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="hire_date" HeaderText="Hire Date" DataFormatString="{0:yyyy-MM-dd}"
                        ReadOnly="True" />
                    <asp:TemplateField HeaderText="Active">
                        <ItemTemplate>
                            <%# Convert.ToBoolean(Eval("is_active")) ? "Yes" : "No" %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:CheckBox ID="chkEditActive" runat="server" Checked='<%# Bind("is_active") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True"
                        ControlStyle-CssClass="btn btn-sm btn-outline-dark" />
                </Columns>

                <PagerStyle CssClass="pagination-ys" />
            </asp:GridView>
        </div>

        <h4 class="mt-5 mb-3 text-green">Staff on Duty</h4>
        <div class="row">
            <asp:Repeater ID="rptStaff" runat="server">
                <ItemTemplate>
                    <div class="col-md-3 mb-3">
                        <div class="card border-success h-100 shadow-sm">
                            <div class="card-body">
                                <h5 class="card-title text-green">
                                    <%# Eval("full_name") %>
                                </h5>
                                <p class="card-text">
                                    <span class="badge badge-warning text-dark">
                                        <%# Eval("role") %>
                                    </span>
                                </p>
                                <small class="text-muted">Since <%# Eval("hire_date", "{0:yyyy-MM-dd}" ) %></small>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </asp:Content>