<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="DMReport_Appointments.aspx.cs" Inherits="AmounCRM4.DMs.DMReport_Appointments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .auto-style {
            width: 96%;
            text-align: left;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <br />
    <br />

    <table id="tblSummary" bgcolor="#3a4e62" align="center" width="88%">
        <tr>
            <td style="color: white" align="left"><b><font size="5">Appointments Numbers:</font></b></td>
            <td style="color: white" align="right"><b><font size="5">Total Appointments: </font></b></td>
            <td align="left" style="padding-left: 20px">
                <asp:Label ID="lblAppsCount" runat="server" Style="color: white" Font-Bold="True" Font-Underline="True" Font-Size="X-Large"></asp:Label>
            </td>
            <td style="color: white" align="right"><b><font size="5">Class "A": </font></b></td>
            <td align="left" style="padding-left: 20px">
                <asp:Label ID="lblClassA_App" runat="server" Style="color: white" Font-Bold="True" Font-Underline="True" Font-Size="X-Large"></asp:Label>
            </td>
            <td style="color: white" align="right"><b><font size="5">Class "B": </font></b></td>
            <td align="left" style="padding-left: 20px">
                <asp:Label ID="lblClassB_App" runat="server" Style="color: white" Font-Bold="True" Font-Underline="True" Font-Size="X-Large"></asp:Label>
            </td>
            <td style="color: white" align="right"><b><font size="5">Class "C": </font></b></td>
            <td align="left" style="padding-left: 20px">
                <asp:Label ID="lblClassC_App" runat="server" Style="color: white" Font-Bold="True" Font-Underline="True" Font-Size="X-Large"></asp:Label>
            </td>
        </tr>
    </table>

    <br />
    <br />

    <table id="tblTile" align="center" width="88%">
        <tr>
            <th><h4 align="left">Appointments by Specialty</h4></th>
        </tr>
        <tr>
            <td align="center">
                <telerik:RadListView ID="List1" runat="server" DataSourceID="AppByAreaGroupBySpec" Skin="WebBlue" RenderMode="Lightweight"
                    ClientDataKeyNames="SpecialityCode" DataKeyNames="SpecialityCode" Width="80%">
                    <LayoutTemplate>
                        <div class="RadListView RadListViewFloated RadListView_WebBlue">
                            <div class="rlvFloated">
                                <div id="itemPlaceholder" runat="server">
                                </div>
                            </div>
                        </div>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <div style="height: 80px; width: 150px" class="rlvI">
                            <table style="height: 80px; width: 150px"><tr valign="bottom"><td valign="top">
                            <asp:Label ID="SpecialityCodeLabel" runat="server" Font-Size="Large" Text='<%# Eval("SpecialityCode") %>' />
                            </td></tr>
                                <tr valign="bottom"><td valign="bottom">
                            <asp:Label ID="No_of_Appointments" runat="server" Font-Size="Large" Text='<%# Eval("No_of_Appointments") %>' />
                                    </td></tr></table>
                        </div>
                    </ItemTemplate>
                    <EmptyDataTemplate>
                        <div class="RadListView RadListView_WebBlue">
                            <div class="rlvEmpty">
                                There are no items to be displayed.
                            </div>
                        </div>
                    </EmptyDataTemplate>
                    <SelectedItemTemplate>
                        <div class="rlvISel">
                            <br />
                            <asp:Label ID="SpecialityCodeLabel" runat="server" Text='<%# Eval("SpecialityCode") %>' />
                            <br />
                            <asp:Label ID="No_of_VisitsLabel" runat="server" Text='<%# Eval("No_of_Appointments") %>' />
                        </div>
                    </SelectedItemTemplate>
                </telerik:RadListView>
            </td>
        </tr>
    </table>

    <br />
    <br />


    <table align="center" width="96%">
        <tr>
            <td align="center">
                <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>
                <telerik:RadAjaxPanel ID="ajaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1" Width="96%" HorizontalAlign="Center">

                    <telerik:RadGrid ID="gridApps" runat="server" DataSourceID="ListOfAppointmentsDS" AllowFilteringByColumn="True" AllowPaging="True" Height="600px"
                        EnableGroupsExpandAll="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
                        AllowSorting="True" GroupPanelPosition="Top" ShowGroupPanel="True" CssClass="auto-style"
                        Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True">

                        <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="ListOfAppointments">
                            <Excel Format="Xlsx" />
                        </ExportSettings>

                        <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                            <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                            <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                        </ClientSettings>
                        <MasterTableView DataSourceID="ListOfAppointmentsDS" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                            AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true" Caption="Appointments List"
                            EnableHeaderContextMenu="True" EnableHeaderContextAggregatesMenu="true" EnableHeaderContextFilterMenu="true">
                            <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                            <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                            <Columns>
                                <telerik:GridBoundColumn DataField="AppointmentID" DataType="System.Int32" FilterControlAltText="Filter AppointmentID column" HeaderText="Appointment ID" ReadOnly="True" SortExpression="AppointmentID" UniqueName="AppointmentID"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="AffiliationID" DataType="System.Int32" FilterControlAltText="Filter AffiliationID column" HeaderText="Affiliation ID" SortExpression="AffiliationID" UniqueName="AffiliationID"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="AffiliationName" FilterControlAltText="Filter AffiliationName column" HeaderText="Affiliation Name" SortExpression="AffiliationName" UniqueName="AffiliationName"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="SpecialityCode" FilterControlAltText="Filter SpecialityCode column" HeaderText="Specialty" SortExpression="SpecialityCode" UniqueName="SpecialityCode"></telerik:GridBoundColumn>
                                <%--<telerik:GridBoundColumn DataField="PhysicianClass" FilterControlAltText="Filter PhysicianClass column" HeaderText="PhClass" SortExpression="PhysicianClass" UniqueName="PhysicianClass"></telerik:GridBoundColumn>--%>
                                <telerik:GridBoundColumn DataField="Subject" FilterControlAltText="Filter Subject column" HeaderText="Subject" SortExpression="Subject" UniqueName="Subject"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="VisitDateTime" FilterControlAltText="Filter VisitDateTime column" HeaderText="Visit Date" SortExpression="VisitDateTime" UniqueName="VisitDateTime" DataType="System.DateTime"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Annotations" FilterControlAltText="Filter Annotations column" HeaderText="Annotations" SortExpression="Annotations" UniqueName="Annotations"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="NewAreaName" FilterControlAltText="Filter NewAreaName column" HeaderText="Area" SortExpression="NewAreaName" UniqueName="NewAreaName"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="CycleID" FilterControlAltText="Filter CycleID column" HeaderText="CycleID" SortExpression="CycleID" UniqueName="CycleID" Visible="false"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="CycleDesc" FilterControlAltText="Filter CycleDesc column" HeaderText="Cycle" SortExpression="CycleDesc" UniqueName="CycleDesc"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="IsTargeted" FilterControlAltText="Filter IsTargeted column" HeaderText="IsTargeted" SortExpression="IsTargeted" UniqueName="IsTargeted"></telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>

                    <asp:SqlDataSource ID="ListOfAppointmentsDS" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                            SelectCommand="SELECT [AppointmentID],[Subject],[VisitDateTime],[AffiliationID],[AffiliationName],[SpecialityCode],[PhysicianClass],[NewAreaName],[CycleID],[CycleDesc], [Annotations], [IsTargeted] FROM [View_ListOfAppointments_Admin] WHERE SupervisorID = @EmployeeIDFromDM"
                            OnSelecting="ListOfAppointmentsDS_Selecting">
                            <SelectParameters>
                                <asp:SessionParameter Name="EmployeeIDFromDM" SessionField="EmployeeIDFromDM" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                    <asp:ObjectDataSource ID="AppByAreaGroupBySpec" runat="server" OldValuesParameterFormatString="original_{0}"
                        SelectMethod="GetDataBySupervisionAreaID2" TypeName="AmounCRM4.App_Data.ExecSummary2TableAdapters.View_AppointmentsTableAdapter">
                        <SelectParameters>
                            <asp:SessionParameter Name="EmployeeIDFromDM" SessionField="EmployeeIDFromDM" Type="Int32" />
                            <asp:SessionParameter Name="CycleIDFromDM" SessionField="CycleIDFromDM" Type="Int32" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                </telerik:RadAjaxPanel>

            </td>
        </tr>
        <tr>
            <td align="center">&nbsp;</td>
        </tr>
    </table>
</asp:Content>
