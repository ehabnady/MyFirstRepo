<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PhysicianForm.aspx.cs" MasterPageFile="~/Site1.Master" Inherits="AmounCRM4.Admins.PhysicianForm" %>

<asp:Content ContentPlaceHolderID="head" ID="head" runat="server">
    <title></title>
    <script type = "text/javascript">

        function KeyPressOrder(fld, e) {

            var strCheck = 'ضصثقفغعهخحجدذشسيبلاتنمكطئءؤرلاىةوزظ1234567890-)( ';
            var whichCode = e.which ? e.which : e.keyCode;

            if (whichCode == 13 || whichCode == 8 || whichCode == 9) return true;
            key = String.fromCharCode(whichCode);
            if (strCheck.indexOf(key) == -1)
                return false;

            return true;
        }

        function Confirm() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Do you want to delete this request?")) {
                confirm_value.value = "Yes";
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }
    </script>
<style type="text/css">
        .auto-style25 {
        text-align: center;
    }
    .newStyle1 {
        table-layout: fixed;
    }
    .auto-style59 {
        width: 72px;
        background-color: #99CCFF;
    }
    .newStyle2 {
        table-layout: fixed;
    }
    .auto-style60 {
        table-layout: fixed;
        width: 215px;
        background-color: #99CCFF;
    }
    .auto-style61 {
        width: 128px;
        background-color: #99CCFF;
    }
    .newStyle3 {
        table-layout: fixed;
    }
    .auto-style62 {
        width: 153px;
        background-color: #99CCFF;
    }
    .auto-style64 {
        height: 23px;
    }
    .auto-style65 {
        width: 149px;
    }
    .auto-style66 {
        width: 114px;
    }
    .auto-style67 {
        width: 132px;
    }
    .auto-style68 {
        width: 165px;
    }
    .newStyle4 {
        table-layout: fixed;
    }
    .auto-style82 {
        text-align: center;
        color: #800000;
        font-size: xx-large;
        text-decoration: underline;
    }
    </style>
</asp:Content>

<asp:Content ContentPlaceHolderID="Body" ID="body" runat="server">
    <div class="auto-style25">
    
        <div class="auto-style82">
            <strong>Physicians</strong></div>
        </div>
        <table class="newStyle3">
            <tr>
                <td class="auto-style61">
    
        <strong>Search</strong></td>
                <td class="auto-style62"> 
        <asp:SqlDataSource ID="SpecialtySource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
    SelectCommand="SELECT SpecialityID, SpecialityCode FROM Specialities WHERE (Deleted IS NULL) ORDER BY SpecialityCode" OnSelecting="AreaDataSource_Selecting"></asp:SqlDataSource>
                </td>
                <td class="auto-style59">&nbsp;</td>
                <td class="auto-style60">
                <asp:Button ID="btnUpdateAll" runat="server" OnClick="btnUpdateAll_Click" Text="Proceed all updates" Width="168px" Visible="False" />
                </td>
            </tr>
            <tr>
                <td class="auto-style61">Physician Name </td>
                <td class="auto-style62"> 
        <asp:TextBox ID="txtPhysicianNameSe" runat="server" Width="127px" MaxLength="50"></asp:TextBox>
                </td>
                <td class="auto-style59">Specialty </td>
                <td class="auto-style60">
        <asp:DropDownList ID="ddlAreaSe" runat="server" OnSelectedIndexChanged="ddlAreaSe_SelectedIndexChanged1" DataSourceID="SpecialtySource" 
            DataTextField="SpecialityCode" DataValueField="SpecialityID" Height="16px" Width="127px" >
            <asp:ListItem Text="Select" Value="0"></asp:ListItem>
        </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="auto-style61">Code</td>
                <td class="auto-style62"> 
                    <asp:TextBox ID="txtPhyCodeSe" runat="server"></asp:TextBox>
                </td>
                <td class="auto-style59">&nbsp;</td>
                <td class="auto-style60">
        <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search" />
                    <asp:Button ID="btnSearchTemp" runat="server" OnClick="btnSearchTemp_Click" Text="Search Temp" />
                </td>
            </tr>
    </table>
    <br />
    <div style="width: 100%; height: 250px; overflow: auto">
    <asp:GridView ID="GridView1" runat="server" OnRowCreated="GridView1_RowCreated" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" CellPadding="4" ForeColor="#333333" GridLines="None">
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
        </div >
                <br />
                <br />
    <table class="newStyle4">
        <tr>
            <td class="auto-style67">&nbsp;</td>
            <td class="auto-style65"> &nbsp;</td>
            <td class="auto-style66">&nbsp;</td>
            <td class="auto-style68">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style67">Physician Name</td>
            <td class="auto-style65"> <asp:TextBox ID="txtPhysicianName" runat="server" Width="127px" MaxLength="50" onselectstart="return false" ondragstart="return false" onkeypress="return(KeyPressOrder(this,event))" onkeydown="(KeyPressOrder(this,event))"></asp:TextBox>
            <asp:Label ID="lblPhReq" runat="server" Text="*" ForeColor="Red" Visible="false"></asp:Label>
            <asp:TextBox ID="txtphysicianID" runat="server" Visible="False" Width="127px" MaxLength="6"></asp:TextBox>
                </td>
            <td class="auto-style66">Mobile Number </td>
            <td class="auto-style68">
            <asp:TextBox ID="txtMobileNumber" runat="server" Width="127px" MaxLength="12"></asp:TextBox>
                </td>
        </tr>
        <tr>
            <td class="auto-style67">Tel Number </td>
            <td class="auto-style65"> <asp:TextBox ID="txtTelNumber" runat="server" Width="127px"></asp:TextBox>
                </td>
            <td class="auto-style66">Email Address </td>
            <td class="auto-style68">
            <asp:TextBox ID="txtPhysicianEmailAddress" runat="server" Width="127px" MaxLength="100"></asp:TextBox>
                </td>
        </tr>
        <tr>
            <td class="auto-style67">Specialty</td>
            <td class="auto-style65">
            <asp:DropDownList ID="ddlAreaId" runat="server" DataSourceID="SpecialtySource" 
                DataTextField="SpecialityCode" DataValueField="SpecialityID" 
                OnSelectedIndexChanged="ddlAreaId_SelectedIndexChanged" Width="127px" >
            <asp:ListItem Text="Select" Value="0"></asp:ListItem>
            </asp:DropDownList>

            

                    <asp:Label ID="lblAreaReq" runat="server" Text="*" ForeColor="Red" Visible="False"></asp:Label>
                </td>
            <td class="auto-style66">Birthdate</td>
            <td class="auto-style68">
                <telerik:RadDatePicker ID="dpBrithDate" Runat="server" FocusedDate="1920-01-01" MinDate="1920-01-01">
                </telerik:RadDatePicker>
            </td>
        </tr>
        <tr>
            <td class="auto-style67">
                &nbsp;</td>
            <td class="auto-style65">&nbsp;</td>
            <td class="auto-style66">
               
            </td>
            <td class="auto-style68">
            <asp:Button ID="btnPhysicianSave" runat="server" OnClick="btnPhysicianSave_Click" Text="Save" />
                    <asp:Button ID="btnPhysicianUpdate" runat="server" Text="Update" OnClick="btnPhysicianUpdate_Click" />
                </td>
        </tr>
        <tr>
            <td class="auto-style64" colspan="4">
            <asp:Label ID="lblSaveStatus" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>