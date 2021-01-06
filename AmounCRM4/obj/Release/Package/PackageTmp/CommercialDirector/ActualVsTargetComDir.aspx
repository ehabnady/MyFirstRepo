<%@ Page Title="Actual Vs Target" Language="C#" MasterPageFile="~/CommercialDirector/SiteMaster2.Master" AutoEventWireup="true" CodeBehind="ActualVsTargetComDir.aspx.cs" Inherits="AmounCRM4.CommercialDirector.ActualVsTargetComDir" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
<link type="text/css" rel="stylesheet" href="styles.css" />
    <style type="text/css">
        .panelItem
        {
            height:auto;
        }
        .DivCenter
        {
            text-align:center;
            align-items:center;
            vertical-align:middle
        }
    </style>

    <title>Actual Vs Target</title>

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
                            SelectCommand="SELECT [CycleID], SUM([AppointmentsCount]) AS 'AppointmentsCount', 
                    SUM([ActualCount]) AS 'ActualCount' FROM [View_PlannedVsActual] 
                    WHERE ([CycleID] = @CycleIDFromComDir) GROUP BY [CycleID]">
                            <SelectParameters>
                                <asp:SessionParameter Name="CycleIDFromComDir" SessionField="CycleIDFromComDir" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
</asp:Content>
