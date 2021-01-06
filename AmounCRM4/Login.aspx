<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AmounCRM4.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <style type="text/css">
        .form {
            vertical-align:middle;
            position: center;
            z-index: 1;
            background: #FFFFFF;
            max-width: 40%;
            margin-top:5%;
            margin-bottom:5%;
            margin-left:30%;
            margin-right:30%;
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
                font-size: 38px;
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
            position:relative;
            vertical-align:middle;
        }
    </style>
</head>
<body>
    <form class="form" id="frm" runat="server">
        <img src="ECMSLogo_png.png" width="50%" height="50%" /><br />
        <br />
        <input type="text" placeholder="User Name" id="UserName" runat="server" size="10" />
        <input type="password" placeholder="Password" id="Password" runat="server" size="10" />
        <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" Text="Login" Style="font-size: 38px"></asp:Button>
        <br />
        <a href="ChangePassword2.aspx" style="font-size: 28px">Change Password</a>
        <br />
        <br />
        <p class="message">
            <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
        </p>
    </form>
</body>
</html>
