<%@ Page Title="Consents" Language="C#" MasterPageFile="~/SalesManagers/SiteMaster2.Master" AutoEventWireup="true" CodeBehind="Consents.aspx.cs" Inherits="AmounCRM4.SalesManagers.Consents" %>

<%@ Register Assembly="Telerik.ReportViewer.Html5.WebForms, Version=13.0.19.116, Culture=neutral, PublicKeyToken=a9d7983dfcc261be" Namespace="Telerik.ReportViewer.Html5.WebForms" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <telerik:ReportViewer ID="rpt1" runat="server"></telerik:ReportViewer>
</asp:Content>
