<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Survey4.aspx.cs" Inherits="AmounCRM4.Surveys.Survey4" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .css1
        {
            border-style:none;
            color:#a19f9f;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="SCM1" runat="server"></telerik:RadScriptManager>
        <div>
            <asp:SqlDataSource runat="server" ID="dsBrands" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
                SelectCommand="SELECT [AmounProductID] as AmounProductCode, [AmounProductName] as BrandName FROM [Survey_Products] order by [AmounProductName]"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="dsMarkets" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
                SelectCommand="SELECT [MarketID], [MarketName] FROM [Survey_Market] Where Deleted is Null or Deleted = 0 Order by [MarketName]"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="dsActivities" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
                SelectCommand="SELECT [ActivityID], [ActivityName], [IsGeneral] FROM [Survey_Activities] Where (Deleted is Null or Deleted = 0) AND (IsGeneral = 0 OR IsGeneral IS NULL) Order by [ActivityName]"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="dsGeneralActivities" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
                SelectCommand="SELECT [ActivityID], [ActivityName], [IsGeneral] FROM [Survey_Activities] Where (Deleted is Null or Deleted = 0) AND (IsGeneral = 1) Order by [ActivityName]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="dsSurveySave" runat="server" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
                SelectCommand="SELECT [SurveyID], [Pharmacy], [AmounProductCode], [MarketID], [CompetitorProduct], [IndicationID], [ActivityID], 
                [GeneralActivityID], [SalesRatio] FROM [Survey]" DeleteCommand="DELETE FROM [Survey] WHERE [SurveyID] = @SurveyID" 
                InsertCommand="INSERT INTO [Survey] ([Pharmacy], [AmounProductCode], [MarketID], [CompetitorProduct], [IndicationID], [ActivityID], 
                [GeneralActivityID], [SalesRatio]) VALUES (@Pharmacy, @AmounProductCode, @MarketID, @CompetitorProduct, @IndicationID, @ActivityID, 
                @GeneralActivityID, @SalesRatio)" 
                UpdateCommand="UPDATE [Survey] SET [Pharmacy] = @Pharmacy, [AmounProductCode] = @AmounProductCode, [MarketID] = @MarketID, 
                [CompetitorProduct] = @CompetitorProduct, [IndicationID] = @IndicationID, [ActivityID] = @ActivityID, 
                [GeneralActivityID] = @GeneralActivityID, [SalesRatio] = @SalesRatio WHERE [SurveyID] = @SurveyID">
                <DeleteParameters>
                    <asp:Parameter Name="SurveyID" Type="Int32"></asp:Parameter>
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Pharmacy" Type="String"></asp:Parameter>
                    <asp:Parameter Name="AmounProductCode" Type="String"></asp:Parameter>
                    <asp:Parameter Name="MarketID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="CompetitorProduct" Type="String"></asp:Parameter>
                    <asp:Parameter Name="IndicationID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="ActivityID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="GeneralActivityID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="SalesRatio" Type="Double"></asp:Parameter>
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Pharmacy" Type="String"></asp:Parameter>
                    <asp:Parameter Name="AmounProductCode" Type="String"></asp:Parameter>
                    <asp:Parameter Name="MarketID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="CompetitorProduct" Type="String"></asp:Parameter>
                    <asp:Parameter Name="IndicationID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="ActivityID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="GeneralActivityID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="SalesRatio" Type="Double"></asp:Parameter>
                    <asp:Parameter Name="SurveyID" Type="Int32"></asp:Parameter>
                </UpdateParameters>
            </asp:SqlDataSource>

            <table>
                <tr>
                    <td>Pharmacy Name:</td>
                    <td>
                        <asp:TextBox ID="txtPharmacy" runat="server" Text="" Width="260"></asp:TextBox>
                        <asp:Label ID="lblPhamaNote" runat="server" Text="Please Enter Pharmacy Name in Arabic" Font-Italic="true" ForeColor="Gray"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Amoun Product:</td>
                    <td>
                        <telerik:RadDropDownList ID="ddlBrandName" runat="server" AutoPostBack="true" DataSourceID="dsBrands" DataTextField="BrandName" 
                            DataValueField="AmounProductCode" AppendDataBoundItems="true" OnSelectedIndexChanged="ddlBrandName_SelectedIndexChanged" 
                            Width="260">
                            <Items>
                                <telerik:DropDownListItem Text="None" Value="0" />
                            </Items>
                        </telerik:RadDropDownList>
                        <asp:Label ID="lblWeeklyRatio" runat="server" Text="Weekly % of Packs from Total Market: "></asp:Label>
                        <asp:TextBox ID="txtWeeklyRatio" runat="server" Width="25"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Market:</td>
                    <td>
                        <telerik:RadDropDownList ID="ddlMarketName" runat="server" AutoPostBack="true" AppendDataBoundItems="true" 
                            OnSelectedIndexChanged="ddlMarketName_SelectedIndexChanged" Width="260">
                            <Items>
                                <telerik:DropDownListItem Text="None" Value="0" />
                            </Items>
                        </telerik:RadDropDownList>
                        <asp:Label ID="lblMarketPacks" runat="server" Text="Packs per Week"></asp:Label>
                        <asp:TextBox ID="txtPacksPerWeek" runat="server" Width="40"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Competitors:</td>
                    <td>
                        <asp:CheckBoxList ID="chklCompetitors" RepeatDirection="Vertical" RepeatLayout="Table" RepeatColumns="1" runat="server"
                            OnSelectedIndexChanged="chklCompetitors_SelectedIndexChanged" AutoPostBack="true"></asp:CheckBoxList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="btnFillTable" runat="server" Text="Get Indications" OnClick="btnFillTable_Click" Visible="false" />
                    </td>
                </tr>
            </table>

            <p>
                <br />
            </p>

            <asp:UpdatePanel runat="server" ID="panel1">
                <ContentTemplate>
                    <table id="tableContent" border="1" runat="server" enableviewstate="true"></table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
            
            <br />
            <p>
                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
            </p>
        </div>
    </form>
</body>
</html>
