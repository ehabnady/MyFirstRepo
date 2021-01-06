<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AdminAffiliationForm.aspx.cs" Inherits="AmounCRM4.Admins.AdminAffiliationForm" %>
<asp:Content ID="head" runat="server" ContentPlaceHolderID="head">
    <title></title>

    <style type="text/css">
         .auto-style21 {
            width: 767px;
            height: 34px;
            text-align: right;
            font-weight: 700;
            font-size: small;
            background-color: #5D7B9D;
        }
        .auto-style54 {
            width: 128px;
        }
        .auto-style57 {
            width: 143px;
            text-decoration: underline;
            font-size: small;
        }
        .auto-style67 {
            border-style: dotted;
            border-width: 1px;
            width: 149px;
            }
        .auto-style68 {
            border-style: dotted;
            border-width: 1px;
            width: 128px;
            }
        .auto-style74 {
            width: 111px;
            text-decoration: underline;
        }
        .auto-style76 {
            width: 111px;
            font-size: small;
        }
        .auto-style78 {
            width: 47px;
            font-size: small;
        }
        .auto-style79 {
            border-style: dotted;
            border-width: 1px;
            width: 149px;
            text-align: left;
        }
        .auto-style80 {
            width: 149px;
        }
        .auto-style81 {
            color: #800000;
            font-size: xx-large;
            text-decoration: underline;
        }
        .auto-style83 {
            border-style: dotted;
            border-width: 1px;
            width: 47px;
        }
        .auto-style84 {
            border-style: dotted;
            border-width: 1px;
            width: 143px;
            text-align: left;
            color: #003300;
            font-size: small;
        }
        .auto-style85 {
            color: #990000;
            font-size: small;
        }
        .auto-style86 {
            border-style: dotted;
            border-width: 1px;
            width: 143px;
            text-align: left;
            color: #990000;
            font-size: small;
        }
        .auto-style87 {
            color: #003300;
            font-size: small;
        }
        .auto-style88 {
            text-align: left;
        }
        .auto-style91 {
            width: 128px;
            text-align: right;
        }
        .auto-style93 {
            width: 143px;
            text-align: right;
        }
        .auto-style94 {
            width: 197px;
            text-align: left;
        }
        .auto-style96 {
            border-style: dotted;
            border-width: 1px;
            text-align: right;
            color: #990000;
            width: 111px;
        }
        .auto-style97 {
            border-style: dotted;
            border-width: 1px;
            width: 111px;
            text-align: right;
            height: 14px;
            color: #003300;
        }
        .auto-style98 {
            width: 128px;
            font-size: small;
        }
        .auto-style99 {
            font-size: small;
        }
        .auto-style100 {
            width: 143px;
            font-size: small;
        }
        .auto-style101 {
            border-style: dotted;
            border-width: 1px;
            text-align: right;
            color: #990000;
            width: 111px;
            font-size: small;
            height: 8px;
        }
        .auto-style102 {
            border-style: dotted;
            border-width: 1px;
            width: 111px;
            text-align: right;
            color: #003300;
            font-size: small;
        }
        .auto-style103 {
            width: 143px;
            text-align: right;
            font-weight: normal;
            background-color: #FFFFFF;
        }
        .auto-style104 {
            width: 128px;
            text-align: right;
            font-weight: normal;
            background-color: #FFFFFF;
        }
        .auto-style105 {
            background-color: #FFFFFF;
        }
        .auto-style106 {
            width: 143px;
            background-color: #5D7B9D;
        }
        .auto-style108 {
            width: 128px;
            background-color: #FFFFFF;
        }
        .auto-style109 {
            width: 197px;
            text-align: left;
            background-color: #FFFFFF;
        }
        .auto-style110 {
            width: 143px;
            text-align: right;
            background-color: #FFFFFF;
        }
        .auto-style111 {
            text-align: left;
            background-color: #FFFFFF;
        }
        .auto-style112 {
            width: 128px;
            text-align: right;
            background-color: #FFFFFF;
        }
        .auto-style113 {
            background-color: #5D7B9D;
        }
        </style>
</asp:Content>
<asp:Content ID="Body" runat="server" ContentPlaceHolderID="Body">
    <div>

        <span class="auto-style81"><strong>Affiliations</strong></span>
            <table  dir="ltr" style="table-layout: fixed; background-color: #99CCFF;">
            <tr>
                <td class="auto-style57">

                    Search</td>
                <td class="auto-style74">

                    </td>
                <td class="auto-style80"></td>
                <td class="auto-style78">&nbsp;</td>
                <td class="auto-style54">

                    <asp:Button ID="btnAllUpdates" runat="server" OnClick="btnAllUpdates_Click" Text="Proceed all updates" Width="47px" Visible="False" />

                    </td>
            </tr>
            <tr>
                <td class="auto-style84" rowspan="2">

                    Clinic</td>
                <td class="auto-style97">

                    <asp:RadioButton ID="rbEntityName" runat="server" Checked="True" GroupName="Clc" Text="Name" CssClass="auto-style99" />
       </td>
                <td class="auto-style67" rowspan="2">

                    <strong style="text-align: left">
                    <asp:TextBox ID="txtEntityNameSe" runat="server" MaxLength="50" CssClass="auto-style99"></asp:TextBox>
        </strong>
                </td>
                <td class="auto-style83" rowspan="2">

                    <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="&gt;&gt;" CssClass="auto-style87" />
                </td>
                <td class="auto-style68" rowspan="2">

        <strong style="text-align: left">
                    <asp:DropDownList ID="ddlEntityIDSe" runat="server" Height="16px" AutoPostBack="True" CssClass="auto-style87" OnSelectedIndexChanged="ddlEntityIDSe_SelectedIndexChanged">
                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                    </asp:DropDownList>
        </strong>
                    <asp:TextBox ID="txtClinicCode" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style102">

                    <strong style="text-align: left">
                    <asp:RadioButton ID="rbEntityCode" runat="server" GroupName="Clc" Text="Code" CssClass="auto-style99" />
        </strong></td>
            </tr>
            <tr>
                <td class="auto-style86" rowspan="2">

        <strong style="text-align: left">
                    Physician</strong></td>
                <td class="auto-style96">
                    <asp:RadioButton ID="rbPhyName" runat="server" Checked="True" GroupName="phy" Text="Name" CssClass="auto-style99" />
                </td>
                <td class="auto-style79" rowspan="2">

        <strong style="text-align: left">
                    <asp:TextBox ID="txtPhusicianSe" runat="server" Width="119px" CssClass="auto-style85" MaxLength="50"></asp:TextBox>
        </strong>
                </td>
                <td class="auto-style83" rowspan="2">

        <strong style="text-align: left">
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="&gt;&gt;" CssClass="auto-style85" />
        </strong>
                </td>
                <td class="auto-style68" rowspan="2">

        <strong style="text-align: left">
                    <asp:DropDownList ID="ddlPhysicianIDSe" runat="server" Style="margin-left: 0px" CssClass="auto-style85" OnSelectedIndexChanged="ddlPhysicianIDSe_SelectedIndexChanged">
                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                    </asp:DropDownList>
        </strong>
                    <asp:TextBox ID="txtPhysicianCode" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style101"><strong style="text-align: left">
                    <asp:RadioButton ID="rbPhyCode" runat="server" GroupName="phy" Text="Code" CssClass="auto-style99" />
        </strong></td>
            </tr>
            <tr>
                <td class="auto-style100">Affiliation </td>
                <td class="auto-style76">Brick</td>
                <td class="auto-style80">
                    <asp:DropDownList ID="ddlBrick" runat="server" DataSourceID="BricksDataSource" DataTextField="AmounBrickName" DataValueField="AmounBrickID" AppendDataBoundItems="True">
                        <asp:ListItem Value="0">Select</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="auto-style78">&nbsp;</td>
                <td class="auto-style54">

        <strong style="text-align: left">
                    <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search" CssClass="auto-style99" />
        </strong>
                </td>
            </tr>
            <tr>
                <td class="auto-style100">
                    <asp:SqlDataSource ID="BricksDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT [AmounBrickName], [AmounBrickID] FROM [AreaHierarchy] WHERE ([Deleted] IS NULL) ORDER BY [AmounBrickName]"></asp:SqlDataSource>
                </td>
                <td class="auto-style76">Name</td>
                <td class="auto-style80">
                    <asp:TextBox ID="txtNameSe" runat="server" MaxLength="110" CssClass="auto-style99"></asp:TextBox>
                </td>
                <td class="auto-style78"><strong style="text-align: left">Code</strong></td>
                <td class="auto-style98">

                    <strong style="text-align: left">
                    <asp:TextBox ID="txtCodeSe" runat="server" MaxLength="10" CssClass="auto-style99"></asp:TextBox>
        </strong>
                </td>
            </tr>
            </table>
        
        <table  dir="ltr" style="table-layout: fixed">
            <tr>

                <td>
        <div style="width: 100%; height: 250px; overflow: auto">
        <asp:GridView ID="gvAffiliations" runat="server" OnRowCreated="gvAffiliations_RowCreated" OnSelectedIndexChanged="gvAffiliations_SelectedIndexChanged" CellPadding="4" ForeColor="#333333" GridLines="None" CssClass="auto-style99">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
               </div>
                </td>
            </tr>
            </table>
        <table class="auto-style21">
           
            <tr>
        
                <td class="auto-style93">Affiliation Name</td>
                <td class="auto-style94">

                    <asp:TextBox ID="txtAffiliationName" runat="server" Width="245px" MaxLength="110" CssClass="auto-style113"></asp:TextBox>

                </td>

                <td class="auto-style91">

                    <asp:TextBox ID="txtAffID" runat="server" Visible="False"></asp:TextBox>

                </td>
                <td class="auto-style88">

                    <br />
                </td>

            </tr>
            <tr>

                <td class="auto-style103">Clinic Code </td>
                <td class="auto-style109">

                    <asp:TextBox ID="txtAffClinicCode" runat="server"></asp:TextBox>

                </td>
                <td class="auto-style104">Physician 

                    Code 

                </td>
                <td class="auto-style111">

                    <asp:TextBox ID="txtAffPhyCode" runat="server" OnTextChanged="txtAffPhyCode_TextChanged"></asp:TextBox>
                </td>

            </tr>
            <tr>

       
                <td class="auto-style110">

        
                    <strong>Best Time From </strong> 
     

                </td>
                <td class="auto-style109">

                    <asp:TextBox ID="txtBestTimeFrom" runat="server" Width="127px" MaxLength="50"></asp:TextBox>
                </td>
                <td class="auto-style112">

                    <strong>To </strong></td>
                <td class="auto-style111">

                    <asp:TextBox ID="txtBestTimeTo" runat="server" MaxLength="50"></asp:TextBox>

                </td>

            </tr>
            <tr>

                <td class="auto-style110">

        
                    Notes 
     

                </td>
                <td class="auto-style109">

        <strong style="text-align: left">
                    <asp:TextBox ID="txtNotes" runat="server" Height="34px" Width="177px" MaxLength="150"></asp:TextBox>
        </strong>
                </td>

                <td class="auto-style108">&nbsp;</td>

                <td class="auto-style105">
                    <asp:TextBox ID="txtSpCode" runat="server" Visible="False"></asp:TextBox>
                </td>
            </tr>
            </table>
        <table class="auto-style21">
           
            <tr>

                <td class="auto-style106">&nbsp;</td>
                <td>Line 1</td>
                <td>Line 2</td>
                <td>Line 3</td>
                <td>Line 4</td>
                <td>Line 5</td>
                <td>Line 6</td>
                <td>Line 7</td>
            </tr>
            <tr>

                <td class="auto-style106">Prescription Habit</td>
                <td class="auto-style111">
                    <asp:DropDownList ID="ddlLine1" runat="server" DataSourceID="PHabitDataSource" DataTextField="ShortName" DataValueField="RangeValue" AppendDataBoundItems="True">
                   <asp:ListItem Value="0">Select</asp:ListItem>
                         </asp:DropDownList>
                </td>
                <td class="auto-style111">
                    <asp:DropDownList ID="ddlLine2" runat="server" DataSourceID="PHabitDataSource" DataTextField="ShortName" DataValueField="RangeValue" AppendDataBoundItems="True">
                    <asp:ListItem Value="0">Select</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="auto-style111">
                    <asp:DropDownList ID="ddlLine3" runat="server" DataSourceID="PHabitDataSource" DataTextField="ShortName" DataValueField="RangeValue" AppendDataBoundItems="True">
                    <asp:ListItem Value="0">Select</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="auto-style111">
                    <asp:DropDownList ID="ddlLine4" runat="server" DataSourceID="PHabitDataSource" DataTextField="ShortName" DataValueField="RangeValue" AppendDataBoundItems="True">
                    <asp:ListItem Value="0">Select</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="auto-style111">
                    <asp:DropDownList ID="ddlLine5" runat="server" DataSourceID="PHabitDataSource" DataTextField="ShortName" DataValueField="RangeValue" AppendDataBoundItems="True">
                    <asp:ListItem Value="0">Select</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="auto-style111">
                    <asp:DropDownList ID="ddlLine6" runat="server" DataSourceID="PHabitDataSource" DataTextField="ShortName" DataValueField="RangeValue" AppendDataBoundItems="True">
                    <asp:ListItem Value="0">Select</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="auto-style111">
                    <asp:DropDownList ID="ddlLine7" runat="server" DataSourceID="PHabitDataSource" DataTextField="ShortName" DataValueField="RangeValue" AppendDataBoundItems="True">
                    <asp:ListItem Value="0">Select</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>

                <td class="auto-style106">No. Of Patients</td>
                <td class="auto-style105">
                    <asp:DropDownList ID="ddlNoPatients1" runat="server" DataSourceID="NOPatientsDataSource" DataTextField="RangeName" DataValueField="RangeValue" AppendDataBoundItems="True">
                    <asp:ListItem Value="0">Select</asp:ListItem>
                    </asp:DropDownList>
                    <asp:TextBox ID="txtRecID1" runat="server" OnTextChanged="txtRecID1_TextChanged" Visible="False" Width="75px"></asp:TextBox>
                </td>
                <td class="auto-style105">
                    <asp:DropDownList ID="ddlNoPatients2" runat="server" DataSourceID="NOPatientsDataSource" DataTextField="RangeName" DataValueField="RangeValue" AppendDataBoundItems="True">
                    <asp:ListItem Value="0">Select</asp:ListItem>
                    </asp:DropDownList>
                    <asp:TextBox ID="txtRecID2" runat="server" Visible="False" Width="76px"></asp:TextBox>
                </td>
                <td class="auto-style105">
                    <asp:DropDownList ID="ddlNoPatients3" runat="server" DataSourceID="NOPatientsDataSource" DataTextField="RangeName" DataValueField="RangeValue" AppendDataBoundItems="True">
                     <asp:ListItem Value="0">Select</asp:ListItem>
                    </asp:DropDownList>
                    <asp:TextBox ID="txtRecID3" runat="server" Visible="False" Width="76px"></asp:TextBox>
                </td>
                <td class="auto-style105">
                    <asp:DropDownList ID="ddlNoPatients4" runat="server" DataSourceID="NOPatientsDataSource" DataTextField="RangeName" DataValueField="RangeValue" AppendDataBoundItems="True">
                                       <asp:ListItem Value="0">Select</asp:ListItem>
                    </asp:DropDownList>
                    <asp:TextBox ID="txtRecID4" runat="server" Visible="False" Width="72px"></asp:TextBox>
                </td>
                <td class="auto-style105">
                    <asp:DropDownList ID="ddlNoPatients5" runat="server" DataSourceID="NOPatientsDataSource" DataTextField="RangeName" DataValueField="RangeValue" AppendDataBoundItems="True">
                                       <asp:ListItem Value="0">Select</asp:ListItem>
                    </asp:DropDownList>
                    <asp:TextBox ID="txtRecID5" runat="server" Visible="False" Width="59px"></asp:TextBox>
                </td>
                <td class="auto-style105">
                    <asp:DropDownList ID="ddlNoPatients6" runat="server" DataSourceID="NOPatientsDataSource" DataTextField="RangeName" DataValueField="RangeValue" AppendDataBoundItems="True">
                                       <asp:ListItem Value="0">Select</asp:ListItem>
                    </asp:DropDownList>
                    <asp:TextBox ID="txtRecID6" runat="server" Visible="False" Width="69px"></asp:TextBox>
                </td>
                <td class="auto-style105">
                    <asp:DropDownList ID="ddlNoPatients7" runat="server" DataSourceID="NOPatientsDataSource" DataTextField="RangeName" DataValueField="RangeValue" AppendDataBoundItems="True">
                                       <asp:ListItem Value="0">Select</asp:ListItem>
                    </asp:DropDownList>
                    <asp:TextBox ID="txtRecID7" runat="server" Visible="False" Width="68px"></asp:TextBox>
                </td>
            </tr>
            <tr>

                <td class="auto-style106">Waiting Time</td>
                <td class="auto-style105">
                    <asp:DropDownList ID="ddlWT1" runat="server" DataSourceID="WTDataSource" DataTextField="RangeName" DataValueField="RangeValue">
                        <asp:ListItem Value="0">Select</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="auto-style105">
                    <asp:DropDownList ID="ddlWT2" runat="server" DataSourceID="WTDataSource" DataTextField="RangeName" DataValueField="RangeValue">
                        <asp:ListItem Value="0">Select</asp:ListItem>

                    </asp:DropDownList>
                </td>
                <td class="auto-style105">
                    <asp:DropDownList ID="ddlWT3" runat="server" DataSourceID="WTDataSource" DataTextField="RangeName" DataValueField="RangeValue">
                    <asp:ListItem Value="0">Select</asp:ListItem>

                    </asp:DropDownList>
                </td>
                <td class="auto-style105">
                    <asp:DropDownList ID="ddlWT4" runat="server" DataSourceID="WTDataSource" DataTextField="RangeName" DataValueField="RangeValue">
                    </asp:DropDownList>
                </td>
                <td class="auto-style105">
                    <asp:DropDownList ID="ddlWT5" runat="server" DataSourceID="WTDataSource" DataTextField="RangeName" DataValueField="RangeValue">
                        <asp:ListItem Value="0">Select</asp:ListItem>

                    </asp:DropDownList>
                </td>
                <td class="auto-style105">
                    <asp:DropDownList ID="ddlWT6" runat="server" DataSourceID="WTDataSource" DataTextField="RangeName" DataValueField="RangeValue">
                                       <asp:ListItem Value="0">Select</asp:ListItem>

                         </asp:DropDownList>
                </td>
                <td class="auto-style105">
                    <asp:DropDownList ID="ddlWT7" runat="server" DataSourceID="WTDataSource" DataTextField="RangeName" DataValueField="RangeValue">
                                        <asp:ListItem Value="0">Select</asp:ListItem>

                    </asp:DropDownList>
                </td>
            </tr>
            <tr>

                <td colspan="8" class="auto-style105">
                    <asp:SqlDataSource ID="PHabitDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT [RangeValue], [ShortName] FROM [PrescriptionHappit]"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="NOPatientsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT [RangeName], [RangeValue] FROM [NoOfPatients]"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="WTDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT [RangeName], [RangeValue] FROM [WaitingTime]"></asp:SqlDataSource>
                    <asp:Button ID="btnDelete" runat="server" OnClick="btnDelete_Click" Text="Delete" Visible="False" />
                    <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Save" />
                    <asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" Text="Update" Visible="False" />
                    </td>
            </tr>
        </table>
        <br />
        <asp:Label ID="affiliationslblSaveStatus" runat="server" ForeColor="#CC0000"></asp:Label>
        &nbsp;
        <br />
    </div>
    </asp:Content>
