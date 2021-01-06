<%@ Page Title="" Language="C#" MasterPageFile="~/Site2.Master" AutoEventWireup="true" CodeBehind="VacationReportO.aspx.cs" Inherits="AmounCRM4.Admins.VacationReportO" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <title>Vacations Report</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <telerik:RadAjaxManager runat="server"></telerik:RadAjaxManager>
    <telerik:RadGrid ID="grd" runat="server" DataSourceID="dsVac" AllowFilteringByColumn="True" AllowPaging="True"
        EnableGroupsExpandAll="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
        AllowSorting="True" GroupPanelPosition="Top" ShowGroupPanel="True" Height="600px"
        Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True">
        <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="ListOfRepsVacations">
            <Excel Format="Xlsx" />
        </ExportSettings>

        <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
            <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
        </ClientSettings>

        <MasterTableView DataSourceID="dsVac" 
            AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
            AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
            <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
            <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
            <Columns>
                <telerik:GridBoundColumn DataField="EmpHRCode" HeaderText="Rep HRCode" SortExpression="EmpHRCode" UniqueName="EmpHRCode" DataType="System.Int32" FilterControlAltText="Filter EmpHRCode column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="EmpName" HeaderText="Rep Name" SortExpression="EmpName" UniqueName="EmpName" FilterControlAltText="Filter EmpName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="DirectManagerName" HeaderText="District Manager" SortExpression="DirectManagerName" UniqueName="DirectManagerName" FilterControlAltText="Filter DirectManagerName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TopManagerName" HeaderText="Sales Manager" SortExpression="TopManagerName" UniqueName="TopManagerName" FilterControlAltText="Filter TopManagerName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Duration" HeaderText="Duration (Days)" SortExpression="Duration" UniqueName="Duration" DataType="System.Int32" FilterControlAltText="Filter Duration column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="CycleDesc" HeaderText="CycleDesc" SortExpression="CycleDesc" UniqueName="CycleDesc" FilterControlAltText="Filter CycleDesc column"></telerik:GridBoundColumn>
                <telerik:GridDateTimeColumn DataField="StartDate" FilterControlAltText="Filter Date column" HeaderText="Start Date" SortExpression="StartDate" UniqueName="StartDate" DataType="System.DateTime" Visible="true" DataFormatString="{0:dd/MM/yyyy}" HtmlEncode="false"></telerik:GridDateTimeColumn>
                <telerik:GridDateTimeColumn DataField="EndDate" FilterControlAltText="Filter Date column" HeaderText="End Date" SortExpression="EndDate" UniqueName="EndDate" DataType="System.DateTime" Visible="true" DataFormatString="{0:dd/MM/yyyy}" HtmlEncode="false"></telerik:GridDateTimeColumn>
                <telerik:GridBoundColumn DataField="VacationType" HeaderText="Vacation Type" SortExpression="VacationType" UniqueName="VacationType" FilterControlAltText="Filter VacationType column"></telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource ID="dsVac" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT * FROM [View_EmployeesVacations]"></asp:SqlDataSource>

</asp:Content>
