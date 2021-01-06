<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="AmounCRM4.Reps.Test" MasterPageFile="~/Site1.Master" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <link type="text/css" rel="stylesheet" href="styles.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <div>
        <telerik:RadGrid ID="rad1" runat="server" DataSourceID="ObjectDataSource1" AllowFilteringByColumn="True" AllowPaging="True"
                            EnableGroupsExpandAll="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
                            AllowSorting="True" GroupPanelPosition="Top" ShowGroupPanel="True" Height="600px" Width="90%"
                            Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True">

                            <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="ListOfClinics_Physicians">
                                <Excel Format="Xlsx" />
                            </ExportSettings>

                            <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>
            <MasterTableView DataSourceID="ObjectDataSource1" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                <Columns>
                    <telerik:GridBoundColumn DataField="CycleDesc" HeaderText="Cycle" SortExpression="CycleDesc" UniqueName="CycleDesc" FilterControlAltText="Filter CycleDesc column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="LineID" HeaderText="Line" SortExpression="LineID" UniqueName="LineID" DataType="System.Int32" FilterControlAltText="Filter LineID column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ActualVisits" ReadOnly="True" HeaderText="Actual Visits" SortExpression="ActualVisits" UniqueName="ActualVisits" DataType="System.Int32" FilterControlAltText="Filter ActualVisits column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TargetVisits" ReadOnly="True" HeaderText="Target Visits" SortExpression="TargetVisits" UniqueName="TargetVisits" DataType="System.Int32" FilterControlAltText="Filter TargetVisits column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Frequency" ReadOnly="True" HeaderText="Frequency" SortExpression="Frequency" UniqueName="Frequency" DataType="System.Decimal" FilterControlAltText="Filter Frequency column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="VisitedDoctors" ReadOnly="True" HeaderText="Visited Doctors" SortExpression="VisitedDoctors" UniqueName="VisitedDoctors" DataType="System.Int32" FilterControlAltText="Filter VisitedDoctors column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TargetDoctors" ReadOnly="True" HeaderText="Target Doctors" SortExpression="TargetDoctors" UniqueName="TargetDoctors" DataType="System.Int32" FilterControlAltText="Filter TargetDoctors column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Coverage" ReadOnly="True" HeaderText="Coverage" SortExpression="Coverage" UniqueName="Coverage" DataType="System.Decimal" FilterControlAltText="Filter Coverage column"></telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
        <asp:ObjectDataSource runat="server" ID="ObjectDataSource1" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataCovFreq" TypeName="AmounCRM4.App_Data.ExecSummary2TableAdapters.View_StatisticesWebView_CovFreqTableAdapter">
            <SelectParameters>
                <asp:SessionParameter SessionField="EmployeeID" Name="EmployeeID" Type="Int32"></asp:SessionParameter>
            </SelectParameters>
        </asp:ObjectDataSource>
    </div>
</asp:Content>