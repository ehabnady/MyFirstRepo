<%@ Page Title="Pivot Analyzer" Language="C#" MasterPageFile="~/CommercialDirector/SiteMaster2.Master" AutoEventWireup="true" CodeBehind="PivotAnalyzer.aspx.cs" Inherits="AmounCRM4.CommercialDirector.PivotAnalyzer" %>

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

    <title>Pivot Analyzer</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <div class="table-responsive" style="margin: 0 auto">
        <div class="row" style="margin: 0 auto">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="align-items: center; text-align: center; grid-row-align: center; margin: 0 auto">
                <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>
                <table style="width: 96%; text-align: center;">
                    <tr>
                        <td style="width: 96%; text-align: center;">
                            <div style="text-align: left;">
                                <h2>Visits Analyzer</h2>
                                <%--<asp:LinkButton ID="btnExport" runat="server" OnClick="btnExport_Click" Visible="false" Text="Export Summary Pivot" />--%>
                                <br />
                            </div>
                            <telerik:RadAjaxPanel ID="ajaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1" Width="100%">
                                <telerik:RadPivotGrid ID="RadPivotGrid1" runat="server" RenderMode="Auto" Width="100%" Height="700px" DataSourceID="ObjectDataSource2"
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
                                        <telerik:PivotGridReportFilterField Caption="Area" DataField="Area" UniqueName="Area">
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
                                            <TotalFormat Axis="Rows" Level="0" SortOrder="Ascending" TotalFunction="NoCalculation" />
                                            <HeaderCellTemplate>Actual Visits</HeaderCellTemplate>
                                            <ColumnGrandTotalHeaderCellTemplate>Total Actual Visits</ColumnGrandTotalHeaderCellTemplate>
                                        </telerik:PivotGridAggregateField>

                                        <telerik:PivotGridAggregateField Caption="% Acheivment" DataField="Acheivment" UniqueName="Acheivment"
                                            CalculationDataFields="ActualVisits, PlannedVisits" CalculationExpression="iif({1}=0,0,(({0}/{1})))" DataFormatString="{0:0%}">
                                            <TotalFormat Axis="Rows" Level="0" SortOrder="Ascending" TotalFunction="NoCalculation" />
                                        </telerik:PivotGridAggregateField>
                                    </Fields>
                                </telerik:RadPivotGrid>
                            </telerik:RadAjaxPanel>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByComDir"
        TypeName="AmounCRM4.App_Data.ExecSummary2TableAdapters.View3_FullViewTableAdapter" OnSelected="ObjectDataSource2_Selected">
        <SelectParameters>
            <asp:SessionParameter Name="CycleIDFromComDir" SessionField="CycleIDFromComDir" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
