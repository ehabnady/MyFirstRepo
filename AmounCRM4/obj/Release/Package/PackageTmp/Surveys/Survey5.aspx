<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Survey5.aspx.cs" Inherits="AmounCRM4.Surveys.Survey5" %>

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
                SelectCommand="SELECT [AmounProductID] as AmounProductCode, [AmounProductName] as BrandName FROM [Survey_Products] Where LineID = @LineID Order by [AmounProductName]">
                <SelectParameters>
                    <asp:SessionParameter SessionField="LineID" Name="LineID"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="dsMarkets" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
                SelectCommand="SELECT [MarketID], [MarketName] FROM [Survey_Market] Where Deleted is Null or Deleted = 0 Order by [MarketName]"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="dsActivities" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
                SelectCommand="SELECT [ActivityID], [ActivityName], [IsGeneral] FROM [Survey_Activities] Where (Deleted is Null or Deleted = 0) AND (IsGeneral = 0 OR IsGeneral IS NULL) Order by [ActivityName]"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="dsGeneralActivities" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
                SelectCommand="SELECT [ActivityID], [ActivityName], [IsGeneral] FROM [Survey_Activities] Where (Deleted is Null or Deleted = 0) AND (IsGeneral = 1) Order by [ActivityName]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="dsSurveySave" runat="server" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
                SelectCommand="SELECT [SurveyID], [Pharmacy], [AmounProductCode], [MarketID], [CompetitorProduct], [IndicationID], [SalesRatio], [ActivityID], 
                [GeneralActivityID], [WeeklyRatioOfPacks], [NoOfPacks] FROM [Survey]" DeleteCommand="DELETE FROM [Survey] WHERE [SurveyID] = @SurveyID" 
                InsertCommand="INSERT INTO [Survey] ([Pharmacy], [AmounProductCode], [MarketID], [CompetitorProduct], [IndicationID], [SalesRatio], [ActivityID], 
                [GeneralActivityID], [WeeklyRatioOfPacks], [NoOfPacks], [LineID], [EmployeeID], [SurveyDate]) VALUES (@Pharmacy, @AmounProductCode, @MarketID, @CompetitorProduct, @IndicationID, @SalesRatio, @ActivityID, 
                @GeneralActivityID, @WeeklyRatioOfPacks, @NoOfPacks, @LineID, @EmployeeID, @SurveyDate)" 
                UpdateCommand="UPDATE [Survey] SET [Pharmacy] = @Pharmacy, [AmounProductCode] = @AmounProductCode, [MarketID] = @MarketID, 
                [CompetitorProduct] = @CompetitorProduct, [IndicationID] = @IndicationID, [SalesRatio] = @SalesRatio, [ActivityID] = @ActivityID, 
                [GeneralActivityID] = @GeneralActivityID, [WeeklyRatioOfPacks] = @WeeklyRatioOfPacks, [NoOfPacks] = @NoOfPacks, [LineID] = @LineID, [EmployeeID] = @EmployeeID, [SurveyDate] = @SurveyDate WHERE [SurveyID] = @SurveyID">
                <DeleteParameters>
                    <asp:Parameter Name="SurveyID" Type="Int32"></asp:Parameter>
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Pharmacy" Type="String"></asp:Parameter>
                    <asp:Parameter Name="AmounProductCode" Type="String"></asp:Parameter>
                    <asp:Parameter Name="MarketID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="CompetitorProduct" Type="String"></asp:Parameter>
                    <asp:Parameter Name="IndicationID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="SalesRatio" Type="Double"></asp:Parameter>
                    <asp:Parameter Name="ActivityID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="GeneralActivityID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="WeeklyRatioOfPacks" Type="Double"></asp:Parameter>
                    <asp:Parameter Name="NoOfPacks" Type="Double"></asp:Parameter>
                    <asp:Parameter Name="LineID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="EmployeeID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="SurveyDate" Type="DateTime"></asp:Parameter>
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Pharmacy" Type="String"></asp:Parameter>
                    <asp:Parameter Name="AmounProductCode" Type="String"></asp:Parameter>
                    <asp:Parameter Name="MarketID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="CompetitorProduct" Type="String"></asp:Parameter>
                    <asp:Parameter Name="IndicationID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="SalesRatio" Type="Double"></asp:Parameter>
                    <asp:Parameter Name="ActivityID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="GeneralActivityID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="WeeklyRatioOfPacks" Type="Double"></asp:Parameter>
                    <asp:Parameter Name="NoOfPacks" Type="Double"></asp:Parameter>
                    <asp:Parameter Name="LineID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="EmployeeID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="SurveyDate" Type="DateTime"></asp:Parameter>
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
                        <asp:TextBox ID="txtWeeklyRatio" runat="server" Width="50" TextMode="Number"></asp:TextBox>
                        <asp:rangevalidator ID="Rangevalidator1" errormessage="Please enter value between 1-100." forecolor="Red" 
                            controltovalidate="txtWeeklyRatio" minimumvalue="1" maximumvalue="100" runat="server" Type="Integer">
                        </asp:rangevalidator>
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
                        <asp:TextBox ID="txtPacksPerWeek" runat="server" Width="50" TextMode="Number"></asp:TextBox>
                        <asp:rangevalidator ID="Rangevalidator2" errormessage="Please enter value between 1-9999." forecolor="Red" 
                            controltovalidate="txtPacksPerWeek" minimumvalue="1" maximumvalue="9999" runat="server" Type="Integer">
                        </asp:rangevalidator>
                    </td>
                </tr>
                <tr>
                    <td>Competitors:</td>
                    <td>
                        <asp:CheckBoxList ID="chklCompetitors" RepeatDirection="Vertical" RepeatLayout="Table" RepeatColumns="1" runat="server"
                            OnSelectedIndexChanged="chklCompetitors_SelectedIndexChanged" AutoPostBack="true"></asp:CheckBoxList>
                    </td>
                </tr>
            </table>

            <p>
                <br />
            </p>
            
            <asp:GridView ID="tableContent2" runat="server" DataSourceID="dsProds" AutoGenerateColumns="False" 
                HeaderStyle-BackColor="#aeaaaa" HeaderStyle-ForeColor="White">
                <Columns>
                    <asp:BoundField DataField="MainCompetitor" HeaderText="Competitors" SortExpression="MainCompetitor"
                        ItemStyle-BackColor="#2f75b5" ItemStyle-ForeColor="White"></asp:BoundField>
                    <asp:BoundField DataField="MainIndication" HeaderText="Indications" SortExpression="MainIndication"
                        ItemStyle-BackColor="#2f75b5" ItemStyle-ForeColor="White"></asp:BoundField>
                    <asp:TemplateField ItemStyle-BackColor="#ffc000">
                        <HeaderTemplate>
                            <asp:label ID="lblHeaderSales1" runat="server" Text ="% of Packs"></asp:label><br />
                            <asp:label ID="lblHeaderSales2" runat="server" Text ="From Total Market"></asp:label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlSales" runat="server" AppendDataBoundItems="true">
                                <asp:ListItem Enabled="true" Text="None" Value="0" Selected="True"></asp:ListItem>
                                <asp:ListItem Enabled="true" Text="5" Value="5"></asp:ListItem>
                                <asp:ListItem Enabled="true" Text="10" Value="10"></asp:ListItem>
                                <asp:ListItem Enabled="true" Text="15" Value="15"></asp:ListItem>
                                <asp:ListItem Enabled="true" Text="20" Value="20"></asp:ListItem>
                                <asp:ListItem Enabled="true" Text="25" Value="25"></asp:ListItem>
                                <asp:ListItem Enabled="true" Text="30" Value="30"></asp:ListItem>
                                <asp:ListItem Enabled="true" Text="35" Value="35"></asp:ListItem>
                                <asp:ListItem Enabled="true" Text="40" Value="40"></asp:ListItem>
                                <asp:ListItem Enabled="true" Text="45" Value="45"></asp:ListItem>
                                <asp:ListItem Enabled="true" Text="50" Value="50"></asp:ListItem>
                                <asp:ListItem Enabled="true" Text="55" Value="55"></asp:ListItem>
                                <asp:ListItem Enabled="true" Text="60" Value="60"></asp:ListItem>
                                <asp:ListItem Enabled="true" Text="65" Value="65"></asp:ListItem>
                                <asp:ListItem Enabled="true" Text="70" Value="70"></asp:ListItem>
                                <asp:ListItem Enabled="true" Text="75" Value="75"></asp:ListItem>
                                <asp:ListItem Enabled="true" Text="80" Value="80"></asp:ListItem>
                                <asp:ListItem Enabled="true" Text="85" Value="85"></asp:ListItem>
                                <asp:ListItem Enabled="true" Text="90" Value="90"></asp:ListItem>
                                <asp:ListItem Enabled="true" Text="95" Value="95"></asp:ListItem>
                                <asp:ListItem Enabled="true" Text="100" Value="100"></asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="lbl1" runat="server" Text=""></asp:Label>
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Activity" ItemStyle-BackColor="#ffc000">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlActivity" runat="server" AppendDataBoundItems="true" DataSourceID="dsActivities"
                                DataTextField="ActivityName" DataValueField="ActivityID">
                                <asp:ListItem Enabled="true" Text="None" Value="0" Selected="True"></asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="lbl2" runat="server" Text=""></asp:Label>
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="General Activity" ItemStyle-BackColor="#ffc000">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlGeneralActivity" runat="server" AppendDataBoundItems="true" DataSourceID="dsGeneralActivities"
                                DataTextField="ActivityName" DataValueField="ActivityID">
                                <asp:ListItem Enabled="true" Text="None" Value="0" Selected="True"></asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="lbl2" runat="server" Text=""></asp:Label>
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="ProductName" HeaderText="ProductName" SortExpression="ProductName" Visible="false"></asp:BoundField>
                    <asp:BoundField DataField="LineID" HeaderText="LineID" SortExpression="LineID" Visible="false"></asp:BoundField>
                    <asp:BoundField DataField="MarketName" HeaderText="MarketName" SortExpression="MarketName" Visible="false"></asp:BoundField>
                    <asp:BoundField DataField="CompetitorID" HeaderText="CompetitorID" ReadOnly="True" SortExpression="CompetitorID" Visible="false"></asp:BoundField>
                    <asp:BoundField DataField="IndicationID" HeaderText="IndicationID" ReadOnly="True" SortExpression="IndicationID" Visible="false"></asp:BoundField>
                    <asp:BoundField DataField="AmounProductID" HeaderText="AmounProductID" ReadOnly="True" SortExpression="AmounProductID" Visible="false"></asp:BoundField>
                    <asp:BoundField DataField="MarketID" HeaderText="MarketID" ReadOnly="True" SortExpression="MarketID" Visible="false"></asp:BoundField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="dsProds" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
                SelectCommand="SELECT [ProductName], [LineID], [MarketName], [MainCompetitor], [MainIndication], [CompetitorID], [IndicationID], [AmounProductID], [MarketID] 
                FROM [View_Survey_Prods]"></asp:SqlDataSource>
            <br />
            <p>
                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                <br />
                <asp:Label ID="lblStatus" runat="server" Text="Ready..."></asp:Label>
                <br /><br /><br />
                <asp:HyperLink ID="h" runat="server" NavigateUrl="~/Reps/Repreport_Dashboard.aspx" Text="Goto Dashboard"></asp:HyperLink>
            </p>
            
        </div>
    </form>
</body>
</html>
