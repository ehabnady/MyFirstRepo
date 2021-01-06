<%@ Page Title="Doctors List" Language="C#" MasterPageFile="~/SalesManagers/SiteMaster2.Master" AutoEventWireup="true"
    CodeBehind="DoctorsList.aspx.cs" Inherits="AmounCRM4.SalesManagers.DoctorsList" %>

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
        .colWidth
        {
            width: auto !important;
        }
    </style>

    <script type="text/javascript">
        function myfunction() {
            $(document).ready(function () {
                // Default settings
                $('.gridAffs').responsiveTable();
                // Custom settings
                //$('.gridAffs').responsiveTable({
                //    staticColumns: 0,
                //    scrollRight: true,
                //    scrollHintEnabled: true,
                //    scrollHintDuration: 2000
                //});
            });
        }
    </script>
    <title>Doctors List</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="p1">
                <UpdatedControls>
                    <%--<telerik:AjaxUpdatedControl ControlID="gridAffs" LoadingPanelID="l1" />--%>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="l1" runat="server" RenderMode="Auto" />

    <%--<script src="scripts.js" type="text/javascript"></script>--%>

    <div class="row DivCenter" style="width:100%">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 DivCenter" style="width:100%">
            <table style="width:100%" class="table-responsive">
                <tr style="width:100%">
                    <td style="text-align:left">
                                            
                        <telerik:RadLabel RenderMode="Mobile" ID="lblTitle" runat="server" Text="Doctors List" style="text-align:left" 
                            Font-Bold="false" Font-Size="Medium" ForeColor="Black"></telerik:RadLabel>
                        <br /><br />

                        <telerik:RadLabel RenderMode="Mobile" ID="lblAffsTotal2" runat="server" style="text-align:left" 
                            Font-Bold="false" Font-Size="Medium" ForeColor="Black"></telerik:RadLabel>

                        <telerik:RadLabel RenderMode="Mobile" ID="lblAffsClassA2" runat="server" style="text-align:left" 
                            Font-Bold="false" Font-Size="Medium" ForeColor="Black"></telerik:RadLabel>

                        <telerik:RadLabel RenderMode="Mobile" ID="lblAffsClassB2" runat="server" style="text-align:left" 
                            Font-Bold="false" Font-Size="Medium" ForeColor="Black"></telerik:RadLabel>

                    </td>                    
                </tr>
                <tr><td role="separator"><br /></td></tr>
                <tr>
                    <td style="text-align:right">
                        <asp:LinkButton ID="LinkButton1" Text="Export to Excel" runat="server" OnClick="btnExport_Click" ForeColor="Black" 
                            Font-Size="Medium" style="text-align:right" />
                    </td>
                </tr>
            </table>


            <telerik:RadGrid ID="gridAffs" runat="server" DataSourceID="ListOfAffDS" AllowFilteringByColumn="True" AllowPaging="True"
                EnableGroupsExpandAll="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
                AllowSorting="True" GroupPanelPosition="Top" ShowGroupPanel="True"
                MasterTableView-EditFormSettings-FormTableButtonRowStyle-Wrap="false"
                Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True" RenderMode="Mobile">

                <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="DoctorsList">
                    <Excel Format="Xlsx" />
                </ExportSettings>

                <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                    <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                    <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                </ClientSettings>

                <MasterTableView DataSourceID="ListOfAffDS" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                    AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true" EnableHeaderContextMenu="True" EnableHeaderContextAggregatesMenu="true" 
                    EnableHeaderContextFilterMenu="true">

                    <GroupHeaderItemStyle CssClass="hidden-lg hidden-md hidden-sm hidden-xs" />
                    <FilterItemStyle CssClass="hidden-lg hidden-md hidden-sm hidden-xs" />

                    <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="false" ShowAddNewRecordButton="false" />
                    <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevNumericAndAdvanced" 
                        CssClass="visible-lg visible-md visible-sm visible-xs" />

                    <Columns>
                        <telerik:GridBoundColumn DataField="AffiliationID" Visible="true" DataType="System.Int32"
                            FilterControlAltText="Filter AffiliationID column" HeaderText="ID" SortExpression="AffiliationID" UniqueName="AffiliationID"
                            ItemStyle-CssClass="visible-lg hidden-md hidden-sm hidden-xs colWidth"
                            HeaderStyle-CssClass="visible-lg hidden-md hidden-sm hidden-xs colWidth"
                            FooterStyle-CssClass="visible-lg hidden-md hidden-sm hidden-xs colWidth">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="AffiliationName" Visible="true" DataType="System.String" FilterControlAltText="Filter AffiliationName column"
                            HeaderText="Name" SortExpression="AffiliationName" UniqueName="AffiliationName"
                            ItemStyle-CssClass="visible-lg visible-md visible-sm visible-xs colWidth" 
                            HeaderStyle-CssClass="visible-lg visible-md visible-sm visible-xs colWidth"
                            FooterStyle-CssClass="visible-lg visible-md visible-sm visible-xs colWidth">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="EntityAddress" Visible="true" DataType="System.String" FilterControlAltText="Filter EntityAddress column"
                            HeaderText="Address" SortExpression="EntityAddress" UniqueName="EntityAddress"
                            ItemStyle-CssClass="visible-lg hidden-md hidden-sm hidden-xs colWidth" 
                            HeaderStyle-CssClass="visible-lg hidden-md hidden-sm hidden-xs colWidth"
                            FooterStyle-CssClass="visible-lg hidden-md hidden-sm hidden-xs colWidth">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="SpecialityCode" Visible="true" DataType="System.String" FilterControlAltText="Filter SpecialityCode column"
                            HeaderText="Specialty" SortExpression="SpecialityCode" UniqueName="SpecialityCode"
                            ItemStyle-CssClass="visible-lg visible-md visible-sm visible-xs colWidth" 
                            HeaderStyle-CssClass="visible-lg visible-md visible-sm visible-xs colWidth"
                            FooterStyle-CssClass="visible-lg visible-md visible-sm visible-xs colWidth">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="PhysicianClass" Visible="true" DataType="System.String" FilterControlAltText="Filter PhysicianClass column"
                            HeaderText="Class" SortExpression="PhysicianClass" UniqueName="PhysicianClass"
                            ItemStyle-CssClass="visible-lg visible-md visible-sm visible-xs colWidth" 
                            HeaderStyle-CssClass="visible-lg visible-md visible-sm visible-xs colWidth"
                            FooterStyle-CssClass="visible-lg visible-md visible-sm visible-xs colWidth">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="AmounBrickName" Visible="true" DataType="System.String" FilterControlAltText="Filter AmounBrickName column"
                            HeaderText="Brick" SortExpression="AmounBrickName" UniqueName="AmounBrickName"
                            ItemStyle-CssClass="visible-lg visible-md visible-sm hidden-xs colWidth" 
                            HeaderStyle-CssClass="visible-lg visible-md visible-sm hidden-xs colWidth" 
                            FooterStyle-CssClass="visible-lg visible-md visible-sm hidden-xs colWidth">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="EmployeeName" DataType="System.String" FilterControlAltText="Filter EmployeeName column" HeaderText="Med. Rep"
                            SortExpression="EmployeeName" UniqueName="EmployeeName"
                            ItemStyle-CssClass="visible-lg visible-md hidden-sm hidden-xs colWidth" 
                            HeaderStyle-CssClass="visible-lg visible-md hidden-sm hidden-xs colWidth" 
                            FooterStyle-CssClass="visible-lg visible-md hidden-sm hidden-xs colWidth">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="AmounTerritoryName" DataType="System.String" FilterControlAltText="Filter AmounTerritoryName column"
                            HeaderText="Territory" SortExpression="AmounTerritoryName" UniqueName="AmounTerritoryName"
                            ItemStyle-CssClass="visible-lg visible-md visible-sm hidden-xs colWidth" 
                            HeaderStyle-CssClass="visible-lg visible-md visible-sm hidden-xs colWidth" 
                            FooterStyle-CssClass="visible-lg visible-md visible-sm hidden-xs colWidth">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="SupervisorName" DataType="System.String" FilterControlAltText="Filter SupervisorName column"
                            HeaderText="District Manager" SortExpression="SupervisorName" UniqueName="SupervisorName"
                            ItemStyle-CssClass="visible-lg hidden-md hidden-sm hidden-xs colWidth" 
                            HeaderStyle-CssClass="visible-lg hidden-md hidden-sm hidden-xs colWidth"
                            FooterStyle-CssClass="visible-lg hidden-md hidden-sm hidden-xs colWidth">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="IsTargeted2" Visible="true" DataType="System.String" FilterControlAltText="Filter IsTargeted column"
                            HeaderText="Mandatory?" SortExpression="IsTargeted" UniqueName="IsTargeted"
                            ItemStyle-CssClass="visible-lg hidden-md hidden-sm hidden-xs colWidth" 
                            HeaderStyle-CssClass="visible-lg hidden-md hidden-sm hidden-xs colWidth"
                            FooterStyle-CssClass="visible-lg hidden-md hidden-sm hidden-xs colWidth">
                        </telerik:GridBoundColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
    </div>
    

    

    <asp:SqlDataSource ID="ListOfAffDS" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
        SelectCommand="SELECT AffiliationID, AffiliationName, EntityAddress, SpecialityCode, PhysicianClass, AmounBrickName, IsTargeted2, EmployeeName, AmounTerritoryName, SupervisorName FROM View_Affiliations_Admin WHERE SpecialtyValue > 0 AND LastModifierID IS NOT NULL AND [PhysicianClass] IN ('A', 'B') AND ManagerID = @EmployeeIDFromSM">
        <SelectParameters>
            <asp:SessionParameter Name="EmployeeIDFromSM" SessionField="EmployeeIDFromSM" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <script src="../js/jquery.responsivetable.min.js"></script>
    
</asp:Content>
