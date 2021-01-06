<%@ Page Title="Cycle Closing" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="CycleClosing.aspx.cs" 
    Inherits="AmounCRM4.Admins.CycleClosing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <title>Cycle Closing</title>
    <style type="text/css">
        .dtpWidth
        {
            width:220px auto !important;
        }

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <div style="text-align: left; margin-left: 5px">
            <a href="#" style="color: red; text-decoration-line: underline; font-size: xx-large">Please, Take Care!</a>
            <br />
            <br />
        <div style="text-align: left; margin-left: 5px; font-size:x-large">
            <i>
                The Below Button Will Close The Current Cycle & Create a New One
                <br />
                Don't Use This Button Until Generating All Closing Reports & Exporting The Resulted Tables To External Excel Files
                <br />
                After Clicking This Button, You Will Find That The Cycle Label Below Your Name Will Indicate To The Next Cycle
            </i>
        </div>        
    </div>

    <p>
        <br /><br />
    </p>

    <div style="text-align: left; margin-left: 5px">
        <asp:Panel ID="pnl" GroupingText="New Cycle Data" runat="server" BorderWidth="2" BorderColor="DarkGray" BorderStyle="Inset">
            <table>
                <tr>
                    <td>Cycle Description</td>
                    <td><asp:TextBox ID="txtCycleDesc" runat="server" Text=""></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Year</td>
                    <td><asp:TextBox ID="txtYearID" runat="server" Text="<%# Eval(DateTime.Now.Year.ToString()) %>"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Quarter</td>
                    <td>
                        <asp:DropDownList ID="ddlQuarter" runat="server">
                            <asp:ListItem Selected="True" Text="Quarter" Value="0" />
                            <asp:ListItem Text="Q1" Value="1" />
                            <asp:ListItem Text="Q2" Value="2" />
                            <asp:ListItem Text="Q3" Value="3" />
                            <asp:ListItem Text="Q4" Value="4" />
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>Month</td>
                    <td>
                        <asp:DropDownList ID="ddlMonth" runat="server">
                            <asp:ListItem Selected="True" Text="Month" Value="0" />
                            <asp:ListItem Text="January" Value="1" />
                            <asp:ListItem Text="February" Value="2" />
                            <asp:ListItem Text="March" Value="3" />
                            <asp:ListItem Text="April" Value="4" />
                            <asp:ListItem Text="May" Value="5" />
                            <asp:ListItem Text="June" Value="6" />
                            <asp:ListItem Text="July" Value="7" />
                            <asp:ListItem Text="August" Value="8" />
                            <asp:ListItem Text="September" Value="9" />
                            <asp:ListItem Text="October" Value="10" />
                            <asp:ListItem Text="November" Value="11" />
                            <asp:ListItem Text="December" Value="12" />
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>Starting From</td>
                    <td>
                        <telerik:RadDateTimePicker ID="dtpFrom" runat="server" PopupDirection="BottomRight" CssClass="dtpWidth"
                            SelectedDate="<%# Eval(DateTime.Now.Date.ToShortDateString()) %>" 
                            MinDate="<%# Eval(DateTime.Now.Date.ToShortDateString()) %>">
                            <TimePopupButton Enabled="false" Visible="false" />
                            <Calendar ID="cld1" runat="server" CalendarCaption="Cycle Starting Date" CellAlign="Center" EnableMonthYearFastNavigation="true">
                                <FastNavigationSettings></FastNavigationSettings>
                            </Calendar>
                        </telerik:RadDateTimePicker>
                    </td>
                </tr>
                <tr>
                    <td>End of Cycle</td>
                    <td>
                        <telerik:RadDateTimePicker ID="dtpTo" runat="server" PopupDirection="BottomRight" CssClass="dtpWidth" 
                            SelectedDate="<%# Eval(DateTime.Now.Date.ToShortDateString()) %>"
                            MinDate="<%# Eval(DateTime.Now.Date.ToShortDateString()) %>">
                            <TimePopupButton Enabled="false" Visible="false" />
                            <Calendar ID="cld2" runat="server" CalendarCaption="Cycle Starting Date" CellAlign="Center" EnableMonthYearFastNavigation="true">
                                <FastNavigationSettings></FastNavigationSettings>
                            </Calendar>
                        </telerik:RadDateTimePicker>
                    </td>
                </tr>
                
            </table>
        </asp:Panel>
        <br />
        <asp:TextBox ID="txtResult" runat="server" Text="" Visible="false" Width="90%"></asp:TextBox>
        <br />
        <asp:Button ID="btnClosing" runat="server" Text="Closing Current Cycle & Openning New Cycle" OnClick="btnClosing_Click" />
    </div>

    <asp:SqlDataSource ID="dsCycleClosing" runat="server" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
        InsertCommand="INSERT INTO [Cycles] ([CycleDesc], [YearID], [QuarterID], [MonthID], [FromDate], [ToDate], [IsCurrent], [PlanningDays]) 
        VALUES (@CycleDesc, @YearID, @QuarterID, @MonthID, @FromDate, @ToDate, @IsCurrent, @PlanningDays)" 
        SelectCommand="SELECT CycleID, CycleDesc FROM [Cycles] Where CycleID = @CycleID" 
        UpdateCommand="UPDATE [Cycles] SET [IsCurrent] = 0 WHERE [CycleID] = @CycleIDFromAdmin">
        <SelectParameters>
            <asp:Parameter Name="CycleID" Type="Int16" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="CycleDesc" Type="String"></asp:Parameter>
            <asp:Parameter Name="YearID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="QuarterID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="MonthID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="FromDate" Type="DateTime"></asp:Parameter>
            <asp:Parameter Name="ToDate" Type="DateTime"></asp:Parameter>
            <asp:Parameter Name="IsCurrent" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="PlanningDays" Type="Int32"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:SessionParameter Name="CycleIDFromAdmin" Type="Int16" SessionField="CycleIDFromAdmin" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
