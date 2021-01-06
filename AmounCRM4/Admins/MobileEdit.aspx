<%@ Page Title="Physician Mobile Number" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="MobileEdit.aspx.cs"
    Inherits="AmounCRM4.Admins.MobileEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <asp:Panel ID="Panel1" runat="server" GroupingText="Search your physicians" HorizontalAlign="Left">
        <table align="left">
            <tr>
                <td>Doctor ID</td>
                <td><asp:TextBox ID="txtAffID" runat="server" /></td>
            </tr>
            <tr>
                <td>Bricks / Specialties:</td>
                <td>
                    <asp:DropDownList ID="ddlSpecialty" runat="server" AppendDataBoundItems="True" DataSourceID="dsSpec" DataTextField="SpecialityCode" DataValueField="SpecialtyID">
                        <asp:ListItem Text="Select Specialty" />
                    </asp:DropDownList>

                    <asp:DropDownList ID="ddlBricks" runat="server" DataSourceID="dsBricks" DataTextField="AmounBrickName" DataValueField="AmounBrickID" AppendDataBoundItems="true">
                        <asp:ListItem Text="Select Brick" />
                    </asp:DropDownList>

                    <asp:Button Text="Search" ID="btnSearch" runat="server" OnClick="btnSearch_Click" />
                </td>
            </tr>

            <tr>
                <td colspan="2">
                    <br />
                    <asp:Label Text="Please Add a Mobile Number Leading with Zero Followed by Ten Numbers" runat="server" Font-Size="Large" ForeColor="Red" />
                    <br /><br />
                    <asp:GridView ID="grdAffs" runat="server" AutoGenerateColumns="False" DataKeyNames="AffiliationID" DataSourceID="dsAffs" CellPadding="4" 
                        ForeColor="#333333" GridLines="Both" AllowSorting="true" OnSorted="grdAffs_Sorted" OnSorting="grdAffs_Sorting">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775"></AlternatingRowStyle>
                        <Columns>
                            <asp:BoundField DataField="AffiliationID" HeaderText="Doctor ID" ReadOnly="True" SortExpression="AffiliationID"></asp:BoundField>
                            <asp:BoundField DataField="AffiliationName" HeaderText="Doctor Name" SortExpression="AffiliationName"></asp:BoundField>
                            <asp:BoundField DataField="PhysicianID" HeaderText="PhysicianID" SortExpression="PhysicianID" Visible="false"></asp:BoundField>
                            <asp:BoundField DataField="SpecialtyID" HeaderText="SpecialtyID" SortExpression="SpecialtyID" Visible="false"></asp:BoundField>
                            <asp:BoundField DataField="SpecialityCode" HeaderText="Specialty" SortExpression="SpecialityCode"></asp:BoundField>
                            <asp:BoundField DataField="BrickID" HeaderText="BrickID" SortExpression="BrickID" Visible="false"></asp:BoundField>
                            <asp:BoundField DataField="AmounBrickName" HeaderText="Brick" SortExpression="AmounBrickName"></asp:BoundField>
                            <asp:BoundField DataField="Tel1" HeaderText="Old Mobile Number" SortExpression="Tel1"></asp:BoundField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:TextBox ID="txtMobile" runat="server" Text="" TextMode="Number" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
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
                </td>
            </tr>
            <tr>
                 <td colspan="2" align="center"><asp:Button ID="btnSave" Text="Save Mobile Numbers" runat="server" OnClick="btnSave_Click" /></td>
            </tr>
        </table>
    </asp:Panel>

    <asp:SqlDataSource ID="dsSpec" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
        SelectCommand="SELECT DISTINCT [SpecialtyID], [SpecialityCode] FROM [View_SpecPriorityByLine] WHERE (([Deleted] IS NULL) AND ([LineID] = @LineID)) ORDER BY [SpecialityCode]">
        <SelectParameters>
            <asp:SessionParameter Name="LineID" SessionField="LineID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="dsBricks" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT DISTINCT [AmounBrickID], [AmounBrickName] FROM [View_EmployeesBricks] WHERE ([EmployeeID] = @EmployeeID) ORDER BY [AmounBrickName]">
        <SelectParameters>
            <asp:SessionParameter Name="EmployeeID" SessionField="EmployeeID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="dsAffs" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
        SelectCommand="SELECT DISTINCT [AffiliationID], [AffiliationName], [PhysicianID], [SpecialtyID], [SpecialityCode], [BrickID], [AmounBrickName], [Tel1] 
        FROM [View_Affiliations_Admin] WHERE ([EmployeeID] = @EmployeeID) AND PhysicianClass IN ('A', 'B') AND SpecialtyValue > 0">
        <SelectParameters>
            <asp:SessionParameter Name="EmployeeID" SessionField="EmployeeID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
