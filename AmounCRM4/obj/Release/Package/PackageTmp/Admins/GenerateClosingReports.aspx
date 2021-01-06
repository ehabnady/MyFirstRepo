<%@ Page Title="Generate Closing Reports" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true"
    CodeBehind="GenerateClosingReports.aspx.cs" Inherits="AmounCRM4.Admins.GenerateClosingReports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <title>Generate Closing Reports</title>

    <link type="text/css" rel="stylesheet" href="styles.css" />
    <style type="text/css">
        .panelItem {
            height: auto;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">

    <div style="text-align: left; margin-left: 5px; visibility:hidden">
            <a href="#" style="color: red; text-decoration-line: underline; font-size: xx-large">Please, Take Care!</a>
            <br />
            <br />
        <div style="text-align: left; margin-left: 5px; font-size:x-large">
            <i>
                The Below Button Will Generate All Reports of The Current Cycle
                <br />
                Don't Use This Button Until Taking-Off-Line an IIS Server & Backing-up a Database
                <br />
                After Clicking This Button, You Will Find That The Below Tables Filled With The Corresponding Data
                <br />
                Please, Extract The Below Tables To External Excel Files Before Leaving This Page
            </i>
        </div>        
    </div>

    <p>
        <br /><br />
    </p>

    <div style="text-align: left; margin-left:5px">

        <asp:Button ID="btnGenerator" runat="server" Text="Generate Closing Reports" Visible="false" Enabled="false" />

        <asp:SqlDataSource ID="dsGenerator" runat="server" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
            SelectCommand="Closing_CreateReport" SelectCommandType="StoredProcedure" OnInserting="dsGenerator_Inserting" OnSelecting="dsGenerator_Selecting">
            <SelectParameters>
                <asp:SessionParameter SessionField="CycleIDFromAdmin" Name="CycleID" Type="Int32"></asp:SessionParameter>
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        
    </div>

    <p><br /></p>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>

    <script src="scripts.js" type="text/javascript"></script>

    <telerik:RadAjaxLoadingPanel ID="ALP1" runat="server"></telerik:RadAjaxLoadingPanel>

    <div>
        <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="95%" Height="800px" Skin="WebBlue" ExpandMode="FullExpandedItem">
            <Items>
                <telerik:RadPanelItem Text="Actual Vs. Target" Expanded="true" CssClass="panelItem">
                    <ContentTemplate>
                        <telerik:RadGrid ID="gridApps" runat="server" DataSourceID="dsTrackingReport_web" AllowFilteringByColumn="True" AllowPaging="True"
                            EnableGroupsExpandAll="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
                            AllowSorting="True" GroupPanelPosition="Top" ShowGroupPanel="True" Height="600px"
                            Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True">

                            <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="Actual Vs Target">
                                <Excel Format="Xlsx" />
                            </ExportSettings>

                            <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>
                            <MasterTableView DataSourceID="dsTrackingReport_web" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="AppointmentID" DataType="System.Int64" FilterControlAltText="AppointmentID" HeaderText="AppointmentID" SortExpression="AppointmentID" UniqueName="AppointmentID"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Line" DataType="System.Int64" FilterControlAltText="Line" HeaderText="Line" SortExpression="Line" UniqueName="Line"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Region" FilterControlAltText="Region" HeaderText="Region" SortExpression="Region" UniqueName="Region"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="District" FilterControlAltText="District" HeaderText="District" SortExpression="District" UniqueName="District"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Territory" FilterControlAltText="Territory" HeaderText="Territory" SortExpression="Territory" UniqueName="Territory"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Brick ID" FilterControlAltText="Brick ID" HeaderText="Brick ID" SortExpression="Brick ID" UniqueName="Brick_ID"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Brick Name" FilterControlAltText="Brick Name" HeaderText="Brick Name" SortExpression="Brick Name" UniqueName="Brick_Name"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="IsTargeted" FilterControlAltText="Targeted" HeaderText="Mandatory?" SortExpression="Targeted" UniqueName="Targeted"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Status" FilterControlAltText="Status" HeaderText="Status" SortExpression="Status" UniqueName="Status"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Rep Name" FilterControlAltText="Rep Name" HeaderText="Rep Name" SortExpression="Rep Name" UniqueName="Rep_Name"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Supervisor Name" FilterControlAltText="Supervisor Name" HeaderText="Supervisor Name" SortExpression="Supervisor Name" UniqueName="Supervisor_Name"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Manager Name" FilterControlAltText="Manager Name" HeaderText="Manager Name" SortExpression="Manager Name" UniqueName="Manager_Name"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Doctor ID" FilterControlAltText="Doctor ID" HeaderText="Doctor ID" SortExpression="Doctor ID" UniqueName="Doctor_ID"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Doctor Name" FilterControlAltText="Doctor Name" HeaderText="Doctor Name" SortExpression="Doctor Name" UniqueName="Doctor_Name"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Specialty" FilterControlAltText="Specialty" HeaderText="Specialty" SortExpression="Specialty" UniqueName="Specialty"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PhClass" FilterControlAltText="Ph. Class" HeaderText="Ph. Class" SortExpression="Ph. Class" UniqueName="Ph_Class"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Visit Date" FilterControlAltText="Visit Date" HeaderText="Visit Date" SortExpression="Visit Date" UniqueName="Visit_Date" DataType="System.DateTime" Visible="true" DataFormatString="{0:MM/dd/yyyy}" HtmlEncode="false"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Entry Date" FilterControlAltText="Entry Date" HeaderText="Entry Date" SortExpression="Entry Date" UniqueName="Entry_Date" DataType="System.DateTime" Visible="true" DataFormatString="{0:MM/dd/yyyy}" HtmlEncode="false"></telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                        <asp:SqlDataSource ID="dsTrackingReport_web" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                            SelectCommand="Select * From rep_sp_TrackingReport_web Where CycleID = @CycleIDFromAdmin2">
                            <SelectParameters>
                                <asp:SessionParameter Name="CycleIDFromAdmin2" SessionField="CycleIDFromAdmin2" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>
                

                <telerik:RadPanelItem Text="Frequency" Expanded="true" CssClass="panelItem">
                    <ContentTemplate>
                        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="dsFrequency_web" AllowFilteringByColumn="True" AllowPaging="True"
                            EnableGroupsExpandAll="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
                            AllowSorting="True" GroupPanelPosition="Top" ShowGroupPanel="True" Height="600px"
                            Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True">

                            <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="Frequency">
                                <Excel Format="Xlsx" />
                            </ExportSettings>

                            <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>
                            <MasterTableView DataSourceID="dsFrequency_web" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="Region" DataType="System.String" FilterControlAltText="Region" HeaderText="ID" SortExpression="Region" UniqueName="Region"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Supervisor Name" FilterControlAltText="Supervisor Name" HeaderText="Supervisor Name" SortExpression="Supervisor Name" UniqueName="Supervisor_Name"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Rep Name" FilterControlAltText="Rep Name" HeaderText="Rep Name" SortExpression="Rep Name" UniqueName="Rep_Name"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AppointmentsCount" FilterControlAltText="AppointmentsCount" HeaderText="AppointmentsCount" SortExpression="AppointmentsCount" UniqueName="AppointmentsCount"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ActualCount" FilterControlAltText="Filter Date column" HeaderText="ActualCount" SortExpression="ActualCount" UniqueName="ActualCount"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AchievmentRatio" FilterControlAltText="AchievmentRatio" HeaderText="AchievmentRatio" SortExpression="AchievmentRatio" UniqueName="AchievmentRatio"></telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                        <asp:SqlDataSource ID="dsFrequency_web" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                            SelectCommand="Select * From rep_sp_Frequency_web WHERE CycleID = @CycleIDFromAdmin2">
                            <SelectParameters>
                                <asp:SessionParameter Name="CycleIDFromAdmin2" SessionField="CycleIDFromAdmin2" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>


                <telerik:RadPanelItem Text="Coverage" Expanded="true" CssClass="panelItem">
                    <ContentTemplate>
                        <telerik:RadGrid ID="grdCoverage_web" runat="server" DataSourceID="dsCoverage_web" AllowFilteringByColumn="True" AllowPaging="True"
                            EnableGroupsExpandAll="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
                            AllowSorting="True" GroupPanelPosition="Top" ShowGroupPanel="True" Height="600px"
                            Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True">

                            <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="Coverage">
                                <Excel Format="Xlsx" />
                            </ExportSettings>

                            <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>
                            <MasterTableView DataSourceID="dsCoverage_web" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="Region" DataType="System.String" FilterControlAltText="Region" HeaderText="ID" SortExpression="Region" UniqueName="Region"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Supervisor Name" FilterControlAltText="Supervisor Name" HeaderText="Supervisor Name" SortExpression="Supervisor Name" UniqueName="Supervisor_Name"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Rep Name" FilterControlAltText="Rep Name" HeaderText="Rep Name" SortExpression="Rep Name" UniqueName="Rep_Name"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PhysicianClass" FilterControlAltText="PhysicianClass" HeaderText="Ph. Class" SortExpression="PhysicianClass" UniqueName="PhysicianClass"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Targeted Doctors" FilterControlAltText="Targeted Doctors" HeaderText="Targeted Doctors" SortExpression="Targeted Doctors" UniqueName="Targeted_Doctors"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Actual Visited Doctors" FilterControlAltText="Filter Actual Visited Doctors column" HeaderText="Actual Visited Doctors" SortExpression="Actual Visited Doctors" UniqueName="Actual_Visited_Doctors"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AchievmentRatio" FilterControlAltText="AchievmentRatio" HeaderText="AchievmentRatio" SortExpression="AchievmentRatio" UniqueName="AchievmentRatio"></telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                        <asp:SqlDataSource ID="dsCoverage_web" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                            SelectCommand="Select * From rep_sp_Coverage_web WHERE CycleID = @CycleIDFromAdmin2">
                            <SelectParameters>
                                <asp:SessionParameter Name="CycleIDFromAdmin2" SessionField="CycleIDFromAdmin2" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>


                <telerik:RadPanelItem Text="Coverage & Frequency" Expanded="true" CssClass="panelItem">
                    <ContentTemplate>
                        <telerik:RadGrid ID="RadGrid2" runat="server" DataSourceID="dsCoverage_Frequency" AllowFilteringByColumn="True" AllowPaging="True"
                            EnableGroupsExpandAll="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
                            AllowSorting="True" GroupPanelPosition="Top" ShowGroupPanel="True" Height="600px"
                            Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True">

                            <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="Coverage - Frequency">
                                <Excel Format="Xlsx" />
                            </ExportSettings>

                            <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>
                            <MasterTableView DataSourceID="dsCoverage_Frequency" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="MonthID" FilterControlAltText="MonthID" HeaderText="Month" SortExpression="MonthID" UniqueName="MonthID"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="RegionName" FilterControlAltText="RegionName" HeaderText="Region" SortExpression="RegionName" UniqueName="RegionName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ManagerName" FilterControlAltText="ManagerName" HeaderText="Manager" SortExpression="ManagerName" UniqueName="ManagerName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SupervisorName" FilterControlAltText="SupervisorName" HeaderText="DM" SortExpression="SupervisorName" UniqueName="SupervisorName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="EmployeeName" FilterControlAltText="EmployeeName" HeaderText="Rep" SortExpression="EmployeeName" UniqueName="EmployeeName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PhysicianClass" FilterControlAltText="PhysicianClass" HeaderText="Ph. Class" SortExpression="PhysicianClass" UniqueName="PhysicianClass"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Targeted Doctors" FilterControlAltText="Targeted Doctors" HeaderText="Targeted Doctors" SortExpression="Targeted Doctors" UniqueName="Targeted_Doctors"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Visited Doctors" FilterControlAltText="Visited Doctors" HeaderText="Visited Doctors" SortExpression="Visited Doctors" UniqueName="Visited_Doctors"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Target Visits" FilterControlAltText="Target Visits" HeaderText="Target Visits" SortExpression="Target Visits" UniqueName="Target_Visits"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Actual Visits" FilterControlAltText="Actual Visits" HeaderText="Actual Visits" SortExpression="Actual Visits" UniqueName="Actual_Visits"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Coverage" FilterControlAltText="Coverage" HeaderText="Coverage" SortExpression="Coverage" UniqueName="Coverage" DataFormatString="{0:p}"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Frequency" FilterControlAltText="Frequency" HeaderText="Frequency" SortExpression="Frequency" UniqueName="Frequency" DataFormatString="{0:p}"></telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                        <asp:SqlDataSource ID="dsCoverage_Frequency" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                            SelectCommand="Select RegionName, LineID, ManagerName, SupervisorName, EmployeeName, PhysicianClass, SpecialityCode,
                                            SUM(TargetedDoctors) AS [Targeted Doctors], 
                                            SUM(ActualTargetedDoctors) AS [Visited Doctors], 
                                            SUM(TargetedVisits) AS [Target Visits], 
                                            SUM(ActualTargetedVisits) AS [Actual Visits], 
                                            (CASE WHEN SUM(TargetedDoctors) = 0 THEN 0 ELSE SUM(ActualTargetedDoctors) / SUM(TargetedDoctors) END) AS 'Coverage', 
                                            (CASE WHEN SUM(TargetedVisits) = 0 THEN 0 ELSE SUM(ActualTargetedVisits) / SUM(TargetedVisits) END) AS 'Frequency'
                                            From [ActualVsTarget_web] Where CycleID = CycleIDFromAdmin2
                                            Group By RegionName, LineID, ManagerName, SupervisorName, EmployeeName, PhysicianClass, SpecialityCode">
                            <SelectParameters>
                                <asp:SessionParameter Name="CycleIDFromAdmin2" SessionField="CycleIDFromAdmin2" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>


                <telerik:RadPanelItem Text="Call Rate" Expanded="true" CssClass="panelItem">
                    <ContentTemplate>
                        <telerik:RadGrid ID="grdVisitMessages" runat="server" DataSourceID="dsMessages" AllowFilteringByColumn="True" AllowPaging="True"
                            EnableGroupsExpandAll="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
                            AllowSorting="True" ShowGroupPanel="True" Height="600px"
                            Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True">

                            <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="Call Rate">
                                <Excel Format="Xlsx" />
                            </ExportSettings>

                            <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>
                            <MasterTableView DataSourceID="dsMessages" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="CycleDesc" HeaderText="CycleDesc" SortExpression="CycleDesc" UniqueName="CycleDesc" FilterControlAltText="Filter CycleDesc column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="LineName" HeaderText="LineName" SortExpression="LineName" UniqueName="LineName" FilterControlAltText="Filter LineName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ManagerName" HeaderText="ManagerName" SortExpression="ManagerName" UniqueName="ManagerName" FilterControlAltText="Filter ManagerName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SupervisorName" HeaderText="SupervisorName" SortExpression="SupervisorName" UniqueName="SupervisorName" FilterControlAltText="Filter SupervisorName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="EmployeeName" HeaderText="EmployeeName" SortExpression="EmployeeName" UniqueName="EmployeeName" FilterControlAltText="Filter EmployeeName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PhysicianClass" HeaderText="PhysicianClass" SortExpression="PhysicianClass" UniqueName="PhysicianClass" FilterControlAltText="Filter PhysicianClass column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SpecialityCode" HeaderText="SpecialityCode" SortExpression="SpecialityCode" UniqueName="SpecialityCode" FilterControlAltText="Filter SpecialityCode column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="BrandName" HeaderText="BrandName" SortExpression="BrandName" UniqueName="BrandName" FilterControlAltText="Filter BrandName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="BrandRankInCall" HeaderText="BrandRankInCall" SortExpression="BrandRankInCall" UniqueName="BrandRankInCall" FilterControlAltText="Filter BrandRankInCall column" DataType="System.Int64"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CountOfBrandRank" HeaderText="CountOfBrandRank" SortExpression="CountOfBrandRank" UniqueName="CountOfBrandRank" FilterControlAltText="Filter CountOfBrandRank column" DataType="System.Int32" ReadOnly="True"></telerik:GridBoundColumn>
                                </Columns>

                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                            </MasterTableView>
                        </telerik:RadGrid>

                        <asp:SqlDataSource ID="dsMessages" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                            SelectCommand="Select CycleDesc,LineName,ManagerName,SupervisorName,PhysicianClass,SpecialityCode,BrandName,BrandRankInCall,
                                            COUNT(BrandRankInCall) AS CallsCount 
                                            From View_VisitMessage_FullView_Web Where CycleID = @CycleIDFromAdmin2
                                            Group By CycleDesc, LineName, ManagerName, SupervisorName, EmployeeName, PhysicianClass, SpecialityCode, BrandName, BrandRankInCall" 
                            SelectCommandType="Text">
                            <SelectParameters>
                                <asp:SessionParameter SessionField="CycleIDFromAdmin2" Name="CycleIDFromAdmin2" Type="Int32"></asp:SessionParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>


                <telerik:RadPanelItem Text="Average Planned-Actual (Rep)" Expanded="true" CssClass="panelItem">
                    <ContentTemplate>
                        <telerik:RadGrid ID="grdAvgByRep" runat="server" DataSourceID="dsAvgByRep" AllowFilteringByColumn="True" AllowPaging="True"
                            EnableGroupsExpandAll="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
                            AllowSorting="True" GroupPanelPosition="Top" ShowGroupPanel="True" Height="600px"
                            Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True">

                            <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="Average Planned-Actual (Rep)">
                                <Excel Format="Xlsx" />
                            </ExportSettings>

                            <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>
                            <MasterTableView DataSourceID="dsAvgByRep" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="Region" FilterControlAltText="Region" HeaderText="Region" SortExpression="Region" UniqueName="Region"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Supervisor" FilterControlAltText="Region" HeaderText="Supervisor" SortExpression="Supervisor" UniqueName="Supervisor"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Rep Name" FilterControlAltText="Rep Name" HeaderText="Rep Name" SortExpression="Rep Name" UniqueName="Rep_Name"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Planned" FilterControlAltText="Planned" HeaderText="Planned" SortExpression="Planned" UniqueName="Planned"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Visited" FilterControlAltText="Visited" HeaderText="Visited" SortExpression="Visited" UniqueName="Visited"></telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                        <asp:SqlDataSource ID="dsAvgByRep" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                            SelectCommand="Select Region, Supervisor, [Rep Name], Planned, Visited, CycleID From rep_sp_AveragePlannedActualRep_web Where CycleID = @CycleIDFromAdmin2">
                            <SelectParameters>
                                <asp:SessionParameter Name="CycleIDFromAdmin2" SessionField="CycleIDFromAdmin2" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>


                <telerik:RadPanelItem Text="Average Planned-Actual (Reg)" Expanded="true" CssClass="panelItem">
                    <ContentTemplate>
                        <telerik:RadGrid ID="grdAvgByReg" runat="server" DataSourceID="dsAvgByReg" AllowFilteringByColumn="True" AllowPaging="True"
                            EnableGroupsExpandAll="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
                            AllowSorting="True" GroupPanelPosition="Top" ShowGroupPanel="True" Height="600px"
                            Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True">

                            <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="Average Planned-Actual (Reg)">
                                <Excel Format="Xlsx" />
                            </ExportSettings>

                            <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>
                            <MasterTableView DataSourceID="dsAvgByReg" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="Region" FilterControlAltText="Region" HeaderText="Region" SortExpression="Region" UniqueName="Region"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Planned" FilterControlAltText="Planned" HeaderText="Planned" SortExpression="Planned" UniqueName="Planned"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Visited" FilterControlAltText="Visited" HeaderText="Visited" SortExpression="Visited" UniqueName="Visited"></telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                        <asp:SqlDataSource ID="dsAvgByReg" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                            SelectCommand="Select Region, Planned, Visited, CycleID From rep_sp_AveragePlannedActualReg_web Where CycleID = @CycleIDFromAdmin2">
                            <SelectParameters>
                                <asp:SessionParameter Name="CycleIDFromAdmin2" SessionField="CycleIDFromAdmin2" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>


                <telerik:RadPanelItem Text="Actual Vs. Target Calls" Expanded="true" CssClass="panelItem">
                    <ContentTemplate>
                        <telerik:RadGrid ID="RadGrid3" runat="server" DataSourceID="dsActVsTargetCalls" AllowFilteringByColumn="True" AllowPaging="True"
                            EnableGroupsExpandAll="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
                            AllowSorting="True" ShowGroupPanel="True" Height="600px"
                            Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True">

                            <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="Actual Vs Target Calls">
                                <Excel Format="Xlsx" />
                            </ExportSettings>

                            <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>
                            <MasterTableView DataSourceID="dsActVsTargetCalls" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />

                                <Columns>
                                    <telerik:GridBoundColumn DataField="CycleID" HeaderText="CycleID" SortExpression="CycleID" UniqueName="CycleID" DataType="System.Int32" FilterControlAltText="Filter CycleID column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CycleDesc" HeaderText="CycleDesc" SortExpression="CycleDesc" UniqueName="CycleDesc" FilterControlAltText="Filter CycleDesc column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="LineName" HeaderText="LineName" SortExpression="LineName" UniqueName="LineName" FilterControlAltText="Filter LineName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AmounTerritoryName" HeaderText="AmounTerritoryName" SortExpression="AmounTerritoryName" UniqueName="AmounTerritoryName" FilterControlAltText="Filter AmounTerritoryName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SupervisionAreaName" HeaderText="SupervisionAreaName" SortExpression="SupervisionAreaName" UniqueName="SupervisionAreaName" FilterControlAltText="Filter SupervisionAreaName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ManagementAreaName" HeaderText="ManagementAreaName" SortExpression="ManagementAreaName" UniqueName="ManagementAreaName" FilterControlAltText="Filter ManagementAreaName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ManagerName" HeaderText="ManagerName" SortExpression="ManagerName" UniqueName="ManagerName" FilterControlAltText="Filter ManagerName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SupervisorName" HeaderText="SupervisorName" SortExpression="SupervisorName" UniqueName="SupervisorName" FilterControlAltText="Filter SupervisorName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="EmployeeName" HeaderText="EmployeeName" SortExpression="EmployeeName" UniqueName="EmployeeName" FilterControlAltText="Filter EmployeeName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PhysicianClass" HeaderText="PhysicianClass" SortExpression="PhysicianClass" UniqueName="PhysicianClass" FilterControlAltText="Filter PhysicianClass column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SpecialityCode" HeaderText="SpecialityCode" SortExpression="SpecialityCode" UniqueName="SpecialityCode" FilterControlAltText="Filter SpecialityCode column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="BrandRankInCall" HeaderText="BrandRankInCall" SortExpression="BrandRankInCall" UniqueName="BrandRankInCall" DataType="System.Int32" FilterControlAltText="Filter BrandRankInCall column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CallsCount" HeaderText="CallsCount" SortExpression="CallsCount" UniqueName="CallsCount" DataType="System.Int32" FilterControlAltText="Filter CallsCount column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TargetCalls" HeaderText="TargetCalls" SortExpression="TargetCalls" UniqueName="TargetCalls" DataType="System.Int32" FilterControlAltText="Filter TargetCalls column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="BrandName" HeaderText="BrandName" SortExpression="BrandName" UniqueName="BrandName" FilterControlAltText="Filter BrandName column"></telerik:GridBoundColumn>
                                </Columns>

                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                            </MasterTableView>
                        </telerik:RadGrid>

                        <asp:SqlDataSource ID="dsActVsTargetCalls" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
                            SelectCommand="GetActualVsTargetCalls" SelectCommandType="StoredProcedure">
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>
            </Items>
        </telerik:RadPanelBar>
    </div>
</asp:Content>

