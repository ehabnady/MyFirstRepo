<%@ Page Title="Messages" Language="C#" MasterPageFile="~/Site2.Master" AutoEventWireup="true" CodeBehind="Notifications.aspx.cs" Inherits="AmounCRM4.Reps.Notifications" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <title>Messages</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    
    <div style="width:100%">
     <table align="center" style="width:100%">
        <tr style="width:100%">
            <td valign="top" align="center" style="width:100%">
                <asp:Label ID="Label1" runat="server" Text="National Vacations" Font-Bold="true"></asp:Label><br /><br />
                <asp:ListView ID="lstVac" runat="server" DataSourceID="sqlDSVac">
                    <AlternatingItemTemplate>
                        <li style="background-color: #FFF8DC; text-align:left">Vacation:
                            <asp:Label Text='<%# Eval("Vaccation_Name") %>' runat="server" ID="Vaccation_NameLabel" /><br />
                            Vacation Date:
                            <asp:Label Text='<%# DateTime.Parse(Eval("VaccationDate").ToString()).ToShortDateString() %>' runat="server" ID="VaccationDateLabel" /><br />
                        </li>
                    </AlternatingItemTemplate>
                    <EmptyDataTemplate>
                        No Vacations in This Cycle.
                    </EmptyDataTemplate>
                    <ItemSeparatorTemplate>
                        <br />
                    </ItemSeparatorTemplate>
                    <ItemTemplate>
                        <li style="background-color: #DCDCDC; color: #000000; text-align:left">Vacation:
                            <asp:Label Text='<%# Eval("Vaccation_Name") %>' runat="server" ID="Vaccation_NameLabel" /><br />
                            Vacation Date:
                            <asp:Label Text='<%# DateTime.Parse(Eval("VaccationDate").ToString()).ToShortDateString() %>' runat="server" ID="VaccationDateLabel" /><br />
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
                        <li style="background-color: #008A8C; font-weight: bold; color: #FFFFFF; text-align:left">Vacation:
                            <asp:Label Text='<%# Eval("Vaccation_Name") %>' runat="server" ID="Vaccation_NameLabel" /><br />
                            Vacation Date:
                            <asp:Label Text='<%# DateTime.Parse(Eval("VaccationDate").ToString()).ToShortDateString() %>' runat="server" ID="VaccationDateLabel" /><br />
                        </li>
                    </SelectedItemTemplate>
                </asp:ListView>
                <asp:SqlDataSource runat="server" ID="sqlDSVac" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
                    SelectCommand="SELECT [Vaccation Name] AS Vaccation_Name, [VaccationDate], [CycleID] FROM [NationalVaccations] WHERE ([CycleID] = @CycleID)">
                    <SelectParameters>
                        <asp:SessionParameter SessionField="CycleID" Name="CycleID" Type="Int32"></asp:SessionParameter>
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
    </tr>
                <tr>
                    <td><p><br /><br /></p></td>
                </tr>
        <tr>
            <td valign="top" align="center">
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
                        <asp:SessionParameter SessionField="LineID" Name="LineID"></asp:SessionParameter>

                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            </tr>

                <tr>
                    <td><p><br /><br /></p></td>
                </tr>

            <tr>
            <td valign="top" align="center">
                <asp:Label ID="lblTitle2" runat="server" Text="Messages and Notifications" Font-Bold="true"></asp:Label><br /><br />
                <telerik:RadGrid ID="gr" runat="server" AllowFilteringByColumn="True" AllowSorting="True" AllowPaging="True" ShowGroupPanel="True" Skin="WebBlue" DataSourceID="sqlDS_Messages" 
                    BorderStyle="Solid" BorderWidth="1" MasterTableView-AllowFilteringByColumn="false" ClientSettings-AllowGroupExpandCollapse="false">
                    <ClientSettings></ClientSettings>
                    <MasterTableView DataKeyNames="CRM_MessageID" DataSourceID="sqlDS_Messages" AutoGenerateColumns="False">
                        <Columns>
                            <telerik:GridBoundColumn DataField="CRM_MessageID" Visible="false" ReadOnly="True" HeaderText="CRM_MessageID" SortExpression="CRM_MessageID" UniqueName="CRM_MessageID" DataType="System.Int32" FilterControlAltText="Filter CRM_MessageID column"></telerik:GridBoundColumn>
                            
                            <telerik:GridBoundColumn DataField="CRM_MessageName" HeaderText="Title" SortExpression="CRM_MessageName" UniqueName="CRM_MessageName" FilterControlAltText="Filter CRM_MessageName column"
                                HeaderStyle-Width="25%" ItemStyle-Width="25%" FooterStyle-Width="25%"
                                ></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CRM_MessageDescription" ItemStyle-Wrap="true" HeaderText="Body" SortExpression="CRM_MessageDescription" UniqueName="CRM_MessageDescription" FilterControlAltText="Filter CRM_MessageDescription column"
                                HeaderStyle-Width="60%" ItemStyle-Width="60%" FooterStyle-Width="60%"></telerik:GridBoundColumn>
                            <telerik:GridDateTimeColumn DataField="EndDate" HeaderText="Expiry Date" SortExpression="EndDate" UniqueName="EndDate" DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy}" FilterControlAltText="Filter EndDate column"
                                HeaderStyle-Width="15%" ItemStyle-Width="15%" FooterStyle-Width="15%"></telerik:GridDateTimeColumn>
                            
                            <telerik:GridDateTimeColumn DataField="StartDate" HeaderText="Start Date" SortExpression="StartDate" UniqueName="StartDate" DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy}" FilterControlAltText="Filter StartDate column" Visible="false"></telerik:GridDateTimeColumn>
                            <telerik:GridBoundColumn DataField="LineID" HeaderText="Line" SortExpression="LineID" UniqueName="LineID" DataType="System.Int32" FilterControlAltText="Filter LineID column" Visible="false"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CRM_MessageTypeName" HeaderText="Type" SortExpression="CRM_MessageTypeName" UniqueName="CRM_MessageTypeName" FilterControlAltText="Filter CRM_MessageTypeName column" Visible="false"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SalesManagerID" HeaderText="SalesManagerID" SortExpression="SalesManagerID" UniqueName="SalesManagerID" DataType="System.Int32" FilterControlAltText="Filter SalesManagerID column" Visible="false"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="DistrictManagerID" HeaderText="DistrictManagerID" SortExpression="DistrictManagerID" UniqueName="DistrictManagerID" DataType="System.Int32" FilterControlAltText="Filter DistrictManagerID column" Visible="false"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SalesRepID" HeaderText="SalesRepID" SortExpression="SalesRepID" UniqueName="SalesRepID" DataType="System.Int32" FilterControlAltText="Filter SalesRepID column" Visible="false"></telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
                </td></tr>
        
         
    </table>
        <p><br /><br /><br /></p>
</div>
    <asp:SqlDataSource runat="server" ID="sqlDS_Messages" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
                    SelectCommand="SELECT [CRM_MessageID], [CRM_MessageName], [CRM_MessageDescription], [CRM_MessageTypeName], [StartDate], [EndDate], [LineID], [SalesRepID] FROM [View_CRM_Messages] WHERE ((([SalesRepID] = @EmployeeID) OR CRM_MessageTypeName = 'All') AND EndDate >= GETDATE())">
                    <SelectParameters>
                        <asp:SessionParameter SessionField="EmployeeID" Name="EmployeeID" Type="Int32" DefaultValue="760"></asp:SessionParameter>
                    </SelectParameters>
                </asp:SqlDataSource>     
    
</asp:Content>
