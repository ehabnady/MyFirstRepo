<%@ Page Title="Sales Analysis" Language="C#" MasterPageFile="~/Site2.Master" AutoEventWireup="true" CodeBehind="SalesAnalysis.aspx.cs" 
    Inherits="AmounCRM4.DMs.SalesAnalysis" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    
    <div align="center">
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>
        <table width="96%" align="center">
            <tr>
                <td width="96%" align="center">
                    <div align="left">
                        <h2>Sales Analyzer</h2>
                        <%--<asp:LinkButton ID="btnExport" runat="server" OnClick="btnExport_Click" Visible="false" Text="Export Summary Pivot" />--%>
                        <br />
                    </div>
                    <telerik:RadAjaxPanel ID="ajaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1" Width="100%">
                        <telerik:RadPivotGrid ID="RadPivotGrid1" runat="server" RenderMode="Lightweight" Width="100%" Height="700px" DataSourceID="dsSalesFromBW"
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
                                <telerik:PivotGridReportFilterField Caption="Year" DataField="YearID" UniqueName="YearID">
                                </telerik:PivotGridReportFilterField>
                                <telerik:PivotGridReportFilterField Caption="Employee HR" DataField="EmployeeHRCode" UniqueName="EmployeeHRCode">
                                </telerik:PivotGridReportFilterField>
                                <telerik:PivotGridReportFilterField Caption="Brick ID" DataField="BrickID" UniqueName="BrickID">
                                </telerik:PivotGridReportFilterField>
                                <telerik:PivotGridReportFilterField Caption="Brick Name" DataField="AmounBrickName" UniqueName="AmounBrickName">
                                </telerik:PivotGridReportFilterField>
                                <telerik:PivotGridReportFilterField Caption="Brand" DataField="BrandName" UniqueName="BrandName">
                                </telerik:PivotGridReportFilterField>
                                <telerik:PivotGridReportFilterField Caption="Line" DataField="LineName" UniqueName="LineName">
                                </telerik:PivotGridReportFilterField>

                                <telerik:PivotGridRowField Caption="Employee Name" DataField="EmployeeFullName" UniqueName="EmployeeFullName">
                                </telerik:PivotGridRowField>

                                <telerik:PivotGridColumnField Caption="Quarter" DataField="QuarterID" UniqueName="QuarterID">
                                </telerik:PivotGridColumnField>
                                <telerik:PivotGridColumnField Caption="Month" DataField="MonthID" UniqueName="MonthID">
                                </telerik:PivotGridColumnField>

                                <telerik:PivotGridAggregateField Caption="Qty" DataField="SalesQty" UniqueName="SalesQty" DataFormatString="{0:###,##0}">
                                    <TotalFormat Axis="Rows" Level="0" SortOrder="Ascending" TotalFunction="NoCalculation" />
                                    <HeaderCellTemplate>Qty</HeaderCellTemplate>
                                    <ColumnGrandTotalHeaderCellTemplate>Total Sales Qty</ColumnGrandTotalHeaderCellTemplate>
                                </telerik:PivotGridAggregateField>

                                <telerik:PivotGridAggregateField Caption="Value" DataField="SalesValue" UniqueName="SalesValue" DataFormatString="{0:###,##0}">
                                    <TotalFormat Axis="Rows" Level="0" SortOrder="Ascending" TotalFunction="NoCalculation" />
                                    <HeaderCellTemplate>Value</HeaderCellTemplate>
                                    <ColumnGrandTotalHeaderCellTemplate>Total Sales Value</ColumnGrandTotalHeaderCellTemplate>
                                </telerik:PivotGridAggregateField>
                            </Fields>
                        </telerik:RadPivotGrid>
                    </telerik:RadAjaxPanel>
                </td>
                </tr>
        </table>
    </div>
    
    <asp:SqlDataSource runat="server" ID="dsSalesFromBW" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
        SelectCommand="SELECT YearID, QuarterID, MonthID, BrickID, AmounBrickName, BrandID, BrandName, LineID, LineName, EmployeeID, EmployeeHRCode, EmployeeFullName, SUM(Qty) AS SalesQty, SUM(Val) AS SalesValue, DirectManagerID FROM View_Sales WHERE (DirectManagerID = @Param1) GROUP BY YearID, QuarterID, MonthID, BrickID, AmounBrickName, BrandID, BrandName, LineID, LineName, EmployeeID, EmployeeHRCode, EmployeeFullName, DirectManagerID">
        <SelectParameters>
            <asp:SessionParameter SessionField="EmployeeIDFromDM" Name="Param1" Type="Int32"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
