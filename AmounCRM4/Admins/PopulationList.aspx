<%@ Page Title="Population List" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="PopulationList.aspx.cs" Inherits="AmounCRM4.Admins.PopulationList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <title>Population List</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <telerik:RadAjaxManager runat="server"></telerik:RadAjaxManager>

    <telerik:RadGrid ID="grdPop" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True" ShowGroupPanel="True" 
        Skin="WebBlue" CellSpacing="-1" DataSourceID="dsPopList" GridLines="Both" EnableHeaderContextFilterMenu="True">
        <ExportSettings Excel-Format="Xlsx" ExportOnlyData="true" Excel-FileExtension=".xlsx" IgnorePaging="true" ></ExportSettings> 
        <CommandItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
        <ClientSettings AllowDragToGroup="True" AllowColumnHide="true" AllowColumnsReorder="true">
            <Resizing AllowResizeToFit="true" AllowColumnResize="true" AllowRowResize="true" EnableRealTimeResize="true" EnableNextColumnResize="true" ResizeGridOnColumnResize="false" />
            <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
        </ClientSettings>
        <PagerStyle AlwaysVisible="true" PageSizes="10,100,200,300,400,500" Mode="NextPrevAndNumeric" />
        <MasterTableView DataKeyNames="AffiliationID" DataSourceID="dsPopList" AutoGenerateColumns="False" CommandItemDisplay="Top">
            <CommandItemSettings ShowExportToExcelButton="true" ShowRefreshButton="true" RefreshText="Refresh" ExportToExcelText="Excel" ShowAddNewRecordButton="false" />
            <Columns>
                <telerik:GridBoundColumn DataField="AffiliationID" ReadOnly="True" HeaderText="Doctor ID" SortExpression="AffiliationID" UniqueName="AffiliationID" DataType="System.Int32" FilterControlAltText="Filter AffiliationID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AffiliationName" HeaderText="Doctor Name" SortExpression="AffiliationName" UniqueName="AffiliationName" FilterControlAltText="Filter AffiliationName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="EntityAddress" HeaderText="Address" SortExpression="EntityAddress" UniqueName="EntityAddress" FilterControlAltText="Filter EntityAddress column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SpecialityCode" HeaderText="Spec" SortExpression="SpecialityCode" UniqueName="SpecialityCode" FilterControlAltText="Filter SpecialityCode column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PhysicianClass" HeaderText="Class" SortExpression="PhysicianClass" UniqueName="PhysicianClass" FilterControlAltText="Filter PhysicianClass column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="NoOfPatients" HeaderText="No of Pat" SortExpression="NoOfPatients" UniqueName="NoOfPatients" DataType="System.Double" FilterControlAltText="Filter NoOfPatients column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SpecialtyValue" HeaderText="Spec Val" SortExpression="SpecialtyValue" UniqueName="SpecialtyValue" DataType="System.Double" FilterControlAltText="Filter SpecialtyValue column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PrescriptionHappit" HeaderText="Presc Hab" SortExpression="PrescriptionHappit" UniqueName="PrescriptionHappit" DataType="System.Double" FilterControlAltText="Filter PrescriptionHappit column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TotalValue" HeaderText="Val" SortExpression="TotalValue" UniqueName="TotalValue" DataType="System.Double" FilterControlAltText="Filter TotalValue column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="IsTargeted3" ReadOnly="True" HeaderText="Mandatory?" SortExpression="IsTargeted3" UniqueName="IsTargeted3" FilterControlAltText="Filter IsTargeted3 column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="LineID" HeaderText="Line" SortExpression="LineID" UniqueName="LineID" DataType="System.Int32" FilterControlAltText="Filter LineID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="EmployeeHRCode" HeaderText="HRCode" SortExpression="EmployeeHRCode" UniqueName="EmployeeHRCode" DataType="System.Int32" FilterControlAltText="Filter EmployeeHRCode column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="EmployeeName" HeaderText="Rep Name" SortExpression="EmployeeName" UniqueName="EmployeeName" FilterControlAltText="Filter EmployeeName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SupervisorName" HeaderText="DM Name" SortExpression="SupervisorName" UniqueName="SupervisorName" FilterControlAltText="Filter SupervisorName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AmounRegionName" HeaderText="Region" SortExpression="AmounRegionName" UniqueName="AmounRegionName" FilterControlAltText="Filter AmounRegionName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SupervisionArea" HeaderText="District" SortExpression="SupervisionArea" UniqueName="SupervisionArea" FilterControlAltText="Filter SupervisionArea column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AmounTerritoryName" HeaderText="Terr" SortExpression="AmounTerritoryName" UniqueName="AmounTerritoryName" FilterControlAltText="Filter AmounTerritoryName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="BrickID" HeaderText="Brick ID" SortExpression="BrickID" UniqueName="BrickID" DataType="System.Int32" FilterControlAltText="Filter BrickID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AmounBrickName" HeaderText="Brick Name" SortExpression="AmounBrickName" UniqueName="AmounBrickName" FilterControlAltText="Filter AmounBrickName column"></telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource runat="server" ID="dsPopList" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
        SelectCommand="SELECT [AffiliationID], [AffiliationName], [SpecialityCode], [PhysicianClass], [NoOfPatients], [SpecialtyValue], 
        [PrescriptionHappit], [TotalValue], [IsTargeted3], [LineID], [EmployeeHRCode], [EmployeeName], [SupervisorName], [AmounRegionName], 
        [SupervisionArea], [AmounTerritoryName], [EntityAddress], [BrickID], [AmounBrickName] FROM [View_Affiliations_Admin] Where Deleted IS NULL OR Deleted = 0"></asp:SqlDataSource>
</asp:Content>
