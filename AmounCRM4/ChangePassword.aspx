<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="AmounCRM4.ChangePassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style3 {
            width: 350px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
        <table class="auto-style3">
            <tr>
                <th colspan="2" align="center">Change Your Password</th>
            </tr>
            <tr>
                <td align="right">User ID:</td>
                <td align="right"><asp:TextBox ID="txtUserName" runat="server" MaxLength="15" /></td>
            </tr>
            <tr>
                <td align="right">Old Password:</td>
                <td align="right"><asp:TextBox ID="txtOldPassword" runat="server" TextMode="Password" MaxLength="25" /></td>
            </tr>
            <tr>
                <td align="right">New Password:</td>
                <td align="right"><asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" MaxLength="25" /></td>
            </tr>
            <tr>
                <td align="right">Confirm New Password:</td>
                <td align="right"><asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" MaxLength="25" /></td>
            </tr>
            <tr>
                <td colspan="2" align="center"><asp:Button ID="btnSubmit" runat="server" Text="Change My Password" OnClick="btnSubmit_Click" /></td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Label ID="lblError" BackColor="Red" ForeColor="White" runat="server" Text=""></asp:Label>
                    <br />
                    <a id="lnkRedirect" runat="server" href="Login2.aspx" visible="false">Gogto Login Page</a>
                </td>
            </tr>
        </table>
    <p></p>
    <div align="left" class="auto-style3">
        <b><u>Password Guidelines</u></b><br />
        <br />
        • Password must be changed every 45 days.
        <br />
        • Contain capital letters.
        <br />
        • Include both number and special characters such as
        <br />
        “! @ # $ % ^ &amp; * ( )”.
        <br />
        • Have a minimum of at least 6 characters.
    </div>

    <br />
    <asp:SqlDataSource ID="sqlDsEmp" runat="server"
        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
        SelectCommand="SELECT [EmployeeUserName], [EmployeePassword] FROM [EmployeesMasterData] WHERE (([EmployeeUserName] = @EmployeeUserName) AND ([EmployeePassword] = @EmployeeOldPassword))" 
        UpdateCommand="UPDATE [EmployeesMasterData] SET [EmployeePassword] = @EmployeeNewPassword, [LastChangeDate] = @LastChangeDate, MustChangePassword = 0, [NextChangeDate] = @NextChangeDate WHERE ([EmployeeUserName] = @EmployeeUserName) AND ([EmployeePassword] = @EmployeeOldPassword)" OnSelecting="sqlDsEmp_Selecting">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtUserName" Name="EmployeeUserName" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtOldPassword" Name="EmployeeOldPassword" PropertyName="Text" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="txtUserName" Name="EmployeeUserName" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtNewPassword" Name="EmployeeNewPassword" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtOldPassword" Name="EmployeeOldPassword" PropertyName="Text" Type="String" />
            <asp:Parameter Name="LastChangeDate" Type="DateTime"/>
            <asp:Parameter Name="NextChangeDate" Type="DateTime"/>
        </UpdateParameters>
        </asp:SqlDataSource>
</asp:Content>