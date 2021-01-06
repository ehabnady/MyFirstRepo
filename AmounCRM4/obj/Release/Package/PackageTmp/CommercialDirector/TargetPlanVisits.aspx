<%@ Page Title="Target / Visits / Plans" Language="C#" MasterPageFile="~/CommercialDirector/SiteMaster2.Master" AutoEventWireup="true" CodeBehind="TargetPlanVisits.aspx.cs" Inherits="AmounCRM4.CommercialDirector.TargetPlanVisits" %>

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

    <title>Target / Visits / Plans</title>
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
            <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="100%" Height="600px" Skin="WebBlue" ExpandMode="FullExpandedItem">
                <Items>
                    <telerik:RadPanelItem Text="Target / Visits / Plans" Expanded="true" Font-Size="Large" CssClass="panelItem" Width="98%">
                    
                    <ContentTemplate>
    <telerik:RadGrid ID="gvTPV" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True" ShowGroupPanel="True" Skin="WebBlue" DataSourceID="dsTPV"
        GridLines="Both" PageSize="50" ShowFooter="True" Height="600" Width="96%">
        <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
            <Scrolling AllowScroll="true" />
            <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
        </ClientSettings>
        <MasterTableView DataSourceID="dsTPV" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
            AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
            <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
            <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
            <Columns>
                <telerik:GridBoundColumn DataField="Line" HeaderText="Line" SortExpression="Line" UniqueName="Line" DataType="System.String" FilterControlAltText="Filter Line column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Cycle" HeaderText="Cycle" SortExpression="Cycle" UniqueName="Cycle" FilterControlAltText="Filter Cycle column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Sales Manager" HeaderText="Sales Manager" SortExpression="Sales Manager" UniqueName="Sales_Manager" FilterControlAltText="Filter Sales Manager column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="DM Name" HeaderText="DM Name" SortExpression="DM Name" UniqueName="DM_Name" FilterControlAltText="Filter DM Name column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Rep Name" HeaderText="Rep Name" SortExpression="Rep Name" UniqueName="Rep_Name" FilterControlAltText="Filter Rep Name column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Supervision Area" HeaderText="Supervision Area" SortExpression="Supervision Area" UniqueName="Supervision_Area" FilterControlAltText="Filter Supervision Area column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Territory Name" HeaderText="Territory Name" SortExpression="Territory Name" UniqueName="Territory_Name" FilterControlAltText="Filter Territory Name column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Brick ID" HeaderText="Brick ID" SortExpression="Brick ID" UniqueName="Brick_ID" DataType="System.Int32" FilterControlAltText="Filter Brick ID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Brick Name" HeaderText="Brick Name" SortExpression="Brick Name" UniqueName="Brick_Name" FilterControlAltText="Filter Brick Name column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Doctor ID" HeaderText="Doctor ID" SortExpression="Doctor ID" UniqueName="Doctor_ID" DataType="System.Int32" FilterControlAltText="Filter Doctor ID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Doctor Name" HeaderText="Doctor Name" SortExpression="Doctor Name" UniqueName="Doctor_Name" FilterControlAltText="Filter Doctor Name column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Class" HeaderText="Class" SortExpression="Class" UniqueName="Class" FilterControlAltText="Filter Class column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Specialty" HeaderText="Specialty" SortExpression="Specialty" UniqueName="Specialty" FilterControlAltText="Filter Specialty column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Mandatory" HeaderText="Mandatory" SortExpression="Mandatory" UniqueName="Mandatory" FilterControlAltText="Filter Mandatory column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Appointment ID" HeaderText="Appointment ID" SortExpression="Appointment ID" UniqueName="Appointment_ID" DataType="System.Int32" FilterControlAltText="Filter Appointment ID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Date" HeaderText="Date" SortExpression="Date" UniqueName="Date" DataType="System.DateTime" FilterControlAltText="Filter Date column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Status" HeaderText="Status" SortExpression="Status" UniqueName="Status" FilterControlAltText="Filter Status column"></telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource runat="server" ID="dsTPV" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
        SelectCommand="GetTargetedListWithAppointments_ComDir" SelectCommandType="StoredProcedure" OnSelected="dsTPV_Selected">
        <SelectParameters>
            <asp:SessionParameter SessionField="CycleIDFromComDir" Name="CycleID"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>


  </ContentTemplate>
                </telerik:RadPanelItem>
                </Items>
            </telerik:RadPanelBar>
        </div>
    </asp:Panel>

</asp:Content>
