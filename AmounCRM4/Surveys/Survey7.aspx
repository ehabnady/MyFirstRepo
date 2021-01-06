<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Survey7.aspx.cs" Inherits="AmounCRM4.Surveys.Survey7" %>

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

            <asp:SqlDataSource runat="server" ID="dsMarkets" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
                SelectCommand="SELECT Distinct [MarketID], [MarketName] FROM [Survey2_Market] Where LineID = @LineID Order by [MarketName]">
                <SelectParameters>
                    <asp:SessionParameter SessionField="LineID" Name="LineID"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource runat="server" ID="dsProducts" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
                SelectCommand="Select [LineID], [MarketID], [MarketName], [ProductID], [ProductName], [IsAmounProduct] FROM [AmounCRM2].[dbo].[View_Survey2_Prods]
                                Where LineID = @LineID AND MarketID = @MarketID Order By IsAmounProduct Desc, ProductName ASC">
                <SelectParameters>
                    <asp:SessionParameter SessionField="LineID" Name="LineID"></asp:SessionParameter>
                    <asp:ControlParameter ControlID="ddlMarketName" PropertyName="SelectedValue" Name="MarketID"></asp:ControlParameter>
                </SelectParameters>
            </asp:SqlDataSource>
            
            <asp:SqlDataSource runat="server" ID="dsActivities" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
                SelectCommand="SELECT [ActivityID], [ActivityName], [IsGeneral] FROM [Survey_Activities] Where (Deleted is Null or Deleted = 0) AND (IsGeneral = 0 OR IsGeneral IS NULL) Order by [ActivityName]">
            </asp:SqlDataSource>
            
            <asp:SqlDataSource runat="server" ID="dsGeneralActivities" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
                SelectCommand="SELECT [ActivityID], [ActivityName], [IsGeneral] FROM [Survey_Activities] Where (Deleted is Null or Deleted = 0) AND (IsGeneral = 1) Order by [ActivityName]">
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="dsSurveySave" runat="server" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
                SelectCommand="SELECT [SurveyID],[SurveyDate],[PharmacyName],[MarketID],[MarketSalesUnit],[ProductID],[SalesRatio],[ActivityID],[GeneralActivityID] FROM [Survey2]" 
                DeleteCommand="UPDATE [Survey2] SET Deleted = 1 WHERE (EmployeeID = @EmployeeID) AND (PharmacyName = @PharmacyName) AND (MarketID = @MarketID)" 
                InsertCommand="INSERT INTO [Survey2] ([SurveyDate],[PharmacyName],[MarketID],[MarketSalesUnit],[ProductID],[ProductSalesRatio],[ActivityID],[GeneralActivityID],[EmployeeID],[PharmacyID]) 
                VALUES (@SurveyDate, @PharmacyName, @MarketID, @MarketSalesUnit, @ProductID, @ProductSalesRatio, @ActivityID, @GeneralActivityID, @EmployeeID, @PharmacyID)">
                <DeleteParameters>
                    <asp:SessionParameter SessionField="EmployeeID" Name="EmployeeID" Type="Int32"></asp:SessionParameter>
                    <asp:ControlParameter ControlID="txtPharmacy" PropertyName="Text" Name="PharmacyName" Type="String"></asp:ControlParameter>
                    <asp:ControlParameter ControlID="ddlMarketName" PropertyName="SelectedValue" Name="MarketID" Type="Double"></asp:ControlParameter>
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="SurveyDate" Type="DateTime"></asp:Parameter>
                    <asp:Parameter Name="PharmacyName" Type="String"></asp:Parameter>
                    <asp:Parameter Name="MarketID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="MarketSalesUnit" Type="Double"></asp:Parameter>
                    <asp:Parameter Name="ProductID" Type="String"></asp:Parameter>
                    <asp:Parameter Name="ProductSalesRatio" Type="String"></asp:Parameter>
                    <asp:Parameter Name="ActivityID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="GeneralActivityID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="EmployeeID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="PharmacyID" Type="Int32"></asp:Parameter>
                </InsertParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource runat="server" ID="dsSearch" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
                SelectCommand="SELECT DISTINCT [PharmacyName], [PharmacyID], [MarketID], [MarketName], [MarketSalesUnit] FROM [View_Survey2] WHERE ([EmployeeID] = @EmployeeID)">
                <SelectParameters>
                    <asp:SessionParameter SessionField="EmployeeID" Name="EmployeeID" Type="Int32"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource runat="server" ID="dsSurvey2" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
                SelectCommand="SELECT PharmacyName, PharmacyID, MarketID, MarketName, MarketSalesUnit, ProductID, ProductName, IsAmounProduct, ProductSalesRatio, ActivityID, 
                ActivityName, GeneralActivityID, GeneralActivityName FROM View_Survey2
                 WHERE (EmployeeID = @EmployeeID) AND (PharmacyName = @PharmacyName) AND (MarketID = @MarketID)">
                <SelectParameters>
                    <asp:SessionParameter SessionField="EmployeeID" Name="EmployeeID" Type="Int32"></asp:SessionParameter>
                    <asp:ControlParameter ControlID="txtPharmacy" PropertyName="Text" Name="PharmacyName" Type="String"></asp:ControlParameter>
                    <asp:ControlParameter ControlID="ddlMarketName" PropertyName="SelectedValue" Name="MarketID" Type="Double"></asp:ControlParameter>
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource runat="server" ID="dsMarketIndications" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
                SelectCommand="SELECT [MarketID], [MarketName], [IndicationID], [IndicationName] FROM [View_Survey2_Market_Indications] WHERE ([MarketID] = @MarketID) Order By IndicationName">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlMarketName" PropertyName="SelectedValue" Name="MarketID" Type="Double"></asp:ControlParameter>
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource runat="server" ID="dsIndicationsEntry" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
                SelectCommand="SELECT [MarketID], [MarketName], [IndicationID], [IndicationName], [PharmacyName], [PharmacyID], [SalesRatio], [EmployeeID]
                FROM [View_Survey2_IndicationsEntry] 
                WHERE (EmployeeID = @EmployeeID) AND (PharmacyName = @PharmacyName) AND (MarketID = @MarketID)"
                InsertCommand="INSERT INTO Survey2_IndicationsEntry (MarketID, SurveyDate, IndicationID, PharmacyName, EmployeeID, SalesRatio, PharmacyID) VALUES (@MarketID, @SurveyDate, @IndicationID, @PharmacyName, @EmployeeID, @SalesRatio, @PharmacyID)"
                DeleteCommand="UPDATE Survey2_IndicationsEntry SET Deleted = 1 WHERE (EmployeeID = @EmployeeID) AND (PharmacyName = @PharmacyName) AND (MarketID = @MarketID)">
                <SelectParameters>
                    <asp:SessionParameter SessionField="EmployeeID" Name="EmployeeID" Type="Int32"></asp:SessionParameter>
                    <asp:ControlParameter ControlID="txtPharmacy" PropertyName="Text" Name="PharmacyName" Type="String"></asp:ControlParameter>
                    <asp:ControlParameter ControlID="ddlMarketName" PropertyName="SelectedValue" Name="MarketID" Type="Double"></asp:ControlParameter>
                </SelectParameters>
                <InsertParameters>
                    <asp:Parameter Name="MarketID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="SurveyDate" Type="DateTime"></asp:Parameter>
                    <asp:Parameter Name="IndicationID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="PharmacyName" Type="String"></asp:Parameter>
                    <asp:Parameter Name="EmployeeID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="SalesRatio" Type="Double"></asp:Parameter>
                    <asp:Parameter Name="PharmacyID" Type="Int32"></asp:Parameter>
                </InsertParameters>
                <DeleteParameters>
                    <asp:SessionParameter SessionField="EmployeeID" Name="EmployeeID" Type="Int32"></asp:SessionParameter>
                    <asp:ControlParameter ControlID="txtPharmacy" PropertyName="Text" Name="PharmacyName" Type="String"></asp:ControlParameter>
                    <asp:ControlParameter ControlID="ddlMarketName" PropertyName="SelectedValue" Name="MarketID" Type="Double"></asp:ControlParameter>
                </DeleteParameters>
            </asp:SqlDataSource>

            <table style="width:50%">
                <tr style="width:80%">
                    <td style="width:10%">Added Surveys</td>
                    <td style="width:80%">

                        <asp:GridView ID="rg" runat="server" OnSelectedIndexChanged="rg_SelectedIndexChanged" DataSourceID="dsSearch"
                            CellPadding="2" GridLines="Both" AllowSorting="True" AutoGenerateColumns="false" BorderColor="Tan" BorderWidth="1px"
                            HeaderStyle-BackColor="#aeaaaa" HeaderStyle-ForeColor="White">
                            <RowStyle BackColor="#ffc000" ForeColor="Black" />
                            <Columns>
                                <asp:CommandField ShowSelectButton="True"></asp:CommandField>
                                <asp:BoundField DataField="PharmacyName" HeaderText="Pharmacy Name" SortExpression="PharmacyName"></asp:BoundField>
                                <asp:BoundField DataField="PharmacyID" HeaderText="Pharmacy Code" SortExpression="PharmacyID"></asp:BoundField>
                                <asp:BoundField DataField="MarketID" HeaderText="Market ID" SortExpression="MarketID" Visible="false"></asp:BoundField>
                                <asp:BoundField DataField="MarketName" HeaderText="Market Name" SortExpression="MarketName"></asp:BoundField>
                                <asp:BoundField DataField="MarketSalesUnit" HeaderText="Market Sales Packs" SortExpression="MarketSalesUnit"></asp:BoundField>
                            </Columns>

                            <FooterStyle BackColor="Tan"></FooterStyle>
                            <HeaderStyle Font-Bold="True"></HeaderStyle>
                            <PagerStyle HorizontalAlign="Center" BackColor="PaleGoldenrod"></PagerStyle>
                            <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite"></SelectedRowStyle>
                            <SortedAscendingCellStyle BackColor="#FAFAE7"></SortedAscendingCellStyle>
                            <SortedAscendingHeaderStyle BackColor="#DAC09E"></SortedAscendingHeaderStyle>
                            <SortedDescendingCellStyle BackColor="#E1DB9C"></SortedDescendingCellStyle>
                            <SortedDescendingHeaderStyle BackColor="#C2A47B"></SortedDescendingHeaderStyle>
                        </asp:GridView>

                    </td>
                </tr>
            </table>
            <br />
            <table>
                <tr>
                    <td style="width:10%">Pharmacy Name:</td>
                    <td>
                        <asp:TextBox ID="txtPharmacy" runat="server" Text="" Width="260" ReadOnly="true"></asp:TextBox>
                        <asp:Label ID="lblPhamaNote" runat="server" Text="Please Enter Pharmacy Name in Arabic" Font-Italic="true" ForeColor="Gray"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Pharmacy Code:</td>
                    <td><asp:TextBox ID="txtPharmacyID" runat="server" Text="0" Width="260" TextMode="Number"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Market:</td>
                    <td>
                        <telerik:RadDropDownList ID="ddlMarketName" runat="server" AutoPostBack="true" AppendDataBoundItems="true" 
                            DataSourceID="dsMarkets" DataTextField="MarketName"  DataValueField="MarketID"
                            OnSelectedIndexChanged="ddlMarketName_SelectedIndexChanged" Width="260">
                            <Items>
                                <telerik:DropDownListItem Text="None" Value="0" />
                            </Items>
                        </telerik:RadDropDownList>
                        <asp:Label ID="lblMarketPacks" runat="server" Text="Packs per Month"></asp:Label>
                        <asp:TextBox ID="txtMarketSalesUnit" runat="server" Width="50" TextMode="Number"></asp:TextBox>
                        <asp:rangevalidator ID="Rangevalidator2" errormessage="Please enter value between 1-9999." forecolor="Red" 
                            controltovalidate="txtMarketSalesUnit" minimumvalue="1" maximumvalue="9999" runat="server" Type="Integer">
                        </asp:rangevalidator>
                    </td>
                </tr>

                <tr>
                    <td colspan="2" style="height:50px"></td>
                </tr>

                <tr>
                    <td></td>
                    <td style="text-align:left">
                        <asp:CheckBox ID="chkDelete" runat="server" Text="Delete This Survey" Checked="false" TextAlign="Right" />
                        <asp:Label ID="lblReminder" runat="server" Text="(Don't Forget to Press Save)" Font-Italic="true" ForeColor="Gray"></asp:Label>
                    </td>
                </tr>
            
                <tr>
                    <td colspan="2" style="height:50px"></td>
                </tr>

                <tr>
                    <td>Products:</td>
                    <td>
                        <asp:GridView ID="grdProducts" runat="server" DataSourceID="dsProducts" AutoGenerateColumns="False" 
                            HeaderStyle-BackColor="#aeaaaa" HeaderStyle-ForeColor="White">
                            <Columns>
                                <asp:TemplateField HeaderText="Product" ItemStyle-BackColor="#2f75b5" ItemStyle-ForeColor="White">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlProducts" runat="server" AppendDataBoundItems="true" DataSourceID="dsProducts"
                                            DataTextField="ProductName" DataValueField="ProductID">
                                            <asp:ListItem Enabled="true" Text="None" Value="0" Selected="True"></asp:ListItem>
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lbl2" runat="server" Text=""></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>

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

                                <asp:TemplateField HeaderText="Pharmacy Activity" ItemStyle-BackColor="#ffc000">
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

                                <asp:BoundField DataField="LineID" HeaderText="LineID" SortExpression="LineID" Visible="false"></asp:BoundField>
                                <asp:BoundField DataField="MarketName" HeaderText="MarketName" SortExpression="MarketName" Visible="false"></asp:BoundField>
                                <asp:BoundField DataField="ProductID" HeaderText="ProductID" ReadOnly="True" SortExpression="ProductID" Visible="false"></asp:BoundField>
                                <asp:BoundField DataField="MarketID" HeaderText="MarketID" ReadOnly="True" SortExpression="MarketID" Visible="false"></asp:BoundField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
            
                <tr>
                    <td colspan="2" style="height:50px"></td>
                </tr>

                <tr style="visibility:visible">
                    <td>Indications:</td>
                    <td>
                        <asp:GridView ID="grdIndications" runat="server" DataSourceID="dsMarketIndications" AutoGenerateColumns="False"
                            HeaderStyle-BackColor="#aeaaaa" HeaderStyle-ForeColor="White">
                            <Columns>
                                <asp:TemplateField HeaderText="Indication" ItemStyle-BackColor="#ffc000">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlIndication" runat="server" AppendDataBoundItems="true" DataSourceID="dsMarketIndications"
                                            DataTextField="IndicationName" DataValueField="IndicationID">
                                            <asp:ListItem Enabled="true" Text="None" Value="0" Selected="True"></asp:ListItem>
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lbl2" runat="server" Text=""></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>

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

                                <asp:BoundField DataField="IndicationID" HeaderText="IndicationID" SortExpression="IndicationID" Visible="false"></asp:BoundField>
                                <asp:BoundField DataField="MarketID" HeaderText="MarketID" SortExpression="MarketID" Visible="false"></asp:BoundField>
                                <asp:BoundField DataField="MarketName" HeaderText="MarketName" SortExpression="MarketName" Visible="false"></asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        
                    </td>
                </tr>
                            
                <tr>
                    <td colspan="2" style="height:50px"></td>
                </tr>

                <tr>
                    <td style="text-align:left">
                        
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                    </td>
                </tr>
                
                <tr>
                    <td></td>
                    <td style="height:50px">
                        <asp:Label ID="lblStatus" runat="server" Text="Ready..." ForeColor="Red"></asp:Label>
                    </td>
                </tr>

                <tr>
                    <td></td>
                    <td>
                        <asp:HyperLink ID="h" runat="server" NavigateUrl="~/Reps/Repreport_Dashboard.aspx" Text="Go to Dashboard"></asp:HyperLink>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
