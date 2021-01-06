<%@ Page Title="Vacation Request" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="VacationRequest.aspx.cs" Inherits="AmounCRM4.Admins.VacationRequest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .auto-style2 {
            width: 727px;
            height: 174px;
            text-align: right;
            font-weight: 700;
            font-size: small;
            background-color: #5D7B9D;
        }

        .auto-style5 {
            font-size: medium;
        }

        .auto-style10 {
                        background-color:#ef8354; 

            height: 21px;
            }

        .auto-style13 {
            background-color: #FFFFFF;
        }

        .auto-style15 {
            background-color: #FFFFFF;
            text-align: left;
        }

        .auto-style16 {
            background-color: #FFFFFF;
            width: 878px;
        }

        .auto-style20 {
            font-size: large;
        }

        .auto-style21 {
            background-color: #FFFFFF;
            width: 534px;
            font-size: medium;
        }

        .auto-style22 {
            background-color: #FFFFFF;
            width: 878px;
            font-size: medium;
        }

        .auto-style23 {
            font-size: medium;
        }

        .auto-style25 {
            background-color: #FFFFFF;
            width: 314px;
            text-align: left;
            font-size: medium;
        }

        .auto-style26 {
            width: 377px;
        }

        .auto-style27 {
            background-color: #FFFFFF;
            width: 377px;
            text-align: left;
            font-size: medium;
        }

        .auto-style28 {
            color: #CC0000;
        }

        .auto-style29 {
            background-color: #FFFFFF;
            width: 878px;
            color: #CC0000;
        }

        .auto-style30 {
            text-decoration: underline;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <table align="center">
        <tr>
            <td>


                <asp:GridView ID="gvVacations" runat="server" CellPadding="4" CssClass="auto-style5" ForeColor="#333333" GridLines="None" OnRowCreated="gvVacations_RowCreated" OnSelectedIndexChanged="gvVacations_SelectedIndexChanged" OnRowDataBound="gvVacations_OnRowDataBound">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>

                        <asp:CommandField ShowSelectButton="True" />
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
            </td>
        </tr>
    </table>

    <br />


    <asp:Label ID="VacationslblSaveStatus" runat="server" Style="color: #CC0000; font-size: large;"></asp:Label>


    <br />


    <br />


    <table align="center" class="auto-style2">
        <tr>
            <td class="auto-style20" colspan="4">
                <asp:TextBox ID="txtVacID" runat="server" Visible="False"></asp:TextBox>
            </td>
        </tr>
        <tr class="auto-style20">
            <td class="auto-style22">Start Date</td>
            <td class="auto-style25">
                <telerik:RadDatePicker ID="dpStartDate" runat="server" Culture="en-US" Skin="WebBlue" AutoPostBack="True" OnSelectedDateChanged="dpStartDate_SelectedDateChanged">
                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="WebBlue"></Calendar>

                    <DateInput runat="server" DisplayDateFormat="d/M/yyyy" DateFormat="M/d/yyyy" LabelWidth="40%" AutoPostBack="True">
                        <EmptyMessageStyle Resize="None"></EmptyMessageStyle>

                        <ReadOnlyStyle Resize="None"></ReadOnlyStyle>

                        <FocusedStyle Resize="None"></FocusedStyle>

                        <DisabledStyle Resize="None"></DisabledStyle>

                        <InvalidStyle Resize="None"></InvalidStyle>

                        <HoveredStyle Resize="None"></HoveredStyle>

                        <EnabledStyle Resize="None"></EnabledStyle>
                    </DateInput>

                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                </telerik:RadDatePicker>
                <asp:Label ID="Label2" runat="server" Style="color: #FF0000" Text="*"></asp:Label>
            </td>
            <td class="auto-style21">End Date</td>
            <td style="text-align: left; background-color: #FFFFFF;" class="auto-style26">
                <telerik:RadDatePicker ID="dpEndDate" runat="server" Culture="en-US" Skin="WebBlue" AutoPostBack="True" OnSelectedDateChanged="dpEndDate_SelectedDateChanged" Style="text-align: left; font-size: medium;">
                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="WebBlue"></Calendar>

                    <DateInput runat="server" DisplayDateFormat="d/M/yyyy" DateFormat="M/d/yyyy" LabelWidth="40%" AutoPostBack="True">
                        <EmptyMessageStyle Resize="None"></EmptyMessageStyle>

                        <ReadOnlyStyle Resize="None"></ReadOnlyStyle>

                        <FocusedStyle Resize="None"></FocusedStyle>

                        <DisabledStyle Resize="None"></DisabledStyle>

                        <InvalidStyle Resize="None"></InvalidStyle>

                        <HoveredStyle Resize="None"></HoveredStyle>

                        <EnabledStyle Resize="None"></EnabledStyle>
                    </DateInput>

                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                </telerik:RadDatePicker>
                <asp:Label ID="Label3" runat="server" Style="color: #FF0000; background-color: #FFFFFF" Text="*"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style22">Duration</td>
            <td class="auto-style15">
                <asp:TextBox ID="txtNoOfDays" runat="server" Style="text-align: left" Enabled="False" CssClass="auto-style23"></asp:TextBox>
            </td>
            <td class="auto-style21">Vacation Type</td>
            <td class="auto-style27">
                <asp:DropDownList ID="ddlVacationType" runat="server" AppendDataBoundItems="True" DataSourceID="VacationTypeDataSource" DataTextField="VacationTypeName" DataValueField="VacationTypeID" CssClass="auto-style23" OnSelectedIndexChanged="ddlVacationType_SelectedIndexChanged" AutoPostBack="true">
                    <asp:ListItem Selected="True" Value="0">Select</asp:ListItem>
                </asp:DropDownList>
                <asp:Label ID="Label1" runat="server" Style="color: #FF0000; font-size: medium" Text="*"></asp:Label>
                <asp:SqlDataSource ID="VacationTypeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT [VacationTypeID], [VacationTypeName] FROM [VacationTypes]"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="auto-style16">&nbsp;</td>
            <td class="auto-style15">&nbsp;</td>
            <td class="auto-style13" colspan="2">
                <asp:Button ID="btnDelete" runat="server" OnClick="btnDelete_Click" Text="Delete" Visible="False" CssClass="auto-style23" />
                <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" Visible="False" CssClass="auto-style23" />
                <asp:Button ID="btnSave" runat="server" CssClass="auto-style23" OnClick="Button1_Click" Text="Save" Height="28px" Width="85px" />
            </td>
        </tr>
        <tr>
            <td class="auto-style29"><span class="auto-style30">Please Note:</span><br class="auto-style30" />
                <br class="auto-style30" />
                <br class="auto-style30" />
            </td>
            <td class="auto-style15" colspan="3">
                <span class="auto-style28">- ECMS vacations are only applied after being approved by the normal vacation system as per Amoun policy.</span><br class="auto-style28" />
                <span class="auto-style28">- The vacations you submit on ECMS will take effect on your Covarage and Frequancy by the end of the Cycle</span></td>
        </tr>
    </table>


</asp:Content>
