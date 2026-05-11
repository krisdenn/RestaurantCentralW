<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="ManagerDashboard.aspx.cs" Inherits="Pages_Reports_ManagerDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
    Manager Dashboard - RestaurantCentral
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="page-header mt-4">
        <h2 class="text-green">Daily Dashboard</h2>
    </div>

    <!-- Section 1: Daily Summary (from view) -->
    <div class="row mb-4">
        <div class="col-md-12">
            <div class="card shadow-sm border-success">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0">Today's Summary</h5>
                </div>
                <div class="card-body">
                    <asp:GridView ID="gvDailySummary" runat="server" CssClass="table table-bordered mb-0" 
                        AutoGenerateColumns="True" EmptyDataText="No orders today.">
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>

    <!-- Section 2: Function Results (Lowest) -->
    <div class="row mb-4">
        <div class="col-md-12">
            <div class="card shadow-sm border-danger">
                <div class="card-header bg-danger text-white">
                    <h5 class="mb-0">Low Stock Warning (Lowest Item Quantity)</h5>
                </div>
                <div class="card-body d-flex align-items-center justify-content-center">
                    <h3 class="text-danger m-0"><asp:Label ID="lblLowest" runat="server"></asp:Label></h3>
                </div>
            </div>
        </div>
    </div>

    <!-- Section 3 & 4: TVF Lists -->
    <div class="row mb-5">
        <div class="col-md-6">
            <h4 class="text-green border-bottom border-warning pb-2">All Customers</h4>
            <div class="table-responsive" style="max-height: 400px; overflow-y: auto;">
                <asp:GridView ID="gvAllCustomers" runat="server" CssClass="table table-sm table-striped" 
                    AutoGenerateColumns="True" EmptyDataText="No records.">
                    <HeaderStyle CssClass="bg-dark text-gold" />
                </asp:GridView>
            </div>
        </div>
        
        <div class="col-md-6">
            <h4 class="text-green border-bottom border-warning pb-2">All Staff Directory</h4>
            <div class="table-responsive" style="max-height: 400px; overflow-y: auto;">
                <asp:GridView ID="gvAllStaff" runat="server" CssClass="table table-sm table-striped" 
                    AutoGenerateColumns="True" EmptyDataText="No records.">
                    <HeaderStyle CssClass="bg-dark text-gold" />
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
