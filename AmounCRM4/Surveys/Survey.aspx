<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Survey.aspx.cs" Inherits="AmounCRM4.Surveys.Survey" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="SCM1" runat="server"></telerik:RadScriptManager>
        <div>
            <br />
            <p>
                <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
                <br />

                <telerik:RadComboBox RenderMode="Lightweight" ID="RadComboBox1" runat="server" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" 
                    Width="500" Label="Select One or More Activity: " DataSourceID="dsActivities2" DataTextField="ActivityName" DataValueField="ActivityID"
                     OnItemChecked="RadComboBox1_ItemChecked" AutoPostBack="true"> 
                </telerik:RadComboBox>
                    
                <asp:SqlDataSource runat="server" ID="dsActivities2" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
                SelectCommand="SELECT [ActivityID], [ActivityName], [Deleted] FROM [Survey_Activities] Where ([Deleted] IS NULL OR [Deleted] = 0) Order by [ActivityName]"></asp:SqlDataSource>
            </p>
            <br />

            <table style="margin-left: 40px">
                <tr>
                    <td>
                        <div>
                            <br />
                            <telerik:RadGrid ID="grdSurvey" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True" ShowGroupPanel="True" Skin="WebBlue"
                                EnableHeaderContextAggregatesMenu="True" EnableHeaderContextFilterMenu="True"
                                EnableHeaderContextMenu="True" ShowFooter="True" DataSourceID="dsSaving" CellSpacing="-1" GridLines="Both" Width="95%" HorizontalAlign="Center"
                                AutoGenerateEditColumn="true"
                                OnItemCommand="grdSurvey_ItemCommand" OnUpdateCommand="grdSurvey_UpdateCommand"
                                OnInsertCommand="grdSurvey_InsertCommand" OnEditCommand="grdSurvey_EditCommand"
                                 PageSize="400">

                                <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="Survey">
                                    <Excel Format="Xlsx" />
                                </ExportSettings>

                                <ClientSettings AllowDragToGroup="True" AllowColumnsReorder="True" EnablePostBackOnRowClick="true">
                                    <Selecting AllowRowSelect="True"></Selecting>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
                                    <Resizing AllowColumnResize="True" AllowRowResize="True" EnableRealTimeResize="True" AllowResizeToFit="True" EnableNextColumnResize="True"></Resizing>
                                </ClientSettings>

                                <MasterTableView AutoGenerateColumns="False" DataKeyNames="SurveyID" EnableHeaderContextAggregatesMenu="True" ShowGroupFooter="True" CommandItemDisplay="Top">
                                    <CommandItemSettings ShowExportToExcelButton="True" ShowRefreshButton="true" ShowAddNewRecordButton="true" AddNewRecordText="New"></CommandItemSettings>
                                    <PagerStyle AlwaysVisible="True" PageSizes="100;200;300;400;500" Mode="NextPrevAndNumeric" />

                                    <Columns>
                                        <telerik:GridTemplateColumn ReadOnly="True" HeaderText="Survey No." SortExpression="SurveyID" UniqueName="SurveyID" DataType="System.Int32" DataField="SurveyID"
                                            Groupable="true" GroupByExpression="SurveyID Group By SurveyID" ColumnGroupName="SurveyID">
                                            <HeaderStyle Width="250px" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblSurveyID" runat="server" Text='<%# Eval("SurveyID") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:Label ID="lblSurveyID_E" runat="server" Text='<%# Eval("SurveyID") %>'></asp:Label>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <asp:Label ID="lblSurveyID_I" runat="server" Text="" Visible="false"></asp:Label>
                                            </InsertItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Pharmacy" SortExpression="Pharmacy" UniqueName="Pharmacy" DataType="System.String" 
                                            DataField="Pharmacy" Groupable="true" GroupByExpression="Pharmacy Group By Pharmacy" ColumnGroupName="Pharmacy">
                                            <HeaderStyle Width="250px" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblPharmacy" runat="server" Text='<%# Eval("Pharmacy") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="lblPharmacy_E" runat="server" Text='<%# Eval("Pharmacy") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <asp:TextBox ID="lblPharmacy_I" runat="server" Text=""></asp:TextBox>
                                            </InsertItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Amoun Product" SortExpression="BrandName" UniqueName="BrandName" FilterControlAltText="Filter BrandName column"
                                            DataField="BrandName" Groupable="true" GroupByExpression="BrandName Group By BrandName" ColumnGroupName="BrandName">
                                            <HeaderStyle Width="250px" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblBrandName" runat="server" Text='<%# Eval("BrandName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadDropDownList ID="ddlBrandName_E" runat="server" DataSourceID="dsAmounProducts" DataTextField="BrandName" 
                                                    DataValueField="AmounProductCode" AppendDataBoundItems="true" SelectedValue='<%# Eval("AmounProductCode") %>'>
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Select" Value="0" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <telerik:RadDropDownList ID="ddlBrandName_I" runat="server" DataSourceID="dsAmounProducts" DataTextField="BrandName" 
                                                    DataValueField="AmounProductCode" AppendDataBoundItems="true" SelectedValue='<%# Eval("AmounProductCode") %>'>
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Select" Value="0" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                            </InsertItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        
                                        <telerik:GridTemplateColumn HeaderText="Market" SortExpression="MarketName" UniqueName="MarketName" DataType="System.String" 
                                            DataField="MarketName" Groupable="true" GroupByExpression="MarketName Group By MarketName" ColumnGroupName="MarketName">
                                            <HeaderStyle Width="250px" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblMarketName" runat="server" Text='<%# Eval("MarketName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadDropDownList ID="ddlMarketName_E" runat="server" DataSourceID="dsMarket" DataTextField="MarketName" 
                                                    DataValueField="MarketID" AppendDataBoundItems="true" SelectedValue='<%# Eval("MarketID") %>'>
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Select" Value="0" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <telerik:RadDropDownList ID="ddlMarketName_I" runat="server" DataSourceID="dsMarket" DataTextField="MarketName" 
                                                    DataValueField="MarketID" AppendDataBoundItems="true" SelectedValue='<%# Eval("MarketID") %>'>
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Select" Value="0" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                            </InsertItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Competitor" SortExpression="CompetingProductName" UniqueName="CompetingProductName" FilterControlAltText="Filter CompetingProductName column"
                                            DataField="CompetingProductName" Groupable="true" GroupByExpression="CompetingProductName Group By CompetingProductName" ColumnGroupName="CompetingProductName">
                                            <HeaderStyle Width="250px" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblCompetingProductName" runat="server" Text='<%# Eval("CompetingProductName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadDropDownList ID="ddlCompetingProductName_E" runat="server" DataSourceID="dsCompetitor" DataTextField="CompetingProductName" 
                                                    DataValueField="CompetingProductCode" AppendDataBoundItems="true" SelectedValue='<%# Eval("CompetingProductCode") %>'>
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Select" Value="0" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <telerik:RadDropDownList ID="ddlCompetingProductName_I" runat="server" DataSourceID="dsCompetitor" DataTextField="CompetingProductName" 
                                                    DataValueField="CompetingProductCode" AppendDataBoundItems="true" SelectedValue='<%# Eval("CompetingProductCode") %>'>
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Select" Value="0" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                            </InsertItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        
                                        <telerik:GridTemplateColumn HeaderText="Indication" SortExpression="IndicationName" UniqueName="IndicationName" DataType="System.String" 
                                            DataField="IndicationName" Groupable="true" GroupByExpression="IndicationName Group By IndicationName" ColumnGroupName="IndicationName">
                                            <HeaderStyle Width="250px" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblIndicationName" runat="server" Text='<%# Eval("IndicationName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadDropDownList ID="ddlIndicationName_E" runat="server" DataSourceID="dsView_Survey_Market_Indications" DataTextField="IndicationName" 
                                                    DataValueField="IndicationID" AppendDataBoundItems="true" SelectedValue='<%# Eval("IndicationID") %>'>
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Select" Value="0" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <telerik:RadDropDownList ID="ddlIndicationName_I" runat="server" DataSourceID="dsView_Survey_Market_Indications" DataTextField="IndicationName" 
                                                    DataValueField="IndicationID" AppendDataBoundItems="true" SelectedValue='<%# Eval("IndicationID") %>'>
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Select" Value="0" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                            </InsertItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Activity" SortExpression="ActivityName" UniqueName="ActivityName" DataType="System.String" 
                                            DataField="ActivityName" Groupable="true" GroupByExpression="ActivityName Group By ActivityName" ColumnGroupName="ActivityName">
                                            <HeaderStyle Width="250px" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblActivityName" runat="server" Text='<%# Eval("ActivityName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadDropDownList ID="ddlActivityName_E" runat="server" DataSourceID="dsActivities" DataTextField="ActivityName" 
                                                    DataValueField="ActivityID" AppendDataBoundItems="true" SelectedValue='<%# Eval("ActivityID") %>'>
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Select" Value="0" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <telerik:RadDropDownList ID="ddlActivityName_I" runat="server" DataSourceID="dsActivities" DataTextField="ActivityName" 
                                                    DataValueField="ActivityID" AppendDataBoundItems="true" SelectedValue='<%# Eval("ActivityID") %>'>
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Select" Value="0" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                            </InsertItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="% of Sales" SortExpression="SalesRatio" UniqueName="SalesRatio" DataType="System.Double" 
                                            DataField="SalesRatio" Groupable="true" GroupByExpression="SalesRatio Group By SalesRatio" ColumnGroupName="SalesRatio">
                                            <HeaderStyle Width="250px" />
                                            <ItemTemplate>
                                                <asp:Label ID="txtSalesRatio" runat="server" Text='<%# Eval("SalesRatio") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadDropDownList ID="ddlSalesRatio_E" runat="server" AppendDataBoundItems="true" 
                                                    SelectedValue='<%# Eval("SalesRatio") %>'>
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Select" Value="0" />
                                                        <telerik:DropDownListItem Text="5" Value="5" /><telerik:DropDownListItem Text="10" Value="10" />
                                                        <telerik:DropDownListItem Text="15" Value="15" /><telerik:DropDownListItem Text="20" Value="20" />
                                                        <telerik:DropDownListItem Text="25" Value="25" /><telerik:DropDownListItem Text="30" Value="30" />
                                                        <telerik:DropDownListItem Text="35" Value="35" /><telerik:DropDownListItem Text="40" Value="40" />
                                                        <telerik:DropDownListItem Text="45" Value="45" /><telerik:DropDownListItem Text="50" Value="50" />
                                                        <telerik:DropDownListItem Text="55" Value="55" /><telerik:DropDownListItem Text="60" Value="60" />
                                                        <telerik:DropDownListItem Text="65" Value="65" /><telerik:DropDownListItem Text="70" Value="70" />
                                                        <telerik:DropDownListItem Text="75" Value="75" /><telerik:DropDownListItem Text="80" Value="80" />
                                                        <telerik:DropDownListItem Text="85" Value="85" /><telerik:DropDownListItem Text="90" Value="90" />
                                                        <telerik:DropDownListItem Text="95" Value="95" /><telerik:DropDownListItem Text="100" Value="100" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <telerik:RadDropDownList ID="ddlSalesRatio_I" runat="server" AppendDataBoundItems="true" 
                                                    SelectedValue='<%# Eval("SalesRatio") %>'>
                                                    <Items>
                                                        <telerik:DropDownListItem Text="Select" Value="0" />
                                                        <telerik:DropDownListItem Text="5" Value="5" /><telerik:DropDownListItem Text="10" Value="10" />
                                                        <telerik:DropDownListItem Text="15" Value="15" /><telerik:DropDownListItem Text="20" Value="20" />
                                                        <telerik:DropDownListItem Text="25" Value="25" /><telerik:DropDownListItem Text="30" Value="30" />
                                                        <telerik:DropDownListItem Text="35" Value="35" /><telerik:DropDownListItem Text="40" Value="40" />
                                                        <telerik:DropDownListItem Text="45" Value="45" /><telerik:DropDownListItem Text="50" Value="50" />
                                                        <telerik:DropDownListItem Text="55" Value="55" /><telerik:DropDownListItem Text="60" Value="60" />
                                                        <telerik:DropDownListItem Text="65" Value="65" /><telerik:DropDownListItem Text="70" Value="70" />
                                                        <telerik:DropDownListItem Text="75" Value="75" /><telerik:DropDownListItem Text="80" Value="80" />
                                                        <telerik:DropDownListItem Text="85" Value="85" /><telerik:DropDownListItem Text="90" Value="90" />
                                                        <telerik:DropDownListItem Text="95" Value="95" /><telerik:DropDownListItem Text="100" Value="100" />
                                                    </Items>
                                                </telerik:RadDropDownList>
                                            </InsertItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Is Deleted" SortExpression="Deleted" AllowSorting="false" AllowFiltering="false" UniqueName="Deleted" DataType="System.Boolean" DataField="Deleted"
                                            Groupable="true" GroupByExpression="Deleted Group By Deleted" ColumnGroupName="Deleted">
                                            <HeaderStyle Width="250px" />
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkDeleted" runat="server" Text='<%# Eval("Deleted") %>' Visible="true" Enabled="false"></asp:CheckBox>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkDeleted_E" runat="server" Text='<%# Eval("Deleted") %>'></asp:CheckBox>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <asp:CheckBox ID="chkDeleted_I" runat="server" Checked="false" Enabled="false"></asp:CheckBox>
                                            </InsertItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>

                                </MasterTableView>
                            </telerik:RadGrid>

                        </div>
                        
                        <asp:SqlDataSource runat="server" ID="dsAmounProducts" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
                            SelectCommand="SELECT [BrandID] as AmounProductCode, [BrandName] FROM [View_Brands] order by [BrandName]"></asp:SqlDataSource>
                        
                        <asp:SqlDataSource runat="server" ID="dsCompetitor" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
                            SelectCommand="SELECT [RecID], [ProductCompany] FROM [View_Survey_Products] Order by [ProductCompany]"></asp:SqlDataSource>

                        <asp:SqlDataSource runat="server" ID="dsMarket" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
                            SelectCommand="SELECT [MarketID], [MarketName] FROM [Survey_Market] Where Deleted is Null or Deleted = 0 Order by [MarketName]"></asp:SqlDataSource>

                        <asp:SqlDataSource runat="server" ID="dsView_Survey_Market_Indications" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
                            SelectCommand="SELECT [IndicationID], [IndicationName] FROM [View_Survey_Market_Indications] Where MarketID = @ddlMarketName Order By [IndicationName]">
                            <SelectParameters>
                                <asp:Parameter DbType="Int32" Name="ddlMarketName" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <asp:SqlDataSource runat="server" ID="dsActivities" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
                            SelectCommand="SELECT [ActivityID], [ActivityName], [Deleted] FROM [Survey_Activities] Where ([Deleted] IS NULL OR [Deleted] = 0) Order by [ActivityName]"></asp:SqlDataSource>

                        <asp:SqlDataSource ID="dsSaving" runat="server" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
                            SelectCommand="Select [SurveyID],[Pharmacy],[AmounProductCode],[BrandName],[CompanyID],[CompanyName],[CompetingProductCode],[CompetingProductName],
                            [MarketID],[MarketName],[IndicationID],[IndicationName],[ActivityID],[ActivityName],[SalesRatio] FROM [View_Survey]"
                            InsertCommand="INSERT INTO Survey ([SurveyID],[Pharmacy],[AmounProductCode],[CompetitorProduct],[MarketID],[IndicationID],[ActivityID],[SalesRatio],[Deleted]) 
                            Values (@ddlLine_Det, @ddlSpec_Det, @txtSpecValue_Det)"
                            UpdateCommand="UPDATE Survey Set Pharmacy = @, AmounProductCode = @, CompetitorProduct = @, MarketID = @, 
                            IndicationID = @, ActivityID = @, SalesRatio = @, [Deleted] = @ 
                            Where SurveyID = @lblRecID_DetU">
                            <InsertParameters>
                                <asp:Parameter DbType="Int32" Name="ddlLine_Det" />
                                <asp:Parameter DbType="Int32" Name="ddlSpec_Det" />
                                <asp:Parameter DbType="Int32" Name="txtSpecValue_Det" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter DbType="Int32" Name="lblRecID_DetU" />
                                <asp:Parameter DbType="Int32" Name="ddlLine_DetU" />
                                <asp:Parameter DbType="Int32" Name="ddlSpec_DetU" />
                                <asp:Parameter DbType="Int32" Name="txtSpecValue_DetU" />
                                <asp:Parameter DbType="Boolean" Name="chkDel_DetU" />
                            </UpdateParameters>
                        </asp:SqlDataSource>

                    </td>
                </tr>
            </table>

            <p>
                <br />
                <br />
            </p>
            <div>
                <asp:Label ID="lblStatus" runat="server" Text="Status: " Font-Italic="true"></asp:Label>
            </div>

        </div>
    </form>
</body>
</html>
