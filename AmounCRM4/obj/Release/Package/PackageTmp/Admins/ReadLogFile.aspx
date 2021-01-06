<%@ Page Title="Log File" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ReadLogFile.aspx.cs" Inherits="AmounCRM4.Admins.ReadLogFile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <title>Read Log File</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <telerik:RadAjaxManager runat="server"></telerik:RadAjaxManager>

    <telerik:RadGrid ID="griddsAudTrailApp" runat="server" DataSourceID="dsReadLogFile" AllowFilteringByColumn="True" AllowPaging="True"
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

        <MasterTableView DataSourceID="dsReadLogFile" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
            AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
            <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
            <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
            <Columns>
                <telerik:GridBoundColumn DataField="CurrentLSN" ReadOnly="True" HeaderText="Current LSN" SortExpression="CurrentLSN" UniqueName="CurrentLSN" DataType="System.String" FilterControlAltText="Filter CurrentLSN column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Operation" HeaderText="Operation" SortExpression="Operation" UniqueName="Operation" FilterControlAltText="Filter Operation column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TransactionID" HeaderText="Transaction ID" SortExpression="TransactionID" UniqueName="TransactionID" FilterControlAltText="Filter TransactionID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TransactionName" HeaderText="Transaction Name" SortExpression="TransactionName" UniqueName="TransactionName" DataType="System.String" FilterControlAltText="Filter TransactionName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AllocUnitName" HeaderText="AllocUnitName" SortExpression="AllocUnitName" UniqueName="AllocUnitName" DataType="System.String" FilterControlAltText="Filter AllocUnitName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TransactionSID" ReadOnly="True" HeaderText="Transaction SID" SortExpression="TransactionSID" UniqueName="TransactionSID" FilterControlAltText="Filter TransactionSID column" Visible="false"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="DBUserName" ReadOnly="True" HeaderText="DB User Name" SortExpression="DBUserName" UniqueName="DBUserName" FilterControlAltText="Filter DBUserName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="BeginDate" ReadOnly="True" HeaderText="Begin Date" SortExpression="BeginDate" UniqueName="BeginDate" FilterControlAltText="Filter BeginDate column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="EndDate" ReadOnly="True" HeaderText="End Date" SortExpression="EndDate" UniqueName="EndDate" FilterControlAltText="Filter EndDate column"></telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource runat="server" ID="dsReadLogFile" SelectCommandType="StoredProcedure" SelectCommand="aud_ReadLogFile" 
        ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'></asp:SqlDataSource>
</asp:Content>
