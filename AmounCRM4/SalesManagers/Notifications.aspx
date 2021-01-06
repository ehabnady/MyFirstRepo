<%@ Page Title="Notifications" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Notifications.aspx.cs" Inherits="AmounCRM4.SalesManagers.Notifications" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <title>Notifications</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    
            <div visible="true">
                <asp:Label ID="Label1" runat="server" Text="National Vacations" Font-Bold="true"></asp:Label><br /><br />
                <asp:ListView ID="lstVac" runat="server" DataSourceID="sqlDSVac">
                    <AlternatingItemTemplate>
                        <li style="background-color: #FFF8DC;">Vacation:
                            <asp:Label Text='<%# Eval("Vaccation_Name") %>' runat="server" ID="Vaccation_NameLabel" /><br />
                            Vacation Date:
                            <asp:Label Text='<%# Eval("VaccationDate") %>' runat="server" ID="VaccationDateLabel" /><br />
                            Cycle:
                            <asp:Label Text='<%# Eval("CycleID") %>' runat="server" ID="CycleIDLabel" /><br />
                        </li>
                    </AlternatingItemTemplate>
                    <EmptyDataTemplate>
                        No Vacations in This Cycle.
                    </EmptyDataTemplate>
                    <ItemSeparatorTemplate>
                        <br />
                    </ItemSeparatorTemplate>
                    <ItemTemplate>
                        <li style="background-color: #DCDCDC; color: #000000;">Vacation:
                            <asp:Label Text='<%# Eval("Vaccation_Name") %>' runat="server" ID="Vaccation_NameLabel" /><br />
                            Vacation Date:
                            <asp:Label Text='<%# Eval("VaccationDate") %>' runat="server" ID="VaccationDateLabel" /><br />
                        </li>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <ul runat="server" id="itemPlaceholderContainer" style="font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <li runat="server" id="itemPlaceholder" />
                        </ul>
                        <div style="text-align: center; background-color: #CCCCCC; font-family: Verdana, Arial, Helvetica, sans-serif; color: #000000;">
                        </div>
                    </LayoutTemplate>
                    <SelectedItemTemplate>
                        <li style="background-color: #008A8C; font-weight: bold; color: #FFFFFF;">Vacation:
                            <asp:Label Text='<%# Eval("Vaccation_Name") %>' runat="server" ID="Vaccation_NameLabel" /><br />
                            Vacation Date:
                            <asp:Label Text='<%# Eval("VaccationDate") %>' runat="server" ID="VaccationDateLabel" /><br />
                            Cycle:
                            <asp:Label Text='<%# Eval("CycleID") %>' runat="server" ID="CycleIDLabel" /><br />
                        </li>
                    </SelectedItemTemplate>
                </asp:ListView>
                <asp:SqlDataSource runat="server" ID="sqlDSVac" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
                    SelectCommand="SELECT [Vaccation Name] AS Vaccation_Name, [VaccationDate], [CycleID] FROM [NationalVaccations] WHERE ([CycleID] = @CycleIDFromSM)">
                    <SelectParameters>
                        <asp:SessionParameter SessionField="CycleIDFromSM" Name="CycleIDFromSM" Type="Int32"></asp:SessionParameter>
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>

    
    <p><br /></p>
    <table width="95%">
        <tr>
            <td valign="top">
                <asp:Label ID="lblTitle1" runat="server" Text="Detailing Priority" Font-Bold="true"></asp:Label><br /><br />
                <asp:GridView runat="server" ID="myID2" DataSourceID="SqlDataSource1" GridLines="Both" CellPadding="5" CellSpacing="5" ForeColor="#333333" HorizontalAlign="Center" 
                    OnRowDataBound="myID2_RowDataBound">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775"></AlternatingRowStyle>

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
                        <asp:SessionParameter SessionField="LineIDFromSM" Name="LineID"></asp:SessionParameter>

                    </SelectParameters>
                </asp:SqlDataSource>
            </td>

            <td valign="top">
                <asp:Label ID="lblTitle2" runat="server" Text="Alerts" Font-Bold="true"></asp:Label><br /><br />
                <telerik:RadGrid ID="gr" runat="server" AllowFilteringByColumn="True" AllowSorting="True" AllowPaging="True" ShowGroupPanel="True" Skin="WebBlue" DataSourceID="sqlDS_Messages" 
                    BorderStyle="Solid" MasterTableView-AllowFilteringByColumn="false" ClientSettings-AllowGroupExpandCollapse="false">
                    <ClientSettings></ClientSettings>
                    <MasterTableView DataKeyNames="CRM_MessageID" DataSourceID="sqlDS_Messages" AutoGenerateColumns="False">
                        <Columns>
                            <telerik:GridBoundColumn DataField="CRM_MessageID" ReadOnly="True" HeaderText="CRM_MessageID" SortExpression="CRM_MessageID" UniqueName="CRM_MessageID" DataType="System.Int32" FilterControlAltText="Filter CRM_MessageID column" Visible="false"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CRM_MessageName" HeaderText="Title" SortExpression="CRM_MessageName" UniqueName="CRM_MessageName" FilterControlAltText="Filter CRM_MessageName column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CRM_MessageDescription" ItemStyle-Wrap="true" HeaderText="Body" SortExpression="CRM_MessageDescription" UniqueName="CRM_MessageDescription" FilterControlAltText="Filter CRM_MessageDescription column"></telerik:GridBoundColumn>
                            <telerik:GridDateTimeColumn DataField="StartDate" HeaderText="Start Date" SortExpression="StartDate" UniqueName="StartDate" DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy}" FilterControlAltText="Filter StartDate column" Visible="false"></telerik:GridDateTimeColumn>
                            <telerik:GridDateTimeColumn DataField="EndDate" HeaderText="Expiry Date" SortExpression="EndDate" UniqueName="EndDate" DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy}" FilterControlAltText="Filter EndDate column"></telerik:GridDateTimeColumn>
                            <telerik:GridBoundColumn DataField="LineID" HeaderText="Line" SortExpression="LineID" UniqueName="LineID" DataType="System.Int32" FilterControlAltText="Filter LineID column" Visible="false"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CRM_MessageTypeName" HeaderText="Type" SortExpression="CRM_MessageTypeName" UniqueName="CRM_MessageTypeName" FilterControlAltText="Filter CRM_MessageTypeName column" Visible="false"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SalesManagerID" HeaderText="SalesManagerID" SortExpression="SalesManagerID" UniqueName="SalesManagerID" DataType="System.Int32" FilterControlAltText="Filter SalesManagerID column" Visible="false"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="DistrictManagerID" HeaderText="DistrictManagerID" SortExpression="DistrictManagerID" UniqueName="DistrictManagerID" DataType="System.Int32" FilterControlAltText="Filter DistrictManagerID column" Visible="false"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SalesRepID" HeaderText="SalesRepID" SortExpression="SalesRepID" UniqueName="SalesRepID" DataType="System.Int32" FilterControlAltText="Filter SalesRepID column" Visible="false"></telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>



                <asp:GridView runat="server" ID="GridView1" DataSourceID="sqlDS_Messages" GridLines="Both" CellPadding="5" CellSpacing="5" ForeColor="#333333" HorizontalAlign="Center" Visible="false">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775"></AlternatingRowStyle>

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

                <asp:SqlDataSource runat="server" ID="sqlDS_Messages" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
                    SelectCommand="SELECT [CRM_MessageID], [CRM_MessageName], [CRM_MessageDescription], [CRM_MessageTypeName], [StartDate], [EndDate], [LineID], [SalesManagerID], [DistrictManagerID], [SalesRepID] FROM [View_CRM_Messages] WHERE ((([LineID] = 14) OR ([SalesManagerID] = @EmployeeIDFromSM)) AND EndDate >= GETDATE())">
                    <SelectParameters>
                        <asp:SessionParameter SessionField="EmployeeIDFromSM" Name="EmployeeIDFromSM" Type="Int32" DefaultValue="760"></asp:SessionParameter>
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>


    
</asp:Content>
