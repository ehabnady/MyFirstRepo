<%@ Page Title="Sales Calls" Language="C#" MasterPageFile="~/SalesManagers/SiteMaster2.Master" AutoEventWireup="true" CodeBehind="Calls2.aspx.cs" 
    Inherits="AmounCRM4.SalesManagers.Calls2" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .MidAlign {
            vertical-align: middle;
        }

        .auto-style2 {
            height: 51px;
        }
    </style>

    <script language="javascript" type="text/javascript">
        var ddl1Val = 0;
        var ddl2Val = 0;
        var ddl3Val = 0;

        function ddlClicked(ddlID)
        {
            var ddl1 = document.getElementById('<%= ddlProduct1.ClientID %>');
            ddl1Val = ddl1.selectedIndex;
        }
        function ddlClicked2(ddlID)
        {
            var ddl2 = document.getElementById('<%= ddlProduct2.ClientID %>');
            ddl2Val = ddl2.selectedIndex;
        }
        function ddlClicked3(ddlID)
        {
            var ddl3 = document.getElementById('<%= ddlProduct3.ClientID %>');
            ddl3Val = ddl3.selectedIndex;
        }

        function ddlChanged(ddlID)
        {
            var ControlName = document.getElementById(ddlID.id);
            var ddl1 = document.getElementById('<%= ddlProduct1.ClientID %>');
            var ddl2 = document.getElementById('<%= ddlProduct2.ClientID %>');
            var ddl3 = document.getElementById('<%= ddlProduct3.ClientID %>');

            if (ControlName.value == 0)
            {
                document.getElementById('<%= pnlProd1.ClientID %>').style.display = 'none';
            }
            else
            {
                if ((ddl2 != null && ddl2.value != 0 && ddl1.value == ddl2.value) || (ddl3 != null && ddl3.value != 0 && ddl1.value == ddl3.value))
                {
                    alert("Choose Different Products");
                    ddl1.selectedIndex = ddl1Val;
                    return;
                }
                else
                {
                    document.getElementById('<%= pnlProd1.ClientID %>').style.display = '';
                }
            }
        }

        function ddlChanged2(ddlID)
        {
            var ControlName = document.getElementById(ddlID.id);
            var ddl1 = document.getElementById('<%= ddlProduct1.ClientID %>');
            var ddl2 = document.getElementById('<%= ddlProduct2.ClientID %>');
            var ddl3 = document.getElementById('<%= ddlProduct3.ClientID %>');

            if (ControlName.value == 0)
            {
                document.getElementById('<%= pnlProd2.ClientID %>').style.display = 'none';
            }
            else
            {
                if ((ddl1 != null && ddl1.value != 0 && ddl2.value == ddl1.value) || (ddl3 != null && ddl3.value != 0 && ddl2.value == ddl3.value))
                {
                    alert("Choose Different Products");
                    ddl2.selectedIndex = ddl2Val;
                    return;
                }
                else
                {
                    document.getElementById('<%= pnlProd2.ClientID %>').style.display = '';
                }
            }
        }

        function ddlChanged3(ddlID)
        {
            var ControlName = document.getElementById(ddlID.id);
            var ddl1 = document.getElementById('<%= ddlProduct1.ClientID %>');
            var ddl2 = document.getElementById('<%= ddlProduct2.ClientID %>');
            var ddl3 = document.getElementById('<%= ddlProduct3.ClientID %>');

            if (ControlName.value == 0)
            {
                document.getElementById('<%= pnlProd3.ClientID %>').style.display = 'none';
            }
            else
            {
                if ((ddl2 != null && ddl2.value != 0 && ddl3.value == ddl2.value) || (ddl1 != null && ddl1.value != 0 && ddl3.value == ddl1.value))
                {
                    alert("Choose Different Products");
                    ddl3.selectedIndex = ddl3Val;
                    return;
                }
                else
                {
                    document.getElementById('<%= pnlProd3.ClientID %>').style.display = '';
                }
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">
    </telerik:RadStyleSheetManager>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>

    <div align="center" style="text-align: center; width: 90%" class="MidAlign">
        <asp:Table ID="Table2" runat="server" Width="90%" CssClass="MidAlign" HorizontalAlign="Center">
            <asp:TableRow ID="TableRow2" runat="server" Height="40" VerticalAlign="Middle" Width="90%">
                <asp:TableCell ID="TableCell3" runat="server">
                    <asp:Label ID="lblVisitDate" runat="server" Text="Visit Date" EnableViewState="true"></asp:Label>
                </asp:TableCell>
                <asp:TableCell ID="td2" runat="server">
                    <telerik:RadDatePicker ID="radDate11" runat="server" Enabled="false"
                        Width="300" Height="30" EnableViewState="true" ViewStateMode="Enabled">
                        <DatePopupButton Visible="false" />
                    </telerik:RadDatePicker>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator0" runat="server"
                        ControlToValidate="radDate11" ErrorMessage="*" InitialValue="Select"></asp:RequiredFieldValidator>
                    <asp:Label ID="lblVisitDateTime" runat="server" Text=""></asp:Label>
                </asp:TableCell>

                <asp:TableCell ID="TableCell8" runat="server">
                    <asp:Label ID="Label1" runat="server" Text="Doctor Info:"></asp:Label>
                </asp:TableCell>
                <asp:TableCell ID="TableCell9" runat="server">
                    <asp:TextBox ID="txtAffName" runat="server" Width="300" ReadOnly="true" Enabled="false" Height="30"></asp:TextBox>
                    <asp:SqlDataSource ID="AffDS" runat="server"
                        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                        SelectCommand="SELECT DISTINCT AffiliationID, AffiliationName3 FROM View_Affiliations_Scheduler WHERE (AffiliationID = @ParticipantID) AND (LineID = @LineID_Sch)">
                        <SelectParameters>
                            <asp:SessionParameter Name="ParticipantID" SessionField="ParticipantID" />
                            <asp:SessionParameter Name="LineID_Sch" SessionField="LineID_Sch" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </asp:TableCell>

                <asp:TableCell ID="TableCell10" runat="server">
                    <asp:Label ID="lblWho" runat="server" Text="Double Visit With: "></asp:Label>
                    <asp:DropDownList ID="ddlWho" runat="server" DataSourceID="dsDoubleVisitManagers" DataTextField="DirectManagerName" DataValueField="DirectManagerID"
                        AppendDataBoundItems="true" Enabled="false">
                        <asp:ListItem Text="Select" Value="0" Selected="True" />
                    </asp:DropDownList>
                    
                    <asp:SqlDataSource runat="server" ID="dsDoubleVisitManagers" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
                        SelectCommand="Select 1 as DirectManagerID, 'None' as DirectManagerName, 0 as TypeID
                                        union
                                        Select Distinct DirectManagerID, DirectManagerName, 1 as TypeID From View_Employees Where TopManagerID = @EmployeeIDFromSM
                                        union 
                                        Select EmployeeID, EmployeeFullName, 2 as TypeID From View_Employees Where EmployeeID = @EmployeeIDFromSM Order By TypeID">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="EmployeeIDFromSM" Name="EmployeeIDFromSM"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>
                </asp:TableCell>


                <asp:TableCell ID="tbl2td1" runat="server" HorizontalAlign="Right" VerticalAlign="Bottom">
                        <asp:CheckBox ID="chkCompleted" runat="server" Text="Approved" TextAlign="Left" />
                    </asp:TableCell>

                <asp:TableCell ID="td3" runat="server" Visible="false">
                    <asp:Label ID="lblVisitType" runat="server" Text="Visit Type"></asp:Label>
                </asp:TableCell>
                <asp:TableCell ID="td4" runat="server" Visible="false">
                    <asp:DropDownList ID="cbVisitType" runat="server" DataSourceID="VisitTypeDS"
                        DataTextField="VisitTypeName" DataValueField="VisitTypeID" EnableViewState="true">
                        <asp:ListItem>Select</asp:ListItem>
                    </asp:DropDownList>
                    
                    <asp:SqlDataSource ID="VisitTypeDS" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                        SelectCommand="SELECT DISTINCT VisitTypeID, VisitTypeName FROM VisitTypes WHERE Deleted IS NULL"></asp:SqlDataSource>
                </asp:TableCell>                
            </asp:TableRow>
        </asp:Table>
    </div>

    <br />

    <div align="center" style="text-align: center; width: 90%" class="MidAlign">
        <asp:Table ID="tbl1" runat="server" HorizontalAlign="Center" CssClass="MidAlign" Width="90%">
            <asp:TableRow ID="tr0" runat="server" BackColor="LightBlue">
                
                <asp:TableCell ID="td1" runat="server" HorizontalAlign="Left" VerticalAlign="Top" BackColor="LightBlue" ForeColor="Black" Width="33%">
                    <br />
                    <asp:Label ID="lblbPro1" runat="server" Text="First Detailed Product: " EnableViewState="true" Font-Bold="True"></asp:Label>
                    <br /><br />
                    <asp:DropDownList ID="ddlProduct1" runat="server" DataSourceID="ProductDS1" AppendDataBoundItems="true" AutoPostBack="true"
                        DataTextField="BrandName" DataValueField="BrandID" Width="215px" OnSelectedIndexChanged="ddlProduct1_SelectedIndexChanged"
                        OnPreRender="ddlProduct1_PreRender" Enabled="false">
                        <asp:ListItem Selected="True" Value="0" Text="Select"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                        ControlToValidate="ddlProduct1" ErrorMessage="*" InitialValue="Select"></asp:RequiredFieldValidator>
                    <asp:SqlDataSource ID="ProductDS1" runat="server"
                        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                        SelectCommand="SELECT DISTINCT BrandID, BrandName, BrandPriority FROM [View_BrandPriorityBySpecLine] WHERE (SpecialtyID = @SpecialtyID AND BrandPriority < 4) Order By BrandName">
                        <SelectParameters>
                            <asp:SessionParameter Name="SpecialtyID" SessionField="SpecialtyID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br /><br />
                    <asp:Panel ID="pnlProd1" runat="server" Visible="false">
                        <h4 style="font-weight:bold">Adoption Ladder Step</h4>
                        <asp:DropDownList ID="ddlAdoptionLadderStep1" runat="server" DataSourceID="AdoptDS1" AppendDataBoundItems="true"
                            DataTextField="AdoptionLadderStepName" DataValueField="AdoptionLadderStepID" Width="215px" Enabled="false">
                            <asp:ListItem Selected="True" Value="0" Text="Select">Select</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                            ControlToValidate="ddlAdoptionLadderStep1" ErrorMessage="*" InitialValue="Select"></asp:RequiredFieldValidator>
                        <asp:SqlDataSource ID="AdoptDS1" runat="server"
                            ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                            SelectCommand="SELECT DISTINCT [AdoptionLadderStepID], [AdoptionLadderStepName] FROM [AdoptionLadderSteps]"></asp:SqlDataSource>                    
                        <br /><br />
                        <table>
                            <tr>
                                <td valign="top">
                                    <h4 style="font-weight:bold; text-decoration:underline">Requests / Giveaways</h4>

                                    <asp:Repeater ID="rep1Pro1Samples1" runat="server" DataSourceID="SamplesDS1">
                                        <HeaderTemplate>
                                            <table border="0" cellpadding="0" cellspacing="0">
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chkPro1Samples1" Text='<%# Eval("SampleName") %>' ToolTip='<%# Eval("SampleID") %>' runat="server"
                                                        OnCheckedChanged="chkPro1Samples1_CheckedChanged" AutoPostBack="true" Font-Bold="false" Font-Italic="True" Font-Size="Medium" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtPro1Samples1Qty" runat="server" MaxLength="1" Width="20" Text="0" BorderStyle="None" />
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </table>
                                        </FooterTemplate>
                                    </asp:Repeater>

                                    <asp:SqlDataSource ID="SamplesDS1" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                                        SelectCommand="SELECT TOP 8 SampleID, SampleName FROM Samples"><%--WHERE (LineID = @LineID)--%>
                                        <%--<SelectParameters>
                                            <asp:SessionParameter Name="LineID" SessionField="LineID" />
                                        </SelectParameters>--%>
                                    </asp:SqlDataSource>
                                </td>
                                </tr>
                            <tr>
                                <td valign="top">
                                    <br />
                                    <h4 style="font-weight:bold; text-decoration:underline">Post Call Analysis</h4>
                                    <asp:CheckBoxList ID="chklPro1PostCalls1" runat="server" DataSourceID="PostCallAnalysisDS1" RepeatColumns="1"
                                        DataTextField="PostCallAnalysisName" DataValueField="PostCallAnalysisID" Font-Italic="True" Font-Size="Medium">
                                    </asp:CheckBoxList>
                                    <asp:SqlDataSource ID="PostCallAnalysisDS1" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                                        SelectCommand="SELECT PostCallAnalysisID, PostCallAnalysisName FROM PostCallAnalysis WHERE Deleted IS NULL"></asp:SqlDataSource>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" colspan="2">
                                    <br />
                                    <h4 style="font-weight:bold; text-decoration:underline">Next Call Objectives</h4>
                                    <asp:CheckBoxList ID="chklPro1NextCallObjective1" runat="server" DataSourceID="NextCallObjectiveDS1" RepeatColumns="1"
                                        DataTextField="NextCallObjName" DataValueField="NextCallObjID" Font-Italic="True" Font-Size="Medium">
                                    </asp:CheckBoxList>
                                    <asp:SqlDataSource ID="NextCallObjectiveDS1" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                                        SelectCommand="SELECT [NextCallObjID], [NextCallObjName] FROM [NextCallObj] WHERE Deleted IS NULL"><%-- WHERE LineID = @LineID--%>
                                        <%--<SelectParameters>
                                            <asp:SessionParameter Name="LineID" SessionField="LineID" />
                                        </SelectParameters>--%>
                                    </asp:SqlDataSource>
                                    <br />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </asp:TableCell>
            
                <asp:TableCell ID="TableCell1" runat="server" HorizontalAlign="Left" VerticalAlign="Top" BackColor="LightBlue" ForeColor="Black" Width="33%">
                    <br />
                    <asp:Label ID="lblPro2" runat="server" Text="Second Detailed Product: " EnableViewState="true" Font-Bold="true"></asp:Label>
                    <br /><br />
                    <asp:DropDownList ID="ddlProduct2" runat="server" DataSourceID="ProductDS2" AppendDataBoundItems="true" AutoPostBack="true"
                        DataTextField="BrandName" DataValueField="BrandID" Width="215px" OnSelectedIndexChanged="ddlProduct2_SelectedIndexChanged"
                         Enabled="false">
                        <asp:ListItem Selected="True" Value="0" Text="Select"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                        ControlToValidate="ddlProduct2" ErrorMessage="*" InitialValue="Select"></asp:RequiredFieldValidator>
                    <asp:SqlDataSource ID="ProductDS2" runat="server"
                        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                        SelectCommand="SELECT DISTINCT BrandID, BrandName, BrandPriority FROM [View_BrandPriorityBySpecLine] WHERE (SpecialtyID = @SpecialtyID AND BrandPriority < 4) Order By BrandName">
                        <SelectParameters>
                            <asp:SessionParameter Name="SpecialtyID" SessionField="SpecialtyID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br /><br />
                    <asp:Panel ID="pnlProd2" runat="server" Visible="false">
                        <h4 style="font-weight:bold">Adoption Ladder Step</h4>
                        <asp:DropDownList ID="ddlAdoptionLadderStep2" runat="server" DataSourceID="AdoptDS2" AppendDataBoundItems="true"
                            DataTextField="AdoptionLadderStepName" DataValueField="AdoptionLadderStepID" Width="215px" Enabled="false">
                            <asp:ListItem Selected="True" Value="0" Text="Select">Select</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                            ControlToValidate="ddlAdoptionLadderStep2" ErrorMessage="*" InitialValue="Select"></asp:RequiredFieldValidator>
                        <asp:SqlDataSource ID="AdoptDS2" runat="server"
                            ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                            SelectCommand="SELECT DISTINCT [AdoptionLadderStepID], [AdoptionLadderStepName] FROM [AdoptionLadderSteps]"></asp:SqlDataSource>
                      
                        <br /><br />
                        <table>
                            <tr>
                                <td valign="top">
                                    <h4 style="font-weight:bold; text-decoration:underline">Requests / Giveaways</h4>


                                    <asp:Repeater ID="rep2Pro2Samples2" runat="server" DataSourceID="SamplesDS2">
                                        <HeaderTemplate>
                                            <table border="0" cellpadding="0" cellspacing="0">
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chkPro2Samples2" Text='<%# Eval("SampleName") %>' ToolTip='<%# Eval("SampleID") %>' runat="server"
                                                        OnCheckedChanged="chkPro2Samples2_CheckedChanged" AutoPostBack="true" Font-Bold="false" Font-Italic="True" Font-Size="Medium" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtPro2Samples2Qty" runat="server" MaxLength="1" Width="20" Text="0" BorderStyle="None" />
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </table>
                                        </FooterTemplate>
                                    </asp:Repeater>

                                    <asp:SqlDataSource ID="SamplesDS2" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                                        SelectCommand="SELECT TOP 8 SampleID, SampleName FROM Samples"><%--WHERE (LineID = @LineID)--%>
                                        <%--<SelectParameters>
                                            <asp:SessionParameter Name="LineID" SessionField="LineID" />
                                        </SelectParameters>--%>
                                    </asp:SqlDataSource>
                                </td>
                                </tr>
                            <tr>
                                <td valign="top">
                                    <br />
                                    <h4 style="font-weight:bold; text-decoration:underline">Post Call Analysis</h4>
                                    <asp:CheckBoxList ID="chklPro2PostCalls2" runat="server" DataSourceID="PostCallAnalysisDS2" RepeatColumns="1"
                                        DataTextField="PostCallAnalysisName" DataValueField="PostCallAnalysisID" Font-Italic="True" Font-Size="Medium">
                                    </asp:CheckBoxList>
                                    <asp:SqlDataSource ID="PostCallAnalysisDS2" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                                        SelectCommand="SELECT PostCallAnalysisID, PostCallAnalysisName FROM PostCallAnalysis WHERE Deleted IS NULL"></asp:SqlDataSource>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" colspan="2">
                                    <br />
                                    <h4 style="font-weight:bold; text-decoration:underline">Next Call Objectives</h4>
                                    <asp:CheckBoxList ID="chklPro2NextCallObjective2" runat="server" DataSourceID="NextCallObjectiveDS2" RepeatColumns="1"
                                        DataTextField="NextCallObjName" DataValueField="NextCallObjID" Font-Italic="True" Font-Size="Medium">
                                    </asp:CheckBoxList>
                                    <asp:SqlDataSource ID="NextCallObjectiveDS2" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                                        SelectCommand="SELECT [NextCallObjID], [NextCallObjName] FROM [NextCallObj] WHERE Deleted IS NULL"><%-- WHERE LineID = @LineID--%>
                                        <%--<SelectParameters>
                                            <asp:SessionParameter Name="LineID" SessionField="LineID" />
                                        </SelectParameters>--%>
                                    </asp:SqlDataSource>
                                    <br />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </asp:TableCell>
            
              
                <asp:TableCell ID="TableCell2" runat="server" HorizontalAlign="Left" VerticalAlign="Top" BackColor="LightBlue" ForeColor="Black" Width="33%">
                    <br />
                    <asp:Label ID="lblPro3" runat="server" Text="Third Detailed Product: " EnableViewState="true" Font-Bold="true"></asp:Label>
                    <br /><br />
                    <asp:DropDownList ID="ddlProduct3" runat="server" DataSourceID="ProductDS3" AppendDataBoundItems="true" AutoPostBack="true"
                        DataTextField="BrandName" DataValueField="BrandID" Width="215px" OnSelectedIndexChanged="ddlProduct3_SelectedIndexChanged"
                         Enabled="false">
                        <asp:ListItem Selected="True" Value="0" Text="Select"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                        ControlToValidate="ddlProduct3" ErrorMessage="*" InitialValue="Select"></asp:RequiredFieldValidator>
                    <asp:SqlDataSource ID="ProductDS3" runat="server"
                        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                        SelectCommand="SELECT DISTINCT BrandID, BrandName, BrandPriority FROM [View_BrandPriorityBySpecLine] WHERE (SpecialtyID = @SpecialtyID AND BrandPriority < 4) Order By BrandName">
                        <SelectParameters>
                            <asp:SessionParameter Name="SpecialtyID" SessionField="SpecialtyID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br /><br />
                    <asp:Panel ID="pnlProd3" runat="server" Visible="false">
                        <h4 style="font-weight:bold">Adoption Ladder Step</h4>
                        <asp:DropDownList ID="ddlAdoptionLadderStep3" runat="server" DataSourceID="AdoptDS3" AppendDataBoundItems="true"
                            DataTextField="AdoptionLadderStepName" DataValueField="AdoptionLadderStepID" Width="215px" Enabled="false">
                            <asp:ListItem Selected="True" Value="0" Text="Select">Select</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                            ControlToValidate="ddlAdoptionLadderStep3" ErrorMessage="*" InitialValue="Select"></asp:RequiredFieldValidator>
                        <asp:SqlDataSource ID="AdoptDS3" runat="server"
                            ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                            SelectCommand="SELECT DISTINCT [AdoptionLadderStepID], [AdoptionLadderStepName] FROM [AdoptionLadderSteps]"></asp:SqlDataSource>
                      
                        <br /><br />
                        <table>
                            <tr>
                                <td valign="top">
                                    <h4 style="font-weight:bold; text-decoration:underline">Requests / Giveaways</h4>


                                    <asp:Repeater ID="rep3Pro3Samples3" runat="server" DataSourceID="SamplesDS3">
                                        <HeaderTemplate>
                                            <table border="0" cellpadding="0" cellspacing="0">
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chkPro3Samples3" Text='<%# Eval("SampleName") %>' ToolTip='<%# Eval("SampleID") %>' runat="server"
                                                        OnCheckedChanged="chkPro3Samples3_CheckedChanged" AutoPostBack="true" Font-Italic="True" Font-Size="Medium" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtPro3Samples3Qty" runat="server" MaxLength="1" Width="20" Text="0" BorderStyle="None" />
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </table>
                                        </FooterTemplate>
                                    </asp:Repeater>

                                    <asp:SqlDataSource ID="SamplesDS3" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                                        SelectCommand="SELECT TOP 8 SampleID, SampleName FROM Samples"><%--WHERE (LineID = @LineID)--%>
                                        <%--<SelectParameters>
                                            <asp:SessionParameter Name="LineID" SessionField="LineID" />
                                        </SelectParameters>--%>
                                    </asp:SqlDataSource>
                                </td>
                                </tr>
                            <tr>
                                <td valign="top">
                                    <br />
                                    <h4 style="font-weight:bold; text-decoration:underline">Post Call Analysis</h4>
                                    <asp:CheckBoxList ID="chklPro3PostCalls3" runat="server" DataSourceID="PostCallAnalysisDS3" RepeatColumns="1"
                                        DataTextField="PostCallAnalysisName" DataValueField="PostCallAnalysisID" Font-Italic="True" Font-Size="Medium">
                                    </asp:CheckBoxList>
                                    <asp:SqlDataSource ID="PostCallAnalysisDS3" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                                        SelectCommand="SELECT PostCallAnalysisID, PostCallAnalysisName FROM PostCallAnalysis WHERE Deleted IS NULL"></asp:SqlDataSource>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" colspan="2">
                                    <br />
                                    <h4 style="font-weight:bold; text-decoration:underline">Next Call Objectives</h4>
                                    <asp:CheckBoxList ID="chklPro3NextCallObjective3" runat="server" DataSourceID="NextCallObjectiveDS3" RepeatColumns="1"
                                        DataTextField="NextCallObjName" DataValueField="NextCallObjID" Font-Italic="True" Font-Size="Medium">
                                    </asp:CheckBoxList>
                                    <asp:SqlDataSource ID="NextCallObjectiveDS3" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                                        SelectCommand="SELECT [NextCallObjID], [NextCallObjName] FROM [NextCallObj] WHERE Deleted IS NULL"><%-- WHERE LineID = @LineID--%>
                                        <%--<SelectParameters>
                                            <asp:SessionParameter Name="LineID" SessionField="LineID" />
                                        </SelectParameters>--%>
                                    </asp:SqlDataSource>
                                    <br />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </div>

    <p><br /></p>

    <div align="center" style="text-align: center; width: 90%; visibility:hidden" class="MidAlign">
        <p align="center" style="width:90%">
            <asp:Table ID="tbl2" runat="server" Width="90%">
                <asp:TableRow ID="tbl2tr1" runat="server" BackColor="LightBlue">
                    
                    <asp:TableCell ID="tbl2td2" runat="server" HorizontalAlign="Right" VerticalAlign="Bottom" Visible="false">
                        <asp:CheckBox ID="chkDelete" runat="server" Text="Delete Visit Details" />
                    </asp:TableCell>
                </asp:TableRow>

                <asp:TableRow ID="trSave" runat="server" Visible="false">
                    <asp:TableCell ID="tdSep5" runat="server"><br /></asp:TableCell>
                    <asp:TableCell ID="TableCell7" runat="server"><br /></asp:TableCell>
                </asp:TableRow>

                <asp:TableRow ID="tbl2tr2" runat="server" Visible="false">
                    <asp:TableCell ID="tbl2td3" runat="server" ColumnSpan="2" HorizontalAlign="Center" VerticalAlign="Bottom">
                        <telerik:RadButton ID="radSave" runat="server" Text="Save" Skin="WebBlue"
                            OnClick="radSave_Click" Font-Names="Times New Roman" Font-Size="Medium"
                            Height="49px" Width="128px" BorderStyle="Outset">
                        </telerik:RadButton>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>

            <asp:Label ID="lblError" runat="server" Text=""></asp:Label>
            <asp:HiddenField ID="hidVisitID" runat="server" Value="0" />
        </p>
    </div>
</asp:Content>

