<%@ Page Title="Calls Analysis" Language="C#" MasterPageFile="~/Site2.Master" AutoEventWireup="true" CodeBehind="Statistics.aspx.cs" Inherits="AmounCRM4.Reps.Statistics" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <title>Calls Analysis</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true"></telerik:RadWindowManager>
    <p></p>
    <br />

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
                        <telerik:RadPivotGrid ID="RadPivotGrid1" runat="server" RenderMode="Lightweight" Width="100%" Height="700px" DataSourceID="ObjectDataSource21"
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
                                <telerik:PivotGridReportFilterField Caption="Brick" DataField="AmounBrickName" SortOrder="Ascending" UniqueName="AmounBrickName">
                                </telerik:PivotGridReportFilterField>
                                <telerik:PivotGridReportFilterField Caption="Priority" DataField="BrandRankInCall" SortOrder="Ascending" UniqueName="BrandRankInCall">
                                </telerik:PivotGridReportFilterField>

                                <telerik:PivotGridColumnField Caption="Class" DataField="PhysicianClass" SortOrder="Ascending" UniqueName="PhysicianClass">
                                </telerik:PivotGridColumnField>

                                <telerik:PivotGridRowField Caption="Specialty" DataField="SpecialityCode" UniqueName="SpecialityCode">
                                </telerik:PivotGridRowField>
                                <telerik:PivotGridRowField Caption="Brand" DataField="BrandName" SortOrder="Ascending" UniqueName="BrandName">
                                </telerik:PivotGridRowField>

                                <telerik:PivotGridAggregateField Caption="Target Calls" DataField="TargetCalls" UniqueName="TargetCalls" DataFormatString="{0:###,##0}">
                                    <TotalFormat Axis="Rows" Level="0" SortOrder="Ascending" TotalFunction="NoCalculation" />
                                    <HeaderCellTemplate>Target Calls</HeaderCellTemplate>
                                    <ColumnGrandTotalHeaderCellTemplate>Total Target Calls</ColumnGrandTotalHeaderCellTemplate>
                                </telerik:PivotGridAggregateField>

                                <telerik:PivotGridAggregateField Caption="Actual Calls" DataField="CallsCount" UniqueName="CallsCount" DataFormatString="{0:###,##0}">                                    
                                    <TotalFormat Axis="Rows" Level="0" SortOrder="Ascending" TotalFunction="NoCalculation" GroupName="TotalCallsCount" />
                                    <HeaderCellTemplate>Actual Calls</HeaderCellTemplate>
                                    <ColumnGrandTotalHeaderCellTemplate>Total Actual Calls</ColumnGrandTotalHeaderCellTemplate>
                                </telerik:PivotGridAggregateField>

                                <telerik:PivotGridAggregateField Caption="% Calls Ratio" DataField="CallsRatio" UniqueName="CallsRatio"
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
    <asp:ObjectDataSource ID="ObjectDataSource21" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData_StatisticsWebView"
        TypeName="AmounCRM4.App_Data.ExecSummary2TableAdapters.View_StatisticesWebViewTableAdapter" OnSelected="ObjectDataSource21_Selected">
        <SelectParameters>
            <asp:SessionParameter Name="EmployeeID" SessionField="EmployeeID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
