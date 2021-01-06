<%@ Page Title="All Users List" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AllUsers.aspx.cs" Inherits="AmounCRM4.Admins.AllUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <title>All Users List</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <telerik:RadAjaxManager runat="server"></telerik:RadAjaxManager>

    <telerik:RadGrid ID="gridUsers" runat="server" DataSourceID="dsAllUsers" AllowFilteringByColumn="True" AllowPaging="True"
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

        <MasterTableView DataSourceID="dsAllUsers" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
            AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
            <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
            <PagerStyle AlwaysVisible="True" PageSizes="15,50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
            <Columns>
                <telerik:GridBoundColumn DataField="EmployeeHRCode" ReadOnly="True" HeaderText="HR Code" SortExpression="EmployeeHRCode" UniqueName="EmployeeHRCode" DataType="System.Int32" FilterControlAltText="Filter EmployeeHRCode column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="EmployeeFullName" HeaderText="Full Name" SortExpression="EmployeeFullName" UniqueName="EmployeeFullName" FilterControlAltText="Filter EmployeeFullName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="EmployeeType" HeaderText="Role" SortExpression="EmployeeType" UniqueName="EmployeeType" FilterControlAltText="Filter EmployeeType column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="LineName" HeaderText="Line" SortExpression="LineName" UniqueName="LineName" FilterControlAltText="Filter LineName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AmounRegionName" HeaderText="Region" SortExpression="AmounRegionName" UniqueName="AmounRegionName" FilterControlAltText="Filter AmounRegionName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="NoOfVisitsPerDay" HeaderText="No of Visits Per Day" SortExpression="NoOfVisitsPerDay" UniqueName="NoOfVisitsPerDay" FilterControlAltText="Filter NoOfVisitsPerDay column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="RecordCreationDate" HeaderText="Creation Date" SortExpression="RecordCreationDate" UniqueName="RecordCreationDate" DataType="System.DateTime" FilterControlAltText="Filter RecordCreationDate column" DataFormatString="{0:MM/dd/yyyy}" HtmlEncode="false"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="RecordCreatedBy" HeaderText="Created By" SortExpression="RecordCreatedBy" UniqueName="RecordCreatedBy" DataType="System.Int32" FilterControlAltText="Filter RecordCreatedBy column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Last Modification Date" HeaderText="Last PWD Modification Date" SortExpression="Last Modification Date" UniqueName="LastModificationDate" DataType="System.DateTime" FilterControlAltText="Filter Last Modification Date column" DataFormatString="{0:MM/dd/yyyy}" HtmlEncode="false"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Days_Since_Last_Modification" HeaderText="Days" SortExpression="Days_Since_Last_Modification" UniqueName="Days_Since_Last_Modification" DataType="System.Int16" FilterControlAltText="Filter Days_Since_Last_Modification column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Remained_Days" HeaderText="Remained Days" SortExpression="Remained_Days" UniqueName="Remained_Days" DataType="System.Int16" FilterControlAltText="Filter Remained_Days column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="IsDeleted" ReadOnly="True" HeaderText="Status" SortExpression="IsDeleted" UniqueName="IsDeleted" FilterControlAltText="Filter IsDeleted column"></telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource runat="server" ID="dsAllUsers" SelectCommandType="StoredProcedure" SelectCommand="aud_GetUsers" 
        ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'></asp:SqlDataSource>


</asp:Content>
