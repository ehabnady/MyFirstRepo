<%@ Page Title="Calls Analysis" Language="C#" MasterPageFile="~/SalesManagers/SiteMaster2.Master" AutoEventWireup="true" CodeBehind="CallsAnalysis.aspx.cs" Inherits="AmounCRM4.SalesManagers.CallsAnalysis" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <div align="center">
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>
        <table width="96%" align="center">
            <tr>
                <td width="96%" align="center">
                    <div align="left">
                        <%--<asp:LinkButton ID="btnExport" runat="server" OnClick="btnExport_Click" Visible="true" Text="Export Summary Pivot" />--%>
                        <h2>Calls Analyzer</h2>
                        <br />
                    </div>
                    <telerik:RadAjaxPanel ID="ajaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1" Width="100%">
                        <telerik:RadPivotGrid ID="RadPivotGrid1" runat="server" RenderMode="Lightweight" Width="100%" Height="700px" DataSourceID="ObjectDataSource2"
                            AllowSorting="True" AllowPaging="True" Skin="WebBlue" EnableConfigurationPanel="True" EnableTheming="True" EnableToolTips="True"
                            EnableZoneContextMenu="True" AggregatesLevel="1" ColumnHeaderTableLayout="Fixed" Font-Size="Medium">
                            <DataCellStyle Width="50px" />
                            <ConfigurationPanelSettings LayoutType="TwoByTwo" EnableDragDrop="true" Position="FieldsWindow" EnableFieldsContextMenu="true" />
                            <RowHeaderCellStyle Width="20%" />
                            <ClientSettings Scrolling-AllowVerticalScroll="true" EnableFieldsDragDrop="true">
                                <Scrolling AllowVerticalScroll="True" />
                                <Resizing AllowColumnResize="True" />
                            </ClientSettings>
                            <PagerStyle ChangePageSizeButtonToolTip="Change Page Size" PageSizeControlType="RadComboBox" AlwaysVisible="true" Mode="NextPrevNumericAndAdvanced" />
                            <OlapSettings>
                                <XmlaConnectionSettings></XmlaConnectionSettings>
                            </OlapSettings>
                            <Fields>
                                <telerik:PivotGridReportFilterField Caption="Line" DataField="LineName" UniqueName="LineName">
                                </telerik:PivotGridReportFilterField>
                                <telerik:PivotGridReportFilterField Caption="Region" DataField="ManagementAreaName" UniqueName="ManagementAreaName">
                                </telerik:PivotGridReportFilterField>
                                <telerik:PivotGridReportFilterField Caption="District" DataField="SupervisionAreaName" UniqueName="SupervisionAreaName">
                                </telerik:PivotGridReportFilterField>
                                <telerik:PivotGridReportFilterField Caption="Territory" DataField="AmounTerritoryName" UniqueName="AmounTerritoryName">
                                </telerik:PivotGridReportFilterField>
                                <telerik:PivotGridReportFilterField Caption="Priority" DataField="BrandRankInCall" SortOrder="Ascending" UniqueName="BrandRankInCall">
                                </telerik:PivotGridReportFilterField>

                                <telerik:PivotGridColumnField Caption="Class" DataField="PhysicianClass" SortOrder="Ascending" UniqueName="PhysicianClass">
                                </telerik:PivotGridColumnField>

                                <telerik:PivotGridRowField Caption="Specialty" DataField="SpecialityCode" UniqueName="SpecialityCode">
                                </telerik:PivotGridRowField>
                                <telerik:PivotGridRowField Caption="Brand" DataField="BrandName" UniqueName="BrandName">
                                </telerik:PivotGridRowField>

                                <telerik:PivotGridAggregateField Caption="Calls" DataField="CallsCount" UniqueName="CallsCount">
                                    <%--<CellTemplate><center><asp:Label ID="lblPlannedVisits" runat="server" Text='<%# Container.DataItem%>'></asp:Label></center></CellTemplate>--%>
                                    <TotalFormat Axis="Rows" Level="0" SortOrder="Ascending" TotalFunction="NoCalculation" />
                                    <HeaderCellTemplate>Calls Count</HeaderCellTemplate>
                                    <ColumnGrandTotalHeaderCellTemplate>Calls Count</ColumnGrandTotalHeaderCellTemplate>
                                </telerik:PivotGridAggregateField>

                                <telerik:PivotGridAggregateField Caption="Target Calls" DataField="TargetCalls" UniqueName="TargetCalls">
                                    <%--<CellTemplate><center><asp:Label ID="lblActualVisits" runat="server" Text='<%# Container.DataItem%>'></asp:Label></center></CellTemplate>--%>
                                    <TotalFormat Axis="Rows" Level="0" SortOrder="Ascending" TotalFunction="NoCalculation" GroupName="Target Calls" />
                                    <HeaderCellTemplate>Target Calls</HeaderCellTemplate>
                                    <ColumnGrandTotalHeaderCellTemplate>Target Calls</ColumnGrandTotalHeaderCellTemplate>
                                </telerik:PivotGridAggregateField>

                                <telerik:PivotGridAggregateField Caption="% Achievment" DataField="Acheivment" UniqueName="Acheivment"
                                    CalculationDataFields="CallsCount, TargetCalls" CalculationExpression="iif({1}=0,0,(({0}/{1})))" DataFormatString="{0:0%}" CellStyle-CssClass="PivotAlign">
                                    <TotalFormat Axis="Rows" Level="0" SortOrder="Ascending" TotalFunction="NoCalculation" />
                                </telerik:PivotGridAggregateField>
                            </Fields>
                        </telerik:RadPivotGrid>
                    </telerik:RadAjaxPanel>
                </td>
            </tr>
        </table>
    </div>
    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByManagerID"
        TypeName="AmounCRM4.App_Data.ExecSummary2TableAdapters.ActualVsTargetCalls_ECMSTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="EmployeeIDFromSM" Type="Int32" SessionField="EmployeeIDFromSM" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
