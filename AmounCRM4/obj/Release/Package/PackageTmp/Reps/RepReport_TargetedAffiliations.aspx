<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="RepReport_TargetedAffiliations.aspx.cs" Inherits="AmounCRM4.Reps.RepReport_TargetedAffiliations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .auto-style {
            width: 96%;
            text-align: left;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
        
    <br />
    <br />

    <table id="tblSummary" bgcolor="#3a4e62" align="center" width="88%">
        <tr>
            <%--<td style="color: white" align="left"><b><font size="5">Affiliations Numbers:</font></b></td>--%>
            <td style="color: white" align="right"><b><font size="5">Total Targeted Doctors: </font></b></td>
            <td align="left" style="padding-left: 20px">
                <asp:Label ID="lblAffsCount" runat="server" Style="color: white" Font-Bold="True" Font-Underline="True" Font-Size="X-Large"></asp:Label>
            </td>
            <td style="color: white" align="right"><b><font size="5">Class "A": </font></b></td>
            <td align="left" style="padding-left: 20px">
                <asp:Label ID="lblClassA_Aff" runat="server" Style="color: white" Font-Bold="True" Font-Underline="True" Font-Size="X-Large"></asp:Label>
            </td>
            <td style="color: white" align="right"><b><font size="5">Class "B": </font></b></td>
            <td align="left">
                <asp:Label ID="lblClassB_Aff" runat="server" Style="color: white" Font-Bold="True" Font-Underline="True" Font-Size="X-Large"></asp:Label>
            </td>
            <td style="color: white; visibility:hidden" align="right"><b><font size="5">Class "C": </font></b></td>
            <td align="left">
                <asp:Label ID="lblClassC_Aff" runat="server" Style="color: white; visibility:hidden" Font-Bold="True" Font-Underline="True" Font-Size="X-Large"></asp:Label>
            </td>
        </tr>
    </table>


    <br />
    <br />

    <table id="tblTile" align="center" width="88%">
        <tr>
            <th><h4 align="left">Affiliations by Specialty</h4></th>
        </tr>
        <tr>
            <td align="center">
                <telerik:RadListView ID="List1" runat="server" DataSourceID="ObjectDataSource1" Skin="WebBlue" RenderMode="Lightweight"
                    ClientDataKeyNames="SpecialityCode" DataKeyNames="SpecialityCode" Width="80%">
                    <LayoutTemplate>
                        <div class="RadListView RadListViewFloated RadListView_WebBlue">
                            <div class="rlvFloated">
                                <div id="itemPlaceholder" runat="server">
                                </div>
                            </div>
                        </div>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <div style="height: 80px; width: 150px" class="rlvI">
                            <table style="height: 80px; width: 150px"><tr valign="bottom"><td valign="top">
                            <asp:Label ID="SpecialityCodeLabel" runat="server" Font-Size="Large" Text='<%# Eval("SpecialityCode") %>' />
                            </td></tr>
                                <tr valign="bottom"><td valign="bottom">
                            <asp:Label ID="No_Of_PhysicianLabel" runat="server" Font-Size="Large" Text='<%# Eval("No_Of_Physician") %>' />
                                </td></tr></table>
                        </div>
                    </ItemTemplate>
                    
                    <EmptyDataTemplate>
                        <div class="RadListView RadListView_WebBlue">
                            <div class="rlvEmpty">
                                There are no items to be displayed.
                            </div>
                        </div>
                    </EmptyDataTemplate>
                    <SelectedItemTemplate>
                        <div class="rlvISel">
                            <br />
                            <asp:Label ID="SpecialityCodeLabel" runat="server" Text='<%# Eval("SpecialityCode") %>' />
                            <br />
                            <asp:Label ID="No_Of_PhysicianLabel" runat="server" Text='<%# Eval("No_Of_Physician") %>' />
                        </div>
                    </SelectedItemTemplate>
                </telerik:RadListView>
            </td>
        </tr>
    </table>    

    <br />
    <br />

    <table align="center" width="96%">
        <tr>
            <td align="center">
                <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>
                <telerik:RadAjaxPanel ID="ajaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1" Width="96%" HorizontalAlign="Center">

                    <telerik:RadGrid ID="gridAffs" runat="server" DataSourceID="ListOfTargetedAffDS" AllowFilteringByColumn="True" AllowPaging="True" Height="600px"
                        EnableGroupsExpandAll="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True" CssClass="auto-style"
                        AllowSorting="True" ShowGroupPanel="True"
                        Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True">

                        <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="ListOfClinics_Physicians">
                            <Excel Format="Xlsx" />
                        </ExportSettings>

                        <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                            <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                            <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                        </ClientSettings>

                        <MasterTableView DataSourceID="ListOfTargetedAffDS" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                            AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true" Caption="Affiliations List"
                            EnableHeaderContextMenu="True" EnableHeaderContextAggregatesMenu="true" EnableHeaderContextFilterMenu="true">
                            <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                            <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                            <Columns>
                                <telerik:GridBoundColumn DataField="AffiliationID" Visible="true" DataType="System.Int32" FilterControlAltText="Filter AffiliationID column" HeaderText="ID" SortExpression="AffiliationID" UniqueName="AffiliationID"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="AffiliationName" Visible="true" FilterControlAltText="Filter AffiliationName column" HeaderText="Name" SortExpression="AffiliationName" UniqueName="AffiliationName"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="AffiliationAddress" Visible="true" FilterControlAltText="Filter AffiliationAddress column" HeaderText="Address" SortExpression="AffiliationAddress" UniqueName="AffiliationAddress"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="SpecialtyCode" Visible="true" FilterControlAltText="Filter SpecialtyCode column" HeaderText="Specialty" SortExpression="SpecialtyCode" UniqueName="SpecialtyCode"></telerik:GridBoundColumn>
                                <%--<telerik:GridBoundColumn DataField="TotalValue" Visible="true" FilterControlAltText="Filter TotalValue column" HeaderText="TotalValue" SortExpression="TotalValue" UniqueName="TotalValue"></telerik:GridBoundColumn>--%>
                                <%--<telerik:GridBoundColumn DataField="AffiliationClass" Visible="true" FilterControlAltText="Filter AffiliationClass column" HeaderText="Class" SortExpression="AffiliationClass" UniqueName="AffiliationClass"></telerik:GridBoundColumn>--%>
                                <telerik:GridBoundColumn DataField="BrickID" Visible="true" FilterControlAltText="Filter BrickID column" HeaderText="Brick ID" SortExpression="BrickID" UniqueName="BrickID"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="BrickName" Visible="true" FilterControlAltText="Filter BrickName column" HeaderText="Brick Name" SortExpression="BrickName" UniqueName="BrickName"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="CycleDesc" Visible="true" FilterControlAltText="Filter CycleDesc column" HeaderText="Cycle" SortExpression="CycleDesc" UniqueName="CycleDesc"></telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>

                    <asp:SqlDataSource ID="ListOfTargetedAffDS" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                        SelectCommand="SELECT AffiliationID, AffiliationName, AffiliationAddress, SpecialtyCode, TotalValue, AffiliationClass, BrickID, BrickName, CycleDesc FROM View_TargetedAffiliations WHERE EmployeeID = @EmployeeID">
                        <SelectParameters>
                            <asp:SessionParameter Name="EmployeeID" SessionField="EmployeeID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByTargetedAffs" TypeName="AmounCRM4.App_Data.ExecSummary2TableAdapters.AffiliationsByAreaGroupBySpecTableAdapter">
                        <SelectParameters>
                            <asp:SessionParameter Name="EmployeeID" SessionField="EmployeeID" Type="Int32" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                </telerik:RadAjaxPanel>
            </td>
        </tr>

        <tr>
            <td align="center">&nbsp;</td>
        </tr>
    </table>
</asp:Content>
