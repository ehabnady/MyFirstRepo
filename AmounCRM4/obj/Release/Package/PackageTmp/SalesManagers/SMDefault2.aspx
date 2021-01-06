<%@ Page Title="Collective Reports" Language="C#" MasterPageFile="~/SalesManagers/SiteMaster2.Master" AutoEventWireup="true" CodeBehind="SMDefault2.aspx.cs"
    Inherits="AmounCRM4.SalesManagers.SMDefault2" %>

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
                                SelectCommand="SELECT [CycleID], [TopManagerID], [TopManagerName], SUM([AppointmentsCount]) AS 'AppointmentsCount', 
                    SUM([ActualCount]) AS 'ActualCount' FROM [View_PlannedVsActual] 
                    WHERE (([TopManagerID] = @EmployeeIDFromSM) AND ([CycleID] = @CycleIDFromSM)) GROUP BY [CycleID], [TopManagerID], [TopManagerName]">
                                <SelectParameters>
                                    <asp:SessionParameter Name="EmployeeIDFromSM" SessionField="EmployeeIDFromSM" Type="Int32" />
                                    <asp:SessionParameter Name="CycleIDFromSM" SessionField="CycleIDFromSM" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ContentTemplate>
                    </telerik:RadPanelItem>


                    <telerik:RadPanelItem Text="Doctors List" Expanded="false" Font-Size="Large" CssClass="panelItem">
                    <HeaderTemplate>
                        <asp:Label ID="lblAffsTotal" runat="server"></asp:Label>
                        <asp:Label ID="lblAffsClassA" runat="server"></asp:Label>
                        <asp:Label ID="lblAffsClassB" runat="server"></asp:Label>
<%--                        <asp:Label ID="lblAffsClassC" runat="server"></asp:Label>--%>
                    </HeaderTemplate>
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
                                        <telerik:GridBoundColumn DataField="AffiliationID" Visible="true" DataType="System.Int32" FilterControlAltText="Filter AffiliationID column" HeaderText="ID" SortExpression="AffiliationID" UniqueName="AffiliationID"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="AffiliationName" Visible="true" DataType="System.String" FilterControlAltText="Filter AffiliationName column" HeaderText="Name" SortExpression="AffiliationName" UniqueName="AffiliationName"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="EntityAddress" Visible="true" DataType="System.String" FilterControlAltText="Filter EntityAddress column" HeaderText="Address" SortExpression="EntityAddress" UniqueName="EntityAddress"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="SpecialityCode" Visible="true" DataType="System.String" FilterControlAltText="Filter SpecialityCode column" HeaderText="Specialty" SortExpression="SpecialityCode" UniqueName="SpecialityCode"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="PhysicianClass" Visible="true" DataType="System.String" FilterControlAltText="Filter PhysicianClass column" HeaderText="Class" SortExpression="PhysicianClass" UniqueName="PhysicianClass"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="AmounBrickName" Visible="true" DataType="System.String" FilterControlAltText="Filter AmounBrickName column" HeaderText="Brick" SortExpression="AmounBrickName" UniqueName="AmounBrickName"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="EmployeeName" DataType="System.String" FilterControlAltText="Filter EmployeeName column" HeaderText="Med. Rep" SortExpression="EmployeeName" UniqueName="EmployeeName"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="AmounTerritoryName" DataType="System.String" FilterControlAltText="Filter AmounTerritoryName column" HeaderText="Territory" SortExpression="AmounTerritoryName" UniqueName="AmounTerritoryName"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="SupervisorName" DataType="System.String" FilterControlAltText="Filter SupervisorName column" HeaderText="District Manager" SortExpression="SupervisorName" UniqueName="SupervisorName"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="IsTargeted2" Visible="true" DataType="System.String" FilterControlAltText="Filter IsTargeted column" HeaderText="M or O" SortExpression="IsTargeted" UniqueName="IsTargeted"></telerik:GridBoundColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>

                            <asp:SqlDataSource ID="ListOfAffDS" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                                SelectCommand="SELECT AffiliationID, AffiliationName, EntityAddress, SpecialityCode, PhysicianClass, AmounBrickName, IsTargeted2, EmployeeName, AmounTerritoryName, SupervisorName FROM View_Affiliations_Admin WHERE SpecialtyValue > 0 AND LastModifierID IS NOT NULL AND [PhysicianClass] IN ('A', 'B', 'A+') AND ManagerID = @EmployeeIDFromSM">
                                <SelectParameters>
                                    <asp:SessionParameter Name="EmployeeIDFromSM" SessionField="EmployeeIDFromSM" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ContentTemplate>
                    </telerik:RadPanelItem>
                    
                    
                <telerik:RadPanelItem Text="Calls List" Expanded="false" Font-Size="Large" CssClass="panelItem" Visible="true">
                    <HeaderTemplate>
                        <asp:Label ID="lblCallsTotal" runat="server"></asp:Label>
                        <asp:Label ID="lblCallsClassA" runat="server"></asp:Label>
                        <asp:Label ID="lblCallsClassB" runat="server"></asp:Label>
<%--                        <asp:Label ID="lblCallsClassC" runat="server"></asp:Label>--%>
                    </HeaderTemplate>
                    <ContentTemplate>
                        <telerik:RadGrid ID="gridCalls" runat="server" DataSourceID="ListOfCallsDS" AllowFilteringByColumn="True" AllowPaging="True"
                            EnableGroupsExpandAll="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
                            AllowSorting="True" GroupPanelPosition="Top" ShowGroupPanel="True" Height="600px"
                            Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True">
                            
                            <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="ListOfCalls">
                                <Excel Format="Xlsx" />
                            </ExportSettings>

                            <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>

                            <MasterTableView DataSourceID="ListOfCallsDS" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true" 
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="VisitID" DataType="System.Int32" FilterControlAltText="Filter VisitID column" HeaderText="Visit ID" SortExpression="VisitID" UniqueName="VisitID"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="VisitDateTime" DataType="System.DateTime" FilterControlAltText="Filter VisitDateTime column" HeaderText="Visit Date" SortExpression="VisitDateTime" UniqueName="VisitDateTime"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AffiliationID" DataType="System.Int32" FilterControlAltText="Filter AffiliationID column" HeaderText="Affiliation ID" SortExpression="AffiliationID" UniqueName="AffiliationID"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AffiliationName" FilterControlAltText="Filter AffiliationName column" HeaderText="Affiliation Name" SortExpression="AffiliationName" UniqueName="AffiliationName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PhysicianClass" FilterControlAltText="Filter PhysicianClass column" HeaderText="Class" SortExpression="PhysicianClass" UniqueName="PhysicianClass"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SupervisorName" DataType="System.String" FilterControlAltText="Filter SupervisorName column" HeaderText="DM" SortExpression="SupervisorName" UniqueName="SupervisorName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="EmployeeName" DataType="System.String" FilterControlAltText="Filter EmployeeName column" HeaderText="Med. Rep" SortExpression="EmployeeName" UniqueName="EmployeeName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CycleID" DataType="System.Int32" FilterControlAltText="Filter CycleID column" HeaderText="Cycle ID" SortExpression="CycleID" UniqueName="CycleID"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CycleDesc" FilterControlAltText="Filter CycleDesc column" HeaderText="Cycle Desc" SortExpression="CycleDesc" UniqueName="CycleDesc"></telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                        <asp:SqlDataSource ID="ListOfCallsDS" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                            SelectCommand="SELECT [VisitID],[VisitTypeName],[AffiliationID],[AffiliationName],[VisitDateTime],[NewAreaName],[CycleID],[CycleDesc],[PhysicianClass],SupervisorName,EmployeeName FROM [View_ListOfCalls_Admin] WHERE [PhysicianClass] IN ('A+', 'A') AND YearID >= 2020 AND ManagerID = @EmployeeIDFromSM">
                            <SelectParameters>
                                <asp:SessionParameter Name="EmployeeIDFromSM" SessionField="EmployeeIDFromSM" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                    </ContentTemplate>
                </telerik:RadPanelItem>
                


                <telerik:RadPanelItem Text="Target / Plan / Visits" Expanded="false" Font-Size="Large" CssClass="panelItem">
                    <ContentTemplate>
                        
                        <telerik:RadGrid ID="rd" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True" ShowGroupPanel="True" Skin="WebBlue" 
                            DataSourceID="dsTargetPlan" Height="600px" GridLines="Both" PageSize="50" ShowFooter="True">

                            <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="Target-Plan-Visit">
                                <Excel Format="Xlsx" />
                            </ExportSettings>

                            <ClientSettings AllowDragToGroup="True">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>
                            <MasterTableView DataSourceID="dsTargetPlan" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="LineID" HeaderText="Line" SortExpression="LineID" UniqueName="LineID" DataType="System.Int32" FilterControlAltText="Filter LineID column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CycleDesc" HeaderText="Cycle" SortExpression="CycleDesc" UniqueName="CycleDesc" FilterControlAltText="Filter CycleDesc column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="EmployeeName" HeaderText="Rep Name" SortExpression="EmployeeName" UniqueName="EmployeeName" FilterControlAltText="Filter EmployeeName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AmounTerritoryName" HeaderText="Territory" SortExpression="AmounTerritoryName" UniqueName="AmounTerritoryName" FilterControlAltText="Filter AmounTerritoryName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="BrickID" HeaderText="Brick ID" SortExpression="BrickID" UniqueName="BrickID" DataType="System.Int32" FilterControlAltText="Filter BrickID column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AmounBrickName" HeaderText="Brick Name" SortExpression="AmounBrickName" UniqueName="AmounBrickName" FilterControlAltText="Filter AmounBrickName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AffiliationID" HeaderText="Doctor ID" SortExpression="AffiliationID" UniqueName="AffiliationID" DataType="System.Int32" FilterControlAltText="Filter AffiliationID column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AffiliationName" HeaderText="Doctor Name" SortExpression="AffiliationName" UniqueName="AffiliationName" FilterControlAltText="Filter AffiliationName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PhysicianClass" HeaderText="PhClass" SortExpression="PhysicianClass" UniqueName="PhysicianClass" FilterControlAltText="Filter PhysicianClass column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SpecialityCode" HeaderText="Specialty" SortExpression="SpecialityCode" UniqueName="SpecialityCode" FilterControlAltText="Filter SpecialityCode column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="IsTargeted3" HeaderText="Mandatory" SortExpression="IsTargeted3" UniqueName="IsTargeted3" FilterControlAltText="Filter IsTargeted3 column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AppointmentID" HeaderText="Appointment ID" SortExpression="AppointmentID" UniqueName="AppointmentID" DataType="System.Int32" FilterControlAltText="Filter AppointmentID column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="VisitDateTime" HeaderText="Visit Date" SortExpression="VisitDateTime" UniqueName="VisitDateTime" DataType="System.DateTime" FilterControlAltText="Filter VisitDateTime column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Annotations2" HeaderText="Status" SortExpression="Annotations2" UniqueName="Annotations2" FilterControlAltText="Filter Annotations2 column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="DoubleVisitWith" HeaderText="Double Visit With" SortExpression="DoubleVisitWith" UniqueName="DoubleVisitWith" FilterControlAltText="Filter DoubleVisitWith column"></telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource runat="server" ID="dsTargetPlan" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
                            SelectCommand="SELECT [LineID], [CycleDesc], [EmployeeName], [AmounTerritoryName], [BrickID], [AmounBrickName], [AffiliationID], [AffiliationName], [PhysicianClass], [SpecialityCode], [IsTargeted3], [AppointmentID], [VisitDateTime], [Annotations2], [DoubleVisitWith] FROM [View_Target_Plan_3tbl] WHERE (([CycleID] >= @CycleID - 2) AND ([ManagerID] = @ManagerID))">
                            <SelectParameters>
                                <asp:SessionParameter SessionField="CycleIDFromSM" Name="CycleID" Type="Int32"></asp:SessionParameter>
                                <asp:SessionParameter SessionField="EmployeeIDFromSM" Name="ManagerID" Type="Int32"></asp:SessionParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>
                



                <telerik:RadPanelItem Text="Coverage & Frequency Per Cycle" Expanded="false" Font-Size="Large" CssClass="panelItem" Visible="true">
                    <ContentTemplate>
                        <telerik:RadGrid ID="rad1" runat="server" DataSourceID="CovFreqPerCycle" AllowFilteringByColumn="True" AllowPaging="True"
                            EnableGroupsExpandAll="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
                            AllowSorting="True" GroupPanelPosition="Top" ShowGroupPanel="True" Height="700px"
                            Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="true">

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
                                    <telerik:GridBoundColumn DataField="DirectManagerName" HeaderText="DM" SortExpression="DirectManagerName" UniqueName="DirectManagerName" FilterControlAltText="Filter DirectManagerName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="EmployeeHRCode" HeaderText="Rep HR" SortExpression="EmployeeHRCode" UniqueName="EmployeeHRCode" FilterControlAltText="Filter EmployeeHRCode column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="EmployeeFullName" HeaderText="Rep Name" SortExpression="EmployeeFullName" UniqueName="EmployeeFullName" FilterControlAltText="Filter EmployeeFullName column"></telerik:GridBoundColumn>
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
                            TypeName="AmounCRM4.App_Data.ExecSummary2TableAdapters.View_StatisticesWebView_CovFreq2_SMTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter SessionField="EmployeeIDFromSM" Name="EmployeeIDFromSM" Type="Int32"></asp:SessionParameter>
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>
                </Items>
            </telerik:RadPanelBar>
        </div>
    </asp:Panel>
</asp:Content>
