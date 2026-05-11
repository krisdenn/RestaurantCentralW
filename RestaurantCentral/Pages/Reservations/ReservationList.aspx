<%@ Page Title="Reservations" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="ReservationList.aspx.cs" Inherits="Pages_Reservations_ReservationList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
    Reservations - RestaurantCentral
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="page-header mt-4">
        <h2 class="text-green">Manage Reservations</h2>
    </div>

    <asp:Label ID="lblError" runat="server" CssClass="text-danger font-weight-bold d-block mb-3"></asp:Label>

    <div class="mb-3 d-flex justify-content-between align-items-center">
        <a href="ReservationForm.aspx" class="btn btn-primary">New Reservation</a>
    </div>

    <div class="table-responsive">
        <asp:GridView ID="gvReservations" runat="server" CssClass="table table-striped table-bordered table-hover" 
            AutoGenerateColumns="False" DataKeyNames="reservation_id"
            OnRowEditing="gvReservations_RowEditing" 
            OnRowCancelingEdit="gvReservations_RowCancelingEdit" 
            OnRowUpdating="gvReservations_RowUpdating" 
            OnRowDeleting="gvReservations_RowDeleting"
            AllowPaging="True" PageSize="10" OnPageIndexChanging="gvReservations_PageIndexChanging"
            EmptyDataText="No reservations found.">
            
            <Columns>
                <asp:BoundField DataField="reservation_id" HeaderText="ID" ReadOnly="True" />
                <asp:BoundField DataField="customer_name" HeaderText="Customer" ReadOnly="True" />
                <asp:BoundField DataField="table_number" HeaderText="Table" ReadOnly="True" />
                <asp:TemplateField HeaderText="Date & Time">
                    <ItemTemplate>
                        <%# Eval("reservation_date", "{0:g}") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEditDate" runat="server" Text='<%# Bind("reservation_date", "{0:yyyy-MM-ddTHH:mm}") %>' CssClass="form-control" TextMode="DateTimeLocal"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Party Size">
                    <ItemTemplate>
                        <%# Eval("party_size") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEditParty" runat="server" Text='<%# Bind("party_size") %>' CssClass="form-control" TextMode="Number"></asp:TextBox>
                        <asp:RangeValidator runat="server" ControlToValidate="txtEditParty" MinimumValue="1" MaximumValue="20" Type="Integer" ErrorMessage="1-20 only" Display="Dynamic" CssClass="text-danger"></asp:RangeValidator>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <%# Eval("status") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlEditStatus" runat="server" CssClass="form-control" SelectedValue='<%# Bind("status") %>'>
                            <asp:ListItem Value="Confirmed">Confirmed</asp:ListItem>
                            <asp:ListItem Value="Completed">Completed</asp:ListItem>
                            <asp:ListItem Value="Cancelled">Cancelled</asp:ListItem>
                            <asp:ListItem Value="No Show">No Show</asp:ListItem>
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>
                
                <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" ControlStyle-CssClass="btn btn-sm btn-outline-dark" />
            </Columns>
            
            <HeaderStyle CssClass="bg-dark text-gold" />
            <PagerStyle CssClass="pagination-ys" />
        </asp:GridView>
    </div>
</asp:Content>
