<%@ Page Title="Visits and Plans" Language="C#" MasterPageFile="~/CommercialDirector/SiteMaster2.Master" AutoEventWireup="true" CodeBehind="Visits_Plans.aspx.cs" Inherits="AmounCRM4.CommercialDirector.Visits_Plans" %>

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
            margin-left:auto; margin-right:auto
        }
    </style>

    <title>Visits & Plans</title>

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

    <asp:Panel ID="p1" runat="server" Width="96%" CssClass="DivCenter">
        <div class="DivCenter">
            <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="100%" Height="800px" Skin="WebBlue" ExpandMode="FullExpandedItem">
                <Items>
<telerik:RadPanelItem Text="Visits & Plans" Expanded="true" Font-Size="Large" CssClass="panelItem" Width="100%">
                    <HeaderTemplate>
                        <asp:Label ID="lblAppsTotal" runat="server"></asp:Label>
                        <asp:Label ID="lblAppsClassA" runat="server"></asp:Label>
                        <asp:Label ID="lblAppsClassB" runat="server"></asp:Label>
                    </HeaderTemplate>
                    <ContentTemplate>
    <telerik:RadGrid ID="gridApps" runat="server" DataSourceID="ListOfAppointmentsDS" AllowFilteringByColumn="True" AllowPaging="True"
        EnableGroupsExpandAll="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
        AllowSorting="True" GroupPanelPosition="Top" ShowGroupPanel="True" Height="100%" Width="100%"
        Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True">

        <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="ListOfAppointments">
            <Excel Format="Xlsx" />
        </ExportSettings>

        <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
            <Scrolling AllowScroll="true" />
            <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
        </ClientSettings>
        <MasterTableView DataSourceID="ListOfAppointmentsDS" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
            AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
            <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
            <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
            <Columns>
                <telerik:GridBoundColumn DataField="AffiliationID" DataType="System.Int32" FilterControlAltText="Filter AffiliationID column" HeaderText="ID" SortExpression="AffiliationID" UniqueName="AffiliationID"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AffiliationName" FilterControlAltText="Filter AffiliationName column" HeaderText="Name" SortExpression="AffiliationName" UniqueName="AffiliationName"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SpecialityCode" FilterControlAltText="Filter SpecialityCode column" HeaderText="Specialty" SortExpression="SpecialityCode" UniqueName="SpecialityCode"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PhysicianClass" FilterControlAltText="Filter PhysicianClass column" HeaderText="Class" SortExpression="PhysicianClass" UniqueName="PhysicianClass"></telerik:GridBoundColumn>
                <telerik:GridDateTimeColumn DataField="EndDate" FilterControlAltText="Filter Date column" HeaderText="Date" SortExpression="EndDate" UniqueName="EndDate" DataType="System.DateTime" Visible="true" DataFormatString="{0:MM/dd/yyyy}" HtmlEncode="false"></telerik:GridDateTimeColumn>
                <telerik:GridBoundColumn DataField="Annotations2" FilterControlAltText="Filter Annotations column" HeaderText="Status" SortExpression="Annotations" UniqueName="Annotations"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="CycleDesc" FilterControlAltText="Filter CycleDesc column" HeaderText="Cycle" SortExpression="CycleDesc" UniqueName="CycleDesc"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AmounBrickName" FilterControlAltText="Filter AmounBrickName column" HeaderText="Brick" SortExpression="AmounBrickName" UniqueName="AmounBrickName"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="NewAreaName" FilterControlAltText="Filter NewAreaName column" HeaderText="Territory" SortExpression="NewAreaName" UniqueName="NewAreaName"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SupervisorName" FilterControlAltText="Filter SupervisorName column" HeaderText="District Manager" SortExpression="SupervisorName" UniqueName="SupervisorName"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ManagerName" FilterControlAltText="Filter ManagerName column" HeaderText="Sales Manager" SortExpression="ManagerName" UniqueName="ManagerName"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="IsTargeted2" FilterControlAltText="Filter IsTargeted column" HeaderText="Mandatory?" SortExpression="IsTargeted" UniqueName="IsTargeted"></telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>

    <asp:SqlDataSource ID="ListOfAppointmentsDS" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
        SelectCommand="SELECT [AppointmentID],[EndDate],[AffiliationID],[AffiliationName],[SpecialityCode],[PhysicianClass],[NewAreaName],[Annotations2], [Subject], [IsTargeted2], [CycleDesc], [AmounBrickName], [SupervisorName], ManagerName FROM [View_ListOfAppointments_Admin] WHERE [PhysicianClass] IN ('A', 'B')"></asp:SqlDataSource>



  </ContentTemplate>
                </telerik:RadPanelItem>
                </Items>
            </telerik:RadPanelBar>
        </div>
    </asp:Panel>

</asp:Content>
