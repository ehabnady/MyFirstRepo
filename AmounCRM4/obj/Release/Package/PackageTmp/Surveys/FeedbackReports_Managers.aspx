<%@ Page Title="Pharmacies Feedback Reports" Language="C#" MasterPageFile="~/FeedbackSite4.Master" AutoEventWireup="true" CodeBehind="FeedbackReports_Managers.aspx.cs" Inherits="AmounCRM4.Surveys.FeedbackReports_Managers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <title>Pharmacies Feedback Reports</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">

    <telerik:RadAjaxLoadingPanel ID="ALP1" runat="server"></telerik:RadAjaxLoadingPanel>
    <br />
    <div style="width: 94%; visibility: visible">
        <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="100%" Height="800px" ExpandMode="FullExpandedItem">
            <Items>
                <telerik:RadPanelItem Text="In-Market Sales by Pharmacy / Product" Expanded="true" Font-Size="Large" Visible="true" Width="100%" BackColor="#5D7B9D" ForeColor="White">
                    <ContentTemplate>
                        <telerik:RadGrid DataSourceID="dsSales" ID="grdSales" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True"
                            Height="600px" GroupPanelPosition="Top" ShowGroupPanel="True"
                            Skin="WebBlue" EnableHeaderContextMenu="True" EnableHeaderContextAggregatesMenu="true" EnableHeaderContextFilterMenu="true"
                            GridLines="Both" PageSize="50" ShowFooter="True">

                            <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="SalesReport">
                                <Excel Format="Xlsx" />
                            </ExportSettings>

                            <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>

                            <MasterTableView DataSourceID="dsSales" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="EmployeeFullName" HeaderText="Rep. Name" SortExpression="EmployeeFullName" UniqueName="EmployeeFullName" DataType="System.String" FilterControlAltText="Filter EmployeeFullName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="BrandName" HeaderText="Brand" SortExpression="BrandName" UniqueName="BrandName" DataType="System.String" FilterControlAltText="Filter BrandName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="EnglishName" HeaderText="Product" SortExpression="EnglishName" UniqueName="EnglishName" FilterControlAltText="Filter EnglishName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AmounCustomerID" HeaderText="Customer ID" SortExpression="AmounCustomerID" UniqueName="AmounCustomerID" DataType="System.Double" FilterControlAltText="Filter AmounCustomerID column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AmounCustomerName" HeaderText="Customer Name" SortExpression="AmounCustomerName" UniqueName="AmounCustomerName" DataType="System.String" FilterControlAltText="Filter AmounCustomerName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="YearID" HeaderText="Year" SortExpression="YearID" UniqueName="YearID" FilterControlAltText="Filter YearID column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MonthID" HeaderText="Month" SortExpression="MonthID" UniqueName="MonthID" FilterControlAltText="Filter MonthID column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Qty" HeaderText="Sales Qty" DataFormatString="{0:###,###}" UniqueName="Qty" FilterControlAltText="Filter Qty column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Val" Aggregate="Sum" DataFormatString="{0:###,###}" HeaderText="Sales Value" SortExpression="Val" UniqueName="Val" DataType="System.Double" FilterControlAltText="Filter Val column"></telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource runat="server" ID="dsSales" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
                            SelectCommand="SELECT * FROM [View_PH_FeedbackPharmaciesSales]">
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>



                <telerik:RadPanelItem Text="Frequency of Visits by Pharmacy" Expanded="false" Font-Size="Large" Visible="true" Width="100%" BackColor="#5D7B9D" ForeColor="White">
                    <ContentTemplate>
                        <telerik:RadGrid ID="grdVisitsByPharmacy" runat="server" DataSourceID="dsVisitsbyPharmacy" AllowFilteringByColumn="True" AllowPaging="True"
                            EnableGroupsExpandAll="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
                            AllowSorting="True" GroupPanelPosition="Top" ShowGroupPanel="True" Height="600px"
                            Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True">

                            <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="VisitsByPharmacy">
                                <Excel Format="Xlsx" />
                            </ExportSettings>

                            <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>

                            <MasterTableView DataSourceID="dsVisitsbyPharmacy" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="YearID" Visible="true" DataType="System.Int64" FilterControlAltText="Filter YearID column" HeaderText="Year" SortExpression="YearID" UniqueName="YearID"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MonthID" Visible="true" DataType="System.Int64" FilterControlAltText="Filter MonthID column" HeaderText="Month" SortExpression="MonthID" UniqueName="MonthID"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="EmployeeFullName" HeaderText="Rep. Name" SortExpression="EmployeeFullName" UniqueName="EmployeeFullName" DataType="System.String" FilterControlAltText="Filter EmployeeFullName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PharmacyID" Visible="true" DataType="System.Int64" FilterControlAltText="Filter PharmacyID column" HeaderText="Ph. ID" SortExpression="PharmacyID" UniqueName="PharmacyID"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PharmacyName" Visible="true" FilterControlAltText="Filter PharmacyName column" HeaderText="Ph. Name" SortExpression="PharmacyName" UniqueName="PharmacyName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="VisitsCount" Aggregate="Sum" DataFormatString="{0:###,###}" Visible="true" FilterControlAltText="Filter VisitsCount column" HeaderText="Visits Count" SortExpression="VisitsCount" UniqueName="VisitsCount"></telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                        <asp:SqlDataSource ID="dsVisitsbyPharmacy" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                            SelectCommand="SELECT [YearID],[MonthID],[PharmacyID],[PharmacyName],[EmployeeID],[EmployeeHRCode],[EmployeeFullName],[VisitsCount] FROM [AmounCRM2].[dbo].[View_PH_Rep_Frequency_Of_Visit_by_Pharmacy]">
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>


                <telerik:RadPanelItem Text="Frequency of Visits by Market" Expanded="false" Font-Size="Large" Visible="true" Width="100%" BackColor="#5D7B9D" ForeColor="White">
                    <ContentTemplate>
                        <telerik:RadGrid ID="grdVisitsByMarket" runat="server" DataSourceID="dsVisitsbyMarket" AllowFilteringByColumn="True" AllowPaging="True"
                            EnableGroupsExpandAll="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
                            AllowSorting="True" GroupPanelPosition="Top" ShowGroupPanel="True" Height="600px"
                            Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True">

                            <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="VisitsByMarket">
                                <Excel Format="Xlsx" />
                            </ExportSettings>

                            <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>

                            <MasterTableView DataSourceID="dsVisitsbyMarket" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="YearID" Visible="true" DataType="System.Int64" FilterControlAltText="Filter YearID column" HeaderText="Year" SortExpression="YearID" UniqueName="YearID"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MonthID" Visible="true" DataType="System.Int64" FilterControlAltText="Filter MonthID column" HeaderText="Month" SortExpression="MonthID" UniqueName="MonthID"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="EmployeeFullName" HeaderText="Rep. Name" SortExpression="EmployeeFullName" UniqueName="EmployeeFullName" DataType="System.String" FilterControlAltText="Filter EmployeeFullName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MarketName" Visible="true" FilterControlAltText="Filter MarketName column" HeaderText="Market" SortExpression="MarketName" UniqueName="MarketName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="VisitCount" Aggregate="Sum" DataFormatString="{0:###,###}" Visible="true" FilterControlAltText="Filter VisitsCount column" HeaderText="Visits Count" SortExpression="VisitsCount" UniqueName="VisitsCount"></telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                        <asp:SqlDataSource ID="dsVisitsbyMarket" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                            SelectCommand="SELECT [YearID],[QuarterID],[MonthID],[CycleID],[CycleDesc],[EmployeeID],[EmployeeHRCode],[EmployeeFullName],[MarketID],[MarketName],[VisitCount] FROM [AmounCRM2].[dbo].[View_PH_Rep_Frequency_Of_Visit_by_Market]">
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>


                <telerik:RadPanelItem Text="Monthly Consumption with Rank" Expanded="false" Font-Size="Large" Visible="true" Width="100%" BackColor="#5D7B9D" ForeColor="White">
                    <ContentTemplate>
                        <telerik:RadGrid ID="grdMonthlySales" runat="server" DataSourceID="dsMonthlySales" AllowFilteringByColumn="True" AllowPaging="True"
                            EnableGroupsExpandAll="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
                            AllowSorting="True" GroupPanelPosition="Top" ShowGroupPanel="True" Height="600px"
                            Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True">

                            <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="MonthlySales">
                                <Excel Format="Xlsx" />
                            </ExportSettings>

                            <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>

                            <MasterTableView DataSourceID="dsMonthlySales" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="YearID" Visible="true" DataType="System.Int64" FilterControlAltText="Filter YearID column" HeaderText="Year" SortExpression="YearID" UniqueName="YearID"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MonthID" Visible="true" DataType="System.Int64" FilterControlAltText="Filter MonthID column" HeaderText="Month" SortExpression="MonthID" UniqueName="MonthID"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="EmployeeFullName" HeaderText="Rep. Name" SortExpression="EmployeeFullName" UniqueName="EmployeeFullName" DataType="System.String" FilterControlAltText="Filter EmployeeFullName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MarketName" Visible="true" FilterControlAltText="Filter MarketName column" HeaderText="Market" SortExpression="MarketName" UniqueName="MarketName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ProductName" Visible="true" FilterControlAltText="Filter ProductName column" HeaderText="Product" SortExpression="ProductName" UniqueName="ProductName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="IsAmounProduct" Visible="true" FilterControlAltText="Filter IsAmounProduct column" HeaderText="Amoun Product?" SortExpression="IsAmounProduct" UniqueName="IsAmounProduct"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MarketMonthlySalesUnit" Aggregate="Sum" DataFormatString="{0:###,###}" HeaderText="Market Sales Unit (Monthly)" SortExpression="MarketMonthlySalesUnit" UniqueName="MarketMonthlySalesUnit" FilterControlAltText="Filter MarketMonthlySalesUnit column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ProductSalesUnits" Aggregate="Sum" DataFormatString="{0:###,###}" HeaderText="Product Sales Units (Monthly)" SortExpression="ProductSalesUnits" UniqueName="ProductSalesUnits" FilterControlAltText="Filter ProductSalesUnits column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SalesRatio" DataFormatString="{0:P}" HeaderText="Sales Ratio" SortExpression="SalesRatio" UniqueName="SalesRatio" DataType="System.Decimal" FilterControlAltText="Filter SalesRatio column"></telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                        <asp:SqlDataSource ID="dsMonthlySales" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                            SelectCommand="SELECT [YearID],[MonthID],[MarketID],[MarketName],[EmployeeID],[EmployeeHRCode],[EmployeeFullName],[ProductID],[ProductName],(CASE WHEN [IsAmounProduct] = 0 THEN 'No' ELSE 'Yes' END) as IsAmounProduct,[MarketMonthlySalesUnit],[ProductSalesUnits],[SalesRatio] FROM [AmounCRM2].[dbo].[View_PH_Rep_Monthly_Consumption] ORDER BY [MarketName], [ProductName], [SalesRatio] DESC">
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>


                <telerik:RadPanelItem Text="Activities" Expanded="false" Font-Size="Large" Visible="true" Width="100%" BackColor="#5D7B9D" ForeColor="White">
                    <ContentTemplate>
                        <telerik:RadGrid ID="grdActivities" runat="server" DataSourceID="dsActivities" AllowFilteringByColumn="True" AllowPaging="True"
                            EnableGroupsExpandAll="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
                            AllowSorting="True" GroupPanelPosition="Top" ShowGroupPanel="True" Height="600px"
                            Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True">

                            <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="Activities">
                                <Excel Format="Xlsx" />
                            </ExportSettings>

                            <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>

                            <MasterTableView DataSourceID="dsActivities" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="YearID" Visible="true" DataType="System.Int64" FilterControlAltText="Filter YearID column" HeaderText="Year" SortExpression="YearID" UniqueName="YearID"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MonthID" Visible="true" DataType="System.Int64" FilterControlAltText="Filter MonthID column" HeaderText="Month" SortExpression="MonthID" UniqueName="MonthID"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="EmployeeFullName" HeaderText="Rep. Name" SortExpression="EmployeeFullName" UniqueName="EmployeeFullName" DataType="System.String" FilterControlAltText="Filter EmployeeFullName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MarketName" Visible="true" FilterControlAltText="Filter MarketName column" HeaderText="Market" SortExpression="MarketName" UniqueName="MarketName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ProductName" Visible="true" FilterControlAltText="Filter ProductName column" HeaderText="Product" SortExpression="ProductName" UniqueName="ProductName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="IsAmounProduct" Visible="true" FilterControlAltText="Filter IsAmounProduct column" HeaderText="Amoun Product?" SortExpression="IsAmounProduct" UniqueName="IsAmounProduct"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ActivityName" HeaderText="Activity" SortExpression="ActivityName" UniqueName="ActivityName" FilterControlAltText="Filter ActivityName column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Occurence" Aggregate="Sum" DataFormatString="{0:###,###}" HeaderText="Occurence" SortExpression="Occurence" UniqueName="Occurence" FilterControlAltText="Filter Occurence column"></telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                        <asp:SqlDataSource ID="dsActivities" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                            SelectCommand="SELECT [YearID],[MonthID],[EmployeeID],[EmployeeHRCode],[EmployeeFullName],[MarketID],[MarketName],[ProductID],[ProductName],(CASE WHEN [IsAmounProduct] = 0 THEN 'No' ELSE 'Yes' END) as IsAmounProduct,[ActivityID],[ActivityName],[Occurence] FROM [AmounCRM2].[dbo].[View_PH_Rep_Activities_By_Product]">
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>


                <telerik:RadPanelItem Text="Feedbacks" Expanded="false" Font-Size="Large" Visible="true" Width="100%" BackColor="#5D7B9D" ForeColor="White">
                    <ContentTemplate>
                        <telerik:RadGrid ID="grdFeedbacks" runat="server" DataSourceID="dsSearch" AllowFilteringByColumn="True" AllowPaging="True"
                            EnableGroupsExpandAll="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
                            AllowSorting="True" GroupPanelPosition="Top" ShowGroupPanel="True" Height="600px"
                            Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True">

                            <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="Feedback List">
                                <Excel Format="Xlsx" />
                            </ExportSettings>

                            <ClientSettings AllowDragToGroup="true" AllowExpandCollapse="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
                            </ClientSettings>

                            <MasterTableView DataSourceID="dsSearch" AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
                                AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true" AllowMultiColumnSorting="true">
                                <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
                                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="FeedbackDate" Visible="true" DataType="System.DateTime" FilterControlAltText="Filter FeedbackDate column" HeaderText="Date" SortExpression="FeedbackDate" UniqueName="FeedbackDate" DataFormatString="{0:MM/dd/yyyy}"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Conc" Visible="true" FilterControlAltText="Filter Pharmacy column" HeaderText="Ph. Name" SortExpression="PharmacyName" UniqueName="PharmacyName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MarketName" Visible="true" FilterControlAltText="Filter Market column" HeaderText="Market" SortExpression="MarketName" UniqueName="MarketName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MarketMonthlySalesUnit" Visible="true" FilterControlAltText="Filter MarketMonthlySalesUnit column" HeaderText="Monthly Sales" SortExpression="MarketMonthlySalesUnit" UniqueName="MarketMonthlySalesUnit"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="EmployeeFullName" Visible="true" FilterControlAltText="Filter EmployeeFullName column" HeaderText="Rep. Name" SortExpression="EmployeeFullName" UniqueName="EmployeeFullName"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="RepAreaName" Visible="true" FilterControlAltText="Filter RepAreaName column" HeaderText="Territory" SortExpression="RepAreaName" UniqueName="RepAreaName"></telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource runat="server" ID="dsSearch" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                            SelectCommand="SELECT DISTINCT [FeedbackID], [PharmacyID], [PharmacyName], CONCAT([PharmacyID], ' - ', [PharmacyName]) as Conc, [FeedbackDate], [MarketID], [MarketName], 
                            [MarketMonthlySalesUnit], [AmounBrickName], [RepAreaName], [EmployeeID], [EmployeeHRCode], [EmployeeFullName] FROM [View_PH_Feedback_FullView] ORDER BY [FeedbackDate] DESC">
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </telerik:RadPanelItem>
            </Items>
        </telerik:RadPanelBar>
    </div>
    <div>
    </div>
















</asp:Content>
