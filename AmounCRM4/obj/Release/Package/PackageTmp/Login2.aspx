<%@ Page Title="Login Form" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Login2.aspx.cs" Inherits="AmounCRM4.Login2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .auto-style1
        {
            width: 100%;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <%--  <h2 style="text-align:center">Targeting is under running</h2>--%>
    <table cellpadding="4" cellspacing="0" style="border-collapse:collapse; background-color:whitesmoke" visible="false">
                <tr>
                    <td> <%--style="visibility:hidden" visible="false">--%>
                        <table cellpadding="0" style="height:402px;width:777px;">
                            <tr>
                                <td align="center" colspan="2" style="color:White;background-color:#5D7B9D;font-size:x-large;font-weight:bold;">Log In</td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" Font-Names="Times New Roman" Font-Size="X-Large">User ID:</asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="UserName" runat="server" Font-Names="Times New Roman" Font-Size="X-Large" MaxLength="15"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password" Font-Names="Times New Roman" Font-Size="X-Large">Password:</asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="Password" runat="server" Font-Names="Times New Roman" Font-Size="X-Large" TextMode="Password" MaxLength="25" OnTextChanged="Password_TextChanged"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:CheckBox ID="RememberMe" runat="server" Text="Remember me next time." />
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="color:Red;">
                                    <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    <asp:LinkButton ID="ChangePasswordLinkButton" runat="server" BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" 
                                        BorderWidth="1px" Font-Names="Times New Roman" Font-Size="X-Large" ForeColor="#284775" ValidationGroup="Login1" 
                                        OnClick="ChangePasswordLinkButton_Click">Change Password</asp:LinkButton>
                                </td>
                                <td align="right">
                                    <asp:LinkButton ID="LoginLinkButton" runat="server" BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" 
                                        BorderWidth="1px" Font-Names="Times New Roman" Font-Size="X-Large" ForeColor="#284775" ValidationGroup="Login1" 
                                        OnClick="LoginLinkButton_Click">Log In</asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
</asp:Content>
