<%@ Page Title="Collective Reports" Language="C#" MasterPageFile="~/SalesDirector/SiteMaster2.Master" AutoEventWireup="true" CodeBehind="SDDefault2.aspx.cs" 
    Inherits="AmounCRM4.SalesDirector.SDDefault2" %>

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

                <telerik:RadPanelItem Text="Call Rate Per Cycle" Expanded="true" Font-Size="Large" CssClass="panelItem">
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
                                SelectCommand="SELECT [CycleID], [CycleDesc], [EmployeeID], [EmployeeName], [SupervisorName], [TopManagerName], [NewAreaName], [NewSupervisionAreaName], [AmounRegionName], [AppointmentsCount], [ActualCount], ([AchievmentRatio] / 100) AS AchievmentRatio FROM [View_PlannedVsActual] WHERE DirectorID = @EmployeeIDFromDir">
                                <SelectParameters>
                                    <asp:SessionParameter Name="EmployeeIDFromDir" SessionField="EmployeeIDFromDir" Type="String" />
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
                            SelectCommand="SELECT AffiliationID, AffiliationName, EntityAddress, SpecialityCode, PhysicianClass, AmounBrickName, IsTargeted2, EmployeeName, AmounTerritoryName, SupervisorName, ManagerName FROM View_Affiliations_Admin WHERE SpecialtyValue > 0 AND LastModifierID IS NOT NULL AND [PhysicianClass] IN ('A', 'A+') AND DirectorID = @EmployeeIDFromDir">
                            <SelectParameters>
                                <asp:SessionParameter Name="EmployeeIDFromDir" SessionField="EmployeeIDFromDir" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>
                

                
                                
                 <telerik:RadPanelItem Text="Target / Plan / Visits" Expanded="false" Font-Size="Large" CssClass="panelItem">
                    <ContentTemplate>
                        <telerik:RadGrid ID="gvTPV" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True" ShowGroupPanel="True" Skin="WebBlue" DataSourceID="dsTargetPlan"
                            Height="600px" GridLines="Both" PageSize="50" ShowFooter="True">
                            <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>
                            <MasterTableView DataSourceID="dsTargetPlan" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="LineID" HeaderText="Line" SortExpression="Line" UniqueName="Line" DataType="System.Int32" FilterControlAltText="Filter Line column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CycleDesc" HeaderText="Cycle" SortExpression="CycleDesc" UniqueName="Cycle" FilterControlAltText="Filter Cycle column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ManagerName" HeaderText="Manager" SortExpression="ManagerName" UniqueName="ManagerName" FilterControlAltText="Filter ManagerName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SupervisorName" HeaderText="DM Name" SortExpression="SupervisorName" UniqueName="SupervisorName" FilterControlAltText="Filter SupervisorName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="EmployeeName" HeaderText="Rep Name" SortExpression="EmployeeName" UniqueName="EmployeeName" FilterControlAltText="Filter EmployeeName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SupervisionArea" HeaderText="District" SortExpression="SupervisionArea" UniqueName="SupervisionArea" FilterControlAltText="Filter SupervisionArea column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AmounTerritoryName" HeaderText="Territory" SortExpression="AmounTerritoryName" UniqueName="AmounTerritoryName" FilterControlAltText="Filter AmounTerritoryName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="BrickID" HeaderText="Brick ID" SortExpression="BrickID" UniqueName="BrickID" DataType="System.Int32" FilterControlAltText="Filter BrickID column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AmounBrickName" HeaderText="Brick Name" SortExpression="Brick Name" UniqueName="Brick_Name" FilterControlAltText="Filter Brick Name column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AffiliationID" HeaderText="Doctor ID" SortExpression="AffiliationID" UniqueName="AffiliationID" DataType="System.Int32" FilterControlAltText="Filter AffiliationID column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AffiliationName" HeaderText="Doctor Name" SortExpression="AffiliationName" UniqueName="AffiliationName" FilterControlAltText="Filter AffiliationName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PhysicianClass" HeaderText="Class" SortExpression="PhysicianClass" UniqueName="PhysicianClass" FilterControlAltText="Filter PhysicianClass column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SpecialityCode" HeaderText="Specialty" SortExpression="SpecialityCode" UniqueName="SpecialityCode" FilterControlAltText="Filter SpecialityCode column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="IsTargeted3" HeaderText="Mandatory" SortExpression="IsTargeted3" UniqueName="IsTargeted3" FilterControlAltText="Filter IsTargeted3 column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AppointmentID" HeaderText="Appointment ID" SortExpression="AppointmentID" UniqueName="AppointmentID" DataType="System.Int32" FilterControlAltText="Filter AppointmentID ID column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="VisitDateTime" HeaderText="Date" SortExpression="VisitDateTime" UniqueName="VisitDateTime" DataType="System.DateTime" FilterControlAltText="Filter VisitDateTime column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Annotations2" HeaderText="Status" SortExpression="Annotations2" UniqueName="Annotations2" FilterControlAltText="Filter Annotations2 column"></telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource runat="server" ID="dsTargetPlan" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
                            SelectCommand="SELECT [LineID], [CycleDesc], [EmployeeName], [ManagerName], [SupervisionArea], [SupervisorName], [AmounTerritoryName], [BrickID], [AmounBrickName], [AffiliationID], [AffiliationName], [PhysicianClass], [SpecialityCode], [IsTargeted3], [AppointmentID], [VisitDateTime], [Annotations2] FROM [View_Target_Plan_3tbl] WHERE (([CycleID] = @CycleIDFromDir) AND ([DirectorID] = @EmployeeIDFromDir))">
                            <SelectParameters>
                                <asp:SessionParameter SessionField="CycleIDFromDir" Name="CycleIDFromDir" Type="Int32"></asp:SessionParameter>
                                <asp:SessionParameter SessionField="EmployeeIDFromDir" Name="EmployeeIDFromDir" Type="Int32"></asp:SessionParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>


                <telerik:RadPanelItem Text="Coverage & Frequency Per Cycle" Expanded="false" Font-Size="Large" CssClass="panelItem" Visible="true">
                    <ContentTemplate>
                        <telerik:RadGrid ID="rad1" runat="server" DataSourceID="CovFreqPerCycle" AllowFilteringByColumn="True" AllowPaging="True"
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
                            <MasterTableView DataSourceID="CovFreqPerCycle" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="CycleDesc" HeaderText="Cycle" SortExpression="CycleDesc" UniqueName="CycleDesc" FilterControlAltText="Filter CycleDesc column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="EmployeeFullName" HeaderText="Rep Name" SortExpression="EmployeeFullName" UniqueName="EmployeeFullName" FilterControlAltText="Filter EmployeeFullName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="DirectManagerName" HeaderText="DM" SortExpression="DirectManagerName" UniqueName="DirectManagerName" FilterControlAltText="Filter DirectManagerName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TopManagerName" HeaderText="Sales Manager" SortExpression="TopManagerName" UniqueName="TopManagerName" FilterControlAltText="Filter TopManagerName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ActualVisits" Aggregate="Sum" FooterAggregateFormatString="{0:00,000.00}" DataFormatString="{0:00}" HeaderText="Actual Visits" SortExpression="ActualVisits" UniqueName="ActualVisits" DataType="System.Decimal" FilterControlAltText="Filter ActualVisits column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TargetVisits" Aggregate="Sum" FooterAggregateFormatString="{0:00,000.00}" DataFormatString="{0:00}" HeaderText="Target Visits" SortExpression="TargetVisits" UniqueName="TargetVisits" DataType="System.Decimal" FilterControlAltText="Filter TargetVisits column"></telerik:GridBoundColumn>
                                    <telerik:GridCalculatedColumn DataFields="ActualVisits, TargetVisits" Expression="iif({1}=0,0,(({0}/{1})))" DataFormatString="{0:P}" HeaderText="Frequency" SortExpression="Frequency" UniqueName="Frequency" DataType="System.Decimal"
                                        FilterControlAltText="Filter Frequency column"></telerik:GridCalculatedColumn>
                                    <telerik:GridBoundColumn DataField="VisitedDoctors" Aggregate="Sum" FooterAggregateFormatString="{0:00,000.00}" DataFormatString="{0:00}" HeaderText="Visited Doctors" SortExpression="VisitedDoctors" UniqueName="VisitedDoctors" DataType="System.Decimal" FilterControlAltText="Filter VisitedDoctors column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TargetDoctors" Aggregate="Sum" FooterAggregateFormatString="{0:00,000.00}" DataFormatString="{0:00}" HeaderText="Target Doctors" SortExpression="TargetDoctors" UniqueName="TargetDoctors" DataType="System.Decimal" FilterControlAltText="Filter TargetDoctors column"></telerik:GridBoundColumn>
                                    <telerik:GridCalculatedColumn DataFields="VisitedDoctors, TargetDoctors" Expression="iif({1}=0,0,(({0}/{1})))" DataFormatString="{0:P}" HeaderText="Coverage" SortExpression="Coverage" UniqueName="Coverage" DataType="System.Decimal" 
                                        FilterControlAltText="Filter Coverage column"></telerik:GridCalculatedColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                        <asp:ObjectDataSource runat="server" ID="CovFreqPerCycle" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataCovFreq" 
                            TypeName="AmounCRM4.App_Data.ExecSummary2TableAdapters.View_StatisticesWebView_CovFreq2_DirTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter SessionField="EmployeeIDFromDir" Name="EmployeeIDFromDir" Type="Int32"></asp:SessionParameter>
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>

                </Items>
            </telerik:RadPanelBar>
    </div>
</asp:Panel>
</asp:Content>
