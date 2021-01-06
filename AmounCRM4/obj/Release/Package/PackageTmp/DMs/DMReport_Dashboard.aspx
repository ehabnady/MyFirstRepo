﻿<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="DMReport_Dashboard.aspx.cs" Inherits="AmounCRM4.DMs.DMReport_Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <link href="../Styles/Gauges.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">

    <table width="95%">
        <tr>
            <td valign="top">
                <asp:GridView runat="server" ID="myID2" DataSourceID="SqlDataSource1" GridLines="Both" CellPadding="5" CellSpacing="5" ForeColor="#333333" HorizontalAlign="Center" 
                    OnRowDataBound="myID2_RowDataBound" Caption="Detailing Priority">
                    <EditRowStyle BackColor="#999999"></EditRowStyle>
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White"></FooterStyle>
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White"></HeaderStyle>
                    <PagerStyle HorizontalAlign="Center" BackColor="#284775" ForeColor="White"></PagerStyle>
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333"></RowStyle>
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333"></SelectedRowStyle>
                    <SortedAscendingCellStyle BackColor="#E9E7E2"></SortedAscendingCellStyle>
                    <SortedAscendingHeaderStyle BackColor="#506C8C"></SortedAscendingHeaderStyle>
                    <SortedDescendingCellStyle BackColor="#FFFDF8"></SortedDescendingCellStyle>
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE"></SortedDescendingHeaderStyle>
                </asp:GridView>
    
                <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
                    SelectCommand="GetDetailingPriority" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter SessionField="LineIDFromDM" Name="LineID"></asp:SessionParameter>

                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            </tr></table>



    <%--<telerik:RadSkinManager ID="RadSkinManager1" runat="server" ShowChooser="true" />--%>
    <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true"></telerik:RadWindowManager>
    <p></p>
    <br />
    <div align="center">
        <table width="96%" align="center">
            <tr>
                <td width="32%" align="center">
                    <asp:Label ID="lblG1" runat="server" Text="Actual Visits vs. Targeted Visits"></asp:Label>
                    <telerik:RadRadialGauge runat="server" ID="g1" Width="325px" Height="192px" RenderMode="Lightweight">
                        <Pointer Color="#000000">
                            <Cap Size="0.2" />
                        </Pointer>
                        <Scale Min="0" MajorUnit="10" MinorUnit="5">
                            <MajorTicks Size="4" Color="#777777" />
                            <MinorTicks Size="2" Color="#777777" />
                            <Labels Position="Outside" Color="#000000" Font="bold 11px Arial,Verdana,Tahoma" />
                            <Ranges>
                                <telerik:GaugeRange From="0" To="50" Color="Red" />
                                <telerik:GaugeRange From="50" To="80" Color="Orange" />
                                <telerik:GaugeRange From="80" To="100" Color="Green" />
                            </Ranges>
                        </Scale>
                    </telerik:RadRadialGauge>
                </td>
                <td width="32%" align="center">
                    <asp:Label ID="lblG3" runat="server" Text="Class 'A+' Coverage"></asp:Label>
                    <telerik:RadRadialGauge runat="server" ID="g3" Width="325px" Height="192px" RenderMode="Lightweight">
                        <Pointer Color="#000000">
                            <Cap Size="0.2" />
                        </Pointer>
                        <Scale Min="0" MajorUnit="10" MinorUnit="5">
                            <MajorTicks Size="4" Color="#777777" />
                            <MinorTicks Size="2" Color="#777777" />
                            <Labels Position="Outside" Color="#000000" Font="bold 11px Arial,Verdana,Tahoma" />
                            <Ranges>
                                <telerik:GaugeRange From="0" To="50" Color="Red" />
                                <telerik:GaugeRange From="50" To="80" Color="Orange" />
                                <telerik:GaugeRange From="80" To="100" Color="Green" />
                            </Ranges>
                        </Scale>
                    </telerik:RadRadialGauge>
                </td>
                <td width="32%" align="center">
                    <asp:Label ID="lblG2" runat="server" Text="Class 'A' Coverage"></asp:Label>
                    <telerik:RadRadialGauge runat="server" ID="g2" Width="325px" Height="192px" RenderMode="Lightweight">
                        <Pointer Value="22" Color="#000000">
                            <Cap Size="0.2" />
                        </Pointer>
                        <Scale Min="0" MajorUnit="10" MinorUnit="5">
                            <MajorTicks Size="4" Color="#777777" />
                            <MinorTicks Size="2" Color="#777777" />
                            <Labels Position="Outside" Color="#000000" Font="bold 11px Arial,Verdana,Tahoma" />
                            <Ranges>
                                <telerik:GaugeRange From="0" To="50" Color="Red" />
                                <telerik:GaugeRange From="50" To="80" Color="Orange" />
                                <telerik:GaugeRange From="80" To="100" Color="Green" />
                            </Ranges>
                        </Scale>
                    </telerik:RadRadialGauge>                    
                </td>
            </tr>
        </table>
    </div>

    <p></p>
    <p></p>
    <br />

    <div align="center">
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>
        <table width="96%" align="center">
            <tr>
                <td width="96%" align="center">
                    <div align="left">
                        <h2>Visits Analyzer</h2>
                        <%--<asp:LinkButton ID="btnExport" runat="server" OnClick="btnExport_Click" Visible="false" Text="Export Summary Pivot" />--%>
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
                                <telerik:PivotGridReportFilterField Caption="Rep Name" DataField="EmployeeName" UniqueName="EmployeeName">
                                </telerik:PivotGridReportFilterField>
                                <telerik:PivotGridReportFilterField Caption="Line" DataField="LineID" UniqueName="LineID">
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

    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataBySupervisionAreaID2"
        TypeName="AmounCRM4.App_Data.ExecSummary2TableAdapters.View3_FullViewTableAdapter" OnSelected="ObjectDataSource2_Selected">
        <SelectParameters>
            <asp:SessionParameter Name="EmployeeIDFromDM" SessionField="EmployeeIDFromDM" Type="Int32" />
            <asp:SessionParameter Name="CycleIDFromDM" SessionField="CycleIDFromDM" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>



</asp:Content>
