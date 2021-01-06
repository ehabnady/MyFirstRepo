<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/CommercialDirector/SiteMaster2.Master" AutoEventWireup="true" 
    CodeBehind="ComDirReport_Dashboard.aspx.cs" Inherits="AmounCRM4.CommercialDirector.ComDirReport_Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <link href="../Styles/Gauges.css" rel="stylesheet" />
    <style type="text/css">
        .panelItem {
            height: auto;
        }

        .DivCenter {
            text-align: center;
            align-items: center;
            vertical-align: middle;
        }
    </style>

    <title>Dashboard</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <%--<telerik:RadSkinManager ID="RadSkinManager1" runat="server" ShowChooser="true" />--%>
    <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true"></telerik:RadWindowManager>
    <p></p>
    <br />

    <div class="table-responsive" style="margin: 0 auto">
        <div class="row" style="margin: 0 auto">
            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12" style="align-items: center; text-align: center; grid-row-align: center; margin: 0 auto">
                <asp:Label ID="lblG1" runat="server" Text="Actual Visits vs. Targeted Visits" Style="align-items: center; text-align: center; grid-row-align: center; margin: 0 auto"></asp:Label>
                <telerik:RadRadialGauge runat="server" ID="g1" Width="325px" Height="192px" RenderMode="Mobile" Style="align-items: center; text-align: center; grid-row-align: center; margin: 0 auto">
                    <Pointer Color="#000000">
                        <Cap Size="0.2" />
                    </Pointer>
                    <Scale Min="0" MajorUnit="10" MinorUnit="5">
                        <MajorTicks Size="4" Color="#777777" />
                        <MinorTicks Size="2" Color="#777777" />
                        <Labels Position="Outside" Color="#000000" Font="bold 11px Arial,Verdana,Tahoma" />
                        <Ranges>
                            <telerik:GaugeRange From="0" To="50" Color="Red" />
                            <telerik:GaugeRange From="50" To="80" Color="Orange" />
                            <telerik:GaugeRange From="80" To="100" Color="Green" />
                        </Ranges>
                    </Scale>
                </telerik:RadRadialGauge>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12" style="align-items: center; text-align: center; grid-row-align: center; margin: 0 auto">
                <asp:Label ID="lblG2" runat="server" Text="Class 'A' Coverage" Style="align-items: center; text-align: center; grid-row-align: center; margin: 0 auto"></asp:Label>
                <telerik:RadRadialGauge runat="server" ID="g2" Width="325px" Height="192px" RenderMode="Mobile" Style="align-items: center; text-align: center; grid-row-align: center; margin: 0 auto">
                    <Pointer Value="22" Color="#000000">
                        <Cap Size="0.2" />
                    </Pointer>
                    <Scale Min="0" MajorUnit="10" MinorUnit="5">
                        <MajorTicks Size="4" Color="#777777" />
                        <MinorTicks Size="2" Color="#777777" />
                        <Labels Position="Outside" Color="#000000" Font="bold 11px Arial,Verdana,Tahoma" />
                        <Ranges>
                            <telerik:GaugeRange From="0" To="50" Color="Red" />
                            <telerik:GaugeRange From="50" To="80" Color="Orange" />
                            <telerik:GaugeRange From="80" To="100" Color="Green" />
                        </Ranges>
                    </Scale>
                </telerik:RadRadialGauge>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12" style="align-items: center; text-align: center; grid-row-align: center; margin: 0 auto">
                <asp:Label ID="lblG3" runat="server" Text="Class 'A+' Coverage" Style="align-items: center; text-align: center; grid-row-align: center; margin: 0 auto"></asp:Label>
                <telerik:RadRadialGauge runat="server" ID="g3" Width="325px" Height="192px" RenderMode="Mobile" Style="align-items: center; text-align: center; grid-row-align: center; margin: 0 auto">
                    <Pointer Color="#000000">
                        <Cap Size="0.2" />
                    </Pointer>
                    <Scale Min="0" MajorUnit="10" MinorUnit="5">
                        <MajorTicks Size="4" Color="#777777" />
                        <MinorTicks Size="2" Color="#777777" />
                        <Labels Position="Outside" Color="#000000" Font="bold 11px Arial,Verdana,Tahoma" />
                        <Ranges>
                            <telerik:GaugeRange From="0" To="50" Color="Red" />
                            <telerik:GaugeRange From="50" To="80" Color="Orange" />
                            <telerik:GaugeRange From="80" To="100" Color="Green" />
                        </Ranges>
                    </Scale>
                </telerik:RadRadialGauge>
            </div>
        </div>

    </div>

</asp:Content>
