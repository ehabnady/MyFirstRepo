<%@ Page Title="Call Rate" Language="C#" MasterPageFile="~/SalesManagers/SiteMaster2.Master" AutoEventWireup="true"
    CodeBehind="CallRate.aspx.cs" Inherits="AmounCRM4.SalesManagers.CallRate" %>

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
        .gridHieght{
            height:auto !important;
            border: 0 none;
        }
    </style>

    <script type="text/javascript">
        function myfunction() {
            $(document).ready(function () {
                // Default settings
                $('.gridAchRatio').responsiveTable();
                // Custom settings
                $('.gridAchRatio').responsiveTable({
                    staticColumns: 5,
                    scrollRight: true,
                    scrollHintEnabled: true,
                    scrollHintDuration: 2000
                });
            });
        }
    </script>
    <title>Call Rate</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="p1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gridAchRatio" LoadingPanelID="l1" />
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
                        <telerik:RadPanelItem Text="Call Rate" Expanded="true" CssClass="panelItem" Font-Size="Large" PreventCollapse="true">
                            <HeaderTemplate>                                
                                <table style="width:100%">
                                    <tr style="width:100%">
                                        <td style="text-align:left">
                                            <asp:Label ID="lblTitle" runat="server" Text="Call Rate" style="text-align:left" 
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
                                <telerik:RadGrid ID="gridAchRatio" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True"
                                    DataSourceID="dsRepAchRatio" Height="600px" GroupPanelPosition="Top" ShowGroupPanel="True" 
                                    Skin="WebBlue" EnableHeaderContextMenu="True" EnableHeaderContextAggregatesMenu="true" EnableHeaderContextFilterMenu="true"
                                    GridLines="Both" PageSize="50" ShowFooter="True" RenderMode="Mobile">
                                    
                                    <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="CallRate">
                                        <Excel Format="Xlsx" />
                                    </ExportSettings>

                                    <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                        <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                                    </ClientSettings>

                                    <MasterTableView AutoGenerateColumns="False" DataSourceID="dsRepAchRatio" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                        AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true" EnableHeaderContextMenu="True" EnableHeaderContextAggregatesMenu="true" 
                                        EnableHeaderContextFilterMenu="true">
                                        <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="false" ShowAddNewRecordButton="False" />
                                        <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevNumericAndAdvanced" />
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="CycleDesc" FilterControlAltText="Filter CycleDesc column" HeaderText="Cycle" 
                                                SortExpression="CycleDesc" UniqueName="CycleDesc">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="AmounRegionName" FilterControlAltText="Filter AmounRegionName column" 
                                                HeaderText="Region Name" SortExpression="AmounRegionName" UniqueName="AmounRegionName"
                                                ItemStyle-CssClass="hidden-md hidden-sm hidden-xs" HeaderStyle-CssClass="hidden-md hidden-sm hidden-xs"
                                                FooterStyle-CssClass="hidden-md hidden-sm hidden-xs">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="NewSupervisionAreaName" 
                                                FilterControlAltText="Filter NewSupervisionAreaName column" HeaderText="Super Area" 
                                                SortExpression="NewSupervisionAreaName" UniqueName="NewSupervisionAreaName"
                                                ItemStyle-CssClass="hidden-md hidden-sm hidden-xs" HeaderStyle-CssClass="hidden-md hidden-sm hidden-xs"
                                                FooterStyle-CssClass="hidden-md hidden-sm hidden-xs">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="NewAreaName" FilterControlAltText="Filter NewAreaName column" 
                                                HeaderText="Territory" SortExpression="NewAreaName" UniqueName="NewAreaName">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="SupervisorName" FilterControlAltText="Filter SupervisorName column" 
                                                HeaderText="District Manager" SortExpression="SupervisorName" UniqueName="SupervisorName"
                                                ItemStyle-CssClass="hidden-sm hidden-xs" HeaderStyle-CssClass="hidden-sm hidden-xs"
                                                FooterStyle-CssClass="hidden-sm hidden-xs">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="AppointmentsCount" DataType="System.Int32" 
                                                FilterControlAltText="Filter AppointmentsCount column" HeaderText="Planned" 
                                                SortExpression="AppointmentsCount" UniqueName="AppointmentsCount"
                                                ItemStyle-CssClass="hidden-sm hidden-xs" HeaderStyle-CssClass="hidden-sm hidden-xs"
                                                FooterStyle-CssClass="hidden-sm hidden-xs">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="ActualCount" DataType="System.Int32" 
                                                FilterControlAltText="Filter ActualCount column" HeaderText="Actual" 
                                                SortExpression="ActualCount" UniqueName="ActualCount"
                                                ItemStyle-CssClass="hidden-sm hidden-xs" HeaderStyle-CssClass="hidden-sm hidden-xs"
                                                FooterStyle-CssClass="hidden-sm hidden-xs">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="AchievmentRatio" DataType="System.Decimal" 
                                                FilterControlAltText="Filter AchievmentRatio column" HeaderText="% of Achievment" ReadOnly="True" 
                                                SortExpression="AchievmentRatio" UniqueName="AchievmentRatio" DataFormatString="{0:##%}">
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

    <asp:SqlDataSource ID="dsRepAchRatio" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
        SelectCommand="SELECT [CycleID], [CycleDesc], [EmployeeID], [EmployeeName], [SupervisorName], [TopManagerName], [NewAreaName], [NewSupervisionAreaName], [AmounRegionName], [SupervisorName], [AppointmentsCount], [ActualCount], ([AchievmentRatio] / 100) AS AchievmentRatio FROM [View_PlannedVsActual] WHERE TopManagerID = @EmployeeIDFromSM">
        <SelectParameters>
            <asp:SessionParameter Name="EmployeeIDFromSM" SessionField="EmployeeIDFromSM" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <script src="scripts/jquery.responsivetable.min.js"></script>

</asp:Content>
