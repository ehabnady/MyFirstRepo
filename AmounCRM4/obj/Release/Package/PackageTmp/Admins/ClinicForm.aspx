<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClinicForm.aspx.cs" MasterPageFile="~/Site1.Master" Inherits="AmounCRM4.Admins.ClinicForm" %>

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

        .auto-style6 {
            width: 582px;
            table-layout: fixed;
            height: 228px;
        }
        .auto-style10 {
            width: 142px;
        }
        .auto-style11 {
            width: 119px;
        }
        .auto-style12 {
            width: 161px;
        }
        .auto-style13 {
            width: 162px;
        }
        .newStyle1 {
            table-layout: fixed;
        }
        .auto-style16 {
            width: 84px;
            height: 2px;
        }
        .auto-style17 {
            height: 23px;
            width: 84px;
        }
        .auto-style18 {
            width: 145px;
            height: 2px;
        }
        .auto-style19 {
            height: 23px;
            width: 145px;
        }
        .newStyle2 {
            table-layout: fixed;
        }
        .auto-style21 {
            table-layout: fixed;
            width: 150px;
            height: 2px;
        }
        .newStyle3 {
            table-layout: fixed;
        }
        .auto-style23 {
            width: 97px;
            height: 2px;
        }
        .auto-style24 {
            height: 23px;
            width: 97px;
        }
        .auto-style25 {
            table-layout: fixed;
            width: 150px;
            height: 23px;
        }
        .auto-style26 {
            width: 84px;
            height: 27px;
            background-color: #99CCFF;
        }
        .auto-style27 {
            width: 145px;
            height: 27px;
            background-color: #99CCFF;
        }
        .auto-style28 {
            width: 97px;
            height: 27px;
            background-color: #99CCFF;
        }
        .auto-style29 {
            table-layout: fixed;
            width: 150px;
            height: 27px;
        }
        .newStyle4 {
            table-layout: fixed;
            background-color: #99CCFF;
        }
        .auto-style81 {
            color: #800000;
            font-size: xx-large;
            text-decoration: underline;
        }
        </style>
</asp:Content>

<asp:Content ContentPlaceHolderID="Body" ID="Body" runat="server">
    <div>
        <span class="auto-style81"><strong>Clinics</strong></span><br />
        <table class="newStyle4">
            <tr>
                <td class="auto-style26">
        <strong style="text-align: left">Search</strong></td>
                <td class="auto-style27">
                <asp:SqlDataSource ID="EntityTypeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
            SelectCommand="SELECT * FROM [EntityTypes] ">
        </asp:SqlDataSource>
                </td>
                <td class="auto-style28"></td>
                <td class="auto-style29">
                    <asp:Button ID="btnAllUpdates" runat="server" OnClick="btnAllUpdates_Click" Text="Proceed all Updates" Width="137px" Visible="False" />
                </td>
            </tr>
            <tr>
                <td class="auto-style16">Clinic Name</td>
                <td class="auto-style18">
                    <asp:TextBox ID="txtEntityNameSe" runat="server" Width="127px" MaxLength="50"></asp:TextBox>
                </td>
                <td class="auto-style23">Clinic Type</td>
                <td class="auto-style21">
                    <asp:DropDownList ID="ddlEntityType" runat="server" OnSelectedIndexChanged="ddlAreaSe_SelectedIndexChanged1" 
                        DataSourceID="EntityTypeDataSource" DataTextField="EntityTypeName" DataValueField="EntityTypeID" Width="127px">
                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                    </asp:DropDownList>


                </td>
            </tr>
            <tr>
                <td class="auto-style17">Clinic Code</td>
                <td class="auto-style19">
                    <asp:TextBox ID="txtEntityCodeSe" runat="server" MaxLength="6"></asp:TextBox>
                </td>
                <td class="auto-style24"></td>
                <td class="auto-style25">
                    <asp:Button ID="btnEntitySearch" runat="server" OnClick="btnEntitySearch_Click" Text="Search" />
                    <asp:Button ID="btnSearchTemp" runat="server" OnClick="Button1_Click" Text="Search Temp" />
                </td>
            </tr>
        </table>
    </div>
    <br />
    <div style="width: 100%; height: 250px; overflow: auto">
    <asp:GridView ID="GridViewClinic" runat="server"  OnSelectedIndexChanged="GridViewClinic_SelectedIndexChanged" CellPadding="4" 
        ForeColor="#333333" GridLines="None" OnRowCreated="GridViewClinic_RowCreated">
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
        </div>
    <br />
    <p>
    <table class="auto-style6">
        <tr>
            <td class="auto-style11">Clinic Name </td>
            <td class="auto-style10">
                <asp:TextBox ID="txtEntityName" runat="server" Width="127px" MaxLength="50" onselectstart="return false" ondragstart="return false" onkeypress="return(KeyPressOrder(this,event))" onkeydown="(KeyPressOrder(this,event))"></asp:TextBox>
                <asp:TextBox ID="txtEntityID" runat="server" Visible="False" Width="35px"></asp:TextBox>
                <asp:Label ID="lblNameReq" runat="server" Text="*" ForeColor="Red" Visible="False"></asp:Label>
            </td>
            <td class="auto-style12">Clinic Code </td>
            <td class="auto-style13">
                <asp:TextBox ID="txtEntityCode" runat="server" Width="127px" MaxLength="6" Enabled="False"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style11">Clinic Address </td>
            <td class="auto-style10">
                <asp:TextBox ID="txtEntityAddress" runat="server" Width="124px" MaxLength="100" onselectstart="return false" ondragstart="return false" onkeypress="return(KeyPressOrder(this,event))" onkeydown="(KeyPressOrder(this,event))"></asp:TextBox>
            </td>
            <td class="auto-style12">Clinic Type </td>
            <td class="auto-style13">


                <asp:DropDownList ID="ddlEntityTypeID" runat="server" OnSelectedIndexChanged="ddlAreaSe_SelectedIndexChanged1" 
                    DataSourceID="EntityTypeDataSource" DataTextField="EntityTypeName" DataValueField="EntityTypeID" Width="127px">
                    <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                </asp:DropDownList>
                <asp:Label ID="lbltypeReq" runat="server" Text="*" ForeColor="Red" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style11">Tel 1 </td>
            <td class="auto-style10">
                <asp:TextBox ID="txtTel1" runat="server" Width="127px" MaxLength="12"></asp:TextBox>
            </td>
            <td class="auto-style12">Tel 2 </td>
            <td class="auto-style13">
                <asp:TextBox ID="txtTel2" runat="server" Width="127px" MaxLength="12"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style11">Tel 3 </td>
            <td class="auto-style10">
                <asp:TextBox ID="txtTel3" runat="server" Width="127px" MaxLength="12"></asp:TextBox>
            </td>
            <td class="auto-style12">Fax </td>
            <td class="auto-style13">
                <asp:TextBox ID="txtFax" runat="server" Width="127px" MaxLength="12"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style11">Email Address </td>
            <td class="auto-style10">
                <asp:TextBox ID="txtEntityEmailAddress" runat="server" Width="127px" MaxLength="100"></asp:TextBox>
            </td>
            <td class="auto-style12">Web Site </td>
            <td class="auto-style13">
                <asp:TextBox ID="txtEntityWebSite" runat="server" Width="127px" MaxLength="100"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style11">Brick </td>
            <td class="auto-style10">
                <asp:DropDownList ID="ddlAreaID" runat="server" DataSourceID="AreaDataSource" DataTextField="AmounBrickName" 
                    DataValueField="AmounBrickID" OnSelectedIndexChanged="ddlAreaID_SelectedIndexChanged" Width="127px" AutoPostBack="True">
                    <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                </asp:DropDownList>



                <asp:Label ID="lblAreaReq" runat="server" Text="*" ForeColor="Red" Visible="False"></asp:Label>



            </td>
            <td class="auto-style12">
                <asp:TextBox ID="txtBrickID" runat="server" Enabled="False"></asp:TextBox>
            </td>
            <td class="auto-style13">
                <asp:Button ID="btnClinicSave" runat="server" OnClick="btnClinicSave_Click" Text="Save" />
                <asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" Text="Update" Visible="False" />
            </td>
        </tr>
    </table>
        &nbsp;
        <asp:SqlDataSource ID="AreaDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
            SelectCommand="SELECT [AmounBrickName], [AmounBrickID] FROM [AreaHierarchy] WHERE ([Deleted] IS NULL) ORDER BY [AmounBrickName]"></asp:SqlDataSource>
    </p>
    <p>
        &nbsp;</p>
    <p>
        <asp:Label ID="ClinclblSaveStatus" runat="server"></asp:Label>
    </p>
    <p>
        &nbsp;
    </p>
</asp:Content>
