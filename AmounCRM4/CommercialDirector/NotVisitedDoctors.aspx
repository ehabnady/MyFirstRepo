<%@ Page Title="Not visited Doctors" Language="C#" MasterPageFile="~/CommercialDirector/SiteMaster2.Master" AutoEventWireup="true" CodeBehind="NotVisitedDoctors.aspx.cs" Inherits="AmounCRM4.CommercialDirector.NotVisitedDoctors" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <link type="text/css" rel="stylesheet" href="styles.css" />
    <style type="text/css">
        .panelItem {
            height: auto;
        }

        .DivCenter {
            text-align: center;
            align-items: center;
            vertical-align: middle;
            margin-left:auto; margin-right:auto
        }
    </style>

    <title>Not visited Doctors</title>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="p1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadPanelBar1" LoadingPanelID="ALP1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    
    <script src="scripts.js" type="text/javascript"></script>

    <telerik:RadAjaxLoadingPanel ID="ALP1" runat="server"></telerik:RadAjaxLoadingPanel>

    <asp:Panel ID="p1" runat="server" Width="96%" CssClass="DivCenter">
        <div class="DivCenter">
            <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="100%" Height="800px" Skin="WebBlue" ExpandMode="FullExpandedItem">
                <Items>
<telerik:RadPanelItem Text="Not visited Doctors" Expanded="true" Font-Size="Large" CssClass="panelItem" Width="100%">
                    
                    <ContentTemplate>
    <telerik:RadGrid ID="gridNotPlanned" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True"
        DataSourceID="dsNotVisited" GroupPanelPosition="Top" ShowGroupPanel="True" Height="100%" Width="100%"
        Skin="WebBlue" EnableHeaderContextMenu="True" EnableHeaderContextAggregatesMenu="true" EnableHeaderContextFilterMenu="true"
        GridLines="Both" PageSize="50" ShowFooter="True">

        <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="ListOfRepsAchievment">
            <Excel Format="Xlsx" />
        </ExportSettings>

        <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
            <Scrolling AllowScroll="true" />
            <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
        </ClientSettings>

        <MasterTableView AutoGenerateColumns="False" DataSourceID="dsNotVisited" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
            AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
            <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
            <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
            <Columns>
                <telerik:GridBoundColumn DataField="AffiliationID" FilterControlAltText="Filter AffiliationID column" HeaderText="Doctor ID" SortExpression="AffiliationID" UniqueName="AffiliationID">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AffiliationName" FilterControlAltText="Filter AffiliationName column" HeaderText="Doctor" SortExpression="AffiliationName" UniqueName="AffiliationName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SpecialityCode" FilterControlAltText="Filter SpecialityCode column" HeaderText="Specialty" SortExpression="SpecialityCode" UniqueName="SpecialityCode">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PhysicianClass" FilterControlAltText="Filter PhysicianClass column" HeaderText="Class" SortExpression="PhysicianClass" UniqueName="PhysicianClass">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="IsTargeted3" DataType="System.String" FilterControlAltText="Filter IsTargeted3 column" HeaderText="Mandatory?" SortExpression="IsTargeted3" UniqueName="IsTargeted3">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AmounBrickName" DataType="System.String" FilterControlAltText="Filter AmounBrickName column" HeaderText="Brick" SortExpression="AmounBrickName" UniqueName="AmounBrickName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AmounTerritoryName" DataType="System.String" FilterControlAltText="Filter AmounTerritoryName column" HeaderText="Area" SortExpression="AmounTerritoryName" UniqueName="AmounTerritoryName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SupervisorName" DataType="System.String" FilterControlAltText="Filter SupervisorName column" HeaderText="Disrtict Manager" SortExpression="SupervisorName" UniqueName="SupervisorName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ManagerName" DataType="System.String" FilterControlAltText="Filter ManagerName column" HeaderText="Sales Manager" SortExpression="ManagerName" UniqueName="ManagerName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="EmployeeName" DataType="System.String" FilterControlAltText="Filter EmployeeName column" HeaderText="Rep Name" SortExpression="EmployeeName" UniqueName="EmployeeName">
                </telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>

    <asp:SqlDataSource ID="dsNotVisited" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
        SelectCommand="GetNotVisited_ComDir" SelectCommandType="StoredProcedure" OnSelecting="dsNotVisited_Selecting">
        <SelectParameters>
            <asp:SessionParameter Name="CycleIDFromComDir" SessionField="CycleIDFromComDir" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

                          </ContentTemplate>
                </telerik:RadPanelItem>
                </Items>
            </telerik:RadPanelBar>
        </div>
    </asp:Panel>

</asp:Content>
