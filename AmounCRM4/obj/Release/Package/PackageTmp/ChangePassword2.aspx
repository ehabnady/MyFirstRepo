<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangePassword2.aspx.cs" Inherits="AmounCRM4.ChangePassword2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Change Password</title>
    <style type="text/css">
        .form {
            vertical-align:middle;
            align-items:inherit;
            position: center;
            z-index: 1;
            background: #FFFFFF;
            max-width: 80%;
            margin-top:5%;
            margin-bottom:5%;
            margin-left:10%;
            margin-right:10%;
            padding: 25px;
            text-align: center;
            box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
        }
            .form input {
                font-family: "Roboto", sans-serif;
                color:white;
                outline: 0;
                background: #00b7ff;
                width: 100%;
                border: 0;
                margin: 0 0 15px;
                padding: 15px;
                box-sizing: border-box;
                font-size: 28px;
            }

            .form button {
                font-family: "Roboto", sans-serif;
                text-transform: uppercase;
                outline: 0;
                background: #4CAF50;
                width: 100%;
                border: 0;
                padding: 5px;
                color: #FFFFFF;
                font-size:xx-large;
                -webkit-transition: all 0.3 ease;
                transition: all 0.3 ease;
                cursor: pointer;
            }
                .form button:hover, .form button:active, .form button:focus {
                    background: #43A047;
                }

            .form .message {
                margin: 15px 0 0;
                color: #b3b3b3;
                font-size: 28px;
            }

                .form .message a {
                    color: #4CAF50;
                    text-decoration: none;
                }

            .form .register-form {
                display: none;
            }

        body 
        {
            background: #00cdff; /* fallback for old browsers */
            background: -webkit-linear-gradient(right, #7cfff2, #1400ff);
            background: -moz-linear-gradient(right, #7cfff2, #1400ff);
            background: -o-linear-gradient(right, #7cfff2, #1400ff);
            background: linear-gradient(to left, #7cfff2, #1400ff);
            font-family: "Roboto", sans-serif;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        .label
        {
            font-size:30px;
            font-weight:700;
            color: darkblue;
            text-decoration: wavy;
            text-decoration-style:dotted;
            position: relative;
            vertical-align:middle;
        }
    </style>
</head>
<body style="vertical-align:middle; align-items:center">
    <form id="frm" runat="server" class="form">
                <table>
                    <tr>
                        <th colspan="2" align="center" style="font-size:x-large">Change Your Password<br /><br />
                        </th>
                    </tr>
                    <tr>
                        <td align="right"><asp:Label ID="lblUserName" runat="server" Text="User ID:" Font-Size="XX-Large"></asp:Label></td>
                        <td align="right">
                            <asp:TextBox ID="txtUserName" runat="server" MaxLength="15" Font-Size="XX-Large" /></td>
                    </tr>
                    <tr>
                        <td align="right"><asp:Label ID="lblOldPassword" runat="server" Text="Old Password:" Font-Size="XX-Large"></asp:Label></td>
                        <td align="right">
                            <asp:TextBox ID="txtOldPassword" runat="server" TextMode="Password" MaxLength="15" Font-Size="XX-Large" /></td>
                    </tr>
                    <tr>
                        <td align="right"><asp:Label ID="lblNewPassword" runat="server" Text="New Password:" Font-Size="XX-Large"></asp:Label></td>
                        <td align="right">
                            <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" MaxLength="15" Font-Size="XX-Large" /></td>
                    </tr>
                    <tr>
                        <td align="right"><asp:Label ID="lblConfirm" runat="server" Text="Confirm New Password:" Font-Size="XX-Large"></asp:Label></td>
                        <td align="right">
                            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" MaxLength="15" Font-Size="XX-Large" /></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <asp:Button ID="btnSubmit" runat="server" Text="Change My Password" OnClick="btnSubmit_Click" Font-Size="XX-Large" />
                            <br />
                            <a href="Login.aspx" style="font-size: 28px">Login</a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Label ID="lblError" BackColor="Red" ForeColor="White" runat="server" Text="" Font-Size="XX-Large"></asp:Label>
                            <br />
                            <a id="lnkRedirect" runat="server" href="Login.aspx" visible="false">Gogto Login Page</a>
                        </td>
                    </tr>
                </table>
                <div style="font-size:x-large; width:80%; vertical-align:middle; text-align:left; border:10px; border-color:red">
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
            SelectCommand="SELECT [EmployeeUserName], [EmployeePassword] FROM [Employees] WHERE (([EmployeeUserName] = @EmployeeUserName) AND ([EmployeePassword] = @EmployeeOldPassword))"
            UpdateCommand="UPDATE [Employees] SET [EmployeePassword] = @EmployeeNewPassword, [LastChangeDate] = @LastChangeDate, MustChangePassword = 0, [NextChangeDate] = @NextChangeDate WHERE ([EmployeeUserName] = @EmployeeUserName) AND ([EmployeePassword] = @EmployeeOldPassword)" OnSelecting="sqlDsEmp_Selecting">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtUserName" Name="EmployeeUserName" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtOldPassword" Name="EmployeeOldPassword" PropertyName="Text" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="txtUserName" Name="EmployeeUserName" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtNewPassword" Name="EmployeeNewPassword" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtOldPassword" Name="EmployeeOldPassword" PropertyName="Text" Type="String" />
                <asp:Parameter Name="LastChangeDate" Type="DateTime" />
                <asp:Parameter Name="NextChangeDate" Type="DateTime" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
