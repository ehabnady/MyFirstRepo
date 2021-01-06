<%@ Page Title="Test" Language="C#" MasterPageFile="~/SalesManagers/SiteMaster2.Master" AutoEventWireup="true"
    CodeBehind="ActualVsTarget.aspx.cs" Inherits="AmounCRM4.SalesManagers.ActualVsTarget" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <link type="text/css" rel="stylesheet" href="styles.css" />
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

    <script type="text/javascript">
        function myfunction() {
            $(document).ready(function () {
                // Default settings
                $('.gridAffs').responsiveTable();
                // Custom settings
                $('.gridAffs').responsiveTable({
                    staticColumns: 5,
                    scrollRight: true,
                    scrollHintEnabled: true,
                    scrollHintDuration: 2000
                });
            });
        }
    </script>
    <title>Actual vs. Target</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <telerik:RadHtmlChart runat="server" Width="400px" Height="400px"
        ID="RadHtmlChart1" DataSourceID="ActVsPlanDS">
        <PlotArea>
            <Series>
                <telerik:ColumnSeries DataFieldY="AppointmentsCount" Name="Appointments">
                    <TooltipsAppearance Color="White">
                        <ClientTemplate>
                                        Appointments
                        </ClientTemplate>
                    </TooltipsAppearance>

                    <Appearance FillStyle-BackgroundColor="RoyalBlue">
                        <FillStyle BackgroundColor="RoyalBlue"></FillStyle>
                    </Appearance>
                </telerik:ColumnSeries>

                <telerik:ColumnSeries DataFieldY="ActualCount" Name="Calls">
                    <TooltipsAppearance Color="White">
                        <ClientTemplate>
                                        Actual Visits
                        </ClientTemplate>
                    </TooltipsAppearance>
                    <Appearance FillStyle-BackgroundColor="Green">
                        <FillStyle BackgroundColor="Green"></FillStyle>
                    </Appearance>
                </telerik:ColumnSeries>
            </Series>

            <XAxis DataLabelsField="EmployeeName">
                <LabelsAppearance>
                </LabelsAppearance>
                <TitleAppearance Text="Actual / Targeted">
                </TitleAppearance>
            </XAxis>

            <YAxis Visible="false">
                <TitleAppearance Visible="false" Text="Value">
                </TitleAppearance>
            </YAxis>
        </PlotArea>

        <Legend>
            <Appearance Visible="true" Position="Right" BackgroundColor="Wheat">
            </Appearance>
        </Legend>

        <ChartTitle Text="Actual / Targeted">
            <Appearance Visible="True">
            </Appearance>
        </ChartTitle>
    </telerik:RadHtmlChart>

    <asp:SqlDataSource ID="ActVsPlanDS" runat="server"
        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
        SelectCommand="SELECT [CycleID], [TopManagerID], [TopManagerName], SUM([AppointmentsCount]) AS 'AppointmentsCount', 
                    SUM([ActualCount]) AS 'ActualCount' FROM [View_PlannedVsActual] 
                    WHERE (([TopManagerID] = @EmployeeIDFromSM) AND ([CycleID] = @CycleIDFromSM)) GROUP BY [CycleID], [TopManagerID], [TopManagerName]">
        <SelectParameters>
            <asp:SessionParameter Name="EmployeeIDFromSM" SessionField="EmployeeIDFromSM" Type="Int32" />
            <asp:SessionParameter Name="CycleIDFromSM" SessionField="CycleIDFromSM" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <script src="scripts/jquery.responsivetable.min.js"></script>

</asp:Content>
