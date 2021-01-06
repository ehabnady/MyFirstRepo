<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="RepsDefault2.aspx.cs" Inherits="AmounCRM4.Reps.RepsDefault2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <link type="text/css" rel="stylesheet" href="styles.css" />
    <style type="text/css">
        .panelItem1 {
            height: auto !important;
            background-color: #2d3142 !important;
            color: white !important;
        }
        .panelItem2 {
            height: auto !important;
            background-color: #4f5d75 !important;
            color: white !important;
        }
        .panelItem3 {
            height: auto !important;
            background-color: #AA9CBE !important;
            color:white !important;
        }
        .panelItem4 {
            height: auto !important;
            background-color: #D26E76 !important;
            color: white !important;
        }
        .panelItem5 {
            height: auto !important;
            background-color: #bfc0c0 !important;
            color: white !important;
        }
        .panelItem6 {
            height: auto !important;
            background-color: #ffffff !important;
            color: #2d3142 !important;
        }
        .panelItem7 {
            height: auto !important;
            background-color: #ef8354 !important;
            color: white !important;
        }
        .panelItem8 {
            height: auto !important;
            background-color: #ef8354 !important;
            color: white !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>

    <script src="scripts.js" type="text/javascript"></script>

    <telerik:RadAjaxLoadingPanel ID="ALP1" runat="server"></telerik:RadAjaxLoadingPanel>

    <div style="width:100%">
        <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="100%" Height="800px" ExpandMode="FullExpandedItem">
            <Items>
                <telerik:RadPanelItem Text="Actual Vs. Planned Visits" Expanded="true" Visible="true" Width="98%" BackColor="#5D7B9D" ForeColor="White">
                    <ContentTemplate>
                        <telerik:RadHtmlChart runat="server" Width="500px" Height="400px" ID="RadHtmlChart1" DataSourceID="ActVsPlanDS">
                            <PlotArea>
                                <Series>
                                    <telerik:ColumnSeries DataFieldY="AppointmentsCount" Name="Appointments">
                                        <TooltipsAppearance Color="White">
                                            <ClientTemplate>
                                        Plan
                                            </ClientTemplate>
                                        </TooltipsAppearance>

                                        <Appearance FillStyle-BackgroundColor="RoyalBlue">
                                            <FillStyle BackgroundColor="RoyalBlue"></FillStyle>
                                        </Appearance>
                                    </telerik:ColumnSeries>

                                    <telerik:ColumnSeries DataFieldY="ActualCount" Name="Visits">
                                        <TooltipsAppearance Color="White">
                                            <ClientTemplate>
                                        Actual
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
                                    <TitleAppearance Text="Actual Visits / Planned">
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

                            <ChartTitle Text="Actual Visits / Planned">
                                <Appearance Visible="True">
                                </Appearance>
                            </ChartTitle>
                        </telerik:RadHtmlChart>

                        <asp:SqlDataSource ID="ActVsPlanDS" runat="server"
                            ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                            SelectCommand="SELECT [CycleID], [EmployeeID], [EmployeeName], SUM([AppointmentsCount]) AS AppointmentsCount, 
                    SUM([ActualCount]) AS ActualCount FROM [View_PlannedVsActual] 
                    WHERE (([EmployeeID] = @EmployeeID) AND ([CycleID] = @CycleID)) GROUP BY [CycleID], [EmployeeID], [EmployeeName]">
                            <SelectParameters>
                                <asp:SessionParameter Name="EmployeeID" SessionField="EmployeeID" Type="Int32" />
                                <asp:SessionParameter Name="CycleID" SessionField="CycleID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>


                <telerik:RadPanelItem Text="Doctors List" Expanded="false" Font-Size="Large" Visible="true" Width="98%" BackColor="#5D7B9D" ForeColor="White">
                    <ContentTemplate>
                        <%--<asp:Button id="btnExport" runat="server" OnClick="btnExport_Click" Text="Export" />--%>
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
                                    <telerik:GridBoundColumn DataField="AffiliationID" Visible="true" DataType="System.Int64" FilterControlAltText="Filter AffiliationID column" HeaderText="ID" SortExpression="AffiliationID" UniqueName="AffiliationID"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AffiliationName" Visible="true" FilterControlAltText="Filter AffiliationName column" HeaderText="Name" SortExpression="AffiliationName" UniqueName="AffiliationName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="EntityAddress" Visible="true" FilterControlAltText="Filter EntityAddress column" HeaderText="Address" SortExpression="EntityAddress" UniqueName="EntityAddress"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SpecialityCode" Visible="true" FilterControlAltText="Filter SpecialityCode column" HeaderText="Specialty" SortExpression="SpecialityCode" UniqueName="SpecialityCode"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PhysicianClass" Visible="true" FilterControlAltText="Filter PhysicianClass column" HeaderText="Class" SortExpression="PhysicianClass" UniqueName="PhysicianClass"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AmounBrickName" Visible="true" FilterControlAltText="Filter AmounBrickName column" HeaderText="Brick" SortExpression="AmounBrickName" UniqueName="AmounBrickName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="IsTargeted2" Visible="true" FilterControlAltText="Filter IsTargeted column" HeaderText="Mandatory?" SortExpression="IsTargeted2" UniqueName="IsTargeted2"></telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                        <asp:SqlDataSource ID="ListOfAffDS" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                            SelectCommand="SELECT AffiliationID, AffiliationName, EntityAddress, SpecialityCode, PhysicianClass, AmounBrickName, IsTargeted2 FROM View_Affiliations_Admin WHERE SpecialtyValue > 0 AND LastModifierID IS NOT NULL AND [PhysicianClass] IN ('A+', 'A') AND EmployeeID = @EmployeeID">
                            <SelectParameters>
                                <asp:SessionParameter Name="EmployeeID" SessionField="EmployeeID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>


                <telerik:RadPanelItem Text="Doctor's Visits / Planned" Expanded="false" Font-Size="Large" Visible="true" Width="98%" BackColor="#5D7B9D" ForeColor="White">
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
                                    <telerik:GridBoundColumn DataField="AffiliationID" DataType="System.Int64" FilterControlAltText="Filter AffiliationID column" HeaderText="ID" SortExpression="AffiliationID" UniqueName="AffiliationID"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AffiliationName" FilterControlAltText="Filter AffiliationName column" HeaderText="Name" SortExpression="AffiliationName" UniqueName="AffiliationName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SpecialityCode" FilterControlAltText="Filter SpecialityCode column" HeaderText="Specialty" SortExpression="SpecialityCode" UniqueName="SpecialityCode"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PhysicianClass" FilterControlAltText="Filter PhysicianClass column" HeaderText="Class" SortExpression="PhysicianClass" UniqueName="PhysicianClass"></telerik:GridBoundColumn>
                                    <telerik:GridDateTimeColumn DataField="EndDate" FilterControlAltText="Filter Date column" HeaderText="Date" SortExpression="EndDate" UniqueName="EndDate" DataType="System.DateTime" Visible="true"></telerik:GridDateTimeColumn>
                                    <telerik:GridBoundColumn DataField="Annotations2" FilterControlAltText="Filter Annotations column" HeaderText="Status" SortExpression="Annotations" UniqueName="Annotations"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NewAreaName" FilterControlAltText="Filter NewAreaName column" HeaderText="Territory" SortExpression="NewAreaName" UniqueName="NewAreaName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="IsTargeted2" FilterControlAltText="Filter IsTargeted column" HeaderText="Mandatory?" SortExpression="IsTargeted2" UniqueName="IsTargeted2"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="DoubleVisitWith" FilterControlAltText="Filter DoubleVisitWith column" HeaderText="DoubleVisitWith" SortExpression="DoubleVisitWith" UniqueName="DoubleVisitWith"></telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                        <asp:SqlDataSource ID="ListOfAppointmentsDS" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                            SelectCommand="SELECT [AppointmentID],[EndDate],[AffiliationID],[AffiliationName],[SpecialityCode],[PhysicianClass],[NewAreaName],[Annotations2], [Subject], [IsTargeted2], [DoubleVisitWith] FROM [View_ListOfAppointments_Admin] WHERE EmployeeID = @EmployeeID AND CycleID = @CycleID">
                            <SelectParameters>
                                <asp:SessionParameter Name="EmployeeID" SessionField="EmployeeID" Type="Int32" />
                                <asp:SessionParameter Name="CycleID" SessionField="CycleID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                    </ContentTemplate>
                </telerik:RadPanelItem>


                <telerik:RadPanelItem Text="Call Rate Per Cycle" Expanded="false" Font-Size="Large" Visible="true" Width="98%" BackColor="#5D7B9D" ForeColor="White">
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
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="CycleDesc" FilterControlAltText="Filter CycleDesc column" HeaderText="Cycle" SortExpression="CycleDesc" UniqueName="CycleDesc">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AmounRegionName" FilterControlAltText="Filter AmounRegionName column" HeaderText="Region" SortExpression="AmounRegionName" UniqueName="AmounRegionName">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NewSupervisionAreaName" FilterControlAltText="Filter NewSupervisionAreaName column" HeaderText="District" SortExpression="NewSupervisionAreaName" UniqueName="NewSupervisionAreaName">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NewAreaName" FilterControlAltText="Filter NewAreaName column" HeaderText="Territory" SortExpression="NewAreaName" UniqueName="NewAreaName">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AppointmentsCount" DataType="System.Int64" FilterControlAltText="Filter AppointmentsCount column" HeaderText="Planned" SortExpression="AppointmentsCount" UniqueName="AppointmentsCount">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ActualCount" DataType="System.Int64" FilterControlAltText="Filter ActualCount column" HeaderText="Actual" SortExpression="ActualCount" UniqueName="ActualCount">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AchievmentRatio" DataType="System.Decimal" FilterControlAltText="Filter AchievmentRatio column" HeaderText="% of Achievment" ReadOnly="True" SortExpression="AchievmentRatio" UniqueName="AchievmentRatio" DataFormatString="{0:##%}">
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="dsRepAchRatio" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                            SelectCommand="SELECT [CycleID], [CycleDesc], [EmployeeID], [EmployeeName], [SupervisorName], [TopManagerName], [NewAreaName], [NewSupervisionAreaName], [AmounRegionName], [AppointmentsCount], [ActualCount], ([AchievmentRatio] / 100) AS AchievmentRatio FROM [View_PlannedVsActual] WHERE YearID >= 2017 AND EmployeeHRCode = @EmployeeHRCode">
                            <SelectParameters>
                                <asp:SessionParameter Name="EmployeeHRCode" SessionField="EmployeeHRCode" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>

                
                <telerik:RadPanelItem Text="Not Visited Doctors" Expanded="false" Font-Size="Large" Visible="true" Width="98%" BackColor="#5D7B9D" ForeColor="White">
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
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                        <asp:SqlDataSource ID="dsNotVisited" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                            SelectCommand="GetNotVisited" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter Name="EmployeeID" SessionField="EmployeeID" Type="Int32" />
                                <asp:SessionParameter Name="CycleID" SessionField="CycleID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>

                <telerik:RadPanelItem Text="Target / Plan / Visits" Expanded="false" Font-Size="Large" Visible="true" Width="98%" BackColor="#5D7B9D" ForeColor="White">
                    <ContentTemplate>
                        <telerik:RadGrid ID="TargetPlan" runat="server" DataSourceID="dsTargetPlan" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True"
                            Height="600px" GroupPanelPosition="Top" ShowGroupPanel="True"
                            Skin="WebBlue" EnableHeaderContextMenu="True" EnableHeaderContextAggregatesMenu="true" EnableHeaderContextFilterMenu="true"
                            GridLines="Both" PageSize="50" ShowFooter="True">

                            <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="ListOfPlansVisits">
                                <Excel Format="Xlsx" />
                            </ExportSettings>

                            <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>

                            <MasterTableView DataSourceID="dsTargetPlan" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="CycleDesc" HeaderText="Cycle" SortExpression="CycleDesc" UniqueName="CycleDesc" FilterControlAltText="Filter CycleDesc column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="BrickID" HeaderText="Brick ID" SortExpression="BrickID" UniqueName="BrickID" DataType="System.Int32" FilterControlAltText="Filter BrickID column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AmounBrickName" HeaderText="Brick Name" SortExpression="AmounBrickName" UniqueName="AmounBrickName" FilterControlAltText="Filter AmounBrickName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AffiliationID" HeaderText="Doctor ID" SortExpression="AffiliationID" UniqueName="AffiliationID" DataType="System.Int32" FilterControlAltText="Filter AffiliationID column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AffiliationName" HeaderText="Doctor Name" SortExpression="AffiliationName" UniqueName="AffiliationName" FilterControlAltText="Filter AffiliationName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PhysicianClass" HeaderText="PhClass" SortExpression="PhysicianClass" UniqueName="PhysicianClass" FilterControlAltText="Filter PhysicianClass column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SpecialityCode" HeaderText="Specialty" SortExpression="SpecialityCode" UniqueName="SpecialityCode" FilterControlAltText="Filter SpecialityCode column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="IsTargeted3" ReadOnly="True" HeaderText="Mandatory" SortExpression="IsTargeted3" UniqueName="IsTargeted3" FilterControlAltText="Filter IsTargeted3 column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AppointmentID" HeaderText="Appointment ID" SortExpression="AppointmentID" UniqueName="AppointmentID" DataType="System.Int32" FilterControlAltText="Filter AppointmentID column"></telerik:GridBoundColumn>
                                    <telerik:GridDateTimeColumn DataField="VisitDateTime" HeaderText="Visit Date" SortExpression="VisitDateTime" UniqueName="VisitDateTime" DataType="System.DateTime" FilterControlAltText="Filter VisitDateTime column"></telerik:GridDateTimeColumn>
                                    <telerik:GridBoundColumn DataField="Annotations2" ReadOnly="True" HeaderText="Status" SortExpression="Annotations2" UniqueName="Annotations2" FilterControlAltText="Filter Annotations2 column"></telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource runat="server" ID="dsTargetPlan" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
                            SelectCommand="SELECT [CycleDesc], [BrickID], [AmounBrickName], [AffiliationID], [AffiliationName], [PhysicianClass], [SpecialityCode], [IsTargeted3], [AppointmentID], [VisitDateTime], [Annotations2] FROM [View_Target_Plan_3tbl] WHERE (([CycleID] >= @CycleID - 6) AND ([EmployeeID] = @EmployeeID))">
                            <SelectParameters>
                                <asp:SessionParameter SessionField="CycleID" Name="CycleID" Type="Int32"></asp:SessionParameter>
                                <asp:SessionParameter SessionField="EmployeeID" Name="EmployeeID" Type="Int32"></asp:SessionParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>


                <telerik:RadPanelItem Text="Coverage & Frequency Per Cycle" Expanded="false" Font-Size="Large" Visible="false" Width="98%" BackColor="#5D7B9D" ForeColor="White">
                    <ContentTemplate>
                        <telerik:RadGrid ID="rad1" runat="server" DataSourceID="CovFreqPerCycle" AllowFilteringByColumn="True" AllowPaging="True"
                            EnableGroupsExpandAll="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
                            AllowSorting="True" ShowGroupPanel="True" Height="600px"
                            Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True">

                            <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="ListOfClinics_Physicians">
                                <Excel Format="Xlsx" />
                            </ExportSettings>

                            <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>
                            <MasterTableView DataSourceID="CovFreqPerCycle" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="CycleDesc" HeaderText="Cycle" SortExpression="CycleDesc" UniqueName="CycleDesc" FilterControlAltText="Filter CycleDesc column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ActualVisits" Aggregate="Sum" DataFormatString="{0:N}" HeaderText="Actual Visits" SortExpression="ActualVisits" UniqueName="ActualVisits" FilterControlAltText="Filter ActualVisits column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TargetVisits" Aggregate="Sum" DataFormatString="{0:N}" HeaderText="Target Visits" SortExpression="TargetVisits" UniqueName="TargetVisits" FilterControlAltText="Filter TargetVisits column"></telerik:GridBoundColumn>
                                    <telerik:GridCalculatedColumn DataFields="ActualVisits, TargetVisits" Expression="iif({1}=0,0,(({0}/{1})))" DataFormatString="{0:P}" HeaderText="Frequency" SortExpression="Frequency" UniqueName="Frequency" DataType="System.Decimal"
                                        FilterControlAltText="Filter Frequency column"></telerik:GridCalculatedColumn>
                                    <telerik:GridBoundColumn DataField="VisitedDoctors" Aggregate="Sum" DataFormatString="{0:N}" HeaderText="Visited Doctors" SortExpression="VisitedDoctors" UniqueName="VisitedDoctors" FilterControlAltText="Filter VisitedDoctors column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TargetDoctors" Aggregate="Sum" DataFormatString="{0:N}" HeaderText="Target Doctors" SortExpression="TargetDoctors" UniqueName="TargetDoctors" FilterControlAltText="Filter TargetDoctors column"></telerik:GridBoundColumn>
                                    <telerik:GridCalculatedColumn DataFields="VisitedDoctors, TargetDoctors" Expression="iif({1}=0,0,(({0}/{1})))" DataFormatString="{0:P}" HeaderText="Coverage" SortExpression="Coverage" UniqueName="Coverage" FilterControlAltText="Filter Coverage column"></telerik:GridCalculatedColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                        <asp:ObjectDataSource runat="server" ID="CovFreqPerCycle" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataCovFreq" 
                            TypeName="AmounCRM4.App_Data.ExecSummary2TableAdapters.View_StatisticesWebView_CovFreq2_RepTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter SessionField="EmployeeID" Name="EmployeeID" Type="Int32"></asp:SessionParameter>
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>
            </Items>
        </telerik:RadPanelBar>
    </div>
    <div>
    </div>
</asp:Content>
