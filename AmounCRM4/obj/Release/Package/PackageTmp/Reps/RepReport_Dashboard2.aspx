<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site2.Master" AutoEventWireup="true" CodeBehind="RepReport_Dashboard2.aspx.cs"
    Inherits="AmounCRM4.Reps.RepReport_Dashboard2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <title>Dashboard</title>
    <style type="text/css">
        .a {
            /*overflow: hidden;*/
            background-color: #333;
            overflow: hidden;
            background: #00cdff; /* fallback for old browsers */
            background: -webkit-linear-gradient(right, #7cfff2, #1400ff);
            background: -moz-linear-gradient(right, #7cfff2, #1400ff);
            background: -o-linear-gradient(right, #7cfff2, #1400ff);
            background: linear-gradient(to left, #7cfff2, #1400ff);
            font-family: "Roboto", sans-serif;
            -webkit-font-smoothing: antialiased;
        }

        .b {
            margin: 50px 50px 50px 50px;
            background-color: aqua;
            overflow: hidden;
            background: #00cdff; /* fallback for old browsers */
            background: -webkit-linear-gradient(right, #7cfff2, #1400ff);
            background: -moz-linear-gradient(right, #7cfff2, #1400ff);
            background: -o-linear-gradient(right, #7cfff2, #1400ff);
            background: linear-gradient(to left, #7cfff2, #1400ff);
            font-family: "Roboto", sans-serif;
            -webkit-font-smoothing: antialiased;
        }

        .c {
            /*background-color:blue*/
            resize: none;
        }

        .form2 {
            background: #FFFFFF;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <div align="center" class="form2">
        <asp:Table ID="tblContainer" runat="server" BorderStyle="None" Width="100%">
            <asp:TableRow ID="tr1" runat="server" BorderStyle="Solid" BorderWidth="2px">
                <asp:TableCell ID="td1_1" runat="server" ForeColor="Blue" Font-Bold="true" HorizontalAlign="Center" BorderColor="#ef8354" BorderStyle="Solid" BorderWidth="1"
                    Width="33%">
                    <asp:Table ID="Table3" runat="server" BackColor="coral" Width="100%">
                        <asp:TableRow ID="TableRow3" runat="server" BackColor="coral">
                            <asp:TableCell ID="TableCell3" runat="server" ForeColor="Blue" Font-Bold="true" HorizontalAlign="Center" BackColor="coral">
                                <asp:Label ID="lblCovALabel" runat="server" Text="Class 'A' Coverage" ForeColor="White" Font-Bold="true"
                                    Font-Size="X-Large"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                    <br />
                   <asp:TextBox ID="txtCovA" runat="server" TextMode="MultiLine" Enabled="false" Rows="3" BorderStyle="None" ForeColor="DarkBlue"
                                        Font-Size="XX-Large" BackColor="White" Font-Bold="true" BorderWidth="0" BorderColor="White" CssClass="c"></asp:TextBox>
                    <br />
                    <br />
                </asp:TableCell>
                <asp:TableCell ID="td2_1" runat="server" ForeColor="Blue" Font-Bold="true" HorizontalAlign="Center" BorderColor="#ef8354" BorderStyle="Solid" BorderWidth="1"
                    Width="33%">
                    <asp:Table ID="Table4" runat="server" BackColor="coral" Width="100%">
                        <asp:TableRow ID="TableRow4" runat="server" BackColor="coral">
                            <asp:TableCell ID="TableCell4" runat="server" ForeColor="Blue" Font-Bold="true" HorizontalAlign="Center" BackColor="coral" Width="300%">
                                <asp:Label ID="lblFreqALabel" runat="server" Text="Class 'A' Frequency" ForeColor="White" Font-Bold="true"
                                    Font-Size="X-Large"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                    <br />
                    <asp:TextBox ID="txtFreqA" runat="server" TextMode="MultiLine" Enabled="false" Rows="3" BorderStyle="None" ForeColor="DarkBlue"
                        Font-Size="XX-Large" BackColor="White" Font-Bold="true" BorderWidth="0" BorderColor="White" CssClass="c"></asp:TextBox>
                    <br />
                    <br />
                </asp:TableCell>
                <asp:TableCell ID="td1_3" runat="server" ForeColor="Blue" Font-Bold="true" HorizontalAlign="Center" BorderColor="#ef8354" BorderStyle="Solid" BorderWidth="1"
                    Width="33%">
                    <asp:Table ID="Table5" runat="server" BackColor="coral" Width="100%">
                        <asp:TableRow ID="TableRow5" runat="server" BackColor="coral">
                            <asp:TableCell ID="TableCell5" runat="server" ForeColor="Blue" Font-Bold="true" HorizontalAlign="Center" BackColor="coral" Width="300%">
                                <asp:Label ID="lblCallsALabel" runat="server" Text="Class 'A' Calls" ForeColor="White" Font-Bold="true"
                                    Font-Size="X-Large"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                    <br />
                    <asp:TextBox ID="txtCallsA" runat="server" TextMode="MultiLine" Enabled="false" Rows="3" BorderStyle="None" ForeColor="DarkBlue"
                        Font-Size="XX-Large" BackColor="White" Font-Bold="true" BorderWidth="0" BorderColor="White" CssClass="c"></asp:TextBox>
                    <br />
                    <br />
                </asp:TableCell>
            </asp:TableRow>

            <asp:TableRow>
                <asp:TableCell><br /></asp:TableCell><asp:TableCell><br /></asp:TableCell><asp:TableCell><br /></asp:TableCell></asp:TableRow>

            <asp:TableRow ID="tr2" runat="server" BorderStyle="Solid" BorderWidth="2px">
                <asp:TableCell ID="td1_2" runat="server" ForeColor="Blue" Font-Bold="true" HorizontalAlign="Center" BorderColor="#ef8354" BorderStyle="Solid" BorderWidth="1">
                    <asp:Table ID="Table6" runat="server" BackColor="coral" Width="100%">
                        <asp:TableRow ID="TableRow6" runat="server" BackColor="coral">
                            <asp:TableCell ID="TableCell6" runat="server" ForeColor="Blue" Font-Bold="true" HorizontalAlign="Center" BackColor="coral" Width="300%">
                                <asp:Label ID="lblCovAplusLabel" runat="server" Text="Class 'A+' Coverage" ForeColor="White" Font-Bold="true"
                                    Font-Size="X-Large"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                    <br />
                    <asp:TextBox ID="txtCovAplus" runat="server" TextMode="MultiLine" Enabled="false" Rows="3" BorderStyle="None" ForeColor="DarkBlue"
                        Font-Size="XX-Large" BackColor="White" Font-Bold="true" BorderWidth="0" BorderColor="White" CssClass="c"></asp:TextBox>
                    <br />
                    <br />
                </asp:TableCell>
                <asp:TableCell ID="td2_2" runat="server" ForeColor="Blue" Font-Bold="true" HorizontalAlign="Center" BorderColor="#ef8354" BorderStyle="Solid" BorderWidth="1">
                    <asp:Table ID="Table7" runat="server" BackColor="coral" Width="100%">
                        <asp:TableRow ID="TableRow7" runat="server" BackColor="coral">
                            <asp:TableCell ID="TableCell7" runat="server" ForeColor="Blue" Font-Bold="true" HorizontalAlign="Center" BackColor="coral" Width="300%">
                                <asp:Label ID="lblFreqAplusLabel" runat="server" Text="Class 'A+' Frequency" ForeColor="White" Font-Bold="true"
                                    Font-Size="X-Large"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                    <br />
                    <asp:TextBox ID="txtFreqAplus" runat="server" TextMode="MultiLine" Enabled="false" Rows="3" BorderStyle="None" ForeColor="DarkBlue"
                        Font-Size="XX-Large" BackColor="White" Font-Bold="true" BorderWidth="0" BorderColor="White" CssClass="c"></asp:TextBox>
                    <br />
                    <br />
                </asp:TableCell>
                <asp:TableCell ID="td2_3" runat="server" ForeColor="Blue" Font-Bold="true" HorizontalAlign="Center" BorderColor="#ef8354" BorderStyle="Solid" BorderWidth="1">
                    <asp:Table ID="Table8" runat="server" BackColor="coral" Width="100%">
                        <asp:TableRow ID="TableRow8" runat="server" BackColor="coral">
                            <asp:TableCell ID="TableCell8" runat="server" ForeColor="Blue" Font-Bold="true" HorizontalAlign="Center" BackColor="coral" Width="300%">
                                <asp:Label ID="lblCallsAplusLabel" runat="server" Text="Class 'A+' Calls" ForeColor="White" Font-Bold="true"
                                    Font-Size="X-Large"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                    <br />
                    <asp:TextBox ID="txtCallsAplus" runat="server" TextMode="MultiLine" Enabled="false" Rows="3" BorderStyle="None" ForeColor="DarkBlue"
                        Font-Size="XX-Large" BackColor="White" Font-Bold="true" BorderWidth="0" BorderColor="White" CssClass="c"></asp:TextBox>
                    <br />
                    <br />
                </asp:TableCell>
            </asp:TableRow>

            <asp:TableRow>
                <asp:TableCell><br /></asp:TableCell><asp:TableCell><br /></asp:TableCell><asp:TableCell><br /></asp:TableCell></asp:TableRow>

            <asp:TableRow ID="tr0" runat="server" BorderStyle="Solid" BorderWidth="2px">
                <asp:TableCell ID="td0_1" runat="server" ForeColor="Blue" Font-Bold="true" HorizontalAlign="Center" BorderColor="#ef8354" BorderStyle="Solid" BorderWidth="1">
                    <asp:Table ID="tInner1" runat="server" BackColor="#ef8354" Width="100%">
                        <asp:TableRow ID="tInner1Tr1" runat="server" BackColor="#ef8354">
                            <asp:TableCell ID="tInner1Tr1TD1" runat="server" ForeColor="Blue" Font-Bold="true" HorizontalAlign="Center" BackColor="#ef8354" Width="300%">
                                <asp:Label ID="lblTotalCovLabel" runat="server" Text="Coverage" ForeColor="White" Font-Bold="true" Font-Size="X-Large"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                    <br />
                    <asp:TextBox ID="txtCovTotal" runat="server" TextMode="MultiLine" Enabled="false" Rows="3" BorderStyle="None" ForeColor="DarkBlue"
                        Font-Size="XX-Large" BackColor="White" Font-Bold="true" BorderWidth="0" BorderColor="White" CssClass="c"></asp:TextBox>
                    <br />
                    <br />
                </asp:TableCell>
                <asp:TableCell ID="td0_2" runat="server" ForeColor="Blue" Font-Bold="true" HorizontalAlign="Center" BorderColor="#ef8354" BorderStyle="Solid" BorderWidth="1">
                    <asp:Table ID="Table1" runat="server" BackColor="#ef8354" Width="100%">
                        <asp:TableRow ID="TableRow1" runat="server" BackColor="#ef8354">
                            <asp:TableCell ID="TableCell1" runat="server" ForeColor="Blue" Font-Bold="true" HorizontalAlign="Center" BackColor="#ef8354" Width="300%">
                                <asp:Label ID="lblFreqTotalLabel" runat="server" Text="Frequency" ForeColor="White" Font-Bold="true" Font-Size="X-Large"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                    <br />
                    <asp:TextBox ID="txtFreqTotal" runat="server" TextMode="MultiLine" Enabled="false" Rows="3" BorderStyle="None" ForeColor="DarkBlue"
                        Font-Size="XX-Large" BackColor="White" Font-Bold="true" BorderWidth="0" BorderColor="White" CssClass="c"></asp:TextBox>
                    <br />
                    <br />
                </asp:TableCell>
                <asp:TableCell ID="td0_3" runat="server" ForeColor="Blue" Font-Bold="true" HorizontalAlign="Center" BorderColor="#ef8354" BorderStyle="Solid" BorderWidth="1">
                    <asp:Table ID="Table2" runat="server" BackColor="#ef8354" Width="100%">
                        <asp:TableRow ID="TableRow2" runat="server" BackColor="#ef8354">
                            <asp:TableCell ID="TableCell2" runat="server" ForeColor="Blue" Font-Bold="true" HorizontalAlign="Center" BackColor="#ef8354" Width="300%">
                                <asp:Label ID="lblCallsTotalLabel" runat="server" Text="Calls" ForeColor="White" Font-Bold="true" Font-Size="X-Large"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                    <br />
                    <asp:TextBox ID="txtCallsTotal" runat="server" TextMode="MultiLine" Enabled="false" Rows="3" BorderStyle="None" ForeColor="DarkBlue"
                        Font-Size="XX-Large" BackColor="White" Font-Bold="true" BorderWidth="0" BorderColor="White" CssClass="c"></asp:TextBox>
                    <br />
                    <br />
                </asp:TableCell>
            </asp:TableRow>

            <asp:TableRow>
                <asp:TableCell><br /></asp:TableCell><asp:TableCell><br /></asp:TableCell><asp:TableCell><br /></asp:TableCell></asp:TableRow>

            <asp:TableRow ID="tr3" runat="server" HorizontalAlign="Center" VerticalAlign="Middle" BorderStyle="Solid" BorderWidth="2px">
                <asp:TableCell ID="tr3_1" runat="server" BackColor="Window" ForeColor="Blue" ColumnSpan="3">
                    <telerik:RadHtmlChart ID="pieSpec" runat="server" Skin="Silk" Transitions="true" DataSourceID="oDS_BySpec" Width="100%">
                        <Legend>
                            <Appearance Position="Left" Visible="True">
                                <TextStyle FontSize="20" />
                            </Appearance>
                        </Legend>
                        <PlotArea>
                            <Series>
                                <telerik:PieSeries>
                                    <LabelsAppearance DataField="Actual Calls" RotationAngle="90" Position="OutsideEnd" DataFormatString="{0} %" Visible="true">
                                        <TextStyle FontSize="40" Bold="true" />
                                    </LabelsAppearance>
                                    <TooltipsAppearance Color="White" DataFormatString="{0} %" Visible="true"></TooltipsAppearance>
                                </telerik:PieSeries>
                                <telerik:PieSeries DataFieldY="ActualCalls" NameField="SpecialityCode" Visible="true" VisibleInLegend="true" />
                            </Series>
                        </PlotArea>
                        <ChartTitle Text="Calls by Specialty">
                            <Appearance Visible="True">
                                <TextStyle FontSize="30" />
                            </Appearance>
                        </ChartTitle>
                        <Navigator>
                            <SelectionHint Visible="true"></SelectionHint>
                        </Navigator>
                    </telerik:RadHtmlChart>
                </asp:TableCell>
            </asp:TableRow>

            <asp:TableRow>
                <asp:TableCell><br /></asp:TableCell><asp:TableCell><br /></asp:TableCell><asp:TableCell><br /></asp:TableCell></asp:TableRow>

            <asp:TableRow ID="tr4" runat="server" HorizontalAlign="Center" VerticalAlign="Middle" BorderStyle="Solid" BorderWidth="2px">
                <asp:TableCell ID="tr3_2" runat="server" BackColor="Window" ForeColor="Blue" ColumnSpan="3">
                    <telerik:RadHtmlChart ID="pieBrick" runat="server" Skin="Silk" Transitions="true" DataSourceID="oDS_Brick" Width="100%">
                        <Legend>
                            <Appearance Position="Left" Visible="True">
                                <TextStyle FontSize="20" />
                            </Appearance>
                        </Legend>
                        <PlotArea>
                            <Series>
                                <telerik:PieSeries>
                                    <LabelsAppearance DataField="Actual Calls" RotationAngle="90" Position="OutsideEnd" DataFormatString="{0} %" Visible="true">
                                        <TextStyle FontSize="40" />
                                    </LabelsAppearance>
                                    <TooltipsAppearance Color="White" DataFormatString="{0} %" Visible="true"></TooltipsAppearance>
                                </telerik:PieSeries>
                                <telerik:PieSeries DataFieldY="ActualCalls" NameField="AmounBrickName" Visible="true" VisibleInLegend="true">
                                </telerik:PieSeries>
                            </Series>
                        </PlotArea>
                        <ChartTitle Text="Calls by Brick">
                            <Appearance Visible="True">
                                <TextStyle FontSize="30" />
                            </Appearance>
                        </ChartTitle>
                        <Navigator>
                            <SelectionHint Visible="true"></SelectionHint>
                        </Navigator>
                    </telerik:RadHtmlChart>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </div>



    <asp:ObjectDataSource ID="oDS_Total" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetDataCovFreq" TypeName="AmounCRM4.App_Data.ExecSummary3TableAdapters.Total_CovFreqCallsTableAdapter">
        <SelectParameters>
            <asp:SessionParameter SessionField="EmployeeID" Name="EmployeeID" Type="Int32"></asp:SessionParameter>
            <asp:SessionParameter SessionField="CycleID" Name="CycleID" Type="Int32"></asp:SessionParameter>
        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:ObjectDataSource ID="oDS_Class" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetDataCovFreq" TypeName="AmounCRM4.App_Data.ExecSummary3TableAdapters.ByClass_CovFreqCallsTableAdapter">
        <SelectParameters>
            <asp:SessionParameter SessionField="EmployeeID" Name="EmployeeID" Type="Int32"></asp:SessionParameter>
            <asp:SessionParameter SessionField="CycleID" Name="CycleID" Type="Int32"></asp:SessionParameter>
        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:ObjectDataSource ID="oDS_BySpec" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetDataCovFreq" TypeName="AmounCRM4.App_Data.ExecSummary3TableAdapters.BySpec_CovFreqCallsTableAdapter">
        <SelectParameters>
            <asp:SessionParameter SessionField="EmployeeID" Name="EmployeeID" Type="Int32"></asp:SessionParameter>
            <asp:SessionParameter SessionField="CycleID" Name="CycleID" Type="Int32"></asp:SessionParameter>
        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:ObjectDataSource ID="oDS_Brick" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetDataCovFreq" TypeName="AmounCRM4.App_Data.ExecSummary3TableAdapters.ByBrick_CovFreqCallsTableAdapter">
        <SelectParameters>
            <asp:SessionParameter SessionField="CycleID" Name="CycleID" Type="Int32"></asp:SessionParameter>
            <asp:SessionParameter SessionField="EmployeeID" Name="EmployeeID" Type="Int32"></asp:SessionParameter>
        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:ObjectDataSource ID="oDS" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetDataCovFreq" TypeName="AmounCRM4.App_Data.ExecSummary3TableAdapters.ByBrick_CovFreqCallsTableAdapter">
        <SelectParameters>
            <asp:SessionParameter SessionField="EmployeeID" Name="EmployeeID" Type="Int32"></asp:SessionParameter>
            <asp:SessionParameter SessionField="CycleID" Name="CycleID" Type="Int32"></asp:SessionParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
