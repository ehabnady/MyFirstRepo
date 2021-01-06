<%@ Page Title="Collective Reports" Language="C#" MasterPageFile="~/CommercialDirector/SiteMaster2.Master" AutoEventWireup="true" 
    CodeBehind="ComDirDefault2.aspx.cs" Inherits="AmounCRM4.CommercialDirector.ComDirDefault2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <link type="text/css" rel="stylesheet" href="styles.css" />
    <style type="text/css">
        .panelItem
        {
            height:auto;
        }
        .DivCenter
        {
            text-align:center;
            align-items:center;
            vertical-align:middle
        }
    </style>

    <title>Collective Reports</title>
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

    <asp:Panel ID="p1" runat="server">
    <div class="DivCenter">
        <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="95%" Height="800px" Skin="WebBlue" ExpandMode="FullExpandedItem">
            <Items>
                <telerik:RadPanelItem Text="Actual / Targeted" Expanded="true" CssClass="panelItem" Font-Size="Large">
                    <ContentTemplate>
                        <telerik:RadHtmlChart runat="server" Width="400px" Height="400px"
                            ID="RadHtmlChart1" DataSourceID="ActVsPlanDS">
                            <PlotArea>
                                <Series>
                                    <telerik:ColumnSeries DataFieldY="AppointmentsCount" Name="Appointments">
                                        <TooltipsAppearance Color="White">
                                            <ClientTemplate>
                                        Appointments
                                            </ClientTemplate>
                                        </TooltipsAppearance>

                                        <Appearance FillStyle-BackgroundColor="RoyalBlue">
                                            <FillStyle BackgroundColor="RoyalBlue"></FillStyle>
                                        </Appearance>
                                    </telerik:ColumnSeries>

                                    <telerik:ColumnSeries DataFieldY="ActualCount" Name="Visits">
                                        <TooltipsAppearance Color="White">
                                            <ClientTemplate>
                                        Actual Visits
                                            </ClientTemplate>
                                        </TooltipsAppearance>
                                        <Appearance FillStyle-BackgroundColor="Green">
                                            <FillStyle BackgroundColor="Green"></FillStyle>
                                        </Appearance>
                                    </telerik:ColumnSeries>
                                </Series>

                                <XAxis DataLabelsField="EmployeeName">
                                    <LabelsAppearance>
                                    </LabelsAppearance>
                                    <TitleAppearance Text="Actual / Planned">
                                    </TitleAppearance>
                                </XAxis>

                                <YAxis Visible="false">
                                    <TitleAppearance Visible="false" Text="Value">
                                    </TitleAppearance>
                                </YAxis>
                            </PlotArea>

                            <Legend>
                                <Appearance Visible="true" Position="Right" BackgroundColor="Wheat">
                                </Appearance>
                            </Legend>

                            <ChartTitle Text="Actual / Planned">
                                <Appearance Visible="True">
                                </Appearance>
                            </ChartTitle>
                        </telerik:RadHtmlChart>

                        <asp:SqlDataSource ID="ActVsPlanDS" runat="server"
                            ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                            SelectCommand="SELECT [CycleID], SUM([AppointmentsCount]) AS 'AppointmentsCount', 
                    SUM([ActualCount]) AS 'ActualCount' FROM [View_PlannedVsActual] 
                    WHERE ([CycleID] = @CycleIDFromComDir) GROUP BY [CycleID]">
                            <SelectParameters>
                                <asp:SessionParameter Name="CycleIDFromComDir" SessionField="CycleIDFromComDir" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>

                <telerik:RadPanelItem Text="Doctors List" Expanded="false" Font-Size="Large" CssClass="panelItem">
                    <HeaderTemplate>
                        <asp:Label ID="lblAffsTotal" runat="server"></asp:Label>
                        <asp:Label ID="lblAffsClassA" runat="server"></asp:Label>
                        <asp:Label ID="lblAffsClassB" runat="server"></asp:Label>
                    </HeaderTemplate>
                    <ContentTemplate>
                        <telerik:RadGrid ID="gridAffs" runat="server" DataSourceID="ListOfAffDS" AllowFilteringByColumn="True" AllowPaging="True"
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
                            
                            <MasterTableView DataSourceID="ListOfAffDS" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true" 
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="AffiliationID" Visible="true" DataType="System.Int32" FilterControlAltText="Filter AffiliationID column" HeaderText="ID" SortExpression="AffiliationID" UniqueName="AffiliationID"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AffiliationName" Visible="true" DataType="System.String" FilterControlAltText="Filter AffiliationName column" HeaderText="Name" SortExpression="AffiliationName" UniqueName="AffiliationName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="EntityAddress" Visible="true" DataType="System.String" FilterControlAltText="Filter EntityAddress column" HeaderText="Address" SortExpression="EntityAddress" UniqueName="EntityAddress"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SpecialityCode" Visible="true" DataType="System.String" FilterControlAltText="Filter SpecialityCode column" HeaderText="Specialty" SortExpression="SpecialityCode" UniqueName="SpecialityCode"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PhysicianClass" Visible="true" DataType="System.String" FilterControlAltText="Filter PhysicianClass column" HeaderText="Class" SortExpression="PhysicianClass" UniqueName="PhysicianClass"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AmounBrickName" Visible="true" DataType="System.String" FilterControlAltText="Filter AmounBrickName column" HeaderText="Brick" SortExpression="AmounBrickName" UniqueName="AmounBrickName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="EmployeeName" DataType="System.String" FilterControlAltText="Filter EmployeeName column" HeaderText="Med. Rep" SortExpression="EmployeeName" UniqueName="EmployeeName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AmounTerritoryName" DataType="System.String" FilterControlAltText="Filter AmounTerritoryName column" HeaderText="Territory" SortExpression="AmounTerritoryName" UniqueName="AmounTerritoryName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SupervisorName" DataType="System.String" FilterControlAltText="Filter SupervisorName column" HeaderText="District Manager" SortExpression="SupervisorName" UniqueName="SupervisorName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ManagerName" DataType="System.String" FilterControlAltText="Filter ManagerName column" HeaderText="Sales Manager" SortExpression="ManagerName" UniqueName="ManagerName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="IsTargeted2" Visible="true" DataType="System.String" FilterControlAltText="Filter IsTargeted column" HeaderText="Mandatory?" SortExpression="IsTargeted" UniqueName="IsTargeted"></telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                        <asp:SqlDataSource ID="ListOfAffDS" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
                            SelectCommand="SELECT AffiliationID, AffiliationName, EntityAddress, SpecialityCode, PhysicianClass, AmounBrickName, IsTargeted2, EmployeeName, AmounTerritoryName, SupervisorName, ManagerName FROM View_Affiliations_Admin WHERE SpecialtyValue > 0 AND LastModifierID IS NOT NULL AND [PhysicianClass] IN ('A', 'B', 'A+')">
                            
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>

                <telerik:RadPanelItem Text="Doctor's Visits / Planned" Expanded="false" Font-Size="Large" CssClass="panelItem">
                    <HeaderTemplate>
                        <asp:Label ID="lblAppsTotal" runat="server"></asp:Label>
                        <asp:Label ID="lblAppsClassA" runat="server"></asp:Label>
                        <asp:Label ID="lblAppsClassB" runat="server"></asp:Label>
<%--                        <asp:Label ID="lblAppsClassC" runat="server"></asp:Label>--%>
                    </HeaderTemplate>
                    <ContentTemplate>
                        <telerik:RadGrid ID="gridApps" runat="server" DataSourceID="ListOfAppointmentsDS" AllowFilteringByColumn="True" AllowPaging="True"
                            EnableGroupsExpandAll="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
                            AllowSorting="True" GroupPanelPosition="Top" ShowGroupPanel="True" Height="600px"
                            Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True">
                            
                            <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="ListOfAppointments">
                                <Excel Format="Xlsx" />
                            </ExportSettings>

                            <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>
                            <MasterTableView DataSourceID="ListOfAppointmentsDS" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true" 
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="AffiliationID" DataType="System.Int32" FilterControlAltText="Filter AffiliationID column" HeaderText="ID" SortExpression="AffiliationID" UniqueName="AffiliationID"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AffiliationName" FilterControlAltText="Filter AffiliationName column" HeaderText="Name" SortExpression="AffiliationName" UniqueName="AffiliationName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SpecialityCode" FilterControlAltText="Filter SpecialityCode column" HeaderText="Specialty" SortExpression="SpecialityCode" UniqueName="SpecialityCode"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PhysicianClass" FilterControlAltText="Filter PhysicianClass column" HeaderText="Class" SortExpression="PhysicianClass" UniqueName="PhysicianClass"></telerik:GridBoundColumn>
                                    <telerik:GridDateTimeColumn DataField="EndDate" FilterControlAltText="Filter Date column" HeaderText="Date" SortExpression="EndDate" UniqueName="EndDate" DataType="System.DateTime" Visible="true" DataFormatString="{0:MM/dd/yyyy}" HtmlEncode="false"></telerik:GridDateTimeColumn>
                                    <telerik:GridBoundColumn DataField="Annotations2" FilterControlAltText="Filter Annotations column" HeaderText="Status" SortExpression="Annotations" UniqueName="Annotations"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CycleDesc" FilterControlAltText="Filter CycleDesc column" HeaderText="Cycle" SortExpression="CycleDesc" UniqueName="CycleDesc"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AmounBrickName" FilterControlAltText="Filter AmounBrickName column" HeaderText="Brick" SortExpression="AmounBrickName" UniqueName="AmounBrickName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NewAreaName" FilterControlAltText="Filter NewAreaName column" HeaderText="Territory" SortExpression="NewAreaName" UniqueName="NewAreaName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SupervisorName" FilterControlAltText="Filter SupervisorName column" HeaderText="District Manager" SortExpression="SupervisorName" UniqueName="SupervisorName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ManagerName" FilterControlAltText="Filter ManagerName column" HeaderText="Sales Manager" SortExpression="ManagerName" UniqueName="ManagerName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="IsTargeted2" FilterControlAltText="Filter IsTargeted column" HeaderText="Mandatory?" SortExpression="IsTargeted" UniqueName="IsTargeted"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="DoubleVisitWith" FilterControlAltText="Filter DoubleVisitWith column" HeaderText="DoubleVisitWith" SortExpression="DoubleVisitWith" UniqueName="DoubleVisitWith"></telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                        <asp:SqlDataSource ID="ListOfAppointmentsDS" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                            SelectCommand="SELECT [AppointmentID],[EndDate],[AffiliationID],[AffiliationName],[SpecialityCode],[PhysicianClass],[NewAreaName],[Annotations2], [Subject], [IsTargeted2], [CycleDesc], [AmounBrickName], [SupervisorName], ManagerName, [DoubleVisitWith] FROM [View_ListOfAppointments_Admin] WHERE [PhysicianClass] IN ('A', 'B', 'A+')">
                            
                        </asp:SqlDataSource>
                        
                    </ContentTemplate>
                </telerik:RadPanelItem>

                <telerik:RadPanelItem Text="Call Rate Per Cycle" Expanded="false" Font-Size="Large" CssClass="panelItem">
                    <ContentTemplate>
                                <telerik:RadGrid ID="gridAchRatio" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" 
                                    DataSourceID="dsRepAchRatio" Height="600px" GroupPanelPosition="Top" ShowGroupPanel="True"
                                    Skin="WebBlue" EnableHeaderContextMenu="True" EnableHeaderContextAggregatesMenu="true" EnableHeaderContextFilterMenu="true" 
                                    GridLines="Both" PageSize="50" ShowFooter="True">

                                <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="ListOfRepsAchievment">
                                    <Excel Format="Xlsx" />
                                </ExportSettings>

                                <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                    <Scrolling AllowScroll="true" UseStaticHeaders="true" />
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
                                SelectCommand="SELECT [CycleID], [CycleDesc], [EmployeeID], [EmployeeName], [SupervisorName], [TopManagerName], [NewAreaName], [NewSupervisionAreaName], [AmounRegionName], [AppointmentsCount], [ActualCount], ([AchievmentRatio] / 100) AS AchievmentRatio FROM [View_PlannedVsActual]">
                                
                            </asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>

                <telerik:RadPanelItem Text="Not Visited Doctors" Expanded="false" Font-Size="Large" CssClass="panelItem">
                    <ContentTemplate>
                        <telerik:RadGrid ID="gridNotPlanned" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True"
                            DataSourceID="dsNotVisited" Height="600px" GroupPanelPosition="Top" ShowGroupPanel="True"
                            Skin="WebBlue" EnableHeaderContextMenu="True" EnableHeaderContextAggregatesMenu="true" EnableHeaderContextFilterMenu="true" 
                            GridLines="Both" PageSize="50" ShowFooter="True">

                            <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="ListOfRepsAchievment">
                                <Excel Format="Xlsx" />
                            </ExportSettings>

                            <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
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
                            SelectCommand="GetNotVisited_ComDir" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter Name="CycleIDFromComDir" SessionField="CycleIDFromComDir" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>


                

                 <telerik:RadPanelItem Text="Target / Plan / Visits" Expanded="false" Font-Size="Large" CssClass="panelItem">
                    <ContentTemplate>
                        <telerik:RadGrid ID="gvTPV" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True" ShowGroupPanel="True" Skin="WebBlue" DataSourceID="dsTPV"
                            Height="600px" GridLines="Both" PageSize="50" ShowFooter="True">
                            <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>
                            <MasterTableView DataSourceID="dsTPV" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="Line" HeaderText="Line" SortExpression="Line" UniqueName="Line" DataType="System.Int32" FilterControlAltText="Filter Line column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Cycle" HeaderText="Cycle" SortExpression="Cycle" UniqueName="Cycle" FilterControlAltText="Filter Cycle column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Sales Manager" HeaderText="Sales Manager" SortExpression="Sales Manager" UniqueName="Sales_Manager" FilterControlAltText="Filter Sales Manager column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="DM Name" HeaderText="DM Name" SortExpression="DM Name" UniqueName="DM_Name" FilterControlAltText="Filter DM Name column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Rep Name" HeaderText="Rep Name" SortExpression="Rep Name" UniqueName="Rep_Name" FilterControlAltText="Filter Rep Name column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Supervision Area" HeaderText="Supervision Area" SortExpression="Supervision Area" UniqueName="Supervision_Area" FilterControlAltText="Filter Supervision Area column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Territory Name" HeaderText="Territory Name" SortExpression="Territory Name" UniqueName="Territory_Name" FilterControlAltText="Filter Territory Name column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Brick ID" HeaderText="Brick ID" SortExpression="Brick ID" UniqueName="Brick_ID" DataType="System.Int32" FilterControlAltText="Filter Brick ID column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Brick Name" HeaderText="Brick Name" SortExpression="Brick Name" UniqueName="Brick_Name" FilterControlAltText="Filter Brick Name column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Doctor ID" HeaderText="Doctor ID" SortExpression="Doctor ID" UniqueName="Doctor_ID" DataType="System.Int32" FilterControlAltText="Filter Doctor ID column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Doctor Name" HeaderText="Doctor Name" SortExpression="Doctor Name" UniqueName="Doctor_Name" FilterControlAltText="Filter Doctor Name column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Class" HeaderText="Class" SortExpression="Class" UniqueName="Class" FilterControlAltText="Filter Class column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Specialty" HeaderText="Specialty" SortExpression="Specialty" UniqueName="Specialty" FilterControlAltText="Filter Specialty column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Mandatory" HeaderText="Mandatory" SortExpression="Mandatory" UniqueName="Mandatory" FilterControlAltText="Filter Mandatory column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Appointment ID" HeaderText="Appointment ID" SortExpression="Appointment ID" UniqueName="Appointment_ID" DataType="System.Int32" FilterControlAltText="Filter Appointment ID column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Date" HeaderText="Date" SortExpression="Date" UniqueName="Date" DataType="System.DateTime" FilterControlAltText="Filter Date column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Status" HeaderText="Status" SortExpression="Status" UniqueName="Status" FilterControlAltText="Filter Status column"></telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource runat="server" ID="dsTPV" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
                            SelectCommand="GetTargetedListWithAppointments_ComDir" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter SessionField="CycleIDFromComDir" Name="CycleID"></asp:SessionParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>


                <%--<telerik:RadPanelItem Text="Coverage, Frequency, and Plan Report (From Targeted Affiliations)" Expanded="false" Font-Size="Large" CssClass="panelItem">
                    <ContentTemplate>
                        <telerik:RadGrid ID="gridStatistics" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True"
                            DataSourceID="sqlDS_Statistics" Height="600px" GroupPanelPosition="Top" ShowGroupPanel="True"
                            Skin="WebBlue" EnableHeaderContextMenu="True" EnableHeaderContextAggregatesMenu="true" EnableHeaderContextFilterMenu="true" GridLines="Both" PageSize="50" ShowFooter="True">

                            <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="Statistics">
                                <Excel Format="Xlsx" />
                            </ExportSettings>

                            <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>

                            <MasterTableView AutoGenerateColumns="False" DataSourceID="sqlDS_Statistics" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true"
                                EnableHeaderContextMenu="True" EnableHeaderContextAggregatesMenu="true" EnableHeaderContextFilterMenu="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="PhysicianClass" DataType="System.String" FilterControlAltText="Filter PhysicianClass column" HeaderText="Ph. Class" SortExpression="PhysicianClass" UniqueName="PhysicianClass">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SpecialityCode" DataType="System.String" FilterControlAltText="Filter SpecialityCode column" HeaderText="Specialty" SortExpression="SpecialityCode" UniqueName="SpecialityCode">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CycleDesc" DataType="System.String" FilterControlAltText="Filter CycleDesc column" HeaderText="Cycle" SortExpression="CycleDesc" UniqueName="CycleDesc">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="EmployeeName" DataType="System.String" FilterControlAltText="Filter EmployeeName column" HeaderText="Med. Rep" SortExpression="EmployeeName" UniqueName="EmployeeName">
                                    </telerik:GridBoundColumn>


                                    <telerik:GridBoundColumn DataField="Targeted Affiliations" DataType="System.String" FilterControlAltText="Filter Targeted Affiliations column" HeaderText="Targeted Affiliations" SortExpression="Targeted Affiliations" UniqueName="Targeted_Affiliations">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Visited Targeted Affiliations" DataType="System.Decimal" FilterControlAltText="Filter Visited Targeted Affiliations column" HeaderText="Visited Targeted Affiliations" SortExpression="Visited Targeted Affiliations" UniqueName="Visited_Targeted_Affiliations">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Coverage" DataType="System.Decimal" FilterControlAltText="Filter Coverage column" HeaderText="Coverage" SortExpression="Coverage" UniqueName="Coverage">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Targeted Appointments" DataType="System.Decimal" FilterControlAltText="Filter Visited Targeted Appointments column" HeaderText="Targeted Appointments" ReadOnly="True" SortExpression="Targeted Appointments" UniqueName="Targeted_Appointments">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Visited Targeted Appointments" DataType="System.Decimal" FilterControlAltText="Filter Visited Targeted Appointments column" HeaderText="Visited Targeted Appointments" ReadOnly="True" SortExpression="Visited Targeted Appointments" UniqueName="Visited_Targeted_Appointments">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Frequency" DataType="System.Decimal" FilterControlAltText="Filter Frequency column" HeaderText="Frequency" ReadOnly="True" SortExpression="Frequency" UniqueName="Frequency">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Planned Appointments" DataType="System.Decimal" FilterControlAltText="Filter Planned Appointments column" HeaderText="Planned Appointments" ReadOnly="True" SortExpression="Planned Appointments" UniqueName="Planned_Appointments">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Visited Planned Appointments" DataType="System.Decimal" FilterControlAltText="Filter Visited Planned Appointments column" HeaderText="Visited Planned Appointments" ReadOnly="True" SortExpression="Visited_Planned_Appointments" UniqueName="Visited_Planned_Affiliations">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ActualVsPlanned" DataType="System.Decimal" FilterControlAltText="Filter ActualVsPlanned column" HeaderText="Actual Vs Planned" ReadOnly="True" SortExpression="ActualVsPlanned" UniqueName="ActualVsPlanned">
                                    </telerik:GridBoundColumn>                                    
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </ContentTemplate>
                </telerik:RadPanelItem>--%>
                
                <%--<telerik:RadPanelItem Text="Planning Report (From Planned Affiliations)" Expanded="false" Font-Size="Large" CssClass="panelItem">
                    <ContentTemplate>
                        <telerik:RadGrid ID="RadGrid1" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True"
                            DataSourceID="sqlDS_Statistics" Height="600px" GroupPanelPosition="Top" ShowGroupPanel="True"
                            Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True">

                            <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="Statistics">
                                <Excel Format="Xlsx" />
                            </ExportSettings>

                            <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>

                            <MasterTableView AutoGenerateColumns="False" DataSourceID="sqlDS_Statistics" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="PhysicianClass" DataType="System.String" FilterControlAltText="Filter PhysicianClass column" HeaderText="Ph. Class" SortExpression="PhysicianClass" UniqueName="PhysicianClass">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SpecialityCode" FilterControlAltText="Filter SpecialityCode column" HeaderText="Specialty" SortExpression="SpecialityCode" UniqueName="SpecialityCode">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CycleDesc" FilterControlAltText="Filter CycleDesc column" HeaderText="Cycle" SortExpression="CycleDesc" UniqueName="CycleDesc">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Planned Affiliations" DataType="System.Decimal" FilterControlAltText="Filter Planned Affiliations column" HeaderText="Affiliations" ReadOnly="True" SortExpression="Planned Affiliations" UniqueName="Planned_Affiliations">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Visited Planned Affiliations" DataType="System.Decimal" FilterControlAltText="Filter Visited Planned Affiliations column" HeaderText="Visited Affiliations" ReadOnly="True" SortExpression="Visited Planned Affiliations" UniqueName="Visited_Planned_Affiliations">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Not Visited From Planned Affiliations" DataType="System.Decimal" FilterControlAltText="Filter Not Visited From Planned Affiliations column" HeaderText="Not Visited Affiliations" ReadOnly="True" SortExpression="Not Visited From Planned Affiliations" UniqueName="Not_Visited_From_Planned_Affiliations">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ActualVsPlanned" DataType="System.Decimal" FilterControlAltText="Filter ActualVsPlanned column" HeaderText="Actual Vs Planned" ReadOnly="True" SortExpression="ActualVsPlanned" UniqueName="ActualVsPlanned">
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </ContentTemplate>
                </telerik:RadPanelItem>



                <telerik:RadPanelItem Text="Frequency Report (From Targeted Appointments)" Expanded="false" Font-Size="Large" CssClass="panelItem">
                    <ContentTemplate>
                        <telerik:RadGrid ID="RadGrid2" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True"
                            DataSourceID="sqlDS_Statistics" Height="600px" GroupPanelPosition="Top" ShowGroupPanel="True"
                            Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True">

                            <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="Statistics">
                                <Excel Format="Xlsx" />
                            </ExportSettings>

                            <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>

                            <MasterTableView AutoGenerateColumns="False" DataSourceID="sqlDS_Statistics" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="PhysicianClass" DataType="System.String" FilterControlAltText="Filter PhysicianClass column" HeaderText="Ph. Class" SortExpression="PhysicianClass" UniqueName="PhysicianClass">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SpecialityCode" FilterControlAltText="Filter SpecialityCode column" HeaderText="Specialty" SortExpression="SpecialityCode" UniqueName="SpecialityCode">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CycleDesc" FilterControlAltText="Filter CycleDesc column" HeaderText="Cycle" SortExpression="CycleDesc" UniqueName="CycleDesc">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Targeted Appointments" DataType="System.Decimal" FilterControlAltText="Filter Visited Targeted Appointments column" HeaderText="Appointments" ReadOnly="True" SortExpression="Targeted Appointments" UniqueName="Targeted_Appointments">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Visited Targeted Appointments" DataType="System.Decimal" FilterControlAltText="Filter Visited Targeted Appointments column" HeaderText="Visited Appointments" ReadOnly="True" SortExpression="Visited Targeted Appointments" UniqueName="Visited_Targeted_Appointments">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Not Visited From Targeted Appointments" DataType="System.Decimal" FilterControlAltText="Filter Not Visited From Targeted Appointments column" HeaderText="Not Visited Appointments" ReadOnly="True" SortExpression="Not Visited From Targeted Appointments" UniqueName="Not_Visited_From_Targeted_Appointments">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Frequency" DataType="System.Decimal" FilterControlAltText="Filter Frequency column" HeaderText="Frequency" ReadOnly="True" SortExpression="Frequency" UniqueName="Frequency">
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </ContentTemplate>
                </telerik:RadPanelItem>--%>

                
            </Items>
        </telerik:RadPanelBar>
    </div>
    <div>
                        <%--<asp:SqlDataSource ID="sqlDS_Statistics" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                            SelectCommand="SELECT PhysicianClass, SpecialityCode, CycleID, CycleDesc, EmployeeID, EmployeeHRCode, EmployeeName, 
                            SupervisorName, SupervisorID, [Targeted Affiliations], [Visited Targeted Affiliations], [Targeted Appointments], 
                            [Visited Targeted Appointments], [Planned Appointments], [Visited Planned Appointments], Coverage, Frequency, 
                            ActualVsPlanned From View_Statistics_Coverage Where CycleID = @CycleID AND SupervisorID = @EmployeeIDFromDM Order by PhysicianClass, SpecialityCode">
                            <SelectParameters>
                                <asp:SessionParameter Name="EmployeeIDFromDM" SessionField="EmployeeIDFromDM" Type="String" />
                                <asp:SessionParameter Name="CycleID" SessionField="CycleID" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>--%>
    </div>
</asp:Panel>
</asp:Content>
