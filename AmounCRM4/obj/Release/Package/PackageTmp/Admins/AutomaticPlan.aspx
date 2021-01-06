<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" 
    CodeBehind="AutomaticPlan.aspx.cs" Inherits="AmounCRM4.Admins.AutomaticPlan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title></title>
    <style type="text/css">
        .auto-style10
        {
            width: 235px;
        }
    </style>

    <script language="javascript" type="text/javascript">
        function jsCalc()
        {
            var num1 = document.getElementById('<%=txtNoOfDays.ClientID  %>').value;
            var num2 = document.getElementById('<%=txtNoOfVisitsPerDay.ClientID  %>').value;
            
            if (!isNaN(num1) && !isNaN(num2)) {
                document.getElementById('<%= txtTotalNoOfVisits.ClientID %>').value = parseInt(num1) * parseInt(num2);
            }
            else {
                alert('Please write a valid number');

                if (isNaN(num1)) {
                    document.getElementById('<%=txtNoOfDays.ClientID  %>').focus();
                }
                if (isNaN(num2)) {
                document.getElementById('<%=txtNoOfVisitsPerDay.ClientID  %>').focus();
                }
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">
    </telerik:RadStyleSheetManager>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    
    <table border="1" style="align-content:center; text-align:center">
        <tr align="left">
            <td class="auto-style10" bgcolor="#99CCFF">
                Cycle:
            </td>
            <td colspan="3" bgcolor="#99CCFF">
                <telerik:RadComboBox ID="cbCycles" runat="server" DataTextField="CycleDesc" EnableViewState="true"
                    DataValueField="CycleID" DataSourceID="CyclesDS" Skin="Web20" Width="551px" ViewStateMode="Enabled"
                    EnableLoadOnDemand="true" MarkFirstMatch="true" OnItemDataBound="cbCycles_ItemDataBound" 
                    EnableAriaSupport="true" EnableAutomaticLoadOnDemand="true" HighlightTemplatedItems="true">
                    <HeaderTemplate>
                        <table><tr>
                            <td style="margin:0;padding:0 5px 0 0;width:50px;line-height:15px;float:left">ID</td>
                            <td style="margin:0;padding:0 5px 0 0;width:100px;line-height:15px;float:left">Name</td>
                            <td style="margin:0;padding:0 5px 0 0;width:100px;line-height:15px;float:left">From</td>
                            <td style="margin:0;padding:0 5px 0 0;width:100px;line-height:15px;float:left">To</td>
                        </tr></table>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <table><tr>
                            <td style="margin:0;padding:0 5px 0 0;width:50px;line-height:15px;float:left">
                                <%# DataBinder.Eval(Container.DataItem, "CycleID") %>
                            </td>
                            <td style="margin:0;padding:0 5px 0 0;width:100px;line-height:15px;float:left">
                                <%# DataBinder.Eval(Container.DataItem, "CycleDesc") %>
                            </td>
                            <td style="margin:0;padding:0 5px 0 0;width:100px;line-height:15px;float:left">
                                <%# DateTime.Parse((DataBinder.Eval(Container.DataItem, "FromDate")).ToString()).ToShortDateString() %>
                            </td>
                            <td style="margin:0;padding:0 5px 0 0;width:100px;line-height:15px;float:left">
                                <%# DateTime.Parse((DataBinder.Eval(Container.DataItem, "ToDate")).ToString()).ToShortDateString() %>
                            </td>
                        </tr></table>
                    </ItemTemplate>
                </telerik:RadComboBox>
            </td>

            <td bgcolor="#99CCFF">
                First Day:
            </td>
            <td bgcolor="#99CCFF">
                <asp:Calendar ID="calFirstDay" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" 
                    CellPadding="1" FirstDayOfWeek="Saturday" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" 
                    Height="200px" Width="280px" ShowGridLines="True">
                    <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                    <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                    <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                    <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                    <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                    <WeekendDayStyle BackColor="#CCCCFF" />
                </asp:Calendar>
            </td>
        </tr>

        <tr align="left">
            <td class="auto-style10" bgcolor="#99CCFF"><asp:Label ID="l11" runat="server" Text="Line:"></asp:Label></td>
            <td colspan="5" bgcolor="#99CCFF">
                <asp:CheckBox ID="chkCheckAll" runat="server" Text="Check All Lines" Checked="false" 
                    OnCheckedChanged="chkCheckAll_CheckedChanged" AutoPostBack="true" />
                <br />
                <asp:CheckBoxList ID="chklLines" runat="server" DataSourceID="LinesDS" RepeatColumns="4"
                    Width="525px" DataTextField="LineName" DataValueField="LineID"></asp:CheckBoxList>
                <asp:Button ID="btnGetAreas" runat="server" OnClick="btnGetAreas_Click" Text="Get Areas and Employees" Visible="false" />
            </td>
        </tr>

        <tr align="left">
            <td class="auto-style10" bgcolor="#99CCFF"><asp:Label ID="Label4" runat="server" Text="Region:"></asp:Label></td>
            <td colspan="5" bgcolor="#99CCFF">
                <asp:CheckBox ID="chkRegionsAll" runat="server" Text="Check All Regions" Checked="false" 
                    OnCheckedChanged="chkRegionsAll_CheckedChanged" AutoPostBack="true" />
                <br />
                <asp:CheckBoxList ID="chklRegions" runat="server" DataSourceID="RegionsDS" RepeatColumns="4"
                    DataTextField="RegionName" DataValueField="RegionID"></asp:CheckBoxList>
                <asp:Button ID="btnGetSupervisors" runat="server" OnClick="btnGetSupervisors_Click" Text="Get District Managers" />
            </td>
        </tr>

        <tr align="left">
            <td class="auto-style10" bgcolor="#99CCFF"><asp:Label ID="Label6" runat="server" Text="District Managers:"></asp:Label></td>
            <td colspan="5" bgcolor="#99CCFF">
                <asp:CheckBox ID="chkSupervisorsAll" runat="server" Text="Check All District Managers" Checked="false" 
                    OnCheckedChanged="chkSupervisorsAll_CheckedChanged" AutoPostBack="true" />
                <br />
                <asp:CheckBoxList ID="chklSupervisors" runat="server" RepeatColumns="3"></asp:CheckBoxList>
                <asp:Button ID="btnGetEmployees" OnClick="btnGetEmployees_Click" runat="server" Text="Get Medical Reps" />
            </td>
        </tr>

        <tr align="left">
            <td class="auto-style10" bgcolor="#99CCFF"><asp:Label ID="Label5" runat="server" Text="Medical Reps:"></asp:Label></td>
            <td colspan="5" bgcolor="#99CCFF">
                <asp:CheckBox ID="chkEmployeesAll" runat="server" Text="Check All Medical Reps" Checked="false" 
                    OnCheckedChanged="chkEmployeesAll_CheckedChanged" AutoPostBack="true" />
                <br />
                <asp:CheckBoxList ID="chklEmployees" runat="server" RepeatColumns="3"></asp:CheckBoxList>
            </td>
        </tr>

        <tr align="left" style="visibility:hidden">
            <td class="auto-style10" bgcolor="#99CCFF">Area:</td>
            <td colspan="5" bgcolor="#99CCFF">
                <asp:CheckBox ID="chkCheckAllAreas" runat="server" Text="Check All" Checked="false" 
                    OnCheckedChanged="chkCheckAllAreas_CheckedChanged" AutoPostBack="true" />
                <br />
                <asp:CheckBoxList ID="chklAreas" runat="server" RepeatColumns="4" Width="525px"></asp:CheckBoxList>
                <!-- DataSourceID="AreasDS" DataTextField="AmounTerritoryName" DataValueField="RecID"-->
            </td>
        </tr>

        <tr align="left">
            <td class="auto-style10" bgcolor="#99CCFF">
                <asp:Label ID="Label1" runat="server" Text="No. Of Days:"></asp:Label>
            </td>
            <td bgcolor="#99CCFF"><asp:TextBox ID="txtNoOfDays" runat="server" Width="60px" Text="0" onblur="jsCalc();" MaxLength="2"></asp:TextBox></td>
            <td class="auto-style10" bgcolor="#99CCFF">
                <asp:Label ID="Label2" runat="server" Text="No. Of Visits Per Day:"></asp:Label>
            </td>
            <td bgcolor="#99CCFF"><asp:TextBox ID="txtNoOfVisitsPerDay" runat="server" Width="60px" Text="0" onblur="jsCalc();" MaxLength="2"></asp:TextBox></td>
            <td bgcolor="#99CCFF">
                <asp:Label ID="Label3" runat="server" Text="Total No. Of Visits:"></asp:Label>
            </td>
            <td bgcolor="#99CCFF"><asp:TextBox ID="txtTotalNoOfVisits" runat="server" Width="60px" ReadOnly="True" Enabled="False"></asp:TextBox></td>
        </tr>
        <tr align="left">
            <td class="auto-style10" bgcolor="#99CCFF">No. Of Visits For Class "A":</td>
            <td bgcolor="#99CCFF">
                <asp:TextBox ID="txtClassA" runat="server" Width="60px" Text="2" MaxLength="1" Enabled="false"></asp:TextBox></td>
            <td class="auto-style10" bgcolor="#99CCFF">No. Of Visits For Class "B":</td>
            <td bgcolor="#99CCFF">
                <asp:TextBox ID="txtClassB" runat="server" Width="60px" Text="1" MaxLength="1" Enabled="false"></asp:TextBox>
            </td>
            <td bgcolor="#99CCFF">No. Of Visits For Class "C":</td>
            <td bgcolor="#99CCFF">
                <asp:TextBox ID="txtClassC" runat="server" Width="60px" Text="0" MaxLength="1" Enabled="false"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="6">
                <asp:Button ID="btnAutoPlan" runat="server" Text="Generate Automatic Plan" OnClick="btnAutoPlan_Click" />
            </td>
        </tr>
    </table>

    <asp:SqlDataSource ID="CyclesDS" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
        SelectCommand="SELECT [CycleID], [CycleDesc], [FromDate], [ToDate] FROM [Cycles] WHERE YearID >= 2017">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="LinesDS" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
        SelectCommand="SELECT [LineID], [LineName] FROM [PromotionalLines] Where Deleted IS NULL">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="AreasDS" runat="server"
        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
        SelectCommand="SELECT DISTINCT RepAreaName, RepAreaID FROM View_AreaHierarchy ORDER BY RepAreaName, RepAreaID">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="RegionsDS" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
        SelectCommand="SELECT Distinct RegionID, RegionName FROM [AreaHierarchy] WHERE RegionID > 0">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SupervisorsDS" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
        SelectCommand="SELECT Distinct DirectManagerID, DirectManagerName FROM [View_EmployeesBricks] WHERE EmployeeID > 0">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="EmployeesDS" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
        SelectCommand="SELECT Distinct EmployeeID, EmployeeFullName FROM [View_EmployeesBricks] WHERE EmployeeID > 0">
    </asp:SqlDataSource>

    <div>
        <asp:TextBox ID="FailureText" runat="server" TextMode="MultiLine" Width="325px"></asp:TextBox>
    </div>
</asp:Content>
