<%@ Page Title="Plan & Visits" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Plan_Visits.aspx.cs" 
    Inherits="AmounCRM4.Admins.Plan_Visits" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <link type="text/css" rel="stylesheet" href="styles.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">

    <%--<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadPanelBar1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gridAffs" LoadingPanelID="ALP_i0" UpdatePanelRenderMode="Inline" />
                    <telerik:AjaxUpdatedControl ControlID="gridCalls" LoadingPanelID="ALP_i0" UpdatePanelRenderMode="Inline" />
                    <telerik:AjaxUpdatedControl ControlID="gridApps" LoadingPanelID="ALP_i0" UpdatePanelRenderMode="Inline" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>--%>

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function mngRequestStarted(ajaxManager, eventArgs) {
                if (eventArgs.get_eventTarget().indexOf("mngBtn") != -1)
                    eventArgs.set_enableAjax(false);
            }
            function pnlRequestStarted(ajaxPanel, eventArgs) {
                if (eventArgs.get_eventTarget().indexOf("pnlBtn") != -1)
                    eventArgs.set_enableAjax(false);
            }
        </script>
    </telerik:RadCodeBlock>
    
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" ClientEvents-OnRequestStart="mngRequestStarted" UpdatePanelsRenderMode="Inline">
        <%--<AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="gridAffs">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl UpdatePanelRenderMode="Inline" ControlID="gridAffs" LoadingPanelID="ALP_i0" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="gridCalls">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gridCalls" LoadingPanelID="ALP_i0" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="gridApps">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gridApps" LoadingPanelID="ALP_i0" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>--%>
    </telerik:RadAjaxManager>

    <script src="scripts.js" type="text/javascript"></script>

    <%--<telerik:RadAjaxLoadingPanel ID="ALP_i0" runat="server"></telerik:RadAjaxLoadingPanel>--%>
 

    <div align="left">
        <telerik:RadDropDownList ID="ddlLines" runat="server">
            <Items>
                <telerik:DropDownListItem Text="Select" Value="0" />
                <telerik:DropDownListItem Text="Line 1" Value="1" />
                <telerik:DropDownListItem Text="Line 2" Value="2" />
                <telerik:DropDownListItem Text="Line 3" Value="3" />
                <telerik:DropDownListItem Text="Line 4" Value="4" />
                <telerik:DropDownListItem Text="Line 5" Value="5" />
                <telerik:DropDownListItem Text="Line 6" Value="6" />
                <telerik:DropDownListItem Text="Line 7" Value="7" />
                <telerik:DropDownListItem Text="Hospital Line" Value="13" />
            </Items>
        </telerik:RadDropDownList>
        <telerik:RadDropDownList ID="ddlRegions" runat="server">
            <Items>
                <telerik:DropDownListItem Text="Select" Value="0" />
                <telerik:DropDownListItem Text="C" Value="C" />
                <telerik:DropDownListItem Text="L" Value="L" />
                <telerik:DropDownListItem Text="U" Value="U" />
                <telerik:DropDownListItem Text="X" Value="X" />
            </Items>
        </telerik:RadDropDownList>
        <telerik:RadDropDownList ID="ddlCycles" runat="server" DataSourceID="dsCycles" DataTextField="CycleDesc" DataValueField="CycleID" AppendDataBoundItems="true">
            <Items>
                <telerik:DropDownListItem Text="Select" Value="0" />
            </Items>
        </telerik:RadDropDownList>

        <asp:SqlDataSource runat="server" ID="dsCycles" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
            SelectCommand="SELECT [CycleID], [CycleDesc] FROM [Cycles] ORDER BY [YearID] DESC, [CycleID] DESC" />

        <asp:Button ID="btnGet" runat="server" OnClick="btnGet_Click" Text="Get Plan" />
        <br /><br />

    </div>
    <div align="left">
        <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="95%" Height="100%" 
            Skin="WebBlue" ExpandMode="SingleExpandedItem">
            <Items>                
                <telerik:RadPanelItem Text="Appointments List" Expanded="false" Font-Size="Large">
                    <ContentTemplate>

                        <telerik:RadGrid ID="gridApps" runat="server" DataSourceID="ListOfAppointmentsDS" AllowFilteringByColumn="True" AllowPaging="True" Height="700px"
                            EnableGroupsExpandAll="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
                            AllowSorting="True" GroupPanelPosition="Top" ShowGroupPanel="True"
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
                                    <telerik:GridBoundColumn DataField="AppointmentID" DataType="System.Int32" FilterControlAltText="Filter AppointmentID column" HeaderText="Appointment ID" ReadOnly="True" SortExpression="AppointmentID" UniqueName="AppointmentID"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Subject" FilterControlAltText="Filter Subject column" HeaderText="Subject" SortExpression="Subject" UniqueName="Subject"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="VisitDateTime" FilterControlAltText="Filter VisitDateTime column" HeaderText="Visit Date" SortExpression="VisitDateTime" UniqueName="VisitDateTime" DataType="System.DateTime"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="EmployeeID" DataType="System.Int32" FilterControlAltText="Filter EmployeeID column" HeaderText="Employee ID" SortExpression="EmployeeID" UniqueName="EmployeeID"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="EmployeeName" FilterControlAltText="Filter EmployeeName column" HeaderText="Employee Name" SortExpression="EmployeeName" UniqueName="EmployeeName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NewLineID" DataType="System.Int32" FilterControlAltText="Filter NewLineID column" HeaderText="Line ID" SortExpression="NewLineID" UniqueName="NewLineID"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NewAreaID" DataType="System.Int32" FilterControlAltText="Filter NewAreaID column" HeaderText="Area ID" SortExpression="NewAreaID" UniqueName="NewAreaID"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CycleID" DataType="System.Int32" FilterControlAltText="Filter CycleID column" HeaderText="Cycle ID" SortExpression="CycleID" UniqueName="CycleID"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Annotations" FilterControlAltText="Filter Annotations column" HeaderText="Annotations" SortExpression="Annotations" UniqueName="Annotations"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AffiliationID" DataType="System.Int32" FilterControlAltText="Filter AffiliationID column" HeaderText="Affiliation ID" SortExpression="AffiliationID" UniqueName="AffiliationID"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AffiliationName" FilterControlAltText="Filter AffiliationName column" HeaderText="Affiliation Name" SortExpression="AffiliationName" UniqueName="AffiliationName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SpecialityCode" FilterControlAltText="Filter SpecialityCode column" HeaderText="Specialty" SortExpression="SpecialityCode" UniqueName="SpecialityCode"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PhysicianClass" FilterControlAltText="Filter PhysicianClass column" HeaderText="Ph. Class" SortExpression="PhysicianClass" UniqueName="PhysicianClass"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CycleDesc" FilterControlAltText="Filter CycleDesc column" HeaderText="Cycle Desc" SortExpression="CycleDesc" UniqueName="CycleDesc"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SupervisorID" DataType="System.Int32" FilterControlAltText="Filter SupervisorID column" HeaderText="Supervisor ID" SortExpression="SupervisorID" UniqueName="SupervisorID" Visible="False"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SupervisorName" FilterControlAltText="Filter SupervisorName column" HeaderText="Supervisor" SortExpression="SupervisorName" UniqueName="SupervisorName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ManagerID" DataType="System.Int32" FilterControlAltText="Filter ManagerID column" HeaderText="ManagerID" SortExpression="ManagerID" UniqueName="ManagerID" Visible="False"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ManagerName" FilterControlAltText="Filter ManagerName column" HeaderText="Manager" SortExpression="ManagerName" UniqueName="ManagerName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NewAreaName" FilterControlAltText="Filter NewAreaName column" HeaderText="Area" SortExpression="NewAreaName" UniqueName="NewAreaName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NewSupervisionAreaID" DataType="System.Int32" FilterControlAltText="Filter SupervisionAreaID column" HeaderText="Supervision Area ID" SortExpression="SupervisionAreaID" UniqueName="SupervisionAreaID" Visible="False"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NewSupervisionAreaName" FilterControlAltText="Filter NewSupervisionAreaID column" HeaderText="Super Area" SortExpression="NewSupervisionAreaName" UniqueName="NewSupervisionAreaName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ManagementAreaID" DataType="System.Int32" FilterControlAltText="Filter ManagementAreaID column" HeaderText="Management Area ID" SortExpression="ManagementAreaID" UniqueName="ManagementAreaID" Visible="False"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NewMgtAreaName" FilterControlAltText="Filter NewMgtAreaName column" HeaderText="Mgt Area" SortExpression="NewMgtAreaName" UniqueName="NewMgtAreaName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="DoubleVisitWith" FilterControlAltText="Filter DoubleVisitWith column" HeaderText="DoubleVisitWith" SortExpression="DoubleVisitWith" UniqueName="DoubleVisitWith"></telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                        <asp:SqlDataSource ID="ListOfAppointmentsDS" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                            SelectCommand="SELECT [AppointmentID],[Subject],[VisitDateTime],[EndDate],[EmployeeID],[EmployeeName],[NewLineID],[NewAreaID],[CycleID],[Annotations],[AffiliationID],[AffiliationName], 
                            [SpecialityCode], [PhysicianClass],[CycleDesc],[SupervisorID],[SupervisorName],[ManagerID],[ManagerName],[NewAreaName],[NewSupervisionAreaID],[NewSupervisionAreaName],
                            [ManagementAreaID],[NewMgtAreaName], [DoubleVisitWith] FROM [View_ListOfAppointments_Admin]">
                        </asp:SqlDataSource>
                        
                    </ContentTemplate>
                </telerik:RadPanelItem>

                <telerik:RadPanelItem Text="Achievement Ratio List" Expanded="false" Font-Size="Large">
                    <ContentTemplate>
                                <telerik:RadGrid ID="gridAchRatio" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" 
                                    DataSourceID="dsRepAchRatio" Height="550px" GroupPanelPosition="Top" ShowGroupPanel="True"
                                    Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True">

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
                                        <telerik:GridBoundColumn DataField="CycleID" DataType="System.Int32" FilterControlAltText="Filter CycleID column" HeaderText="Cycle" SortExpression="CycleID" UniqueName="CycleID">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="EmployeeID" DataType="System.Int32" FilterControlAltText="Filter EmployeeID column" HeaderText="Employee ID" SortExpression="EmployeeID" UniqueName="EmployeeID">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="EmployeeName" FilterControlAltText="Filter EmployeeName column" HeaderText="Employee Name" SortExpression="EmployeeName" UniqueName="EmployeeName">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="SupervisorName" FilterControlAltText="Filter SupervisorName column" HeaderText="Supervisor" SortExpression="SupervisorName" UniqueName="SupervisorName">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TopManagerName" FilterControlAltText="Filter Regional Manager column" HeaderText="Manager" SortExpression="TopManagerName" UniqueName="TopManagerName">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="NewAreaName" FilterControlAltText="Filter NewAreaName column" HeaderText="Area" SortExpression="NewAreaName" UniqueName="NewAreaName">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="NewSupervisionAreaName" FilterControlAltText="Filter NewSupervisionAreaName column" HeaderText="Super Area" SortExpression="NewSupervisionAreaName" UniqueName="NewSupervisionAreaName">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="NewMgtAreaName" FilterControlAltText="Filter NewMgtAreaName column" HeaderText="Region" SortExpression="NewMgtAreaName" UniqueName="NewMgtAreaName">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="AppointmentsCount" DataType="System.Int32" FilterControlAltText="Filter AppointmentsCount column" HeaderText="Planned" SortExpression="AppointmentsCount" UniqueName="AppointmentsCount">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="ActualCount" DataType="System.Int32" FilterControlAltText="Filter ActualCount column" HeaderText="Actual" SortExpression="ActualCount" UniqueName="ActualCount">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="AchievmentRatio" DataType="System.Decimal" FilterControlAltText="Filter AchievmentRatio column" HeaderText="Ratio" ReadOnly="True" SortExpression="AchievmentRatio" UniqueName="AchievmentRatio">
                                        </telerik:GridBoundColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                            <asp:SqlDataSource ID="dsRepAchRatio" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
                                SelectCommand="SELECT [CycleID], [EmployeeID], [EmployeeName], [SupervisorName], [TopManagerName], [NewAreaName], [NewSupervisionAreaName], [NewMgtAreaName], [AppointmentsCount], [ActualCount], [AchievmentRatio] FROM [View_PlannedVsActual] WHERE YearID >= 2018"></asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>
            </Items>
        </telerik:RadPanelBar>
    </div>

    <div>
    </div>
</asp:Content>
