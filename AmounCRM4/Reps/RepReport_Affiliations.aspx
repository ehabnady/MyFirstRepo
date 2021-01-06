<%@ Page Title="Affiliation Report" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="RepReport_Affiliations.aspx.cs" Inherits="AmounCRM4.Reps.RepReport_Affiliations" %>

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
            <td style="color: white" align="right"><b><font size="5">Total Affiliations: </font></b></td>
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
            <td style="color: white" align="right"><b><font size="5">Class "C": </font></b></td>
            <td align="left">
                <asp:Label ID="lblClassC_Aff" runat="server" Style="color: white" Font-Bold="True" Font-Underline="True" Font-Size="X-Large"></asp:Label>
            </td>
        </tr>
    </table>


    <br />
    <br />

    <table id="tblTile" align="center" width="88%">
        <tr>
            <th><h4 align="left">Doctors by Specialty</h4></th>
        </tr>
        <tr>
            <td align="center">
                <telerik:RadListView ID="List1" runat="server" DataSourceID="ObjectDataSource1" Skin="WebBlue" RenderMode="Lightweight"
                    ClientDataKeyNames="SpecialityCode" DataKeyNames="SpecialityCode">
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

                    <telerik:RadGrid ID="gridAffs" runat="server" DataSourceID="ListOfAffDS" AllowFilteringByColumn="True" AllowPaging="True" Height="600px"
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

                        <MasterTableView DataSourceID="ListOfAffDS" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                            AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true" Caption="Affiliations List"
                            EnableHeaderContextMenu="True" EnableHeaderContextAggregatesMenu="true" EnableHeaderContextFilterMenu="true">
                            <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                            <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                            <Columns>
                                <telerik:GridBoundColumn DataField="AffiliationID" Visible="true" DataType="System.Int32" FilterControlAltText="Filter AffiliationID column" HeaderText="ID" SortExpression="AffiliationID" UniqueName="AffiliationID"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="AffiliationName" Visible="true" FilterControlAltText="Filter AffiliationName column" HeaderText="Name" SortExpression="AffiliationName" UniqueName="AffiliationName"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="EntityAddress" Visible="true" FilterControlAltText="Filter EntityAddress column" HeaderText="Address" SortExpression="EntityAddress" UniqueName="EntityAddress"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="SpecialityCode" Visible="true" FilterControlAltText="Filter SpecialityCode column" HeaderText="Specialty" SortExpression="SpecialityCode" UniqueName="SpecialityCode"></telerik:GridBoundColumn>
                                <%--<telerik:GridBoundColumn DataField="PhysicianClass" Visible="true" FilterControlAltText="Filter PhysicianClass column" HeaderText="Class" SortExpression="PhysicianClass" UniqueName="PhysicianClass"></telerik:GridBoundColumn>--%>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>

                    <asp:SqlDataSource ID="ListOfAffDS" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                        SelectCommand="SELECT AffiliationID, AffiliationName, EntityAddress, SpecialityCode, PhysicianClass FROM View_Affiliations_Admin WHERE SpecialtyValue > 0 AND EmployeeID = @EmployeeID">
                        <SelectParameters>
                            <asp:SessionParameter Name="EmployeeID" SessionField="EmployeeID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataAreaGroupBySpec2" TypeName="AmounCRM4.App_Data.ExecSummary2TableAdapters.AffiliationsByAreaGroupBySpecTableAdapter">
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
