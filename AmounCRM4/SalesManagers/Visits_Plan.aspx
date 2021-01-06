<%@ Page Title="Doctors Visits & Plans" Language="C#" MasterPageFile="~/SalesManagers/SiteMaster2.Master" AutoEventWireup="true"
    CodeBehind="Visits_Plan.aspx.cs" Inherits="AmounCRM4.SalesManagers.Visits_Plan" %>

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
            margin: 0 auto;
        }
    </style>

    <script type="text/javascript">
        function myfunction() {
            $(document).ready(function () {
                // Default settings
                $('.gridApps').responsiveTable();
                // Custom settings
                $('.gridApps').responsiveTable({
                    staticColumns: 5,
                    scrollRight: true,
                    scrollHintEnabled: true,
                    scrollHintDuration: 2000
                });
            });
        }
    </script>
    <title>Doctors Visits & Plans</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="p1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gridApps" LoadingPanelID="l1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="l1" runat="server" />

    <script src="scripts.js" type="text/javascript"></script>

    <asp:Panel ID="p1" runat="server" CssClass="container DivCenter" Width="100%" Height="90%">
        <div class="row DivCenter" style="width: 100%">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 DivCenter" style="width: 100%">
                <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="95%" Height="100%" Skin="WebBlue" ExpandMode="FullExpandedItem"
                    CssClass="DivCenter">
                    <Items>
                        <telerik:RadPanelItem Text="Doctor's Visits / Planned" Expanded="true" CssClass="panelItem" Font-Size="Large" PreventCollapse="true">
                            <HeaderTemplate>
                                <table style="width:100%">
                                    <tr style="width:100%">
                                        <td style="text-align:left">
                                            <asp:Label ID="lblTitle" runat="server" Text="Doctor's Visits / Planned" style="text-align:left" 
                                                Font-Bold="false" Font-Size="Larger" ForeColor="White"></asp:Label>
                                            <br /><br />
                                            <asp:Label ID="lblAppsTotal" runat="server" style="text-align:left" 
                                                Font-Bold="false" Font-Size="Larger" ForeColor="White"></asp:Label>
                                            <asp:Label ID="lblAppsClassA" runat="server" style="text-align:left" 
                                                Font-Bold="false" Font-Size="Larger" ForeColor="White"></asp:Label>
                                            <asp:Label ID="lblAppsClassB" runat="server" style="text-align:left" 
                                                Font-Bold="false" Font-Size="Larger" ForeColor="White"></asp:Label>
                                        </td>
                                        <td style="text-align:right">
                                            <asp:LinkButton ID="btnExport" Text="Export to Excel" runat="server" OnClick="btnExport_Click" ForeColor="White" 
                                                Font-Size="Small" style="text-align:right" />
                                        </td>
                                    </tr>
                                </table>
                            </HeaderTemplate>

                            <ContentTemplate>
                                <telerik:RadGrid ID="gridApps" runat="server" DataSourceID="ListOfAppointmentsDS" AllowFilteringByColumn="True" AllowPaging="True"
                                    EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
                                    AllowSorting="True" GroupPanelPosition="Top" ShowGroupPanel="True" Height="600px"
                                    Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True" RenderMode="Mobile">

                                    <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="PlansAndVisits">
                                        <Excel Format="Xlsx" />
                                    </ExportSettings>

                                    <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                        <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                                    </ClientSettings>

                                    <MasterTableView DataSourceID="ListOfAppointmentsDS" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                        AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true" EnableHeaderContextMenu="True" EnableHeaderContextAggregatesMenu="true" 
                                        EnableHeaderContextFilterMenu="true">
                                        <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="false" ShowAddNewRecordButton="False" />
                                        <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevNumericAndAdvanced" />
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="AffiliationID" DataType="System.Int32" 
                                                FilterControlAltText="Filter AffiliationID column" HeaderText="ID" SortExpression="AffiliationID" 
                                                UniqueName="AffiliationID"
                                                ItemStyle-CssClass="hidden-md hidden-sm hidden-xs" HeaderStyle-CssClass="hidden-md hidden-sm hidden-xs"
                                                FooterStyle-CssClass="hidden-md hidden-sm hidden-xs">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="AffiliationName" FilterControlAltText="Filter AffiliationName column" 
                                                HeaderText="Name" SortExpression="AffiliationName" UniqueName="AffiliationName">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="SpecialityCode" FilterControlAltText="Filter SpecialityCode column" 
                                                HeaderText="Specialty" SortExpression="SpecialityCode" UniqueName="SpecialityCode"
                                                ItemStyle-CssClass="hidden-sm hidden-xs" HeaderStyle-CssClass="hidden-sm hidden-xs"
                                                FooterStyle-CssClass="hidden-sm hidden-xs">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="PhysicianClass" FilterControlAltText="Filter PhysicianClass column" 
                                                HeaderText="Class" SortExpression="PhysicianClass" UniqueName="PhysicianClass">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridDateTimeColumn DataField="EndDate" FilterControlAltText="Filter Date column" HeaderText="Date" 
                                                SortExpression="EndDate" UniqueName="EndDate" DataType="System.DateTime" Visible="true" 
                                                DataFormatString="{0:MM/dd/yyyy}" HtmlEncode="false"
                                                ItemStyle-CssClass="hidden-sm hidden-xs" HeaderStyle-CssClass="hidden-sm hidden-xs"
                                                FooterStyle-CssClass="hidden-sm hidden-xs">
                                            </telerik:GridDateTimeColumn>
                                            <telerik:GridBoundColumn DataField="Annotations2" FilterControlAltText="Filter Annotations column" 
                                                HeaderText="Status" SortExpression="Annotations" UniqueName="Annotations">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="CycleDesc" FilterControlAltText="Filter CycleDesc column" 
                                                HeaderText="Cycle" SortExpression="CycleDesc" UniqueName="CycleDesc">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="AmounBrickName" FilterControlAltText="Filter AmounBrickName column" 
                                                HeaderText="Brick" SortExpression="AmounBrickName" UniqueName="AmounBrickName"
                                                ItemStyle-CssClass="hidden-md hidden-sm hidden-xs" HeaderStyle-CssClass="hidden-md hidden-sm hidden-xs"
                                                FooterStyle-CssClass="hidden-md hidden-sm hidden-xs">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="NewAreaName" FilterControlAltText="Filter NewAreaName column" 
                                                HeaderText="Territory" SortExpression="NewAreaName" UniqueName="NewAreaName">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="SupervisorName" FilterControlAltText="Filter SupervisorName column" 
                                                HeaderText="District Manager" SortExpression="SupervisorName" UniqueName="SupervisorName"
                                                ItemStyle-CssClass="hidden-md hidden-sm hidden-xs" HeaderStyle-CssClass="hidden-md hidden-sm hidden-xs"
                                                FooterStyle-CssClass="hidden-md hidden-sm hidden-xs">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="IsTargeted2" FilterControlAltText="Filter IsTargeted column" 
                                                HeaderText="Mandatory?" SortExpression="IsTargeted" UniqueName="IsTargeted"
                                                ItemStyle-CssClass="hidden-sm hidden-xs" HeaderStyle-CssClass="hidden-sm hidden-xs"
                                                FooterStyle-CssClass="hidden-sm hidden-xs">
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </ContentTemplate>
                        </telerik:RadPanelItem>
                    </Items>
                </telerik:RadPanelBar>
            </div>
        </div>
    </asp:Panel>
    <asp:SqlDataSource ID="ListOfAppointmentsDS" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
        SelectCommand="SELECT [AppointmentID],[EndDate],[AffiliationID],[AffiliationName],[SpecialityCode],[PhysicianClass],[NewAreaName],[Annotations2], [Subject], [IsTargeted2], [CycleDesc], [AmounBrickName], [SupervisorName] FROM [View_ListOfAppointments_Admin] WHERE [PhysicianClass] IN ('A', 'B') AND ManagerID = @EmployeeIDFromSM">
        <SelectParameters>
            <asp:SessionParameter Name="EmployeeIDFromSM" SessionField="EmployeeIDFromSM" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <script src="scripts/jquery.responsivetable.min.js"></script>

</asp:Content>
