<%@ Page Title="Call Rate" Language="C#" MasterPageFile="~/CommercialDirector/SiteMaster2.Master" AutoEventWireup="true" CodeBehind="CallRate.aspx.cs" Inherits="AmounCRM4.CommercialDirector.CallRate" %>

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

    <title>Call Rate</title>
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
                    <telerik:RadPanelItem Text="Call Rate" Expanded="true" Font-Size="Large" CssClass="panelItem" Width="100%">
                    
                    <ContentTemplate>
    <telerik:RadGrid ID="gridAchRatio" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True"
        DataSourceID="dsRepAchRatio" GroupPanelPosition="Top" ShowGroupPanel="True" Height="100%" Width="100%"
        Skin="WebBlue" EnableHeaderContextMenu="True" EnableHeaderContextAggregatesMenu="true" EnableHeaderContextFilterMenu="true"
        GridLines="Both" PageSize="50" ShowFooter="True">

        <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="ListOfRepsAchievment">
            <Excel Format="Xlsx" />
        </ExportSettings>

        <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
            <Scrolling AllowScroll="true" />
            <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
        </ClientSettings>

        <MasterTableView AutoGenerateColumns="False" DataSourceID="dsRepAchRatio" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
            AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true" EnableHeaderContextMenu="True" EnableHeaderContextAggregatesMenu="true" EnableHeaderContextFilterMenu="true">
            <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
            <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
            <Columns>
                <telerik:GridBoundColumn DataField="CycleDesc" FilterControlAltText="Filter CycleDesc column" HeaderText="Cycle" SortExpression="CycleDesc" UniqueName="CycleDesc">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AmounRegionName" FilterControlAltText="Filter AmounRegionName column" HeaderText="Region Name" SortExpression="AmounRegionName" UniqueName="AmounRegionName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="NewSupervisionAreaName" FilterControlAltText="Filter NewSupervisionAreaName column" HeaderText="Super Area" SortExpression="NewSupervisionAreaName" UniqueName="NewSupervisionAreaName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="NewAreaName" FilterControlAltText="Filter NewAreaName column" HeaderText="Territory" SortExpression="NewAreaName" UniqueName="NewAreaName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SupervisorName" FilterControlAltText="Filter SupervisorName column" HeaderText="District Manager" SortExpression="SupervisorName" UniqueName="SupervisorName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TopManagerName" FilterControlAltText="Filter TopManagerName column" HeaderText="Sales Manager" SortExpression="TopManagerName" UniqueName="TopManagerName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AppointmentsCount" DataType="System.Int32" FilterControlAltText="Filter AppointmentsCount column" HeaderText="Planned" SortExpression="AppointmentsCount" UniqueName="AppointmentsCount">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ActualCount" DataType="System.Int32" FilterControlAltText="Filter ActualCount column" HeaderText="Actual" SortExpression="ActualCount" UniqueName="ActualCount">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AchievmentRatio" DataType="System.Decimal" FilterControlAltText="Filter AchievmentRatio column" HeaderText="% of Achievment" ReadOnly="True" SortExpression="AchievmentRatio" UniqueName="AchievmentRatio" DataFormatString="{0:##%}">
                </telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource ID="dsRepAchRatio" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
        SelectCommand="SELECT [CycleID], [CycleDesc], [EmployeeID], [EmployeeName], [SupervisorName], [TopManagerName], [NewAreaName], [NewSupervisionAreaName], [AmounRegionName], [AppointmentsCount], [ActualCount], ([AchievmentRatio] / 100) AS AchievmentRatio FROM [View_PlannedVsActual]"></asp:SqlDataSource>

                    </ContentTemplate>
                </telerik:RadPanelItem>
                </Items>
            </telerik:RadPanelBar>
        </div>
    </asp:Panel>
</asp:Content>
