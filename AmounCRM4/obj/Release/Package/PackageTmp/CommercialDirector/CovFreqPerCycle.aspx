<%@ Page Title="Coverage & Frequency by Cycle" Language="C#" MasterPageFile="~/CommercialDirector/SiteMaster2.Master" AutoEventWireup="true" CodeBehind="CovFreqPerCycle.aspx.cs" Inherits="AmounCRM4.CommercialDirector.CovFreqPerCycle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <title>Coverage & Frequency by Cycle</title>
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
                    <telerik:GridBoundColumn DataField="EmployeeFullName" HeaderText="Rep Name" SortExpression="EmployeeFullName" UniqueName="EmployeeFullName" FilterControlAltText="Filter EmployeeFullName column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DirectManagerName" HeaderText="DM" SortExpression="DirectManagerName" UniqueName="DirectManagerName" FilterControlAltText="Filter DirectManagerName column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TopManagerName" HeaderText="Sales Manager" SortExpression="TopManagerName" UniqueName="TopManagerName" FilterControlAltText="Filter TopManagerName column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DirectorName" HeaderText="Sales Director" SortExpression="DirectorName" UniqueName="DirectorName" FilterControlAltText="Filter DirectorName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ActualVisits" Aggregate="Sum" FooterAggregateFormatString="{0:00,000.00}" DataFormatString="{0:00}" HeaderText="Actual Visits" SortExpression="ActualVisits" UniqueName="ActualVisits" DataType="System.Decimal" FilterControlAltText="Filter ActualVisits column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TargetVisits" Aggregate="Sum" FooterAggregateFormatString="{0:00,000.00}" DataFormatString="{0:00}" HeaderText="Target Visits" SortExpression="TargetVisits" UniqueName="TargetVisits" DataType="System.Decimal" FilterControlAltText="Filter TargetVisits column"></telerik:GridBoundColumn>
                                    <telerik:GridCalculatedColumn DataFields="ActualVisits, TargetVisits" Expression="iif({1}=0,0,(({0}/{1})))" DataFormatString="{0:P}" HeaderText="Frequency" SortExpression="Frequency" UniqueName="Frequency" DataType="System.Decimal"
                                        FilterControlAltText="Filter Frequency column"></telerik:GridCalculatedColumn>
                                    <telerik:GridBoundColumn DataField="VisitedDoctors" Aggregate="Sum" FooterAggregateFormatString="{0:00,000.00}" DataFormatString="{0:00}" HeaderText="Visited Doctors" SortExpression="VisitedDoctors" UniqueName="VisitedDoctors" DataType="System.Decimal" FilterControlAltText="Filter VisitedDoctors column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TargetDoctors" Aggregate="Sum" FooterAggregateFormatString="{0:00,000.00}" DataFormatString="{0:00}" HeaderText="Target Doctors" SortExpression="TargetDoctors" UniqueName="TargetDoctors" DataType="System.Decimal" FilterControlAltText="Filter TargetDoctors column"></telerik:GridBoundColumn>
                                    <telerik:GridCalculatedColumn DataFields="VisitedDoctors, TargetDoctors" Expression="iif({1}=0,0,(({0}/{1})))" DataFormatString="{0:P}" HeaderText="Coverage" SortExpression="Coverage" UniqueName="Coverage" DataType="System.Decimal" 
                                        FilterControlAltText="Filter Coverage column"></telerik:GridCalculatedColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
        <asp:ObjectDataSource runat="server" ID="ObjectDataSource1" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataCovFreq" 
            TypeName="AmounCRM4.App_Data.ExecSummary2TableAdapters.View_StatisticesWebView_CovFreq2_ComDirTableAdapter">
        </asp:ObjectDataSource>
    </div>
</asp:Content>
