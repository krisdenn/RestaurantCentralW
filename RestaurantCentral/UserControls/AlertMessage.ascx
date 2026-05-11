<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AlertMessage.ascx.cs" Inherits="UserControls_AlertMessage" %>
<asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-dismissible fade show mt-3" role="alert">
    <asp:Literal ID="litMessage" runat="server"></asp:Literal>
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</asp:Panel>
