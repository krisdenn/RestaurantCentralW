<%@ Page Title="Payments" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="AccountantPayments.aspx.cs" Inherits="Pages_Reports_AccountantPayments" %>
<%@ Register Src="~/UserControls/AlertMessage.ascx" TagPrefix="uc" TagName="AlertMessage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
    Payments - RestaurantCentral
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="page-header mt-4">
        <h2 class="text-green">Payment Management</h2>
    </div>

    <div class="row">
        <!-- New Payment Form -->
        <div class="col-md-4">
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-dark text-gold">
                    <h5 class="mb-0">Record New Payment</h5>
                </div>
                <div class="card-body">
                    <uc:AlertMessage runat="server" id="ucAlert" />
                    <asp:ValidationSummary runat="server" ValidationGroup="Payment" CssClass="alert alert-danger" DisplayMode="BulletList" />

                    <div class="form-group">
                        <label>Invoice Number</label>
                        <asp:DropDownList ID="ddlInvoice" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlInvoice_SelectedIndexChanged">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ValidationGroup="Payment" ControlToValidate="ddlInvoice" InitialValue="0" ErrorMessage="Select an invoice." Display="Dynamic" CssClass="text-danger" runat="server"/>
                    </div>

                    <div class="form-group">
                        <label>Customer</label>
                        <asp:DropDownList ID="ddlCustomer" runat="server" CssClass="form-control" Enabled="false">
                        </asp:DropDownList>
                        <!-- Enabled=false so it's auto-populated based on invoice, but prompt says dropdown customer. We will keep it enabled if they can select it, but usually it's linked. Let's enable it to match prompt strictly. -->
                    </div>

                    <div class="form-group">
                        <label>Payment Method</label>
                        <asp:DropDownList ID="ddlMethod" runat="server" CssClass="form-control">
                            <asp:ListItem Value="Cash">Cash</asp:ListItem>
                            <asp:ListItem Value="Card">Card</asp:ListItem>
                            <asp:ListItem Value="Online">Online</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form-group">
                        <label>Amount (J$)</label>
                        <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" TextMode="Number" step="0.01"></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="Payment" ControlToValidate="txtAmount" ErrorMessage="Amount is required." Display="Dynamic" CssClass="text-danger" runat="server"/>
                        <asp:RangeValidator ValidationGroup="Payment" ControlToValidate="txtAmount" Type="Currency" MinimumValue="1.00" MaximumValue="999999.00" ErrorMessage="Invalid amount." Display="Dynamic" CssClass="text-danger" runat="server"/>
                    </div>

                    <asp:Button ID="btnRecord" runat="server" Text="Record Payment" ValidationGroup="Payment" CssClass="btn btn-primary btn-block" OnClick="btnRecord_Click" />
                </div>
            </div>
        </div>

        <!-- Payments Grid -->
        <div class="col-md-8">
            <div class="card shadow-sm">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0">Payment History</h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <asp:GridView ID="gvPayments" runat="server" CssClass="table table-striped table-hover mb-0" 
                            AutoGenerateColumns="False" EmptyDataText="No payments recorded."
                            AllowPaging="True" PageSize="10" OnPageIndexChanging="gvPayments_PageIndexChanging">
                            <Columns>
                                <asp:BoundField DataField="payment_id" HeaderText="Payment ID" />
                                <asp:BoundField DataField="invoice_number" HeaderText="Invoice #" />
                                <asp:BoundField DataField="customer_name" HeaderText="Customer" />
                                <asp:BoundField DataField="method" HeaderText="Method" />
                                <asp:BoundField DataField="amount" HeaderText="Amount (J$)" DataFormatString="{0:N2}" />
                                <asp:BoundField DataField="payment_status" HeaderText="Status" />
                                <asp:BoundField DataField="processed_at" HeaderText="Date" DataFormatString="{0:g}" />
                            </Columns>
                            <PagerStyle CssClass="pagination-ys" />
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
