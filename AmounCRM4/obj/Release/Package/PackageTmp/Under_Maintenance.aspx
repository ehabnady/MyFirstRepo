<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Under_Maintenance.aspx.cs" Inherits="AmounCRM4.Under_Maintenance" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Under Maintenance</title>
    <style>
        .div {
            width: 100px;
            height: 100px;
            position: absolute;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            margin: auto;
        }
        .auto-style1 {
            width: 363px;
            height: 263px;
        }
        </style>
</head>
<body>
    <form id="form1" runat="server">
        
        <asp:Table ID="Table1" runat="server" CssClass="div" GridLines="Horizontal" Height="100%" Width="100%">
            <asp:TableRow runat="server" Height="100%" HorizontalAlign="Center" VerticalAlign="Middle" Width="100%">
                <asp:TableCell runat="server" Height="100%" HorizontalAlign="Center" VerticalAlign="Middle" Width="100%">
                    <h1>
                        Under Maintenance
                    </h1>
                    <hr />
                    <br />
                    <img src="UnderMain.jpg" class="auto-style1" />
                </asp:TableCell>
            </asp:TableRow>
            
        </asp:Table>
    </form>
</body>
</html>
