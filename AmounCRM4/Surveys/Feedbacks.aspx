<%@ Page Title="Pharmacies Feedback" Language="C#" MasterPageFile="~/FeedbackSite4.Master" AutoEventWireup="true" CodeBehind="Feedbacks.aspx.cs" Inherits="AmounCRM4.Surveys.Feedbacks" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <title>Pharmacies Feedback</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <br /><br />
    <div>
        <asp:SqlDataSource runat="server" ID="dsSearch" ConnectionString='<%$ ConnectionStrings:AmounCRM2ConnectionString10101423 %>' 
            SelectCommand="SELECT DISTINCT [FeedbackID], [PharmacyID], [PharmacyName], CONCAT([PharmacyID], ' - ', [PharmacyName]) as Conc, [FeedbackDate], [MarketID], [MarketName], 
            [MarketMonthlySalesUnit], [AmounBrickName], [RepAreaName] FROM [View_PH_Feedback_FullView] WHERE ([EmployeeID] = @EmployeeID) ORDER BY [FeedbackDate] DESC">
            <SelectParameters>
                <asp:SessionParameter SessionField="EmployeeIDFromSales" Name="EmployeeID" Type="Int32"></asp:SessionParameter>
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource runat="server" ID="dsPharmacies" ConnectionString='<%$ ConnectionStrings:AmounCRM2ConnectionString10101423 %>'
            SelectCommand="SELECT PharmacyID, PharmacyName, CONCAT(PharmacyID, ' - ', PharmacyName) as 'ID_Name' FROM dbo.View_PH_PharmacyEmployees_SalesReps Where EmployeeID = @EmployeeID Order by [PharmacyID]">
            <SelectParameters>
                <asp:SessionParameter SessionField="EmployeeHRCodeFromSales" Name="EmployeeID"></asp:SessionParameter>
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource runat="server" ID="dsMarkets" ConnectionString='<%$ ConnectionStrings:AmounCRM2ConnectionString10101423 %>'
            SelectCommand="SELECT Distinct [MarketID], [MarketName] FROM [PH_Markets] Where LineID = @LineID Or MarketID > 0 Order by [MarketName]">
            <SelectParameters>
                <asp:SessionParameter SessionField="LineIDFromSales" Name="LineID"></asp:SessionParameter>
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource runat="server" ID="dsProducts" ConnectionString='<%$ ConnectionStrings:AmounCRM2ConnectionString10101423 %>' 
            SelectCommand="Select [LineID], [MarketID], [MarketName], [ProductID], [ProductName], [IsAmounProduct] FROM [View_PH_MarketProducts] Where (LineID = @LineID Or LineID > 0) AND MarketID = @MarketID Order By IsAmounProduct Desc, ProductName ASC">
            <SelectParameters>
                <asp:SessionParameter SessionField="LineIDFromSales" Name="LineID"></asp:SessionParameter>
                <asp:ControlParameter ControlID="ddlMarket" PropertyName="SelectedValue" Name="MarketID"></asp:ControlParameter>
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource runat="server" ID="dsActivities" ConnectionString='<%$ ConnectionStrings:AmounCRM2ConnectionString10101423 %>'
            SelectCommand="SELECT [ActivityID], [ActivityName], [IsGeneral] FROM [PH_Activities] Where (Deleted is Null or Deleted = 0) AND (IsGeneral = 0 OR IsGeneral IS NULL) Order by [ActivityName]">
        </asp:SqlDataSource>
            
        <asp:SqlDataSource runat="server" ID="dsGeneralActivities" ConnectionString='<%$ ConnectionStrings:AmounCRM2ConnectionString10101423 %>'
            SelectCommand="SELECT [ActivityID], [ActivityName], [IsGeneral] FROM [PH_Activities] Where (Deleted is Null or Deleted = 0) AND (IsGeneral = 1) Order by [ActivityName]">
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="dsFeedbackHeadSave" runat="server" ConnectionString='<%$ ConnectionStrings:AmounCRM2ConnectionString10101423 %>'
            SelectCommand="SELECT [CycleID], [FeedbackID], [FeedbackDate], [PharmacyID], [EmployeeID], [LineID], [Deleted] FROM [PH_FeedbackHeader]"
            DeleteCommand="UPDATE [PH_FeedbackHeader] SET Deleted = 1 WHERE [FeedbackID] = @FeedbackID"
            InsertCommand="INSERT INTO [PH_FeedbackHeader] ([CycleID], [FeedbackDate], [PharmacyID], [EmployeeID], [LineID], [Deleted]) OUTPUT INSERTED.FeedbackID VALUES (@CycleID, @FeedbackDate, @PharmacyID, @EmployeeID, @LineID, @Deleted)" 
            UpdateCommand="UPDATE [PH_FeedbackHeader] SET [CycleID] = @CycleID, [FeedbackDate] = @FeedbackDate, [PharmacyID] = @PharmacyID, [EmployeeID] = @EmployeeID, [LineID] = @LineID, [Deleted] = @Deleted WHERE [FeedbackID] = @FeedbackID">
            <DeleteParameters>
                <asp:Parameter Name="FeedbackID" Type="Int32"></asp:Parameter>
            </DeleteParameters>
            <InsertParameters>
                <asp:SessionParameter Name="CycleID" SessionField="CycleIDFromSales" Type="Int32"></asp:SessionParameter>
                <asp:ControlParameter Name="FeedbackDate" ControlID="dtpFeedbackDate" PropertyName="SelectedDate" Type="DateTime"></asp:ControlParameter>
                <asp:ControlParameter Name="PharmacyID" ControlID="txtPhID" PropertyName="Text" Type="Int32"></asp:ControlParameter>
                <asp:SessionParameter Name="EmployeeID" SessionField="EmployeeIDFromSales" Type="Int32"></asp:SessionParameter>
                <asp:SessionParameter Name="LineID" SessionField="LineIDFromSales" Type="Int32"></asp:SessionParameter>
                <asp:ControlParameter Name="Deleted" ControlID="chkDelete" PropertyName="Checked" Type="Boolean"></asp:ControlParameter>
            </InsertParameters>
            <UpdateParameters>
                <asp:SessionParameter Name="CycleID" SessionField="CycleIDFromSales" Type="Int32"></asp:SessionParameter>
                <asp:Parameter Name="FeedbackDate" Type="DateTime"></asp:Parameter>
                <asp:Parameter Name="PharmacyID" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="EmployeeID" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="LineID" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="Deleted" Type="Boolean"></asp:Parameter>
                <asp:Parameter Name="FeedbackID" Type="Int32"></asp:Parameter>
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="dsFeedbackMarketsSave" runat="server" ConnectionString='<%$ ConnectionStrings:AmounCRM2ConnectionString10101423 %>'
            SelectCommand="SELECT [FeedbackMarketRecID], [FeedbackID], [MarketID], [MarketMonthlySalesUnit], [Deleted] FROM [PH_FeedbackMarkets]"
            DeleteCommand="UPDATE [PH_FeedbackMarkets] SET Deleted = 1 WHERE [FeedbackID] = @FeedbackID AND MarketID = @MarketID"
            InsertCommand="INSERT INTO [PH_FeedbackMarkets] ([FeedbackID], [MarketID], [MarketMonthlySalesUnit], [Deleted]) OUTPUT INSERTED.FeedbackMarketRecID VALUES (@FeedbackID, @MarketID, @MarketMonthlySalesUnit, @Deleted)" 
            UpdateCommand="UPDATE [PH_FeedbackMarkets] SET [FeedbackID] = @FeedbackID, [MarketID] = @MarketID, [MarketMonthlySalesUnit] = @MarketMonthlySalesUnit, [Deleted] = @Deleted WHERE [FeedbackMarketRecID] = @FeedbackMarketRecID">
            <DeleteParameters>
                <asp:Parameter Name="FeedbackID" Type="Int32"></asp:Parameter>
                <asp:ControlParameter Name="MarketID" ControlID="ddlMarket" PropertyName="SelectedValue" Type="Int32"></asp:ControlParameter>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="FeedbackID" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="MarketID" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="MarketMonthlySalesUnit" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="Deleted" Type="Boolean"></asp:Parameter>
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="FeedbackID" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="MarketID" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="MarketMonthlySalesUnit" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="Deleted" Type="Boolean"></asp:Parameter>
                <asp:Parameter Name="FeedbackMarketRecID" Type="Int32"></asp:Parameter>
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="dsFeedbackMarketProductsSave" runat="server" ConnectionString='<%$ ConnectionStrings:AmounCRM2ConnectionString10101423 %>'
            SelectCommand="SELECT [FeedbackMarketProductRecID], [FeedbackMarketID], [ProductID], [SalesRatio], [ActivityID], [GeneralActivityID], [Deleted], [FeedbackID] FROM [View_PH_FeedbackMarketProducts]"
            DeleteCommand="UPDATE [PH_FeedbackMarketProducts] SET Deleted = 1 WHERE [FeedbackMarketRecID] = @FeedbackMarketRecID AND Deleted = 0"
            InsertCommand="INSERT INTO [PH_FeedbackMarketProducts] ([FeedbackMarketID], [ProductID], [SalesRatio], [ActivityID], [GeneralActivityID], [Deleted]) VALUES (@FeedbackMarketID, @ProductID, @SalesRatio, @ActivityID, @GeneralActivityID, @Deleted)" 
            UpdateCommand="UPDATE [PH_FeedbackMarketProducts] SET [FeedbackMarketID] = @FeedbackMarketID, [ProductID] = @ProductID, [SalesRatio] = @SalesRatio, [ActivityID] = @ActivityID, [GeneralActivityID] = @GeneralActivityID, [Deleted] = @Deleted WHERE [FeedbackMarketProductRecID] = @FeedbackMarketProductRecID">
            <DeleteParameters>
                <asp:Parameter Name="FeedbackMarketRecID" Type="Int32"></asp:Parameter>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="FeedbackMarketID" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="ProductID" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="SalesRatio" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="ActivityID" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="GeneralActivityID" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="Deleted" Type="Boolean"></asp:Parameter>
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="FeedbackMarketID" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="ProductID" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="SalesRatio" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="ActivityID" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="GeneralActivityID" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="Deleted" Type="Boolean"></asp:Parameter>
                <asp:Parameter Name="FeedbackMarketProductRecID" Type="Int32"></asp:Parameter>
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="dsFeedbackMarketIndicationsSave" runat="server" ConnectionString='<%$ ConnectionStrings:AmounCRM2ConnectionString10101423 %>'
            SelectCommand="SELECT [FeedbackMarketIndicationRecID], [FeedbackMarketRecID], [IndicationID], [SalesRatio], [Deleted], [FeedbackID] FROM [View_PH_FeedbackMarketIndications]"
            DeleteCommand="UPDATE [PH_FeedbackMarketIndications] SET Deleted = 1 WHERE [FeedbackMarketRecID] = @FeedbackMarketRecID AND Deleted = 0"
            InsertCommand="INSERT INTO [PH_FeedbackMarketIndications] ([FeedbackMarketRecID], [IndicationID], [SalesRatio], [Deleted]) 
            VALUES (@FeedbackMarketRecID, @IndicationID, @SalesRatio, @Deleted)" 
            UpdateCommand="UPDATE [PH_FeedbackMarketIndications] SET [FeedbackMarketRecID] = @FeedbackMarketRecID, [IndicationID] = @IndicationID, [SalesRatio] = @SalesRatio, [Deleted] = @Deleted WHERE [FeedbackMarketIndicationRecID] = @FeedbackMarketIndicationRecID">
            <DeleteParameters>
                <asp:Parameter Name="FeedbackMarketRecID" Type="Int32"></asp:Parameter>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="FeedbackMarketRecID" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="IndicationID" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="SalesRatio" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="Deleted" Type="Boolean"></asp:Parameter>
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="FeedbackMarketRecID" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="IndicationID" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="SalesRatio" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="Deleted" Type="Boolean"></asp:Parameter>
                <asp:Parameter Name="FeedbackMarketIndicationRecID" Type="Int32"></asp:Parameter>
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource runat="server" ID="dsMarketIndications" ConnectionString='<%$ ConnectionStrings:AmounCRM2ConnectionString10101423 %>' 
            SelectCommand="SELECT [MarketID], [MarketName], [IndicationID], [IndicationName] FROM [View_PH_MarketIndications] WHERE ([MarketID] = @MarketID) Order By IndicationName">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlMarket" PropertyName="SelectedValue" Name="MarketID" Type="Double"></asp:ControlParameter>
            </SelectParameters>
        </asp:SqlDataSource>
    </div>

    <table style="width:80%" border="0">
        <tr>
            <td style="height:50px">
                <asp:Label ID="lblStatus2" runat="server" Text="Ready..." ForeColor="Red"></asp:Label>
            </td>
        </tr>
        <tr style="width:100%">
            <td style="width:100%" colspan="2">
                <telerik:RadGrid ID="grdFeedbacks" runat="server" DataSourceID="dsSearch" AllowFilteringByColumn="True" AllowPaging="True"
                    EnableGroupsExpandAll="false" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
                    AllowSorting="True" ShowGroupPanel="false" Height="600px" Culture="en-GB"
                    Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True" OnSelectedIndexChanged="grdFeedbacks_SelectedIndexChanged">

                    <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="Feedback List">
                        <Excel Format="Xlsx" />
                    </ExportSettings>

                    <ClientSettings AllowDragToGroup="false" AllowExpandCollapse="false">
                        <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                        <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                    </ClientSettings>

                    <MasterTableView DataSourceID="dsSearch" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                        AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true" AllowMultiColumnSorting="true">
                        <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                        <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                        <Columns>
                            <telerik:GridButtonColumn Text="Select" ButtonType="LinkButton" CommandName="Select" HeaderStyle-Width="70px" ItemStyle-Width="70px" FooterStyle-Width="70px"></telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="FeedbackID" Visible="true" DataType="System.Int64" FilterControlAltText="Filter ID column" HeaderText="ID" SortExpression="FeedbackID" UniqueName="FeedbackID"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FeedbackDate" Visible="true" DataType="System.DateTime" FilterControlAltText="Filter FeedbackDate column" HeaderText="Date" SortExpression="FeedbackDate" UniqueName="FeedbackDate" DataFormatString="{0:MM/dd/yyyy}"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Conc" Visible="true" FilterControlAltText="Filter Pharmacy column" HeaderText="Ph. Name" SortExpression="PharmacyName" UniqueName="PharmacyName"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="MarketName" Visible="true" FilterControlAltText="Filter Market column" HeaderText="Market" SortExpression="MarketName" UniqueName="MarketName"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="MarketMonthlySalesUnit" Visible="true" FilterControlAltText="Filter MarketMonthlySalesUnit column" HeaderText="Monthly Sales" SortExpression="MarketMonthlySalesUnit" UniqueName="MarketMonthlySalesUnit"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="AmounBrickName" Visible="true" FilterControlAltText="Filter AmounBrickName column" HeaderText="Brick" SortExpression="AmounBrickName" UniqueName="AmounBrickName"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="RepAreaName" Visible="true" FilterControlAltText="Filter RepAreaName column" HeaderText="Territory" SortExpression="RepAreaName" UniqueName="RepAreaName"></telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
        
        <tr>
            <td colspan="2">
                <br />

                <table style="width:100%">
                    <tr style="width:100%">
                        <td style="width:10%">
                            <asp:Label ID="lblPhName" runat="server" Text="Pharmacy Name:"></asp:Label>
                        </td>
                        <td style="width:40%">
                            <telerik:RadDropDownList ID="ddlPhName" runat="server" DataSourceID="dsPharmacies" DataValueField="PharmacyID" DataTextField="ID_Name" AppendDataBoundItems="true">
                                <Items>
                                    <telerik:DropDownListItem Text="Select" Value="0" />
                                </Items>
                            </telerik:RadDropDownList>
                        </td>

                        <td style="width:10%">
                            <asp:Label ID="lblFeedback" runat="server" Text="Visit Date:"></asp:Label>
                        </td>
                        <td style="width:40%">
                            <telerik:RadDatePicker ID="dtpFeedbackDate" runat="server" AutoPostBack="false" Calendar-EnableMultiSelect="False" 
                                Calendar-FirstDayOfWeek="Saturday" DateInput-DateFormat="dd/MM/yyyy" DateInput-DisplayDateFormat="dd/MM/yyyy">
                                <Calendar runat="server">
                                    <SpecialDays>
                                        <telerik:RadCalendarDay Date="07/07/2017" IsWeekend="true" IsSelectable="false" IsDisabled="true" Repeatable="Week">
                                        </telerik:RadCalendarDay>
                                    </SpecialDays>
                                    <DisabledDayStyle BackColor="LightGray" />
                                </Calendar>
                            </telerik:RadDatePicker>
                        </td>
                    </tr>

                    <tr style="width:100%">
                        <td style="width:10%">
                            <asp:Label ID="lblMarket" runat="server" Text="Market"></asp:Label>
                        </td>
                        <td style="width:40%">
                            <telerik:RadDropDownList ID="ddlMarket" runat="server" DataSourceID="dsMarkets" DataTextField="MarketName" DataValueField="MarketID"
                                AppendDataBoundItems="true" OnSelectedIndexChanged="ddlMarket_SelectedIndexChanged" AutoPostBack="true">
                                <Items>
                                    <telerik:DropDownListItem Text="Select" Value="0" />
                                </Items>
                            </telerik:RadDropDownList>
                        </td>

                        <td style="width:10%">
                            <asp:Label ID="lblMonthlySales" runat="server" Text="Total Market Packs Sold per Week:"></asp:Label>
                        </td>
                        <td style="width:40%">
                            <asp:TextBox ID="txtMarketSalesUnit" runat="server" Width="50" TextMode="Number"></asp:TextBox>
                            <asp:RangeValidator ID="Rangevalidator2" errormessage="Please enter value between 1 and 9999." forecolor="Red" 
                                controltovalidate="txtMarketSalesUnit" minimumvalue="1" maximumvalue="9999" runat="server" Type="Integer">
                            </asp:RangeValidator>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>

        <tr>
            <td colspan="2">
                <br />

                <asp:CheckBox ID="chkDelete" runat="server" Text="Delete This Feedback" Checked="false" TextAlign="Right" />
                <asp:Label ID="lblReminder" runat="server" Text="(Don't Forget to Press Save)" Font-Italic="true" ForeColor="Gray"></asp:Label>

                <P><br /></P>

                <asp:GridView ID="grdProducts" runat="server" DataSourceID="dsProducts" AutoGenerateColumns="False" 
                    HeaderStyle-BackColor="#aeaaaa" HeaderStyle-ForeColor="White" ShowHeaderWhenEmpty="true">
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
                                    <asp:ListItem Enabled="true" Text="5%" Value="5"></asp:ListItem>
                                    <asp:ListItem Enabled="true" Text="10%" Value="10"></asp:ListItem>
                                    <asp:ListItem Enabled="true" Text="15%" Value="15"></asp:ListItem>
                                    <asp:ListItem Enabled="true" Text="20%" Value="20"></asp:ListItem>
                                    <asp:ListItem Enabled="true" Text="25%" Value="25"></asp:ListItem>
                                    <asp:ListItem Enabled="true" Text="30%" Value="30"></asp:ListItem>
                                    <asp:ListItem Enabled="true" Text="35%" Value="35"></asp:ListItem>
                                    <asp:ListItem Enabled="true" Text="40%" Value="40"></asp:ListItem>
                                    <asp:ListItem Enabled="true" Text="45%" Value="45"></asp:ListItem>
                                    <asp:ListItem Enabled="true" Text="50%" Value="50"></asp:ListItem>
                                    <asp:ListItem Enabled="true" Text="55%" Value="55"></asp:ListItem>
                                    <asp:ListItem Enabled="true" Text="60%" Value="60"></asp:ListItem>
                                    <asp:ListItem Enabled="true" Text="65%" Value="65"></asp:ListItem>
                                    <asp:ListItem Enabled="true" Text="70%" Value="70"></asp:ListItem>
                                    <asp:ListItem Enabled="true" Text="75%" Value="75"></asp:ListItem>
                                    <asp:ListItem Enabled="true" Text="80%" Value="80"></asp:ListItem>
                                    <asp:ListItem Enabled="true" Text="85%" Value="85"></asp:ListItem>
                                    <asp:ListItem Enabled="true" Text="90%" Value="90"></asp:ListItem>
                                    <asp:ListItem Enabled="true" Text="95%" Value="95"></asp:ListItem>
                                    <asp:ListItem Enabled="true" Text="100%" Value="100"></asp:ListItem>
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
            <td colspan="2">
                <p><br /></p>
                <asp:GridView ID="grdIndications" runat="server" DataSourceID="dsMarketIndications" AutoGenerateColumns="False"
                    HeaderStyle-BackColor="#aeaaaa" HeaderStyle-ForeColor="White" ShowHeaderWhenEmpty="true">
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
            <td align="left">
                <asp:Button ID="btnSave" runat="server" Text="Save Feedback" OnClick="btnSave_Click" />
            </td>
            <td align="right">
                <asp:Button ID="btnClear" runat="server" Text="New Feedback" OnClick="btnClear_Click" />
            </td>
        </tr>
                
        <tr>
            <td></td>
            <td style="height:50px">
                <asp:Label ID="lblStatus" runat="server" Text="Ready..." ForeColor="Red"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>
