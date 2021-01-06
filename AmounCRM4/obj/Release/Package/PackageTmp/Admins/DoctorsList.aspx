<%@ Page Title="Doctors List" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="DoctorsList.aspx.cs"
    Inherits="AmounCRM4.Admins.DoctorsList" %>

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

    <div>
        <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="95%" Height="100%"
            Skin="WebBlue" ExpandMode="SingleExpandedItem">
            <Items>


                <telerik:RadPanelItem Text="Hospitals, Clinics, and Physicians" Expanded="true" Font-Size="Large">
                    <ContentTemplate>
                        <telerik:RadGrid ID="gridAffs"
                            runat="server"
                            DataSourceID="ListOfAffDS"
                            AllowFilteringByColumn="True"
                            AllowPaging="True"
                            Height="700px"
                            EnableGroupsExpandAll="True"
                            EnableHeaderContextFilterMenu="True"
                            EnableHeaderContextAggregatesMenu="True"
                            AllowSorting="True"
                            ShowGroupPanel="True"
                            Skin="WebBlue"
                            EnableHeaderContextMenu="True"
                            GridLines="Both"
                            PageSize="50"
                            ShowFooter="True">

                            <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="Doctors List">
                                <Excel Format="Xlsx" />
                            </ExportSettings>

                            <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>

                            <MasterTableView DataSourceID="ListOfAffDS" AutoGenerateColumns="False"
                                ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true"
                                DataKeyNames="Doctor ID">
                                <CommandItemSettings ExportToExcelText="Export"
                                    ShowRefreshButton="true"
                                    ShowExportToExcelButton="true"
                                    ShowAddNewRecordButton="False" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="Line" HeaderText="Line" SortExpression="Line" UniqueName="Line" DataType="System.Int32" FilterControlAltText="Filter Line column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Region" HeaderText="Region" SortExpression="Region" UniqueName="Region" FilterControlAltText="Filter Region column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="District" HeaderText="District" SortExpression="District" UniqueName="District" FilterControlAltText="Filter District column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Territory" HeaderText="Territory" SortExpression="Territory" UniqueName="Territory" FilterControlAltText="Filter Territory column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Brick ID" HeaderText="Brick ID" SortExpression="Brick ID" UniqueName="BrickID" DataType="System.Int32" FilterControlAltText="Filter Brick ID column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Brick Name" HeaderText="Brick Name" SortExpression="Brick Name" UniqueName="BrickName" FilterControlAltText="Filter Brick Name column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Doctor ID" ReadOnly="True" HeaderText="Doctor ID" SortExpression="Doctor ID" UniqueName="DoctorID" DataType="System.Int32" FilterControlAltText="Filter Doctor ID column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Doctor Name" HeaderText="Doctor Name" SortExpression="Doctor Name" UniqueName="DoctorName" FilterControlAltText="Filter Doctor Name column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Specialty" HeaderText="Specialty" SortExpression="Specialty" UniqueName="Specialty" FilterControlAltText="Filter Specialty column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="HR Code" HeaderText="HR Code" SortExpression="HR Code" UniqueName="HRCode" DataType="System.Int32" FilterControlAltText="Filter HR Code column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Rep Name" HeaderText="Rep Name" SortExpression="Rep Name" UniqueName="RepName" FilterControlAltText="Filter Rep Name column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Supervisor Name" HeaderText="Supervisor Name" SortExpression="Supervisor Name" UniqueName="SupervisorName" FilterControlAltText="Filter Supervisor Name column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="No of Patients Value" HeaderText="No of Patients Value" SortExpression="No of Patients Value" UniqueName="NoofPatientsValue" DataType="System.Double" FilterControlAltText="Filter No of Patients Value column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Specialty Value" HeaderText="Specialty Value" SortExpression="Specialty Value" UniqueName="SpecialtyValue" DataType="System.Double" FilterControlAltText="Filter Specialty Value column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Prescription Habit" HeaderText="Prescription Habit" SortExpression="Prescription Habit" UniqueName="PrescriptionHabit" DataType="System.Double" FilterControlAltText="Filter Prescription Habit column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Total Value" HeaderText="Total Value" SortExpression="Total Value" UniqueName="TotalValue" DataType="System.Double" FilterControlAltText="Filter Total Value column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Class" HeaderText="Class" SortExpression="Class" UniqueName="Class" FilterControlAltText="Filter Class column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="IsTargeted3" ReadOnly="True" HeaderText="IsTargeted3" SortExpression="IsTargeted3" UniqueName="IsTargeted3" FilterControlAltText="Filter IsTargeted3 column"></telerik:GridBoundColumn>
                                </Columns>

                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />

                            </MasterTableView>
                        </telerik:RadGrid>


                        <asp:SqlDataSource ID="ListOfAffDS" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                            SelectCommand="rep_List_TargetedDoctors" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>
                <telerik:RadPanelItem Text="Requests" Expanded="true" Font-Size="Large">
                    <ContentTemplate>
                        <telerik:RadGrid ID="gridReqs" runat="server" DataSourceID="RequestsDataSourse" AllowFilteringByColumn="True"
                            AllowPaging="True"
                            Height="700px"
                            EnableGroupsExpandAll="True"
                            EnableHeaderContextFilterMenu="True"
                            EnableHeaderContextAggregatesMenu="True"
                            AllowSorting="True"
                            ShowGroupPanel="True"
                            Skin="WebBlue"
                            EnableHeaderContextMenu="True"
                            GridLines="Both"
                            PageSize="50"
                            ShowFooter="True">
                            <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="RequestsList">
                                <Excel Format="Xlsx" />
                            </ExportSettings>
                            <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>
                            <MasterTableView DataSourceID="RequestsDataSourse" AutoGenerateColumns="true"
                                ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export"
                                    ShowRefreshButton="true"
                                    ShowExportToExcelButton="true"
                                    ShowAddNewRecordButton="False" />


                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />

                            </MasterTableView>
                        </telerik:RadGrid>
                    </ContentTemplate>

                </telerik:RadPanelItem>

                <telerik:RadPanelItem Text="Hospital Requests" Expanded="true" Font-Size="Large">
                    <ContentTemplate>
                        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="HRequestsDataSourse" AllowFilteringByColumn="True"
                            AllowPaging="True"
                            Height="700px"
                            EnableGroupsExpandAll="True"
                            EnableHeaderContextFilterMenu="True"
                            EnableHeaderContextAggregatesMenu="True"
                            AllowSorting="True"
                            ShowGroupPanel="True"
                            Skin="WebBlue"
                            EnableHeaderContextMenu="True"
                            GridLines="Both"
                            PageSize="50"
                            ShowFooter="True">
                            <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="HospitalRequestsList">
                                <Excel Format="Xlsx" />
                            </ExportSettings>
                            <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>
                            <MasterTableView DataSourceID="HRequestsDataSourse" AutoGenerateColumns="true"
                                ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export"
                                    ShowRefreshButton="true"
                                    ShowExportToExcelButton="true"
                                    ShowAddNewRecordButton="False" />


                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />

                            </MasterTableView>
                        </telerik:RadGrid>
                    </ContentTemplate>

                </telerik:RadPanelItem>





            </Items>
        </telerik:RadPanelBar>
    </div>

    <asp:SqlDataSource ID="RequestsDataSourse" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
        SelectCommand="SELECT  * FROM [AmounCRM2].[dbo].[View_ChangeRequests_All] where ExportDate is  null and (Status='Sales Director' or Status='Commercial Director')"></asp:SqlDataSource>
    <asp:SqlDataSource ID="HRequestsDataSourse" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
        SelectCommand="SELECT  * FROM [AmounCRM2].[dbo].[View_ChangeRequestsForCO2] where ExportDate is  null"></asp:SqlDataSource>
    <div>
        <div align="center">
            <asp:Button ID="btnExport" runat="server" Text="Export" OnClick="btnExport_Click" Height="30px" BackColor="White" Font-Names="Times New Roman" Font-Size="Medium" ForeColor="#0000CC" />
        </div>
    </div>
</asp:Content>
