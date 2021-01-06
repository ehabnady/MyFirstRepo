<%@ Page Title="Not Visited Doctors" Language="C#" MasterPageFile="~/SalesManagers/SiteMaster2.Master" AutoEventWireup="true"
    CodeBehind="NotVisited.aspx.cs" Inherits="AmounCRM4.SalesManagers.NotVisited" %>

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
                $('.gridNotPlanned').responsiveTable();
                // Custom settings
                $('.gridNotPlanned').responsiveTable({
                    staticColumns: 5,
                    scrollRight: true,
                    scrollHintEnabled: true,
                    scrollHintDuration: 2000
                });
            });
        }
    </script>
    <title>Not Visited Doctors</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="p1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gridNotPlanned" LoadingPanelID="l1" />
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
                        <telerik:RadPanelItem Text="Not Visited Doctors List" Expanded="true" CssClass="panelItem" Font-Size="Large" PreventCollapse="true">
                            <HeaderTemplate>
                                <table style="width: 100%">
                                    <tr style="width: 100%">
                                        <td style="text-align: left">
                                            <asp:Label ID="lblTitle" runat="server" Text="Not Visited Doctors List" Style="text-align: left"
                                                Font-Bold="false" Font-Size="Larger" ForeColor="White"></asp:Label>
                                        </td>
                                        <td style="text-align: right">
                                            <asp:LinkButton ID="btnExport" Text="Export to Excel" runat="server" OnClick="btnExport_Click" ForeColor="White"
                                                Font-Size="Small" Style="text-align: right" />
                                        </td>
                                    </tr>
                                </table>
                            </HeaderTemplate>

                            <ContentTemplate>
                                <telerik:RadGrid ID="gridNotPlanned" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True"
                                    DataSourceID="dsNotVisited" Height="600px" GroupPanelPosition="Top" ShowGroupPanel="True"
                                    Skin="WebBlue" EnableHeaderContextMenu="True" EnableHeaderContextAggregatesMenu="true" EnableHeaderContextFilterMenu="true"
                                    GridLines="Both" PageSize="50" ShowFooter="True" RenderMode="Mobile">

                                    <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="NotVisitedDoctors">
                                        <Excel Format="Xlsx" />
                                    </ExportSettings>

                                    <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                        <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                                    </ClientSettings>

                                    <MasterTableView AutoGenerateColumns="False" DataSourceID="dsNotVisited" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                        AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                        <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="false" ShowAddNewRecordButton="False" />
                                        <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevNumericAndAdvanced" />
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="AffiliationID" FilterControlAltText="Filter AffiliationID column"
                                                HeaderText="Doctor ID" SortExpression="AffiliationID" UniqueName="AffiliationID"
                                                ItemStyle-CssClass="hidden-md hidden-sm hidden-xs" HeaderStyle-CssClass="hidden-md hidden-sm hidden-xs"
                                                FooterStyle-CssClass="hidden-md hidden-sm hidden-xs">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="AffiliationName" FilterControlAltText="Filter AffiliationName column"
                                                HeaderText="Doctor" SortExpression="AffiliationName" UniqueName="AffiliationName">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="SpecialityCode" FilterControlAltText="Filter SpecialityCode column"
                                                HeaderText="Specialty" SortExpression="SpecialityCode" UniqueName="SpecialityCode"
                                                ItemStyle-CssClass="hidden-sm hidden-xs" HeaderStyle-CssClass="hidden-sm hidden-xs"
                                                FooterStyle-CssClass="hidden-sm hidden-xs">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="PhysicianClass" FilterControlAltText="Filter PhysicianClass column"
                                                HeaderText="Class" SortExpression="PhysicianClass" UniqueName="PhysicianClass">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="IsTargeted3" DataType="System.String"
                                                FilterControlAltText="Filter IsTargeted3 column" HeaderText="Mandatory?" SortExpression="IsTargeted3"
                                                UniqueName="IsTargeted3"
                                                ItemStyle-CssClass="hidden-sm hidden-xs" HeaderStyle-CssClass="hidden-sm hidden-xs"
                                                FooterStyle-CssClass="hidden-sm hidden-xs">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="AmounBrickName" DataType="System.String"
                                                FilterControlAltText="Filter AmounBrickName column" HeaderText="Brick" SortExpression="AmounBrickName"
                                                UniqueName="AmounBrickName"
                                                ItemStyle-CssClass="hidden-md hidden-sm hidden-xs" HeaderStyle-CssClass="hidden-md hidden-sm hidden-xs"
                                                FooterStyle-CssClass="hidden-xs">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="AmounTerritoryName" DataType="System.String"
                                                FilterControlAltText="Filter AmounTerritoryName column" HeaderText="Area" SortExpression="AmounTerritoryName"
                                                UniqueName="AmounTerritoryName">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="SupervisorName" DataType="System.String"
                                                FilterControlAltText="Filter SupervisorName column" HeaderText="Disrtict Manager"
                                                SortExpression="SupervisorName" UniqueName="SupervisorName"
                                                ItemStyle-CssClass="hidden-sm hidden-xs" HeaderStyle-CssClass="hidden-sm hidden-xs"
                                                FooterStyle-CssClass="hidden-sm hidden-xs">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="EmployeeName" DataType="System.String"
                                                FilterControlAltText="Filter EmployeeName column" HeaderText="Rep Name" SortExpression="EmployeeName"
                                                UniqueName="EmployeeName"
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

    <asp:SqlDataSource ID="dsNotVisited" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
        SelectCommand="GetNotVisited_SM" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="EmployeeIDFromSM" SessionField="EmployeeIDFromSM" Type="Int32" />
            <asp:SessionParameter Name="CycleIDFromSM" SessionField="CycleIDFromSM" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <script src="scripts/jquery.responsivetable.min.js"></script>

</asp:Content>
