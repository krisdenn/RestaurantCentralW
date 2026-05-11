<%@ Page Title="New Reservation" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="ReservationForm.aspx.cs" Inherits="Pages_Reservations_ReservationForm" %>
<%@ Register Src="~/UserControls/AlertMessage.ascx" TagPrefix="uc" TagName="AlertMessage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
    New Reservation - RestaurantCentral
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="page-header mt-4 d-flex justify-content-between align-items-center">
        <h2 class="text-green">Book a Table</h2>
        <a href="ReservationList.aspx" class="btn btn-outline-secondary">Back to List</a>
    </div>

    <uc:AlertMessage runat="server" id="ucAlert" />

    <asp:ValidationSummary runat="server" HeaderText="Please correct the following:" CssClass="alert alert-danger mt-3" DisplayMode="BulletList" />

    <div class="card shadow-sm mt-4">
        <div class="card-body">
            <div class="row">
                <div class="col-md-6 form-group">
                    <label>Customer</label>
                    <asp:DropDownList ID="ddlCustomer" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ControlToValidate="ddlCustomer" InitialValue="0" ErrorMessage="Please select a customer." Display="Dynamic" CssClass="text-danger" runat="server"/>
                </div>
                
                <div class="col-md-6 form-group">
                    <label>Dining Table</label>
                    <asp:DropDownList ID="ddlTable" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ControlToValidate="ddlTable" InitialValue="0" ErrorMessage="Please select a table." Display="Dynamic" CssClass="text-danger" runat="server"/>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 form-group">
                    <label>Date and Time</label>
                    <asp:TextBox ID="txtResDate" runat="server" CssClass="form-control" TextMode="DateTimeLocal"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtResDate" ErrorMessage="Reservation date and time is required." Display="Dynamic" CssClass="text-danger" runat="server"/>
                    <asp:CustomValidator ID="cvFutureDate" runat="server" ControlToValidate="txtResDate" ErrorMessage="Reservation must be in the future." Display="Dynamic" CssClass="text-danger" OnServerValidate="cvFutureDate_ServerValidate"></asp:CustomValidator>
                </div>
                
                <div class="col-md-6 form-group">
                    <label>Party Size (1-20)</label>
                    <asp:TextBox ID="txtPartySize" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtPartySize" ErrorMessage="Party size is required." Display="Dynamic" CssClass="text-danger" runat="server"/>
                    <asp:RangeValidator ControlToValidate="txtPartySize" Type="Integer" MinimumValue="1" MaximumValue="20" ErrorMessage="Party size must be between 1 and 20." Display="Dynamic" CssClass="text-danger" runat="server"/>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12 form-group">
                    <label>Special Requests / Notes</label>
                    <asp:TextBox ID="txtNotes" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                </div>
            </div>

            <div class="mt-4">
                <asp:Button ID="btnSave" runat="server" Text="Confirm Booking" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary ml-2" CausesValidation="false" OnClick="btnClear_Click" />
            </div>
        </div>
    </div>
</asp:Content>
