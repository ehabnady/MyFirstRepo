<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SurveyReport.aspx.cs" Inherits="AmounCRM4.Surveys.SurveyReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="width:90%; align-items:center;">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        </telerik:RadScriptManager>

        <telerik:RadGrid ID="grdSurvey" runat="server" DataSourceID="dsSurvey" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True" ShowGroupPanel="True" Skin="WebBlue">
            <ClientSettings AllowDragToGroup="True">
                <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
            </ClientSettings>

            <MasterTableView DataSourceID="dsSurvey" AutoGenerateColumns="False">
                <Columns>
                    <telerik:GridBoundColumn DataField="SurveyDate" HeaderText="SurveyDate" SortExpression="SurveyDate" UniqueName="SurveyDate" DataType="System.DateTime" FilterControlAltText="Filter SurveyDate column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Pharmacy" HeaderText="Pharmacy" SortExpression="Pharmacy" UniqueName="Pharmacy" FilterControlAltText="Filter Pharmacy column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WeeklyRatioOfPacks" HeaderText="WeeklyRatioOfPacks" SortExpression="WeeklyRatioOfPacks" UniqueName="WeeklyRatioOfPacks" DataType="System.Double" FilterControlAltText="Filter WeeklyRatioOfPacks column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="NoOfPacks" HeaderText="NoOfPacks" SortExpression="NoOfPacks" UniqueName="NoOfPacks" DataType="System.Double" FilterControlAltText="Filter NoOfPacks column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="AmounProductName" HeaderText="AmounProductName" SortExpression="AmounProductName" UniqueName="AmounProductName" FilterControlAltText="Filter AmounProductName column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MarketName" HeaderText="MarketName" SortExpression="MarketName" UniqueName="MarketName" FilterControlAltText="Filter MarketName column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CompetitorName" HeaderText="CompetitorName" SortExpression="CompetitorName" UniqueName="CompetitorName" FilterControlAltText="Filter CompetitorName column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="IndicationName" HeaderText="IndicationName" SortExpression="IndicationName" UniqueName="IndicationName" FilterControlAltText="Filter IndicationName column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SalesRatio" HeaderText="SalesRatio" SortExpression="SalesRatio" UniqueName="SalesRatio" DataType="System.Double" FilterControlAltText="Filter SalesRatio column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ActivityName" HeaderText="ActivityName" SortExpression="ActivityName" UniqueName="ActivityName" FilterControlAltText="Filter ActivityName column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="GeneralActivityName" HeaderText="GeneralActivityName" SortExpression="GeneralActivityName" UniqueName="GeneralActivityName" FilterControlAltText="Filter GeneralActivityName column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="LineID" HeaderText="LineID" SortExpression="LineID" UniqueName="LineID" DataType="System.Int32" FilterControlAltText="Filter LineID column" Visible="false"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="EmployeeID" HeaderText="EmployeeID" SortExpression="EmployeeID" UniqueName="EmployeeID" DataType="System.Int32" FilterControlAltText="Filter EmployeeID column" Visible="false"></telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
        <asp:SqlDataSource runat="server" ID="dsSurvey" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' SelectCommand="SELECT [Pharmacy], [WeeklyRatioOfPacks], [NoOfPacks], [AmounProductName], [MarketName], [CompetitorName], [IndicationName], [SalesRatio], [ActivityName], [GeneralActivityName], [SurveyDate], [LineID], [EmployeeID] FROM [View_Survey] WHERE ([EmployeeID] = @EmployeeID)">
            <SelectParameters>
                <asp:SessionParameter SessionField="EmployeeID" Name="EmployeeID" Type="Int32"></asp:SessionParameter>
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
