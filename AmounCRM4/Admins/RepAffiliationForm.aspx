<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="RepAffiliationForm.aspx.cs" Inherits="AmounCRM4.Admins.RepAffiliationForm" %>

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
        .auto-style81 {
            color: #800000;
            font-size: xx-large;
            text-decoration: underline;
            vertical-align:top;
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
        .auto-style106 {
            font-size: small;
            }
        .auto-style112 {
            height: 34px;
            text-align: left;
            width: 211px;
            background-color: #5D7B9D;
        }
        .auto-style122 {
            text-align: left;
            width: 211px;
            background-color: #F7F6F3;
        }
        .auto-style124 {
            width: 182px;
            text-align: right;
            font-weight: 700;
            font-size: small;
            background-color: #F7F6F3;
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
        .auto-style143 {
            height: 20px;
            text-align: left;
            width: 627px;
            background-color: #F7F6F3;
        }
        .auto-style144 {
            width: 182px;
            height: 20px;
            text-align: right;
            font-weight: 700;
            font-size: small;
            background-color: #F7F6F3;
        }
        .auto-style145 {
            height: 20px;
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
        .auto-style172 {
            width: 166px;
            height: 20px;
            text-align: right;
            font-weight: 700;
            font-size: small;
            background-color: #F7F6F3;
        }
        .auto-style175 {
            width: 627px;
            text-align: left;
            background-color: #F7F6F3;
        }
        .auto-style176 {
            width: 182px;
            height: 15px;
            text-align: right;
            font-weight: 700;
            font-size: small;
            background-color: #F7F6F3;
        }
        .auto-style177 {
            height: 15px;
            text-align: left;
            width: 211px;
            background-color: #F7F6F3;
        }
        .auto-style178 {
            width: 166px;
            height: 15px;
            text-align: right;
            font-weight: 700;
            font-size: small;
            background-color: #F7F6F3;
        }
        .auto-style179 {
            height: 15px;
            text-align: left;
            width: 627px;
            background-color: #F7F6F3;
        }
        .auto-style180 {
            width: 182px;
            text-align: right;
            font-weight: 700;
            font-size: small;
            height: 5px;
            background-color: #F7F6F3;
        }
        .auto-style181 {
            text-align: left;
            width: 211px;
            height: 5px;
            background-color: #F7F6F3;
        }
        .auto-style182 {
            width: 166px;
            height: 5px;
            text-align: right;
            font-weight: 700;
            font-size: small;
            background-color: #F7F6F3;
        }
        .auto-style183 {
            height: 5px;
            text-align: left;
            width: 627px;
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
        .auto-style192 {
            background-color: #F7F6F3;
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
    .auto-style204 {
        border-width: 0;
        padding: 0;
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
                    <td class="auto-style105">Doctor Name
                    </td>
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
                            <asp:ListItem>Update Added Doctor</asp:ListItem>
                        </asp:DropDownList>
                        <asp:Label ID="lblRequestTypeReq" runat="server" ForeColor="Red" Text="*" Visible="False"></asp:Label>
                    </td>
                    <td class="auto-style163">&nbsp;</td>
                    <td class="auto-style162">
                        <asp:DropDownList ID="ddlRepAffiliations" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlRepAffiliations_SelectedIndexChanged" Visible="False" Width="188px" AppendDataBoundItems="True" DataSourceID="AffDataSource1" DataTextField="AffiliationName" DataValueField="AffiliationID">
                            <asp:ListItem Value="0">Select</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style196" rowspan="2">
                        <asp:Label ID="lblSelectAffiliation" runat="server" Text="Select Doctor" Visible="False"></asp:Label>
                    </td>
                    <td class="auto-style164">
                        <telerik:RadComboBox ID="cbBricks" runat="server" AppendDataBoundItems="true" AutoPostBack="true" DataSourceID="dsBricks" DataTextField="AmounBrickName" DataValueField="AmounBrickID" OnSelectedIndexChanged="cbBricks_SelectedIndexChanged" Skin="WebBlue" Width="190px" Visible="False">
                            <Items>
                                <telerik:RadComboBoxItem Text="Bricks" Value="0" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td class="auto-style163">
                        <telerik:RadComboBox ID="cbClass" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cbBricks_SelectedIndexChanged" Skin="WebBlue" Width="189px" Visible="False">
                            <Items>
                                <telerik:RadComboBoxItem Selected="true" Text="Class" Value="0" />
                                <telerik:RadComboBoxItem Text="A+" Value="A+" />
                                <telerik:RadComboBoxItem Text="A" Value="A" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td class="auto-style162">
                        <telerik:RadComboBox ID="cbSpec" runat="server" AppendDataBoundItems="true" AutoPostBack="true" DataSourceID="dsSpecs" DataTextField="SpecialityCode" DataValueField="SpecialtyID" OnSelectedIndexChanged="cbBricks_SelectedIndexChanged" Skin="WebBlue" Width="194px" Visible="False">
                            <Items>
                                <telerik:RadComboBoxItem Text="Specialty" Value="0" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style164" colspan="3">
                        <telerik:RadComboBox ID="cbAffs" runat="server" AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="cbAffs_SelectedIndexChanged" Skin="WebBlue" Visible="False" Width="576px">
                            <Items>
                                <telerik:RadComboBoxItem Text="Select Doctor" Value="0" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style196"><span class="auto-style186"><strong><span class="auto-style192">Clinic</span></strong></span><strong><span class="auto-style189"> Name</span></strong></td>
                    <td class="auto-style164"><strong style="text-align: left">

                        <asp:TextBox ID="txtNewEntityID" runat="server" Width="165px" onselectstart="return false" ondragstart="return false" onkeypress="return(KeyPressOrder(this,event))" onkeydown="(KeyPressOrder(this,event))"></asp:TextBox>
                        <asp:TextBox ID="txtNewEntityIDOld" runat="server" Width="165px" Enabled="False" Visible="False"></asp:TextBox>
                        <asp:Label ID="lblEntityReq" runat="server" ForeColor="Red" Text="*" Visible="False"></asp:Label>
                    </strong></td>
                    <td class="auto-style163"><strong style="text-align: left">Doctor Name</strong></td>
                    <td class="auto-style162"><strong style="text-align: left">
                        <asp:TextBox ID="txtNewPhysicianID" runat="server" Width="187px" onselectstart="return false" ondragstart="return false" onkeypress="return(KeyPressOrder(this,event))" onkeydown="(KeyPressOrder(this,event))"></asp:TextBox>
                        <asp:TextBox ID="txtNewPhysicianIDOld" runat="server" Width="187px" Enabled="False" Visible="False"></asp:TextBox>
                        <asp:Label ID="lblPhysicianReq" runat="server" ForeColor="Red" Text="*" Visible="False"></asp:Label>
                    </strong></td>
                </tr>
                <tr>

                    <td class="auto-style197">Clinc Address<br />
                        <asp:Label ID="lblClinicAddressOld" runat="server" Style="color: #666666" Text="Current Clinic Address" Visible="False"></asp:Label>
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
                    <td class="auto-style134"><strong style="text-align: left">Speciality </strong></td>
                    <td class="auto-style135">
                        <div class="auto-style88">
                            <strong style="text-align: left">
                                <asp:DropDownList ID="ddlSpecialityID" runat="server" DataSourceID="SpecialityDataSource" DataTextField="Specialitycode" DataValueField="SpecialtyID" Width="167px" AppendDataBoundItems="true">
                                    <asp:ListItem Value="0">Select</asp:ListItem>
                                </asp:DropDownList>
                                <asp:DropDownList ID="ddlSpecialityIDOld" runat="server" DataSourceID="SpecialityDataSource" DataTextField="Specialitycode" DataValueField="SpecialtyID" Width="167px" AppendDataBoundItems="true" Enabled="False" Visible="False">

                                    <asp:ListItem Value="0">Select</asp:ListItem>
                                </asp:DropDownList>
                                <asp:Label ID="lblSpecialityReq" runat="server" ForeColor="Red" Text="*" Visible="False"></asp:Label>
                            </strong>
                        </div>
                    </td>

                </tr>
                <tr>

                    <td class="auto-style178"><strong><span class="auto-style106">Entity Type</span><br class="auto-style106" />
                    </strong>
                        <asp:Label ID="lblOldEntityType" runat="server" Style="color: #666666; background-color: #F7F6F3" Text="Current Entity Type" Visible="False"></asp:Label>
                    </td>
                    <td class="auto-style179">
                        <div class="auto-style88">
                            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="EntityTypeDataSource" DataTextField="EntityTypeName" DataValueField="EntityTypeID" Width="169px" AppendDataBoundItems="true">
                                <asp:ListItem Value="0">Select</asp:ListItem>
                            </asp:DropDownList>
                            <asp:Label ID="lblClincTypeReq" runat="server" ForeColor="Red" Text="*" Visible="False"></asp:Label>
                            <asp:DropDownList ID="DropDownList1Old" runat="server" DataSourceID="EntityTypeDataSource" DataTextField="EntityTypeName" DataValueField="EntityTypeID" Width="169px" AppendDataBoundItems="True" Enabled="False" Visible="False">
                                <asp:ListItem Value="0">Select</asp:ListItem>
                            </asp:DropDownList>
                            <br class="auto-style106" />
                        </div>
                    </td>
                    <td class="auto-style176"><strong style="text-align: left">Line </strong></td>
                    <td class="auto-style177"><strong style="text-align: left">
                        <asp:DropDownList ID="ddlLineID" runat="server" AppendDataBoundItems="True" DataSourceID="LineDataSource" DataTextField="LineName" DataValueField="LineID" OnSelectedIndexChanged="ddlLineID_SelectedIndexChanged" Width="167px">
                        </asp:DropDownList>

                    </strong>
                        <br class="auto-style106" />
                    </td>
                </tr>
                <tr>

                    <td class="auto-style196">
                        <asp:Label ID="lblNoOfPatients1" runat="server" Style="color: #000000" Text="No Of Patients" Visible="False"></asp:Label>
                        <br />
                        <asp:Label ID="lblNoOfPatientsOld" runat="server" Style="color: #666666" Text="Current No.Of Patients" Visible="False"></asp:Label>
                        <br />


                    </td>

                    <td class="auto-style164">
                        <asp:DropDownList ID="ddlNoOfPatients" runat="server" Width="169px" AppendDataBoundItems="True" DataSourceID="NoOfPatDataSource" DataTextField="RangeName" DataValueField="RangeValue" Visible="False">
                            <asp:ListItem Value="0">Select</asp:ListItem>
                        </asp:DropDownList>
                        <asp:Label ID="lblNoOfPatients" runat="server" ForeColor="Red" Text="*" Visible="False"></asp:Label>
                        <asp:DropDownList ID="ddlNoOfPatientsOld" runat="server" Width="169px" AppendDataBoundItems="True" DataSourceID="NoOfPatDataSource" DataTextField="RangeName" DataValueField="RangeValue" Enabled="False" Visible="False">
                            <asp:ListItem Value="0">Select</asp:ListItem>
                        </asp:DropDownList>


                    </td>
                    <td class="auto-style163">
                        <asp:TextBox ID="txtStatus" runat="server" Visible="False"></asp:TextBox>

                    </td>
                    <td class="auto-style162">
                        <asp:TextBox ID="txtAffID" runat="server" Enabled="False" Visible="False"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style196">
                        <asp:Label ID="lblNoOfOperations1" runat="server" Style="color: #000000" Text="No. Of Operations" Visible="False"></asp:Label>
                        <br />
                        <asp:Label ID="lblCurrNoOfOperations1" runat="server" Style="color: #666666" Text="Current No. Of Operations" Visible="False"></asp:Label></td>
                    <td class="auto-style164">
                        <asp:DropDownList ID="ddlNoOfOperations" runat="server" Visible="False" Width="169px" AppendDataBoundItems="True" DataSourceID="NoOfOpeDataSource" DataTextField="RangeName" DataValueField="RangeValue">
                            <asp:ListItem Value="0">Select</asp:ListItem>
                        </asp:DropDownList>
                        <asp:Label ID="lblNoOfOperations" runat="server" ForeColor="Red" Text="*" Visible="False"></asp:Label>
                        <asp:DropDownList ID="ddlNoOfOperationsOld" runat="server" Width="169px" AppendDataBoundItems="True" DataSourceID="NoOfOpeDataSource" DataTextField="RangeName" DataValueField="RangeValue" Enabled="False" Visible="False">
                            <asp:ListItem Value="0">Select</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style163"></td>
                    <td class="auto-style162"></td>
                </tr>
                <tr>

                    <td class="auto-style182">Prescription Habit<br />
                        <asp:Label ID="lblPrescriptionHabitOld" runat="server" Style="color: #666666" Text="Current Prescription Habit" Visible="False"></asp:Label>
                    </td>
                    <td class="auto-style183">
                        <asp:DropDownList ID="ddlPrescriptionHappit" runat="server" Width="169px" AppendDataBoundItems="True" DataSourceID="PHabitDataSource" DataTextField="RangeName" DataValueField="RangeValue">
                            <asp:ListItem Value="0">Select</asp:ListItem>
                        </asp:DropDownList>
                        <asp:Label ID="lblPrescriptionHappit" runat="server" ForeColor="Red" Text="*" Visible="False"></asp:Label>
                        <asp:DropDownList ID="ddlPrescriptionHappitOld" runat="server" Width="169px" Enabled="False" Visible="False" AppendDataBoundItems="True" DataSourceID="PHabitDataSource" DataTextField="RangeName" DataValueField="RangeValue">
                            <asp:ListItem Value="0">Select</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style180">Waiting Time<br />
                        <asp:Label ID="lblWatingTimeOld" runat="server" Text="Current Waiting Time" Visible="False" Style="color: #666666"></asp:Label>
                    </td>
                    <td class="auto-style181">
                        <asp:DropDownList ID="ddlWatingTime" runat="server" Width="167px" AppendDataBoundItems="True" DataSourceID="WTDataSource" DataTextField="RangeName" DataValueField="RangeValue">
                            <asp:ListItem Value="0">Select</asp:ListItem>
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddlWatingTimeOld" runat="server" Width="167px" AppendDataBoundItems="True" DataSourceID="WTDataSource" DataTextField="RangeName" DataValueField="RangeValue" Enabled="False" Visible="False">
                            <asp:ListItem Value="0">Select</asp:ListItem>
                        </asp:DropDownList>
                        <asp:Label ID="lblWatingTime" runat="server" ForeColor="Red" Text="*" Visible="False"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style197">Mobile</td>
                    <td class="auto-style200">
                        <asp:TextBox ID="txtTel1" runat="server" Width="167px"></asp:TextBox>
                        <asp:Label ID="lblTelReq" runat="server" ForeColor="Red" Text="*" Visible="False"></asp:Label>
                    </td>
                    <td class="auto-style134"><strong>Tel 2</strong></td>
                    <td class="auto-style135">
                        <asp:TextBox ID="txtTel2" runat="server" Width="167px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style196">Tel 3</td>
                    <td class="auto-style164">
                        <asp:TextBox ID="txtTel3" runat="server" Text="" Width="167px"></asp:TextBox>
                    </td>
                    <td class="auto-style163">Fax</td>
                    <td class="auto-style162">
                        <asp:TextBox ID="txtFax" runat="server" Width="167px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style172">Email Address</td>
                    <td class="auto-style143">
                        <asp:TextBox ID="txtEmailAddress" runat="server" Width="167px"></asp:TextBox>
                    </td>
                    <td class="auto-style144">Web Site</td>
                    <td class="auto-style145">
                        <asp:TextBox ID="txtWebSite" runat="server" Width="167px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style198">Best Time From </td>
                    <td class="auto-style175">
                        <asp:TextBox ID="txtBestTimeFrom" runat="server" Width="167px"></asp:TextBox>
                    </td>
                    <td class="auto-style124">To </td>
                    <td class="auto-style122">
                        <asp:TextBox ID="txtBestTimeTo" runat="server" Width="167px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style198"><strong style="text-align: left">Notes </strong></td>
                    <td class="auto-style158" colspan="3">
                        <strong style="text-align: left">
                            <asp:TextBox ID="txtNotes" runat="server" Width="552px"></asp:TextBox>
                        </strong>
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
                        <asp:TextBox ID="txtRequestDate" runat="server" Enabled="False" Width="73px"></asp:TextBox>
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
                    <td class="auto-style189"><strong>District Manager</strong></td>
                    <td style="background-color: #F7F6F3">
                        <asp:RadioButton ID="cbIsApproved" runat="server" GroupName="DMApproval" OnCheckedChanged="RadioButton1_CheckedChanged" Text="Approved" CssClass="auto-style186" AutoPostBack="True" />
                        <asp:RadioButton ID="cbRejected" runat="server" GroupName="DMApproval" Text="Rejected" CssClass="auto-style186" AutoPostBack="True" OnCheckedChanged="cbRejected_CheckedChanged1" />
                    </td>
                    <td class="auto-style185" style="background-color: #F7F6F3">
                        <asp:TextBox ID="txtDMName" runat="server" Width="143px" CssClass="auto-style186" Enabled="False"></asp:TextBox>
                        <asp:TextBox ID="txtDMDate" runat="server" Enabled="False" Width="73px"></asp:TextBox>
                    </td>
                    <td style="background-color: #F7F6F3" class="auto-style1">
                        <asp:TextBox ID="txtDMComments" runat="server" TextMode="MultiLine" CssClass="auto-style186"></asp:TextBox>
                        <asp:Label ID="lblDmCommentReq" runat="server" ForeColor="Red" Text="*" CssClass="auto-style186"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style189"><strong>Sales Manager</strong></td>
                    <td style="background-color: #F7F6F3">
                        <asp:RadioButton ID="rbSMApprove" runat="server" GroupName="SM" Text="Approved" CssClass="auto-style186" AutoPostBack="True" OnCheckedChanged="rbSMApprove_CheckedChanged" />
                        <asp:RadioButton ID="rpSMReject" runat="server" GroupName="SM" Text="Rejected" CssClass="auto-style186" AutoPostBack="True" OnCheckedChanged="rpSMReject_CheckedChanged" />
                    </td>
                    <td class="auto-style185" style="background-color: #F7F6F3">
                        <asp:TextBox ID="txtSMName" runat="server" Width="143px" CssClass="auto-style186" Enabled="False"></asp:TextBox>
                        <asp:TextBox ID="txtSMDate" runat="server" Enabled="False" Width="73px"></asp:TextBox>
                    </td>
                    <td style="background-color: #F7F6F3" class="auto-style1">
                        <asp:TextBox ID="txtSMComments" runat="server" TextMode="MultiLine" CssClass="auto-style186"></asp:TextBox>
                    </td>
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
                    <td class="auto-style189"><strong>Commercial Director</strong></td>
                    <td style="background-color: #F7F6F3">
                        <asp:RadioButton ID="rbCOApprove" runat="server" GroupName="CO" Text="Approved" CssClass="auto-style186" AutoPostBack="True" OnCheckedChanged="rbCOApprove_CheckedChanged" />
                        <asp:RadioButton ID="rbCOReject" runat="server" GroupName="CO" Text="Rejected" CssClass="auto-style186" AutoPostBack="True" OnCheckedChanged="rbCOReject_CheckedChanged" />
                    </td>
                    <td class="auto-style185" style="background-color: #F7F6F3">
                        <asp:TextBox ID="txtCOMangerName" runat="server" Width="143px" CssClass="auto-style186" Enabled="False"></asp:TextBox>
                        <asp:TextBox ID="txtCOMangerDate" runat="server" Enabled="False" Width="73px"></asp:TextBox>
                    </td>
                    <td style="background-color: #F7F6F3" class="auto-style1">
                        <asp:TextBox ID="txtCOComments" runat="server" TextMode="MultiLine" CssClass="auto-style186"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style189"><strong>Administrator</strong></td>
                    <td style="background-color: #F7F6F3">
                        <asp:RadioButton ID="cbimplemented" runat="server" AutoPostBack="True" CssClass="auto-style186" GroupName="Admin" OnCheckedChanged="RadioButton1_CheckedChanged1" Text="Approved" />
                        <asp:RadioButton ID="cbNotImplement" runat="server" AutoPostBack="True" CssClass="auto-style186" GroupName="Admin" OnCheckedChanged="cbNotImplement_CheckedChanged" Text="Rejected" />
                    </td>
                    <td class="auto-style185" style="background-color: #F7F6F3">
                        <asp:TextBox ID="txtAdminName" runat="server" CssClass="auto-style186" Enabled="False" Width="143px"></asp:TextBox>
                        <asp:TextBox ID="txtAdminDate" runat="server" Enabled="False" Width="73px"></asp:TextBox>
                    </td>
                    <td class="auto-style1" style="background-color: #F7F6F3">
                        <asp:TextBox ID="txtAdminComments" runat="server" CssClass="auto-style186" TextMode="MultiLine"></asp:TextBox>
                        <asp:Label ID="lblAdminCommentReq" runat="server" CssClass="auto-style186" ForeColor="Red" Text="*"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style189"><strong>Procced By</strong></td>
                    <td style="background-color: #F7F6F3">
                        <asp:CheckBox ID="cbProccedBy" runat="server" OnCheckedChanged="cbProccedBy_CheckedChanged" AutoPostBack="True" />
                    </td>
                    <td class="auto-style185" style="background-color: #F7F6F3">
                        <asp:TextBox ID="txtProccedByName" runat="server" Enabled="False" Width="143px"></asp:TextBox>
                        <asp:TextBox ID="txtProccedByDate" runat="server" Enabled="False" Width="73px"></asp:TextBox>
                    </td>
                    <td style="background-color: #F7F6F3" class="auto-style1">&nbsp;</td>
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
        <asp:SqlDataSource ID="PhysicianDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
            SelectCommand="SELECT PhysicianID, PhysicianName FROM Physicians"></asp:SqlDataSource>
        <asp:SqlDataSource ID="EntityDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
            SelectCommand="SELECT EntityID, EntityName FROM Entities"></asp:SqlDataSource>
        <asp:SqlDataSource ID="NoOfPatDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT [RangeName], [RangeValue] FROM [NoOfPatients]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="NoOfOpeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT [RangeName], [RangeValue] FROM [NoOfOperations]"></asp:SqlDataSource>

        <asp:SqlDataSource ID="AreaDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
            SelectCommand="SELECT AmounBrickID, AmounBrickName FROM View_EmployeesBricks WHERE (Deleted IS NULL) OR (Deleted = 0)"></asp:SqlDataSource>

        <asp:SqlDataSource ID="PHabitDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT [RangeName], [RangeValue] FROM [PrescriptionHappit]"></asp:SqlDataSource>

        <asp:SqlDataSource ID="LineDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
            SelectCommand="SELECT [LineID], [LineName], [OldLineName], [Deleted] FROM [PromotionalLines] WHERE ([Deleted] IS NULL)" OnSelected="LineDataSource_Selected"></asp:SqlDataSource>
        <asp:SqlDataSource ID="EntityTypeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
            SelectCommand="SELECT EntityTypeID, EntityTypeName, Deleted FROM EntityTypes WHERE (Deleted IS NULL)"></asp:SqlDataSource>

        <asp:SqlDataSource ID="dsBricks" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
            SelectCommand="SELECT [AmounBrickID], [AmounBrickName], [RepAreaID] FROM [View_EmployeesBricks] WHERE ([EmployeeID] = @EmployeeID) ORDER BY [AmounBrickName]">
            <SelectParameters>
                <asp:SessionParameter Name="EmployeeID" SessionField="EmployeeID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="dsSpecs" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
            SelectCommand="SELECT SpecialtyID, SpecialityCode, LineID FROM View_SpecValByLine WHERE LineID = @LineID AND SpecValue > 0 order by SpecValue DESC, SpecialityCode ASC">
            <SelectParameters>
                <asp:SessionParameter Name="LineID" SessionField="LineID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="dsAffsOut" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
            SelectCommand="SELECT Distinct AffiliationID, AffiliationName2, PhysicianClass, SpecialtyID FROM View_Affiliations_Scheduler WHERE (BrickID = @BrickID) AND (PhysicianClass IN (@PhysicianClass)) AND (SpecialtyID = @SpecialtyID) ORDER BY AffiliationName2 Desc">
            <SelectParameters>
                <asp:ControlParameter Name="BrickID" ControlID="cbBricks" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter Name="PhysicianClass" ControlID="cbClass" PropertyName="SelectedValue" Type="String" />
                <asp:ControlParameter Name="SpecialtyID" ControlID="cbSpec" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SpecialityDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
            SelectCommand="SELECT DISTINCT BrandPriorityBySpecLine.SpecialtyID, Specialities.Specialitycode FROM BrandPriorityBySpecLine INNER JOIN Specialities ON BrandPriorityBySpecLine.SpecialtyID = Specialities.SpecialityID"></asp:SqlDataSource>
        <asp:SqlDataSource ID="WTDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT [RangeName], [RangeValue] FROM [WaitingTime]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="AffDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT [AffiliationID], [AffiliationName] FROM [View_Affiliations_Admin] WHERE (([EmployeeID] = @EmployeeID) AND ([SpecialtyValue] &gt; @SpecialtyValue)) ORDER BY [AffiliationName]">
            <SelectParameters>
                <asp:SessionParameter Name="EmployeeID" SessionField="EmployeeID" Type="Int32" />
                <asp:Parameter DefaultValue="0" Name="SpecialtyValue" Type="Double" />
            </SelectParameters>

        </asp:SqlDataSource>
        <asp:SqlDataSource ID="AffPropDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT distinct Affiliations_Proposed.AffiliationName, Affiliations_Proposed.SpecialityID, Affiliations_Proposed.LineID, Affiliations_Proposed.RequestType, Affiliations_Proposed.RepName FROM Affiliations_Proposed inner JOIN BrandPriorityBySpecLine ON Affiliations_Proposed.SpecialityID =BrandPriorityBySpecLine.SpecialtyID">
            <SelectParameters>
                <asp:SessionParameter Name="EmployeeID" SessionField="EmployeeID" Type="Int32" />
                <asp:Parameter DefaultValue="0" Name="SpecialtyValue" Type="Double" />
            </SelectParameters>

        </asp:SqlDataSource>
        <br />
    </div>

</asp:Content>

