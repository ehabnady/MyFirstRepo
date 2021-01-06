<%@ Page Title="Sales Analysis" Language="C#" MasterPageFile="~/Site2.Master" AutoEventWireup="true" CodeBehind="SalesAnalysis.aspx.cs" 
    Inherits="AmounCRM4.Reps.SalesAnalysis" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">

    <%--<div style="visibility:hidden">
    <telerik:RadGrid ID="grdSales" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True" ShowGroupPanel="True" Skin="WebBlue" DataSourceID="dsSalesFromBW"
        Width="95%" EnableHeaderContextFilterMenu="true" EnableHeaderContextMenu="true" EnableHeaderContextAggregatesMenu="true" ShowFooter="true">

        <PagerStyle Mode="NextPrevNumericAndAdvanced" HorizontalAlign="Center" Position="Bottom" PageSizes="50,100,200" />
        <ClientSettings AllowDragToGroup="True" AllowColumnsReorder="True">
            <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
            <Resizing AllowColumnResize="true" AllowResizeToFit="true" AllowRowResize="true" EnableRealTimeResize="true" EnableNextColumnResize="true" ResizeGridOnColumnResize="true" />
        </ClientSettings>
        <ExportSettings Excel-Format="Xlsx" ExportOnlyData="true" FileName="Sales" IgnorePaging="true"></ExportSettings>
        <MasterTableView DataSourceID="dsSalesFromBW" AutoGenerateColumns="False" EnableHeaderContextMenu="true" EnableHeaderContextAggregatesMenu="true" ShowFooter="true" ShowHeader="true" ShowGroupFooter="true" CommandItemDisplay="Top">
            <CommandItemSettings ExportToExcelText="Excel" RefreshText="Refresh" ShowExportToExcelButton="true" ShowRefreshButton="true" />
            <Columns>
                <telerik:GridBoundColumn DataField="YearID" HeaderText="Year" SortExpression="YearID" UniqueName="YearID" DataType="System.Int32" FilterControlAltText="Filter YearID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="QuarterID" HeaderText="Quarter" SortExpression="QuarterID" UniqueName="QuarterID" DataType="System.Int32" FilterControlAltText="Filter QuarterID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="MonthID" HeaderText="Month" SortExpression="MonthID" UniqueName="MonthID" DataType="System.Int32" FilterControlAltText="Filter MonthID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="BrickID" HeaderText="Brick ID" SortExpression="BrickID" UniqueName="BrickID" DataType="System.Int32" FilterControlAltText="Filter BrickID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AmounBrickName" HeaderText="Brick Name" SortExpression="AmounBrickName" UniqueName="AmounBrickName" FilterControlAltText="Filter AmounBrickName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="BrandName" HeaderText="Brand" SortExpression="BrandName" UniqueName="BrandName" FilterControlAltText="Filter BrandName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="LineName" HeaderText="Line" SortExpression="LineName" UniqueName="LineName" FilterControlAltText="Filter LineName column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SalesQty" ReadOnly="True" HeaderText="Qty" SortExpression="SalesQty" UniqueName="SalesQty" DataType="System.Double" DataFormatString="{0:N}" FilterControlAltText="Filter SalesQty column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SalesValue" ReadOnly="True" HeaderText="Value" SortExpression="SalesValue" UniqueName="SalesValue" DataType="System.Double" DataFormatString="{0:N}" FilterControlAltText="Filter SalesValue column"></telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    </div>--%>

    <div>
        <br />
    </div>
    <div align="left">
                        <%--<asp:LinkButton ID="btnExport" runat="server" OnClick="btnExport_Click" Visible="true" Text="Export Summary Pivot" />--%>
                        <h2>In-Market Sales Analyzer</h2>
                        <br />
                    </div>
    <div>
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
                                <telerik:PivotGridReportFilterField Caption="Brick ID" DataField="BrickID" UniqueName="BrickID">
                                </telerik:PivotGridReportFilterField>
                                <telerik:PivotGridReportFilterField Caption="Brick Name" DataField="AmounBrickName" UniqueName="AmounBrickName">
                                </telerik:PivotGridReportFilterField>

                                <telerik:PivotGridRowField Caption="Brand" DataField="BrandName" UniqueName="BrandName">
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
    </div>
    <asp:SqlDataSource runat="server" ID="dsSalesFromBW" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
        SelectCommand="SELECT YearID, QuarterID, MonthID, BrickID, AmounBrickName, BrandID, BrandName, EmployeeID, EmployeeHRCode, EmployeeFullName, SUM(Qty) AS SalesQty, SUM(Val) AS SalesValue 
        FROM View_Sales WHERE (EmployeeID = @Param1) GROUP BY YearID, QuarterID, MonthID, BrickID, AmounBrickName, BrandID, BrandName, LineID, LineName, EmployeeID, EmployeeHRCode, EmployeeFullName">
        <SelectParameters>
            <asp:SessionParameter SessionField="EmployeeID" Name="Param1" Type="Int32"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
