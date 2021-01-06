<%@ Page Title="Test" Language="C#" MasterPageFile="~/SalesManagers/SiteMaster2.Master" AutoEventWireup="true"
    CodeBehind="MyTest.aspx.cs" Inherits="AmounCRM4.SalesManagers.MyTest" %>

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

    <script type="text/javascript">
        function myfunction() {
            $(document).ready(function () {
                // Default settings
                $('.gridAffs').responsiveTable();
                // Custom settings
                $('.gridAffs').responsiveTable({
                    staticColumns: 5,
                    scrollRight: true,
                    scrollHintEnabled: true,
                    scrollHintDuration: 2000
                });
            });
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <%--    bs-example-navbar-collapse-1--%>



    <%--<h1>My Page</h1>
    <br />

    <div style="width: 100%; align-content: center">
        Works Well W/O Passing Parameters & W/O RLS - No SiginIn Needed
        <br />
        <iframe width="95%" height="90%" src="https://app.powerbi.com/view?r=eyJrIjoiMDg5ODE5NmQtNjcyNC00YmQ0LWI5NmItYWJjZDA4NTkxNzE5IiwidCI6IjhkYmNhYjUxLTZkNmEtNDhhOC1hN2JjLTk1YzZiZWIxZGE2NCIsImMiOjh9"
            frameborder="0" allowfullscreen="true"></iframe>
    </div>

    <br />

    <div style="visibility:hidden">
        <a href="https://app.powerbi.com/view?r=eyJrIjoiMDg5ODE5NmQtNjcyNC00YmQ0LWI5NmItYWJjZDA4NTkxNzE5IiwidCI6IjhkYmNhYjUxLTZkNmEtNDhhOC1hN2JjLTk1YzZiZWIxZGE2NCIsImMiOjh9?filter=rep_fn_Union_View_ActualVsTarget/Regions eq 'C'"
            target="_blank">Dashboard Failed-1</a>
    
        <br />
        <a href="https://app.powerbi.com/view?r=eyJrIjoiMDg5ODE5NmQtNjcyNC00YmQ0LWI5NmItYWJjZDA4NTkxNzE5IiwidCI6IjhkYmNhYjUxLTZkNmEtNDhhOC1hN2JjLTk1YzZiZWIxZGE2NCIsImMiOjh9?filter=rep_fn_Union_View_ActualVsTarget/Regions eq 'C'"
            target="_blank">
            Dashboard Failed-2</a>
    </div>

    <br />
    <a href="https://app.powerbi.com/groups/me/reports/f831704e-9a92-47ff-a983-73b141993a0b/ReportSection?filter=rep_fn_Union_View_ActualVsTarget%252FRegions%20eq%20'C'"
        target="_blank">Dashboard1 (Amoun-ECMS2) Work Without RLS & Needs Power BI SignIn</a>
    
    <br />
    <a href="https://app.powerbi.com/groups/me/reports/84be2212-ae75-4f3e-be6d-16a6f978f755/ReportSection?filter=rep_fn_Union_View_ActualVsTarget%252FRegions%20eq%20'C'"
        target="_blank">Dahsboard2 - (Amoun-ECMS) - No Data Displayed - Because of RLS & Needs PowerBI SignIn</a>
    
    <br />
    <iframe width="100%" height="700" src="https://app.powerbi.com/groups/me/reports/84be2212-ae75-4f3e-be6d-16a6f978f755/ReportSection?filter=rep_fn_Union_View_ActualVsTarget%252FRegions%20eq%20'C'"
        frameborder="0" allowfullscreen="true"></iframe>
    
    <br />
    <iframe width="100%" height="700" src="https://app.powerbi.com/groups/me/reports/84be2212-ae75-4f3e-be6d-16a6f978f755/ReportSection">Dashboard5</iframe>

    <br />
    <div style="width: 100%; align-content: center">
        <iframe width="933" height="700"
            src="https://app.powerbi.com/view?r=eyJrIjoiMDg5ODE5NmQtNjcyNC00YmQ0LWI5NmItYWJjZDA4NTkxNzE5IiwidCI6IjhkYmNhYjUxLTZkNmEtNDhhOC1hN2JjLTk1YzZiZWIxZGE2NCIsImMiOjh9?filter=rep_fn_Union_View_ActualVsTarget/Regions eq 'C'"
            frameborder="0" allowfullscreen="true"></iframe>
        <br />
    </div>--%>




    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="p1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gridAffs" LoadingPanelID="l1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="l1" runat="server" />

    <script src="scripts.js" type="text/javascript"></script>

    <asp:Panel ID="p1" runat="server">
    <telerik:RadGrid ID="gridAffs" runat="server" DataSourceID="ListOfAffDS" AllowFilteringByColumn="True" AllowPaging="True"
        EnableGroupsExpandAll="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
        AllowSorting="True" GroupPanelPosition="Top" ShowGroupPanel="True" Height="600px" 
        MasterTableView-EditFormSettings-FormTableButtonRowStyle-Wrap="false"
        Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True" RenderMode="Mobile">

        <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="ListOfClinics_Physicians">
            <Excel Format="Xlsx" />
        </ExportSettings>

        <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
            <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
        </ClientSettings>

        <MasterTableView DataSourceID="ListOfAffDS" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
            AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
            <%--FilterItemStyle-CssClass="hidden-sm hidden-xs hidden-md"--%>
            <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
            <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
            <Columns>
                <telerik:GridBoundColumn DataField="AffiliationID" Visible="true" DataType="System.Int32" FilterControlAltText="Filter AffiliationID column" 
                    HeaderText="ID" SortExpression="AffiliationID" UniqueName="AffiliationID"
                    ItemStyle-CssClass="hidden-md hidden-sm hidden-xs" HeaderStyle-CssClass="hidden-md hidden-sm hidden-xs" 
                    FooterStyle-CssClass="hidden-md hidden-sm hidden-xs"></telerik:GridBoundColumn>

                <telerik:GridBoundColumn DataField="AffiliationName" Visible="true" DataType="System.String" FilterControlAltText="Filter AffiliationName column" 
                    HeaderText="Name" SortExpression="AffiliationName" UniqueName="AffiliationName"></telerik:GridBoundColumn>

                <telerik:GridBoundColumn DataField="EntityAddress" Visible="true" DataType="System.String" FilterControlAltText="Filter EntityAddress column" 
                    HeaderText="Address" SortExpression="EntityAddress" UniqueName="EntityAddress" 
                    ItemStyle-CssClass="hidden-md hidden-sm hidden-xs" HeaderStyle-CssClass="hidden-md hidden-sm hidden-xs"
                    FooterStyle-CssClass="hidden-md hidden-sm hidden-xs"></telerik:GridBoundColumn>
                
                <telerik:GridBoundColumn DataField="SpecialityCode" Visible="true" DataType="System.String" FilterControlAltText="Filter SpecialityCode column" 
                    HeaderText="Specialty" SortExpression="SpecialityCode" UniqueName="SpecialityCode"></telerik:GridBoundColumn>
                
                <telerik:GridBoundColumn DataField="PhysicianClass" Visible="true" DataType="System.String" FilterControlAltText="Filter PhysicianClass column" 
                    HeaderText="Class" SortExpression="PhysicianClass" UniqueName="PhysicianClass"></telerik:GridBoundColumn>
                
                <telerik:GridBoundColumn DataField="AmounBrickName" Visible="true" DataType="System.String" FilterControlAltText="Filter AmounBrickName column" 
                    HeaderText="Brick" SortExpression="AmounBrickName" UniqueName="AmounBrickName"
                    ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" FooterStyle-CssClass="hidden-xs"></telerik:GridBoundColumn>
                
                <telerik:GridBoundColumn DataField="EmployeeName" DataType="System.String" FilterControlAltText="Filter EmployeeName column" HeaderText="Med. Rep" 
                    SortExpression="EmployeeName" UniqueName="EmployeeName"
                    ItemStyle-CssClass="hidden-sm hidden-xs" HeaderStyle-CssClass="hidden-sm hidden-xs" FooterStyle-CssClass="hidden-sm hidden-xs"></telerik:GridBoundColumn>
                
                <telerik:GridBoundColumn DataField="AmounTerritoryName" DataType="System.String" FilterControlAltText="Filter AmounTerritoryName column" 
                    HeaderText="Territory" SortExpression="AmounTerritoryName" UniqueName="AmounTerritoryName"
                    ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" FooterStyle-CssClass="hidden-xs"></telerik:GridBoundColumn>
                
                <telerik:GridBoundColumn DataField="SupervisorName" DataType="System.String" FilterControlAltText="Filter SupervisorName column" 
                    HeaderText="District Manager" SortExpression="SupervisorName" UniqueName="SupervisorName"
                    ItemStyle-CssClass="hidden-md hidden-sm hidden-xs" HeaderStyle-CssClass="hidden-md hidden-sm hidden-xs"
                    FooterStyle-CssClass="hidden-md hidden-sm hidden-xs"></telerik:GridBoundColumn>
                
                <telerik:GridBoundColumn DataField="IsTargeted2" Visible="true" DataType="System.String" FilterControlAltText="Filter IsTargeted column" 
                    HeaderText="Mandatory?" SortExpression="IsTargeted" UniqueName="IsTargeted"
                    ItemStyle-CssClass="hidden-md hidden-sm hidden-xs" HeaderStyle-CssClass="hidden-md hidden-sm hidden-xs"
                    FooterStyle-CssClass="hidden-md hidden-sm hidden-xs"></telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    </asp:Panel>

    <asp:SqlDataSource ID="ListOfAffDS" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
        SelectCommand="SELECT AffiliationID, AffiliationName, EntityAddress, SpecialityCode, PhysicianClass, AmounBrickName, IsTargeted2, EmployeeName, AmounTerritoryName, SupervisorName FROM View_Affiliations_Admin WHERE SpecialtyValue > 0 AND LastModifierID IS NOT NULL AND [PhysicianClass] IN ('A', 'B') AND ManagerID = 857">
        <%--<SelectParameters>
            <asp:SessionParameter Name="EmployeeIDFromSM" SessionField="EmployeeIDFromSM" Type="Int32" />
        </SelectParameters>--%>
    </asp:SqlDataSource>

    <script src="scripts/jquery.responsivetable.min.js"></script> 

</asp:Content>
