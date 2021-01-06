<%@ Page Title="Appointments Audit Trail" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AuditTrailApps.aspx.cs" Inherits="AmounCRM4.Admins.AuditTrailApps" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <title>Appointments Audit Trail</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <telerik:RadAjaxManager runat="server"></telerik:RadAjaxManager>

    <telerik:RadGrid ID="griddsAudTrailApp" runat="server" DataSourceID="dsAudTrailApp" AllowFilteringByColumn="True" AllowPaging="True"
        EnableGroupsExpandAll="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
        AllowSorting="True" GroupPanelPosition="Top" ShowGroupPanel="True" Height="600px"
        Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True">

        <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="ListOfClinics_Physicians">
            <Excel Format="Xlsx" />
        </ExportSettings>

        <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
            <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
        </ClientSettings>

        <MasterTableView DataSourceID="dsAudTrailApp" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
            AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
            <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
            <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
            <Columns>
                <telerik:GridBoundColumn DataField="AppointmentID" ReadOnly="True" HeaderText="Appointment ID" SortExpression="AppointmentID" UniqueName="AppointmentID" DataType="System.Int32" FilterControlAltText="Filter AppointmentID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="EmployeeHRCode" HeaderText="HR Code" SortExpression="EmployeeHRCode" UniqueName="EmployeeHRCode" FilterControlAltText="Filter EmployeeHRCode column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="LineID" HeaderText="Line" SortExpression="LineID" UniqueName="LineID" FilterControlAltText="Filter LineID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="EmployeeName" HeaderText="Full Name" SortExpression="EmployeeName" UniqueName="EmployeeName" FilterControlAltText="Filter EmployeeName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="EmployeeType" HeaderText="Role" SortExpression="EmployeeType" UniqueName="EmployeeType" FilterControlAltText="Filter EmployeeType column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="EntryDateTime" HeaderText="Creation Date" SortExpression="EntryDateTime" UniqueName="EntryDateTime" DataType="System.DateTime" FilterControlAltText="Filter EntryDateTime column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="LastModified" HeaderText="Last Modification" SortExpression="LastModified" UniqueName="LastModified" DataType="System.DateTime" FilterControlAltText="Filter LastModified column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Annotations" HeaderText="Status" SortExpression="Annotations" UniqueName="Annotations" FilterControlAltText="Filter Annotations column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="IsDeleted" ReadOnly="True" HeaderText="Record Status" SortExpression="IsDeleted" UniqueName="IsDeleted" FilterControlAltText="Filter IsDeleted column"></telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource runat="server" ID="dsAudTrailApp" SelectCommandType="StoredProcedure" SelectCommand="aud_GetAuditTrails" 
        ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'></asp:SqlDataSource>



</asp:Content>
