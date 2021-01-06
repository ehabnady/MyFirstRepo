<%@ Page Title="Pivot Analyzer" Language="C#" MasterPageFile="~/Site2.Master" AutoEventWireup="true" CodeBehind="PivotAnalyzer.aspx.cs" Inherits="AmounCRM4.Reps.PivotAnalyzer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <title>Pivot Analyzer</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <div align="center">
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>
        <table width="96%" align="center">
            <tr>
                <td width="96%" align="center">
                    <div align="left">
                        <h2>Visits Analyzer</h2>
                        <br />
                    </div>
                    <telerik:RadAjaxPanel ID="ajaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1" Width="100%">
                        <telerik:RadPivotGrid ID="RadPivotGrid1" runat="server" RenderMode="Lightweight" Width="100%" Height="700px" DataSourceID="ObjectDataSource22"
                            AllowSorting="True" AllowPaging="True" Skin="WebBlue" EnableConfigurationPanel="True" EnableTheming="True" EnableToolTips="True" 
                            EnableZoneContextMenu="True" AggregatesLevel="1" ColumnHeaderTableLayout="Fixed" Font-Size="Medium">
                            <DataCellStyle Width="50px" />
                            <ConfigurationPanelSettings LayoutType="TwoByTwo" EnableDragDrop="true" Position="FieldsWindow" EnableFieldsContextMenu="true" />
                            <RowHeaderCellStyle Width="20%" />
                            <ClientSettings Scrolling-AllowVerticalScroll="true" EnableFieldsDragDrop="true">
                                <Scrolling AllowVerticalScroll="True" />
                                <Resizing AllowColumnResize="True" />
                            </ClientSettings>
                            <PagerStyle ChangePageSizeButtonToolTip="Change Page Size" PageSizeControlType="RadComboBox" />
                            <OlapSettings>
                                <XmlaConnectionSettings></XmlaConnectionSettings>
                            </OlapSettings>
                            <Fields>
                                <telerik:PivotGridReportFilterField Caption="Quarter" DataField="QuarterID" UniqueName="QuarterID">
                                </telerik:PivotGridReportFilterField>
                                <telerik:PivotGridReportFilterField Caption="Cycle" DataField="CycleDesc" UniqueName="CycleDesc">
                                </telerik:PivotGridReportFilterField>
                                <telerik:PivotGridReportFilterField Caption="Mandatory?" DataField="IsTargeted2" UniqueName="IsTargeted2">
                                </telerik:PivotGridReportFilterField>

                                <telerik:PivotGridColumnField Caption="Class" DataField="PhysicianClass" SortOrder="Ascending" UniqueName="PhysicianClass">
                                </telerik:PivotGridColumnField>
                                <%--<telerik:PivotGridRowField DataField="BrandName" ShowGroupsWhenNoData="true" UniqueName="BrandName">
                                </telerik:PivotGridRowField>--%>
                                <telerik:PivotGridRowField Caption="Specialty" DataField="SpecialityCode" UniqueName="SpecialityCode">
                                </telerik:PivotGridRowField>

                                <telerik:PivotGridAggregateField Caption="Planned Visits" DataField="PlannedVisits" UniqueName="PlannedVisits">
                                    <%--<CellTemplate><center><asp:Label ID="lblPlannedVisits" runat="server" Text='<%# Container.DataItem%>'></asp:Label></center></CellTemplate>--%>
                                    <TotalFormat Axis="Rows" Level="0" SortOrder="Ascending" TotalFunction="NoCalculation" />
                                    <HeaderCellTemplate>Planned Visits</HeaderCellTemplate>
                                    <ColumnGrandTotalHeaderCellTemplate>Total Planned Visits</ColumnGrandTotalHeaderCellTemplate>
                                </telerik:PivotGridAggregateField>

                                <telerik:PivotGridAggregateField Caption="Actual Visits" DataField="ActualVisits" UniqueName="ActualVisits">
                                    <%--<CellTemplate><center><asp:Label ID="lblActualVisits" runat="server" Text='<%# Container.DataItem%>'></asp:Label></center></CellTemplate>--%>
                                    <TotalFormat Axis="Rows" Level="0" SortOrder="Ascending" TotalFunction="NoCalculation" GroupName="Total Actual Visits" />
                                    <HeaderCellTemplate>Actual Visits</HeaderCellTemplate>
                                    <ColumnGrandTotalHeaderCellTemplate>Total Actual Visits</ColumnGrandTotalHeaderCellTemplate>
                                </telerik:PivotGridAggregateField>

                                <telerik:PivotGridAggregateField Caption="% Achievment" DataField="Acheivment" UniqueName="Acheivment"
                                    CalculationDataFields="ActualVisits, PlannedVisits" CalculationExpression="iif({1}=0,0,(({0}/{1})))" DataFormatString="{0:0%}" CellStyle-CssClass="PivotAlign">
                                    <TotalFormat Axis="Rows" Level="0" SortOrder="Ascending" TotalFunction="NoCalculation" />
                                </telerik:PivotGridAggregateField>
                            </Fields>
                        </telerik:RadPivotGrid>
                    </telerik:RadAjaxPanel>
                </td>
                </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="ObjectDataSource22" runat="server" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
        SelectCommand="SELECT     
                        YearID, QuarterID, MonthID, CycleDesc, PhysicianClass, SpecialityCode, AmounTerritoryName AS 'Area', EmployeeName, LineID, IsTargeted2, 
                        COUNT(DISTINCT (CASE WHEN Annotations = 'Final Save' THEN AppointmentID ELSE NULL END)) AS 'ActualVisits', 
                        COUNT(DISTINCT AppointmentID) AS 'PlannedVisits', 
                        COUNT(DISTINCT (CASE WHEN Annotations = 'Final Save' THEN AffiliationID ELSE NULL END)) AS 'VisitedPhysicians', 
                        COUNT(DISTINCT AffiliationID) AS 'PlannedPhysicians'
                        FROM        View3_FullView_Web2
                        WHERE       (Deleted IS NULL OR Deleted = 0) AND (PhysicianClass IN ('A+', 'A')) AND (SpecialityCode IS NOT NULL) AND 
				                    (EmployeeID = @EmployeeID) AND (CycleID = @CycleID)
                        GROUP BY YearID, QuarterID, MonthID, CycleDesc, PhysicianClass, SpecialityCode, AmounTerritoryName, EmployeeName, LineID, IsTargeted2"
        >
        <SelectParameters>
            <asp:SessionParameter SessionField="EmployeeID" Name="EmployeeID"></asp:SessionParameter>
            <asp:SessionParameter SessionField="CycleID" Name="CycleID"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
