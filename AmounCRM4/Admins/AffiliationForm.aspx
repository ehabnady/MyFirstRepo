<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AffiliationForm.aspx.cs" Inherits="AmounCRM4.Admins.AffiliationForm" 
    MasterPageFile="~/Site1.Master" %>

<asp:Content ID="head" runat="server" ContentPlaceHolderID="head">
    <title></title>
    <style type="text/css">
        .auto-style126 {
            font-size: small;
            font-weight: bold;
            background-color: #F7F6F3;
            width: 106px;
            text-align: right;
        }
        .auto-style127 {
            font-size: small;
            text-align: left;
        }
        .auto-style128 {
            text-align: right;
            font-size: small;
            font-weight: bold;
            background-color: #F7F6F3;
            width: 135px;
        }
        .auto-style129 {
            font-size: small;
        }
        .auto-style131 {
            background-color: #F7F6F3;
            width: 106px;
        }
        .auto-style134 {
            width: 408px;
            background-color: #F7F6F3;
        }
        .auto-style136 {
            font-size: small;
            width: 408px;
            background-color: #F7F6F3;
        }
        .auto-style138 {
            font-size: small;
            font-weight: bold;
            background-color: #F7F6F3;
            width: 135px;
        }
        .auto-style139 {
            background-color: #F7F6F3;
            width: 135px;
        }
        .auto-style144 {
            font-size: small;
            background-color: #5D7B9D;
        }
        .auto-style145 {
            font-size: small;
            font-weight: bold;
            background-color: #5D7B9D;
            width: 135px;
        }
        .auto-style146 {
            font-size: small;
            background-color: #F7F6F3;
        }
        .auto-style147 {
            width: 185px;
            background-color: #F7F6F3;
        }
        .auto-style152 {
            width: 58px;
        }
        .auto-style154 {
            width: 176px;
        }
        .auto-style81 {
            color: #800000;
            font-size: xx-large;
            text-decoration: underline;
        }
        .auto-style155 {
            color: #1818E4;
            width: 176px;
            height: 23px;
        }
        .auto-style156 {
            color: #1818E4;
            width: 74px;
            height: 23px;
        }
        .auto-style157 {
            width: 74px;
        }
        .auto-style158 {
            color: #1818E4;
            width: 58px;
            height: 23px;
        }
        .auto-style159 {
            color: #1818E4;
            width: 204px;
            height: 23px;
        }
        .auto-style160 {
            width: 204px;
        }
        .auto-style161 {
            color: #1818E4;
            width: 83px;
            height: 23px;
        }
        .auto-style162 {
            width: 83px;
        }
        </style>
</asp:Content>
<asp:Content ID="Body" runat="server" ContentPlaceHolderID="Body">
    <div>

        <span class="auto-style81"><strong>Doctor&#39;s Profile<br />
        </strong></span><strong style="text-align: left"><br />
<table align="center" dir="ltr" style="table-layout: fixed; background-color: #A2C5D0; width: 628px;">
            <tr>
                <td class="auto-style158">

        <strong style="text-align: left">
                    Search</strong></td>
                <td class="auto-style155">

                </td>
                <td class="auto-style156">

                </td>
                <td class="auto-style159">

                </td>
                <td class="auto-style161">

                    &nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style152">

        <strong style="font-size: small">
                    Brick</strong></td>
                <td class="auto-style154">

                    <asp:DropDownList ID="ddlBrickSe" runat="server" DataSourceID="AreaDataSource" DataTextField="AmounBrickName" DataValueField="AmounBrickID" style="text-align: left; font-size: small;" Height="20px" Width="146px">
                        <asp:ListItem Value="0">Select</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="auto-style157">

                    <strong style="text-align: left"><strong style="text-align: left; font-size: small;">Specialty</strong></strong></td>
                <td class="auto-style160">

                    <strong style="text-align: left">
                    <asp:DropDownList ID="ddlSpecialtySe" runat="server" DataSourceID="SpecialtyDataSource" DataTextField="Specialitycode" DataValueField="SpecialtyID" style="font-size: small; " Height="20px" Width="169px">
                        <asp:ListItem Value="0">Select</asp:ListItem>
                    </asp:DropDownList>
        
        </strong>
                </td>
                <td class="auto-style162">

                    <strong style="text-align: left">
                    <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search" style="font-size: small" />
        
        </strong>
                </td>
            </tr>
            </table>
        
        </strong>
        <table align="center" dir="ltr" style="table-layout: fixed">
            <tr>

        <strong style="text-align: left">
                <td>
                    <br />

         <div style="width: 100%; height: 250px; overflow: auto">
        <asp:GridView ID="gvAffiliations" runat="server" OnSelectedIndexChanged="gvAffiliations_SelectedIndexChanged" OnRowCreated="gvAffiliations_RowCreated" style="font-size: small" CellPadding="4" ForeColor="#333333" GridLines="None" >
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
     
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
 </div>
                    <br />
                </td>
        </strong>
            </tr>
            </table>
        <asp:Label ID="affiliationslblSaveStatus" runat="server" ForeColor="#CC0000"></asp:Label>
        <asp:Panel ID="Panel1" runat="server" Height="194px" Width="699px">
            <table align="center" dir="ltr" style="table-layout: fixed; width: 514px;">
                <tr>
                    <td class="auto-style145" style="text-align: right">Affliation Name</td>
                    <td class="auto-style144" colspan="3"><span style="text-align: left">
                        <asp:TextBox ID="txtAffiliationName" runat="server" BorderStyle="None" Enabled="False" MaxLength="110" style="color: #FFFFFF; background-color: #5D7B9D;" Width="302px"></asp:TextBox>
                        <strong style="text-align: left">
                        <asp:TextBox ID="txtAffiliationID" runat="server" Enabled="False" MaxLength="6" OnTextChanged="txtAffiliationID_TextChanged" ReadOnly="True" Visible="False" Width="39px"></asp:TextBox>
                        </strong></span></td>
                </tr>
                <tr>
                    <td class="auto-style138" style="text-align: right">No. Of Patients</td>
                    <td class="auto-style136"><strong style="text-align: left">
                        <asp:DropDownList ID="ddlNoOfPatients" runat="server" CssClass="auto-style129" DataSourceID="NoOfPatDataSource" DataTextField="RangeName" DataValueField="RangeValue" Enabled="False" Width="115px">
                        </asp:DropDownList>
                        </strong></td>
                    <td class="auto-style146" style="text-align: right; font-weight: 700; font-size: small;">Wating Time</td>
                    <td class="auto-style147"><strong style="text-align: left">
                        <asp:DropDownList ID="ddlWaitingTime" runat="server" CssClass="auto-style129" DataSourceID="WTDataSource" DataTextField="RangeName" DataValueField="RangeValue" Enabled="False" style="text-align: left" Width="115px">
                        </asp:DropDownList>
                        </strong></td>
                </tr>
                <tr>
                    <td class="auto-style128"><strong dir="rtl" style="text-align: right">Prescription Habit</strong></td>
                    <td class="auto-style136"><strong style="text-align: left">
                        <asp:DropDownList ID="ddlPHappit" runat="server" CssClass="auto-style129" DataSourceID="PHappitDataSource" DataTextField="RangeName" DataValueField="RangeValue" Width="115px">
                        </asp:DropDownList>
                        </strong>
                        <asp:Label ID="lblPHappitReq" runat="server" Enabled="False" ForeColor="Red" Text="*" Visible="False"></asp:Label>
                    </td>
                    <td class="auto-style126">&nbsp;</td>
                    <td class="auto-style147">
                        <asp:TextBox ID="txtSpecValue" runat="server" CssClass="auto-style129" Visible="False" Width="108px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style128"><strong style="text-align: right">Best Time to visit From</strong></td>
                    <td class="auto-style136"><strong style="text-align: left">
                        <asp:TextBox ID="txtBestTimeFrom" runat="server" MaxLength="50" Width="106px" Wrap="False"></asp:TextBox>
                        </strong></td>
                    <td class="auto-style146" style="text-align: right"><strong><span class="auto-style146">To</span></strong></td>
                    <td class="auto-style147"><strong style="text-align: left">
                        <asp:TextBox ID="txtBestTimeTo" runat="server" CssClass="auto-style129" MaxLength="50" Width="106px"></asp:TextBox>
                        </strong></td>
                </tr>
                <tr>
                    <td class="auto-style138" style="text-align: right">Notes</td>
                    <td colspan="3"><strong style="text-align: left">
                        <asp:TextBox ID="txtNotes" runat="server" Height="16px" MaxLength="150" Width="354px"></asp:TextBox>
                        </strong></td>
                </tr>
                <tr>
                    <strong style="text-align: left">
                    <td class="auto-style139">&nbsp;</td>
                    <td class="auto-style134">&nbsp;</td>
                    <td class="auto-style131">&nbsp;</td>
                    <td class="auto-style147">
                        <asp:Button ID="btnUpdate" runat="server" CssClass="auto-style127" OnClick="btnUpdate_Click" Text="Update" />
                    </td>
                    </strong>
                </tr>
            </table>
        </asp:Panel>
<asp:SqlDataSource ID="AreaDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
            SelectCommand="SELECT AmounBrickID , AmounBrickName FROM View_EmployeesBricks WHERE (Deleted IS NULL) AND (EmployeeID = @EmployeeId)" OnSelecting="AreaDataSource_Selecting">
            <SelectParameters>
                <asp:SessionParameter Name="EmployeeId" SessionField="EmployeeID" />
            </SelectParameters>
        </asp:SqlDataSource>
        
        <asp:SqlDataSource ID="LineDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
            SelectCommand="SELECT [LineID], [LineName], [OldLineName], [Deleted] FROM [PromotionalLines] WHERE ([Deleted] IS NULL)" OnSelected="LineDataSource_Selected">
        </asp:SqlDataSource>
        
        <asp:SqlDataSource ID="NoOfPatDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT [RangeName], [RangeValue] FROM [NoOfPatients]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="WTDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT [RangeName], [RangeValue] FROM [WaitingTime]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="PHappitDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT [RangeName], [RangeValue] FROM [PrescriptionHappit]"></asp:SqlDataSource>
        
        <asp:SqlDataSource ID="SpecialtyDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
            SelectCommand="SELECT DISTINCT BrandPriorityBySpecLine.SpecialtyID, Specialities.Specialitycode FROM BrandPriorityBySpecLine INNER JOIN Specialities ON BrandPriorityBySpecLine.SpecialtyID = Specialities.SpecialityID where(BrandPriorityBySpecLine.LineID = @LineID) AND(BrandPriorityBySpecLine.BrandPriority &lt; 5) order by Specialities.Specialitycode">
            <SelectParameters>
                <asp:SessionParameter Name="LineID" SessionField="LineID" DefaultValue="1" />
            </SelectParameters>
        </asp:SqlDataSource>
        
    </div>
    <br />
</asp:Content>
