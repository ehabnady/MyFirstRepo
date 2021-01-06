<%@ Page Title="Sales Reps - Pharmacies" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="SalesRepsPharmacies.aspx.cs" Inherits="AmounCRM4.Admins.SalesRepsPharmacies" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <title>Sales Reps - Pharmacies</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <telerik:RadGrid DataSourceID="dsResp" ID="grdResp" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True"
        Height="600px" GroupPanelPosition="Top" ShowGroupPanel="True"
        Skin="WebBlue" EnableHeaderContextMenu="True" EnableHeaderContextAggregatesMenu="true" EnableHeaderContextFilterMenu="true"
        GridLines="Both" PageSize="50" ShowFooter="True">

        <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="SalesReport">
            <Excel Format="Xlsx" />
        </ExportSettings>

        <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
            <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
        </ClientSettings>

        <MasterTableView DataSourceID="dsResp" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
            AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
            <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
            <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
            <Columns>
                <telerik:GridBoundColumn DataField="PharmacyID" HeaderText="Pharmacy Code" SortExpression="PharmacyID" UniqueName="PharmacyID" DataType="System.String" FilterControlAltText="Filter PharmacyID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PharmacyName" HeaderText="Pharmacy Name" SortExpression="PharmacyName" UniqueName="PharmacyName" FilterControlAltText="Filter PharmacyName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AmounBrickName" HeaderText="Brick" SortExpression="AmounBrickName" UniqueName="AmounBrickName" DataType="System.String" FilterControlAltText="Filter AmounBrickName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="RepAreaName" HeaderText="Territory" SortExpression="RepAreaName" UniqueName="RepAreaName" DataType="System.String" FilterControlAltText="Filter RepAreaName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="EmployeeID" HeaderText="Rep HR Code" SortExpression="EmployeeID" UniqueName="EmployeeID" DataType="System.Double" FilterControlAltText="Filter EmployeeID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="EmployeeFullName" HeaderText="Rep Name" SortExpression="EmployeeFullName" UniqueName="EmployeeFullName" DataType="System.String" FilterControlAltText="Filter EmployeeFullName column"></telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource runat="server" ID="dsResp" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
        SelectCommand="SELECT [PharmacyID], [PharmacyName], [EmployeeID], [EmployeeFullName], [AmounBrickName], [RepAreaName] FROM [View_PH_PharmacyEmployees_SalesReps]">
        <SelectParameters>
            <asp:SessionParameter SessionField="EmployeeHRCodeFromSales" Name="EmployeeHRCodeFromSales" Type="Int32"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
