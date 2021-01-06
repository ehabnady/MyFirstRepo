<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="EmployeesForm.aspx.cs" Inherits="AmounCRM4.Admins.EmployeesForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .auto-style2 {
             width: 605px;
            height: 34px;
            text-align: right;
            font-weight: 700;
            font-size: small;
            background-color: #5D7B9D;
        }
        .auto-style10 {
            height: 27px;
            width: 127px;
        }
        .auto-style12 {
            height: 27px;
            width: 289px;
        }
        .auto-style11 {
            background-color: #FFFFFF;
            width: 127px;
        }
        .auto-style13 {
            background-color: #FFFFFF;
            width: 289px;
        }
        .auto-style14 {
            background-color: #FFFFFF;
            width: 102px;
            text-align: left;
        }
        .auto-style17 {
            background-color: #FFFFFF;
            width: 289px;
            text-align: left;
        }
        .auto-style21 {
            width: 670px;
            height: 34px;
            text-align: right;
            font-weight: 700;
            font-size: small;
            background-color: #5D7B9D;
        }
        .auto-style22 {
            height: 27px;
            width: 134px;
        }
        .auto-style23 {
            background-color: #FFFFFF;
            width: 134px;
        }
        .auto-style24 {
            height: 27px;
            width: 102px;
        }
        .auto-style25 {
            background-color: #FFFFFF;
            width: 102px;
        }
        .auto-style26 {
            background-color: #FFFFFF;
        }
        .auto-style27 {
            background-color: #FFFFFF;
            
        }
        .auto-style28 {
            background-color: #FFFFFF;
        }
        .auto-style29 {
            background-color: #FFFFFF;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <br />
    <table class="auto-style2">
        <tr>
            <td>Search</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class= "auto-style11"> Code</td>
            <td class= "auto-style11"> 
                <asp:TextBox ID="txtCodeSe" runat="server"></asp:TextBox>
            </td>
           <td class= "auto-style11"> Name</td>
           <td class= "auto-style11"> 
               <asp:TextBox ID="txtNameSe" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class= "auto-style11"> </td>
            <td class= "auto-style11"> </td>
            <td class= "auto-style11"> </td>
            <td class= "auto-style11"> 
                <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search" />
            </td>
        </tr>
    </table>
    <br />
    <asp:GridView ID="gvEmployee" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" OnRowCreated="gvEmployee_RowCreated" OnSelectedIndexChanged="gvEmployee_SelectedIndexChanged">
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
    <br />
    <table class="auto-style21">
        <tr>
            <td class="auto-style10">
                <asp:Image ID="Image1" runat="server" Height="122px" Width="109px" />
            </td>
            <td class="auto-style24"></td>
            <td class="auto-style22">&nbsp;</td>
            <td class="auto-style12">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style11">HR Code</td>
            <td class="auto-style25">
                <asp:TextBox ID="txtHRCode" runat="server"></asp:TextBox>
            </td>
            <td class="auto-style23">Full Name</td>
            <td class="auto-style17">
                <asp:TextBox ID="txtName" runat="server" Width="201px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style11">Position</td>
            <td class="auto-style25">
                <asp:DropDownList ID="ddlPosition" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlPosition_SelectedIndexChanged">
                    <asp:ListItem>Select</asp:ListItem>
                    <asp:ListItem Value="DM">District Manager</asp:ListItem>
                    <asp:ListItem Value="Rep">Medical Representative</asp:ListItem>
                    <asp:ListItem Value="Sales Manager">Sales Manager</asp:ListItem>
                    <asp:ListItem Value="Sales Director">Sales Director</asp:ListItem>
                    <asp:ListItem Value="Commercial Director">Commercial Director</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="auto-style23">Line</td>
            <td class="auto-style17">
                <asp:DropDownList ID="ddlLine" runat="server" DataSourceID="LineDataSource" DataTextField="LineName" DataValueField="LineID" AppendDataBoundItems="True">
                    <asp:ListItem Value="0">Select</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="LineDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT [LineID], [LineName] FROM [PromotionalLines] WHERE ([Deleted] IS NULL)"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="auto-style26">Area </td>
            <td class="auto-style27">
                <asp:DropDownList ID="ddlAreaForRep" runat="server" DataSourceID="RepAreaDataSource" DataTextField="RepAreaName" 
                    DataValueField="RepAreaID" Visible="False" AppendDataBoundItems="True" AutoPostBack="true">
                    <asp:ListItem Value="0">Select</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="RepAreaDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT DISTINCT [RepAreaID], [RepAreaName] FROM [AreaHierarchy] WHERE ([Deleted] IS NULL)"></asp:SqlDataSource>
                <asp:DropDownList ID="ddlAreaForDM" runat="server" DataSourceID="DMAreaDataSource" DataTextField="SupervisionAreaName" DataValueField="SupervisionAreaID" Visible="False" AppendDataBoundItems="True">
                    <asp:ListItem Value="0">Select</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="DMAreaDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT DISTINCT [SupervisionAreaID], [SupervisionAreaName] FROM [AreaHierarchy] WHERE ([Deleted] IS NULL)"></asp:SqlDataSource>
                <asp:DropDownList ID="ddlAreaForMan" runat="server" DataSourceID="ManAreaDataSource" DataTextField="RegionName" DataValueField="RegionID" Visible="False" AppendDataBoundItems="True">
                    <asp:ListItem Value="0">Select</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="ManAreaDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT DISTINCT [RegionID], [RegionName] FROM [AreaHierarchy] WHERE ([Deleted] IS NULL)"></asp:SqlDataSource>
            </td>
            <td class="auto-style28">Report to</td>
            <td class="auto-style29">
                <asp:DropDownList ID="ddlDMNames" runat="server" DataSourceID="DMDataSource" DataTextField="EmployeeFullName" DataValueField="EmployeeID" Visible="False" AppendDataBoundItems="True">
                    <asp:ListItem Value="0">Select</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="DMDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT DISTINCT [EmployeeFullName], [EmployeeID] FROM [View_Employees] WHERE (([DeletedEmployee] IS NULL OR [DeletedEmployee] = 0) AND ([EmployeeType] = @EmployeeType))">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="DM" Name="EmployeeType" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:DropDownList ID="ddlManNames" runat="server" DataSourceID="MANDataSource" DataTextField="EmployeeFullName" DataValueField="EmployeeID" Visible="False" AppendDataBoundItems="True">
                    <asp:ListItem Value="0">Select</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="MANDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT DISTINCT [EmployeeFullName], [EmployeeID] FROM [View_Employees] WHERE (([DeletedEmployee] IS NULL OR [DeletedEmployee] = 0) AND ([EmployeeType] = @EmployeeType))">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="Sales Manager" Name="EmployeeType" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="auto-style11">No. of visits per day</td>
            <td class="auto-style14">
                <asp:TextBox ID="txtVisitsPreDay" runat="server"></asp:TextBox>
            </td>
            <td class="auto-style23">
                &nbsp;</td>
            <td class="auto-style17">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style11">Picture</td>
            <td class="auto-style14">
                <asp:FileUpload ID="PicUpload" runat="server" />
            </td>
            <td class="auto-style23">
                <asp:Button ID="btnUpload" runat="server" OnClick="btnUpload_Click" Text="Upload" Visible="False" />
                </td>
            <td class="auto-style17">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style11">&nbsp;</td>
            <td class="auto-style14">
                <asp:Label ID="lblEmployeeSaveStatus" runat="server" Enabled="False"></asp:Label>
            </td>
            <td class="auto-style23">
                <asp:Button ID="btnLoad" runat="server" OnClick="btnLoad_Click" Text="Load" Visible="False" />
                </td>
            <td class="auto-style13">
                <asp:Button ID="btnReset" runat="server" OnClick="btnReset_Click" Text="Reset" Visible="False" />
                <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" Visible="False" />
                <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" Visible="False" />
                <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Save" />
            </td>
        </tr>
    </table>

    </asp:Content>
