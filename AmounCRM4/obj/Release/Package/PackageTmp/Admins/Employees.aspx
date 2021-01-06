<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Employees.aspx.cs" MasterPageFile="~/Site1.Master" Inherits="AmounCRM4.Admins.Employees" %>
<%@ Register Src="~/Admins/RadGridEmployeesMainData.ascx" TagName="RadGridEmployeesMainData" TagPrefix="uc" %>

<asp:Content ContentPlaceHolderID="head" ID="head" runat="server">
    <style type="text/css">
        .auto-style2 
        {
            direction: ltr;
        }
    </style>
</asp:Content>
<asp:Content ContentPlaceHolderID="Body" runat="server">
    <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
    <div class="auto-style2">
    <telerik:RadTabStrip ID="tabStripEmployees" runat="server" Skin="WebBlue" 
        RenderMode="Lightweight" SelectedIndex="0" MultiPageID="multPages">
        <Tabs>
            <telerik:RadTab runat="server" Text="Main Data" Selected="True"></telerik:RadTab>
            <telerik:RadTab runat="server" Text="Managers & Supervisors"></telerik:RadTab>
            <telerik:RadTab runat="server" Text="Area Structure"></telerik:RadTab>
            <telerik:RadTab runat="server" Text="Administration"></telerik:RadTab>
        </Tabs>
    </telerik:RadTabStrip>
        <telerik:RadMultiPage ID="multPages" runat="server" SelectedIndex="0">
            <telerik:RadPageView ID="mainData" runat="server">
                <div style="display:block; clear:both">
                    <uc:RadGridEmployeesMainData ID="EmpMainData" runat="server" />
                </div>
            </telerik:RadPageView>
            <telerik:RadPageView ID="mgt" runat="server">
                <div style="display:block; clear:both">

                </div>
            </telerik:RadPageView>
            <telerik:RadPageView ID="areas" runat="server">
                <div style="display:block; clear:both">

                </div>
            </telerik:RadPageView>
            <telerik:RadPageView ID="admin" runat="server">
                <div style="display:block; clear:both">

                </div>
            </telerik:RadPageView>
        </telerik:RadMultiPage>
    </div>
</asp:Content>
