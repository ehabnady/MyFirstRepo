<%@ Page Title="Plan Adjustment" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="PlanAdjustment.aspx.cs" Inherits="AmounCRM4.Admins.PlanAdjustment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <script language="javascript" type="text/javascript">
        function jsCalc()
        {
            var num1 = document.getElementById('<%=txtCurrentPlan.ClientID  %>').value;
            var num2 = document.getElementById('<%=txtOriginalPlan.ClientID  %>').value;
            
            if (!isNaN(num1) && !isNaN(num2)) {
                document.getElementById('<%= txtForDel.ClientID %>').value = parseInt(num1) - parseInt(num2);
            }
            else {
                alert('Please write a valid number');

                if (isNaN(num1)) {
                    document.getElementById('<%=txtCurrentPlan.ClientID  %>').focus();
                }
                if (isNaN(num2)) {
                document.getElementById('<%=txtOriginalPlan.ClientID  %>').focus();
                }
            }
        }
    </script>

    <style type="text/css">
        .auto-style2 {
            height: 61px;
        }
        .auto-style3 {
            height: 45px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <br />
    <table rules="all" width="438px" id="tbl" frame="border" title="Adjust Area Plan">
        <tr>
            <td align="right" class="auto-style3">
                <asp:Label ID="lbl1" runat="server" Text="Rep Area: "></asp:Label>
            </td>
            <td align="right" class="auto-style3">
                <asp:DropDownList ID="ddlArea" runat="server" DataSourceID="dsAreas" DataTextField="NewAreaName" DataValueField="AmounTerritoryID"
                    OnSelectedIndexChanged="ddlArea_SelectedIndexChanged" AutoPostBack="true" ViewStateMode="Enabled"></asp:DropDownList>
            </td>
        </tr>

        <tr>
            <td align="right" class="auto-style3">
                <asp:Label ID="lbl2" runat="server" Text="Current Plan Count: "></asp:Label>
            </td>
            <td align="right" class="auto-style3">
                <asp:TextBox ID="txtCurrentPlan" runat="server" Text='<%# Eval("MyCount") %>' ReadOnly="true"></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td align="right" class="auto-style3">
                <asp:Label ID="lbl3" runat="server" Text="Original Plan Count: "></asp:Label>
            </td>
            <td align="right" class="auto-style3">
                <asp:TextBox ID="txtOriginalPlan" runat="server" Text="0" onblur="jsCalc();" MaxLength="3"></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td align="right" class="auto-style3">
                <asp:Label ID="lbl4" runat="server" Text="To-Be-Deleted Appointments: "></asp:Label>
            </td>
            <td align="right" class="auto-style3">
                <asp:TextBox ID="txtForDel" runat="server" Text="0" ReadOnly="true" MaxLength="3"></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td colspan="2" align="center" class="auto-style2" valign="bottom">
                <asp:Button ID="btnDelete" runat="server" Text="Delete Appointments" OnClick="btnDelete_Click" />
            </td>
        </tr>
    </table>
    <p>
        <asp:SqlDataSource ID="dsAreas" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
            SelectCommand="SELECT DISTINCT NewAreaName, AmounTerritoryID, NewLineID FROM View_AreaHier WHERE (NewLineID IN (1,2,3,4,5,6,7,13)) ORDER BY NewLineID, NewAreaName">
        </asp:SqlDataSource>
    </p>
    <p>            
        <asp:SqlDataSource ID="dsAppsCount" runat="server"
            ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
            SelectCommand="SELECT COUNT(*) AS MyCount FROM Appointments WHERE (DeletedAppointment = 'false' or DeletedAppointment is null) and (AreaRecID = @AreaRecID) AND (CycleID = @CycleID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlArea" DefaultValue="1" Name="AreaRecID" PropertyName="SelectedValue" />
                <asp:SessionParameter SessionField="CycleIDFromAdmin" Name="CycleID" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="dsAppsUpdate" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
            SelectCommand="Select AppointmentID From Appointments WHERE (DeletedAppointment = 'false' or DeletedAppointment is null) and CycleID = @CycleID AND AreaRecID = @AreaRecID AND Annotations = 'Appointment'"
            UpdateCommand="UPDATE Appointments Set DeletedAppointment = 1, [Description] = 'Extra Visits Deletion' WHERE AppointmentID = @AppointmentID">
            <UpdateParameters>
                <asp:Parameter DefaultValue="0" Name="AppointmentID" />
            </UpdateParameters>
            <SelectParameters>
                <asp:ControlParameter Name="AreaRecID" ControlID="ddlArea" PropertyName="SelectedValue" />
                <asp:SessionParameter Name="CycleID" SessionField="CycleIDFromAdmin" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>
