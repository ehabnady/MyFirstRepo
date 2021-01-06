<%@ Page Title="" Language="C#" MasterPageFile="~/FeedbackSite4.Master" AutoEventWireup="true" CodeBehind="SalesRepPharmaReq.aspx.cs" Inherits="AmounCRM4.Admins.SalesRepPharmaReq" %>

<asp:Content ID="head" runat="server" ContentPlaceHolderID="head">
    <title></title>
       <script type = "text/javascript">

        function KeyPressOrder(fld, e) {

            var strCheck = 'ضصثقفغعهخحجدذشسيبلاتنمكطئءؤرلاىةوزظ1234567890-)( ';
            var whichCode = e.which ? e.which : e.keyCode;

            if (whichCode == 13 || whichCode == 8 || whichCode == 9) return true;
            key = String.fromCharCode(whichCode);
            if (strCheck.indexOf(key) == -1)
                return false;

            return true;
        }

        function Confirm() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Do you want to delete this request?")) {
                confirm_value.value = "Yes";
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }
    </script>
        
    <style type="text/css">
        .FixedHeader {
            position: absolute;
            font-weight: bold;
        }     
        .auto-style88 {
            text-align: left;
        }
        .auto-style104 {
            height: 34px;
            text-align: left;
            background-color: #5D7B9D;
        }
        .auto-style105 {
            width: 166px;
            height: 34px;
            text-align: right;
            font-weight: 700;
            font-size: small;
            background-color: #5D7B9D;
        }
        .auto-style112 {
            height: 34px;
            text-align: left;
            width: 211px;
            background-color: #5D7B9D;
        }
        .auto-style133 {
            height: 17px;
            text-align: left;
            background-color: #F7F6F3;
        }
        .auto-style134 {
            width: 182px;
            height: 17px;
            text-align: right;
            font-weight: 700;
            font-size: small;
            background-color: #F7F6F3;
        }
        .auto-style135 {
            height: 17px;
            text-align: left;
            width: 211px;
            background-color: #F7F6F3;
        }
        .auto-style158 {
            text-align: left;
            background-color: #F7F6F3;
        }
        .auto-style162 {
            text-align: left;
            width: 211px;
            height: 19px;
            background-color: #F7F6F3;
        }
        .auto-style163 {
            width: 182px;
            text-align: right;
            font-weight: 700;
            font-size: small;
            height: 19px;
            background-color: #F7F6F3;
        }
        .auto-style164 {
            text-align: left;
            height: 19px;
            background-color: #F7F6F3;
        }
        .auto-style184 {
            background-color: #5D7B9D;
        }
        .auto-style185 {
        }
        .auto-style186 {
            font-size: small;
        }
        .auto-style188 {
            width: 254px;
            font-size: small;
            background-color: #5D7B9D;
        }
        .auto-style189 {
            font-size: small;
            background-color: #F7F6F3;
        }
        .auto-style190 {
            background-color: #5D7B9D;
            font-size: medium;
        }
        .auto-style191 {
            background-color: #5D7B9D;
            font-size: small;
        }
        .auto-style196 {
            width: 166px;
            text-align: right;
            font-weight: 700;
            font-size: small;
            background-color: #F7F6F3;
        }
        .auto-style197 {
            width: 166px;
            height: 17px;
            text-align: right;
            font-weight: 700;
            font-size: small;
            background-color: #F7F6F3;
        }
        .auto-style198 {
            width: 166px;
            text-align: right;
            font-weight: 700;
            font-size: small;
            background-color: #F7F6F3;
        }
        .auto-style200 {
            height: 17px;
            text-align: left;
            background-color: #F7F6F3;
            width: 627px;
        }
        .auto-style201 {
            width: 627px;
        }
        .auto-style202 {
            background-color: #5D7B9D;
            font-size: small;
            width: 243px;
        }
        .RadComboBox_WebBlue{color:#000;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_WebBlue{color:#000;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_WebBlue{color:#000;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox_WebBlue .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI.Skins, Version=2016.3.1018.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.WebBlue.Common.radFormSprite.png')}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_WebBlue .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI.Skins, Version=2016.3.1018.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.WebBlue.Common.radFormSprite.png')}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_WebBlue .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI.Skins, Version=2016.3.1018.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.WebBlue.Common.radFormSprite.png')}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_WebBlue .rcbReadOnly .rcbInput{color:#0d202b}.RadComboBox .rcbReadOnly .rcbInput{cursor:default}.RadComboBox_WebBlue .rcbReadOnly .rcbInput{color:#0d202b}.RadComboBox .rcbReadOnly .rcbInput{cursor:default}.RadComboBox_WebBlue .rcbReadOnly .rcbInput{color:#0d202b}.RadComboBox .rcbReadOnly .rcbInput{cursor:default}.RadComboBox_WebBlue .rcbInput{color:#000;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif;line-height:16px}.RadComboBox .rcbInput{margin:0;padding:2px 0 1px;height:auto;width:100%;border-width:0;outline:0;color:inherit;background-color:transparent;vertical-align:top;opacity:1}.RadComboBox_WebBlue .rcbInput{color:#000;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif;line-height:16px}.RadComboBox .rcbInput{margin:0;padding:2px 0 1px;height:auto;width:100%;border-width:0;outline:0;color:inherit;background-color:transparent;vertical-align:top;opacity:1}.RadComboBox_WebBlue .rcbInput{color:#000;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif;line-height:16px}.RadComboBox .rcbInput{margin:0;padding:2px 0 1px;height:auto;width:100%;border-width:0;outline:0;color:inherit;background-color:transparent;vertical-align:top;opacity:1}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox_WebBlue .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI.Skins, Version=2016.3.1018.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.WebBlue.Common.radFormSprite.png')}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_WebBlue .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI.Skins, Version=2016.3.1018.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.WebBlue.Common.radFormSprite.png')}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_WebBlue .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI.Skins, Version=2016.3.1018.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.WebBlue.Common.radFormSprite.png')}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}
    .auto-style203 {
        border-width: 0;
        padding-left: 5px;
        padding-right: 4px;
        padding-top: 0;
        padding-bottom: 0;
    }
        </style>
</asp:Content>

<asp:Content ID="Body" runat="server" ContentPlaceHolderID="Body" >
    <div>

        
        </strong>
        <table align="center">
            <tr>
                <td class="auto-style203">
                    <strong>DB Request
                </strong>
                </td>

            </tr>
        </table>
        <table align="center" dir="ltr" style="table-layout: fixed" >
            <tr>
                <td>
                    <div style="width: 100%; height: 200px; overflow: auto" >
                        <%--<asp:Panel ID="gridPanel" runat="server" Height="200px" Width="Auto" ScrollBars="Auto">--%>
                        <asp:GridView ID="gvAffiliations" runat="server" OnSelectedIndexChanged="gvAffiliations_SelectedIndexChanged" 
                            OnRowCreated="gvAffiliations_RowCreated"
                            CellPadding="4" ForeColor="#333333" GridLines="None" Style="font-size: small">
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
                        <%--</asp:Panel>--%>
                    </div>
                </td>
            </tr>
        </table>
        <br />
        <asp:Label ID="affiliationslblSaveStatus" runat="server" ForeColor="#CC0000"></asp:Label>

        <asp:Panel ID="Panel1" runat="server">
            <table align="center" dir="ltr" style="table-layout: fixed; width: 769px;">
                <tr>
                    <td class="auto-style105">&nbsp;</td>
                    <td class="auto-style104" colspan="2"><strong style="text-align: left">
                        <asp:TextBox ID="txtAffiliationName" runat="server" Width="366px" BackColor="#5D7B9D" BorderStyle="None" Enabled="False" ForeColor="white" Style="font-size: small"></asp:TextBox>
                    </strong></td>
                    <td class="auto-style112"><strong style="text-align: left">
                        <asp:TextBox ID="txtAffiliationID" runat="server" Enabled="False" ReadOnly="True" Width="83px" BorderStyle="None" CssClass="auto-style184"></asp:TextBox>
                    </strong></td>
                </tr>
                <tr>
                    <td class="auto-style196">Request Type </td>
                    <td class="auto-style164">
                        <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged" Width="169px">
                            <asp:ListItem Value="0">Select</asp:ListItem>
                            <asp:ListItem>New</asp:ListItem>
                            <asp:ListItem>Update</asp:ListItem>
                            <asp:ListItem>Delete</asp:ListItem>
                        </asp:DropDownList>
                        <asp:Label ID="lblRequestTypeReq" runat="server" ForeColor="Red" Text="*" Visible="False"></asp:Label>
                    </td>
                    <td class="auto-style163">
                        <asp:Label ID="lblCodeSe" runat="server" Text="Enter Code" Visible="False"></asp:Label>
                    </td>
                    <td class="auto-style162">
                       <%-- <asp:DropDownList ID="ddlRepAffiliations" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlRepAffiliations_SelectedIndexChanged" Visible="False" Width="188px" AppendDataBoundItems="True" DataSourceID="AffDataSource1" DataTextField="AffiliationName" DataValueField="AffiliationID">
                            <asp:ListItem Value="0">Select</asp:ListItem>
                        </asp:DropDownList>--%>
                        <asp:TextBox ID="txtSeCode" runat="server" OnTextChanged="txtSeCode_TextChanged" Visible="False" AutoPostBack="true"></asp:TextBox>

                    </td>
                </tr>
                <tr>
                    <td class="auto-style196">
                        <asp:Label ID="lblPharma" runat="server" Text="Select Pharmacy" Visible="False"></asp:Label>
                    </td>
                    <td class="auto-style164">
                        <asp:DropDownList ID="ddlPharma" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPharma_SelectedIndexChanged" Visible="false" >
                            <asp:ListItem Value="0">Select</asp:ListItem>

                        </asp:DropDownList>
                    </td>
                    <td class="auto-style163">&nbsp;</td>
                    <td class="auto-style162">
                        <asp:TextBox ID="txtEmpID" runat="server" Visible="False"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style196">Pharmacy <strong><span class="auto-style189">Name</span></strong></td>
                    <td class="auto-style164"><strong style="text-align: left">

                        <asp:TextBox ID="txtNewEntityIDOld" runat="server" Width="165px" Enabled="False" Visible="False" OnTextChanged="txtNewEntityIDOld_TextChanged"></asp:TextBox>
                        <asp:Label ID="lblEntityReq" runat="server" ForeColor="Red" Text="*" Visible="False"></asp:Label>
                        <asp:TextBox ID="txtNewEntityID" runat="server" ondragstart="return false" onkeydown="(KeyPressOrder(this,event))" onkeypress="return(KeyPressOrder(this,event))" onselectstart="return false" Width="165px"></asp:TextBox>
                    </strong></td>
                    <td class="auto-style163">Pharmacy Code</td>
                    <td class="auto-style162">
                        <asp:TextBox ID="txtPharmaCode" runat="server" Enabled="false" OnTextChanged="txtPharmaCode_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                                        <asp:Label ID="lblPharmaCode" runat="server" ForeColor="Red" Text="*" Visible="False"></asp:Label>

                    </td>
                </tr>
                <tr>

                    <td class="auto-style197">Pharmacy Address<br />
                        <asp:Label ID="lblClinicAddressOld" runat="server" Style="color: #666666" Text="Current Pharmacy Address" Visible="False"></asp:Label>
                    </td>
                    <td class="auto-style133" colspan="3">
                        <asp:TextBox ID="txtClinicAddress" runat="server" Width="572px" onselectstart="return false" ondragstart="return false" onkeypress="return(KeyPressOrder(this,event))" onkeydown="(KeyPressOrder(this,event))"></asp:TextBox>
                        <asp:Label ID="lblAddressReq" runat="server" ForeColor="Red" Text="*" Visible="False"></asp:Label>
                        <asp:TextBox ID="txtClinicAddressOld" runat="server" Width="571px" Enabled="False" Visible="False"></asp:TextBox>

                    </td>

                </tr>
                <tr>

                    <td class="auto-style197">
                        <asp:TextBox ID="txtBrickID" runat="server" Enabled="False" Visible="False" Width="50px"></asp:TextBox>
                        <strong style="text-align: left">Brick<br />
                            <asp:Label ID="lblOldBrick" runat="server" Style="color: #666666" Text="Current Brick" Visible="False"></asp:Label>
                        </strong></td>
                    <td class="auto-style200">
                        <strong style="text-align: left">
                            <asp:DropDownList ID="ddlAreaRecID" runat="server" DataSourceID="AreaDataSource" DataTextField="AmounBrickName" DataValueField="AmounBrickID" OnSelectedIndexChanged="ddlAreaRecID_SelectedIndexChanged" Width="169px"
                                AppendDataBoundItems="true">
                                <asp:ListItem Value="0">Select</asp:ListItem>
                            </asp:DropDownList>
                            <asp:Label ID="lblAreaReq" runat="server" ForeColor="Red" Text="*" Visible="False"></asp:Label>
                            <asp:DropDownList ID="ddlAreaRecIDOld" runat="server" DataSourceID="AreaDataSource" DataTextField="AmounBrickName" DataValueField="AmounBrickID" Width="169px"
                                AppendDataBoundItems="true" Enabled="False" Visible="False">
                                <asp:ListItem Value="0">Select</asp:ListItem>
                            </asp:DropDownList>
                        </strong>
                    </td>
                    <td class="auto-style134">
                        <asp:TextBox ID="txtStatus" runat="server" Visible="False"></asp:TextBox>
                    </td>
                    <td class="auto-style135">
                        <div class="auto-style88">
                            <asp:TextBox ID="txtAffID" runat="server" Enabled="False" Visible="False"></asp:TextBox>
                        </div>
                    </td>

                </tr>
                <tr>
                    <td class="auto-style198">&nbsp;Request
                        <asp:Label ID="lblDescription" runat="server" Text="Description"></asp:Label>
                    </td>
                    <td class="auto-style158" colspan="3">
                        <asp:TextBox ID="txtDescription" runat="server" Width="552px"></asp:TextBox>
                        <asp:Label ID="lblDescriptionReq" runat="server" ForeColor="Red" Text="*" Visible="False"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style198">Request Date</td>
                    <td style="background-color: #F7F6F3" class="auto-style201">
                        <asp:TextBox ID="txtRequestDate" runat="server" Enabled="False" Width="153px"></asp:TextBox>
                    </td>
                    <td style="background-color: #F7F6F3">&nbsp;</td>
                    <td style="background-color: #F7F6F3">&nbsp;</td>
                </tr>

            </table>

            <br />





            <table align="center">
                <tr>

                    <td class="auto-style191">
                        <strong>Approvals List</strong></td>
                    <td class="auto-style190">
                        <strong></strong></td>
                    <td class="auto-style188">
                        <strong>Name</strong></td>
                    <td class="auto-style202"><strong>Comments</strong></td>
                </tr>
                <tr>
                    <td class="auto-style189"><strong>Sales Director</strong></td>
                    <td style="background-color: #F7F6F3">
                        <asp:RadioButton ID="rbSDApprove" runat="server" GroupName="SD" Text="Approved" CssClass="auto-style186" AutoPostBack="True" OnCheckedChanged="rbSDApprove_CheckedChanged" />
                        <asp:RadioButton ID="rbSDReject" runat="server" GroupName="SD" Text="Rejected" CssClass="auto-style186" AutoPostBack="True" OnCheckedChanged="rbSDReject_CheckedChanged" />
                    </td>
                    <td class="auto-style185" style="background-color: #F7F6F3">
                        <asp:TextBox ID="txtSDName" runat="server" Width="143px" CssClass="auto-style186" Enabled="False"></asp:TextBox>
                        <asp:TextBox ID="txtSDDate" runat="server" Enabled="False" Width="73px"></asp:TextBox>
                    </td>
                    <td style="background-color: #F7F6F3" class="auto-style1">
                        <asp:TextBox ID="txtSDComments" runat="server" TextMode="MultiLine" CssClass="auto-style186"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style191">&nbsp;</td>
                    <td class="auto-style184">&nbsp;</td>
                    <td class="auto-style184" colspan="2" align="right"><strong style="text-align: right">
                        <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Save" />
                        <asp:Button ID="btnUpdate" runat="server" OnClick="Button1_Click" Text="Update" />
                    </strong>
                        <asp:Button ID="btnDelete" runat="server" OnClick="btnDelete_Click" OnClientClick="Confirm()" Text="Delete" />
                        <asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="Cancel" Visible="False" />
                    </td>
                </tr>
            </table>


        </asp:Panel>
        <asp:SqlDataSource ID="EntityDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
            SelectCommand="SELECT EntityID, EntityName FROM Entities"></asp:SqlDataSource>

        <asp:SqlDataSource ID="AreaDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
            SelectCommand="SELECT AmounBrickID, AmounBrickName FROM View_EmployeesBricks WHERE (Deleted IS NULL) OR (Deleted = 0)"></asp:SqlDataSource>

        <asp:SqlDataSource ID="dsBricks" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
            SelectCommand="SELECT [AmounBrickID], [AmounBrickName], [RepAreaID] FROM [View_EmployeesBricks] WHERE ([EmployeeID] = @EmployeeID) ORDER BY [AmounBrickName]">
            <SelectParameters>
                <asp:SessionParameter Name="EmployeeID" SessionField="EmployeeID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="AffPropDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT distinct Affiliations_Proposed.AffiliationName, Affiliations_Proposed.SpecialityID, Affiliations_Proposed.LineID, Affiliations_Proposed.RequestType, Affiliations_Proposed.RepName FROM Affiliations_Proposed inner JOIN BrandPriorityBySpecLine ON Affiliations_Proposed.SpecialityID =BrandPriorityBySpecLine.SpecialtyID">
            <SelectParameters>
                <asp:SessionParameter Name="EmployeeID" SessionField="EmployeeID" Type="Int32" />
                <asp:Parameter DefaultValue="0" Name="SpecialtyValue" Type="Double" />
            </SelectParameters>

        </asp:SqlDataSource>
        <asp:SqlDataSource ID="PharmaDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT [PharmacyID], [PharmacyName] FROM [PH_Pharmacies] WHERE (([Deleted] IS NULL) or ([Deleted] = 0))"></asp:SqlDataSource>
        <br />
    </div>

</asp:Content>

