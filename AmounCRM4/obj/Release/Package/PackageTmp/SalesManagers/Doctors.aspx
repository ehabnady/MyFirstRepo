<%@ Page Title="Doctors List" Language="C#" MasterPageFile="~/SalesManagers/SiteMaster2.Master" AutoEventWireup="true" CodeBehind="Doctors.aspx.cs" Inherits="AmounCRM4.SalesManagers.Doctors" %>

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

    <title>Doctors List</title>
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
                                        <telerik:GridBoundColumn DataField="IsTargeted2" Visible="true" DataType="System.String" FilterControlAltText="Filter IsTargeted column" HeaderText="Mandatory?" SortExpression="IsTargeted" UniqueName="IsTargeted"></telerik:GridBoundColumn>
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

                </Items>
            </telerik:RadPanelBar>
        </div>
    </asp:Panel>
</asp:Content>
