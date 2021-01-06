<%@ Page Title="New Temp Doctors" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="TempDoctorsNew.aspx.cs" Inherits="AmounCRM4.Admins.TempDoctorsNew" %>


<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <title>New Temp Doctors</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">

    <telerik:RadAjaxManager runat="server"></telerik:RadAjaxManager>

    <telerik:RadGrid ID="grdTempDeoctors" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True" ShowGroupPanel="True" Skin="WebBlue" 
        DataSourceID="dsTempNewDoctors" CellSpacing="-1" GridLines="Both">

        <GroupingSettings CollapseAllTooltip="Collapse all groups" ShowUnGroupButton="True" RetainGroupFootersVisibility="True"></GroupingSettings>
        <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="ECMS_TempDoctors">
            <Excel Format="Xlsx" />
        </ExportSettings>
        <ClientSettings AllowDragToGroup="True" AllowColumnsReorder="True">
            <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
            <Selecting AllowRowSelect="True"></Selecting>
            <Resizing AllowColumnResize="true" AllowResizeToFit="true" EnableRealTimeResize="true" EnableNextColumnResize="true" ResizeGridOnColumnResize="true"
                ShowRowIndicatorColumn="true" AllowRowResize="true" />
        </ClientSettings>

        <MasterTableView DataSourceID="dsTempNewDoctors" AutoGenerateColumns="False">
            <Columns>
                <telerik:GridBoundColumn DataField="AffiliationsTemp_AffiliationID" HeaderText="AffiliationsTemp_AffiliationID" SortExpression="AffiliationsTemp_AffiliationID" UniqueName="AffiliationsTemp_AffiliationID" FilterControlAltText="Filter AffiliationsTemp_AffiliationID column" DataType="System.Int32"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AffiliationsTemp_ID" HeaderText="AffiliationsTemp_ID" SortExpression="AffiliationsTemp_ID" UniqueName="AffiliationsTemp_ID" FilterControlAltText="Filter AffiliationsTemp_ID column" DataType="System.Int32"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PhysicianValueByLineTemp_ID" HeaderText="PhysicianValueByLineTemp_ID" SortExpression="PhysicianValueByLineTemp_ID" UniqueName="PhysicianValueByLineTemp_ID" DataType="System.Int32" FilterControlAltText="Filter PhysicianValueByLineTemp_ID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PhysicianValueByLineTemp_RecID" HeaderText="PhysicianValueByLineTemp_RecID" SortExpression="PhysicianValueByLineTemp_RecID" UniqueName="PhysicianValueByLineTemp_RecID" DataType="System.Int32" FilterControlAltText="Filter PhysicianValueByLineTemp_RecID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AffiliationName" HeaderText="AffiliationName" SortExpression="AffiliationName" UniqueName="AffiliationName" FilterControlAltText="Filter AffiliationName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PhysicianID" HeaderText="PhysicianID" SortExpression="PhysicianID" UniqueName="PhysicianID" DataType="System.Int32" FilterControlAltText="Filter PhysicianID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="EntityID" HeaderText="EntityID" SortExpression="EntityID" UniqueName="EntityID" DataType="System.Int32" FilterControlAltText="Filter EntityID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="LineID" HeaderText="LineID" SortExpression="LineID" UniqueName="LineID" DataType="System.Int32" FilterControlAltText="Filter LineID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Required_NoOfPatients" HeaderText="Required_NoOfPatients" SortExpression="Required_NoOfPatients" UniqueName="Required_NoOfPatients" FilterControlAltText="Filter Required_NoOfPatients column" DataType="System.Double"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Required_NoOfOperations" HeaderText="Required_NoOfOperations" SortExpression="Required_NoOfOperations" UniqueName="Required_NoOfOperations" FilterControlAltText="Filter Required_NoOfOperations column" DataType="System.Double"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Required_SpecialtyValue" HeaderText="Required_SpecialtyValue" SortExpression="Required_SpecialtyValue" UniqueName="Required_SpecialtyValue" FilterControlAltText="Filter Required_SpecialtyValue column" DataType="System.Double"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Required_PrescriptionHappit" HeaderText="Required_PrescriptionHappit" SortExpression="Required_PrescriptionHappit" UniqueName="Required_PrescriptionHappit" FilterControlAltText="Filter Required_PrescriptionHappit column" DataType="System.Double"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Required_TotalValue" HeaderText="Required_TotalValue" SortExpression="Required_TotalValue" UniqueName="Required_TotalValue" DataType="System.Double" FilterControlAltText="Filter Required_TotalValue column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Required_WaitingTime" HeaderText="Required_WaitingTime" SortExpression="Required_WaitingTime" UniqueName="Required_WaitingTime" DataType="System.Double" FilterControlAltText="Filter Required_WaitingTime column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PhysicianClass" HeaderText="PhysicianClass" SortExpression="PhysicianClass" UniqueName="PhysicianClass" FilterControlAltText="Filter PhysicianClass column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Notes" HeaderText="Notes" SortExpression="Notes" UniqueName="Notes" FilterControlAltText="Filter Notes column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="LastModificationDate" HeaderText="LastModificationDate" SortExpression="LastModificationDate" UniqueName="LastModificationDate" FilterControlAltText="Filter LastModificationDate column" DataType="System.DateTime"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="LastModifierID" HeaderText="LastModifierID" SortExpression="LastModifierID" UniqueName="LastModifierID" DataType="System.Int32" FilterControlAltText="Filter LastModifierID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="EntryDate" HeaderText="EntryDate" SortExpression="EntryDate" UniqueName="EntryDate" DataType="System.DateTime" FilterControlAltText="Filter EntryDate column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="CreatorID" HeaderText="CreatorID" SortExpression="CreatorID" UniqueName="CreatorID" DataType="System.Int32" FilterControlAltText="Filter CreatorID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PhysicianValueByLineTemp_CreateDate" HeaderText="PhysicianValueByLineTemp_CreateDate" SortExpression="PhysicianValueByLineTemp_CreateDate" UniqueName="PhysicianValueByLineTemp_CreateDate" FilterControlAltText="Filter PhysicianValueByLineTemp_CreateDate column" DataType="System.DateTime"></telerik:GridBoundColumn>
                <telerik:GridCheckBoxColumn DataField="AffiliationsTemp_RecStatus" HeaderText="AffiliationsTemp_RecStatus" SortExpression="AffiliationsTemp_RecStatus" UniqueName="AffiliationsTemp_RecStatus" DataType="System.Boolean" FilterControlAltText="Filter AffiliationsTemp_RecStatus column"></telerik:GridCheckBoxColumn>

                <telerik:GridCheckBoxColumn DataField="PhysicianValueByLineTemp_Status" HeaderText="PhysicianValueByLineTemp_Status" SortExpression="PhysicianValueByLineTemp_Status" UniqueName="PhysicianValueByLineTemp_Status" DataType="System.Boolean" FilterControlAltText="Filter PhysicianValueByLineTemp_Status column"></telerik:GridCheckBoxColumn>
                <telerik:GridCheckBoxColumn DataField="AffiliationsTemp_IsNew" HeaderText="AffiliationsTemp_IsNew" SortExpression="AffiliationsTemp_IsNew" UniqueName="AffiliationsTemp_IsNew" DataType="System.Boolean" FilterControlAltText="Filter AffiliationsTemp_IsNew column"></telerik:GridCheckBoxColumn>
                <telerik:GridCheckBoxColumn DataField="PhysicianValueByLineTemp_New" HeaderText="PhysicianValueByLineTemp_New" SortExpression="PhysicianValueByLineTemp_New" UniqueName="PhysicianValueByLineTemp_New" DataType="System.Boolean" FilterControlAltText="Filter PhysicianValueByLineTemp_New column"></telerik:GridCheckBoxColumn>
                <telerik:GridCheckBoxColumn DataField="AffiliationsTemp_Deleted" HeaderText="AffiliationsTemp_Deleted" SortExpression="AffiliationsTemp_Deleted" UniqueName="AffiliationsTemp_Deleted" DataType="System.Boolean" FilterControlAltText="Filter AffiliationsTemp_Deleted column"></telerik:GridCheckBoxColumn>
                <telerik:GridCheckBoxColumn DataField="PhysicianValueByLineTemp_Deleted" HeaderText="PhysicianValueByLineTemp_Deleted" SortExpression="PhysicianValueByLineTemp_Deleted" UniqueName="PhysicianValueByLineTemp_Deleted" DataType="System.Boolean" FilterControlAltText="Filter PhysicianValueByLineTemp_Deleted column"></telerik:GridCheckBoxColumn>
                <telerik:GridBoundColumn DataField="CurrentSpecialtyID" HeaderText="CurrentSpecialtyID" SortExpression="CurrentSpecialtyID" UniqueName="CurrentSpecialtyID" DataType="System.Int32" FilterControlAltText="Filter CurrentSpecialtyID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="CurrentBrickID" HeaderText="CurrentBrickID" SortExpression="CurrentBrickID" UniqueName="CurrentBrickID" DataType="System.Int32" FilterControlAltText="Filter CurrentBrickID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="CurrentBrickName" HeaderText="CurrentBrickName" SortExpression="CurrentBrickName" UniqueName="CurrentBrickName" FilterControlAltText="Filter CurrentBrickName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="CurrentSpecialtyCode" HeaderText="CurrentSpecialtyCode" SortExpression="CurrentSpecialtyCode" UniqueName="CurrentSpecialtyCode" FilterControlAltText="Filter CurrentSpecialtyCode column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AmounBrickName" HeaderText="AmounBrickName" SortExpression="AmounBrickName" UniqueName="AmounBrickName" FilterControlAltText="Filter AmounBrickName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="RepAreaID" HeaderText="RepAreaID" SortExpression="RepAreaID" UniqueName="RepAreaID" DataType="System.Int32" FilterControlAltText="Filter RepAreaID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="RepAreaName" HeaderText="RepAreaName" SortExpression="RepAreaName" UniqueName="RepAreaName" FilterControlAltText="Filter RepAreaName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="EmployeeID" HeaderText="EmployeeID" SortExpression="EmployeeID" UniqueName="EmployeeID" DataType="System.Int32" FilterControlAltText="Filter EmployeeID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="EmployeeHRCode" HeaderText="EmployeeHRCode" SortExpression="EmployeeHRCode" UniqueName="EmployeeHRCode" DataType="System.Int32" FilterControlAltText="Filter EmployeeHRCode column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="EmployeeFullName" HeaderText="EmployeeFullName" SortExpression="EmployeeFullName" UniqueName="EmployeeFullName" FilterControlAltText="Filter EmployeeFullName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="DirectManagerID" HeaderText="DirectManagerID" SortExpression="DirectManagerID" UniqueName="DirectManagerID" DataType="System.Int32" FilterControlAltText="Filter DirectManagerID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="DirectManagerHRCode" HeaderText="DirectManagerHRCode" SortExpression="DirectManagerHRCode" UniqueName="DirectManagerHRCode" DataType="System.Int32" FilterControlAltText="Filter DirectManagerHRCode column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="DirectManagerName" HeaderText="DirectManagerName" SortExpression="DirectManagerName" UniqueName="DirectManagerName" FilterControlAltText="Filter DirectManagerName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TopManagerID" HeaderText="TopManagerID" SortExpression="TopManagerID" UniqueName="TopManagerID" DataType="System.Int32" FilterControlAltText="Filter TopManagerID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TopManagerHRCode" HeaderText="TopManagerHRCode" SortExpression="TopManagerHRCode" UniqueName="TopManagerHRCode" DataType="System.Int32" FilterControlAltText="Filter TopManagerHRCode column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TopManagerName" HeaderText="TopManagerName" SortExpression="TopManagerName" UniqueName="TopManagerName" FilterControlAltText="Filter TopManagerName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="DirectorID" HeaderText="DirectorID" SortExpression="DirectorID" UniqueName="DirectorID" DataType="System.Int32" FilterControlAltText="Filter DirectorID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="DirectorHRCode" HeaderText="DirectorHRCode" SortExpression="DirectorHRCode" UniqueName="DirectorHRCode" FilterControlAltText="Filter DirectorHRCode column" DataType="System.Int32"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="DirectorName" HeaderText="DirectorName" SortExpression="DirectorName" UniqueName="DirectorName" FilterControlAltText="Filter DirectorName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="NoOfVisitsPerDay" HeaderText="NoOfVisitsPerDay" SortExpression="NoOfVisitsPerDay" UniqueName="NoOfVisitsPerDay" FilterControlAltText="Filter NoOfVisitsPerDay column" DataType="System.Int32"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="RegionID" HeaderText="RegionID" SortExpression="RegionID" UniqueName="RegionID" FilterControlAltText="Filter RegionID column" DataType="System.Int32"></telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource runat="server" ID="dsTempNewDoctors" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
        SelectCommand="SELECT * FROM [View_Affiliations_Temp_New_Admin]"></asp:SqlDataSource>
</asp:Content>
