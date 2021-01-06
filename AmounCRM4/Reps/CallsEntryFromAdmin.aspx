<%@ Page Title="Sales Calls" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="CallsEntryFromAdmin.aspx.cs" Inherits="AmounCRM4.Reps.CallsEntryFromAdmin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .myTbl
        {
            text-align:left;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">
    </telerik:RadStyleSheetManager>
    
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <br />
    <div align="center" style="background-color: lightblue; text-align:left; padding-left:1.5em;">
        <asp:Table ID="tbl1" runat="server" Width="755px">
            
            <asp:TableRow ID="tr1" runat="server">
                <asp:TableCell ID="td1" runat="server">
                    <asp:Label ID="lblVisitDate" runat="server" Text="Visit Date" EnableViewState="true"></asp:Label>
                </asp:TableCell>
                <asp:TableCell ID="td2" runat="server">
                    <telerik:RadDateTimePicker ID="radDate1" runat="server" Enabled="false"
                        Width="190" OnSelectedDateChanged="radDate1_SelectedDateChanged" EnableViewState="true" ViewStateMode="Enabled"></telerik:RadDateTimePicker>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator0" runat="server"
                        ControlToValidate="radDate1" ErrorMessage="*" InitialValue="Select"></asp:RequiredFieldValidator>
                    <asp:Label ID="lblVisitDateTime" runat="server" Text=""></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="tr2" runat="server">
                <asp:TableCell ID="td3" runat="server">
                    <asp:Label ID="lblVisitType" runat="server" Text="Visit Type"></asp:Label>
                </asp:TableCell>
                <asp:TableCell ID="td4" runat="server">
                    <asp:DropDownList ID="cbVisitType" runat="server" DataSourceID="VisitTypeDS"
                        DataTextField="VisitTypeName" DataValueField="VisitTypeID" EnableViewState="true">
                        <asp:ListItem>Select</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                        ControlToValidate="cbVisitType" ErrorMessage="*" InitialValue="Select"></asp:RequiredFieldValidator>
                    <asp:SqlDataSource ID="VisitTypeDS" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                        SelectCommand="SELECT DISTINCT VisitTypeID, VisitTypeName FROM VisitTypes"></asp:SqlDataSource>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </div>

    <div>
        <h3 align="left" style="padding-left:1.5em; background-color: lightblue;">Participants</h3>
    <asp:GridView ID="gvParticipants" runat="server" ShowFooter="True" AutoGenerateColumns="False"
                CellPadding="4" ForeColor="#333333" GridLines="None" OnRowDeleting="gvParticipants_RowDeleting"
                Width="97%" Style="text-align: left">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:TemplateField HeaderText="Affiliation" HeaderStyle-HorizontalAlign="Left">
                <ItemTemplate>
                    <asp:DropDownList ID="ddlAff" runat="server" DataSourceID="AffDS" Enabled="false"
                        DataTextField="AffiliationName" DataValueField="AffiliationID" Width="215px">
                        <asp:ListItem>Select</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="ddlAff" ErrorMessage="*" InitialValue="Select"></asp:RequiredFieldValidator>
                    <br />
                    <asp:SqlDataSource ID="AffDS" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
                        SelectCommand="SELECT DISTINCT AffiliationID, AffiliationName FROM View_Affiliations WHERE (AreaRecID = @RepAreaIDFromAdmin)">
                        <SelectParameters>
                            <asp:SessionParameter Name="RepAreaIDFromAdmin" SessionField="RepAreaIDFromAdmin" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </ItemTemplate>
                <FooterStyle HorizontalAlign="Left" />
                <FooterTemplate>
                    <asp:Button ID="ButtonAdd" runat="server" Text="Add New Participant" OnClick="ButtonAdd_Click" />
                </FooterTemplate>
            </asp:TemplateField>
            <asp:CommandField ShowDeleteButton="True" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" />
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


    <h3 align="left" style="padding-left:1.5em; background-color: lightblue;">Messages</h3>
    <div>
    <asp:GridView ID="gvMessages" runat="server" ShowFooter="True" AutoGenerateColumns="False"
                CellPadding="4" ForeColor="#333333" GridLines="None" OnRowDeleting="gvMessages_RowDeleting"
                Width="97%" Style="text-align: left" ShowHeader="true">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:TemplateField HeaderText="Product" HeaderStyle-HorizontalAlign="Left">
                <ItemTemplate>
                    <asp:DropDownList ID="ddlProduct" runat="server" DataSourceID="ProductDS" 
                        DataTextField="BrandName" DataValueField="BrandID" Width="215px">
                        <asp:ListItem>Select</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                        ControlToValidate="ddlProduct" ErrorMessage="*" InitialValue="Select"></asp:RequiredFieldValidator>
                    <asp:SqlDataSource ID="ProductDS" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
                        SelectCommand="SELECT DISTINCT BrandID, BrandName FROM Products WHERE (CompanyID = 1) AND (Deleted = 'false') AND (ProductTypeID = 1) AND (LineID = @RepLineIDFromAdmin)">
                        <SelectParameters>
                            <asp:SessionParameter Name="RepLineIDFromAdmin" SessionField="RepLineIDFromAdmin" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </ItemTemplate>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" HorizontalAlign="Left" />
                <FooterTemplate>
                    <asp:Button ID="btnAddMessage" runat="server" Text="Add New Message" OnClick="btnAddMessage_Click" />
                </FooterTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Adoption Ladder Step" HeaderStyle-HorizontalAlign="Left">
                <ItemTemplate>
                    <asp:DropDownList ID="ddlAdoptionLadderStep" runat="server" DataSourceID="AdoptDS" 
                        DataTextField="AdoptionLadderStepName" DataValueField="AdoptionLadderStepID" Width="215px">
                        <asp:ListItem>Select</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                        ControlToValidate="ddlAdoptionLadderStep" ErrorMessage="*" InitialValue="Select"></asp:RequiredFieldValidator>
                    <asp:SqlDataSource ID="AdoptDS" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
                        SelectCommand="SELECT DISTINCT [AdoptionLadderStepID], [AdoptionLadderStepName] FROM [AdoptionLadderSteps]"></asp:SqlDataSource>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ShowDeleteButton="True" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" />
        </Columns>
        
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" HorizontalAlign="Left" />
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


    <h3 align="left" style="padding-left:1.5em; background-color: lightblue;">Closing</h3>
    <div>
    <asp:GridView ID="gvClosing" runat="server" ShowFooter="True" AutoGenerateColumns="False"
                CellPadding="4" ForeColor="#333333" GridLines="None" OnRowDeleting="gvClosing_RowDeleting"
                Width="97%" Style="text-align: left" ShowHeader="true">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:TemplateField HeaderText="Post Call Analysis" HeaderStyle-HorizontalAlign="Left">
                <ItemTemplate>
                    <asp:DropDownList ID="ddlPostCallAnalysis" runat="server" DataSourceID="PostCallAnalysisDS" 
                        DataTextField="PostCallAnalysisName" DataValueField="PostCallAnalysisID" Width="215px">
                        <asp:ListItem>Select</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                        ControlToValidate="ddlPostCallAnalysis" ErrorMessage="*" InitialValue="Select"></asp:RequiredFieldValidator>
                    <asp:SqlDataSource ID="PostCallAnalysisDS" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
                        SelectCommand="SELECT DISTINCT PostCallAnalysisID, PostCallAnalysisName FROM PostCallAnalysis"></asp:SqlDataSource>
                </ItemTemplate>
                <FooterStyle HorizontalAlign="Left" />
                <FooterTemplate>
                    <asp:Button ID="btnAddClosing" runat="server" Text="Add New Closing" OnClick="btnAddClosing_Click" />
                </FooterTemplate>

            </asp:TemplateField>

            <asp:TemplateField HeaderText="Physician Requests" HeaderStyle-HorizontalAlign="Left">
                <ItemTemplate>
                    <asp:DropDownList ID="ddlPhysicianRequest" runat="server" DataSourceID="PhysicianRequestsDS" 
                        DataTextField="RequestName" DataValueField="RequestID" Width="215px">
                        <asp:ListItem>Select</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                        ControlToValidate="ddlPhysicianRequest" ErrorMessage="*" InitialValue="Select"></asp:RequiredFieldValidator>
                    <asp:SqlDataSource ID="PhysicianRequestsDS" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
                        SelectCommand="SELECT DISTINCT [RequestID], [RequestName] FROM [PhysicianRequests]"></asp:SqlDataSource>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Next Call Objective" HeaderStyle-HorizontalAlign="Left">
                <ItemTemplate>
                    <asp:DropDownList ID="ddlNextCallObjective" runat="server" DataSourceID="NextCallObjectiveDS" 
                        DataTextField="NextCallObjName" DataValueField="NextCallObjID" Width="215px">
                        <asp:ListItem>Select</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                        ControlToValidate="ddlNextCallObjective" ErrorMessage="*" InitialValue="Select"></asp:RequiredFieldValidator>
                    <asp:SqlDataSource ID="NextCallObjectiveDS" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
                        SelectCommand="SELECT DISTINCT [NextCallObjID], [NextCallObjName] FROM [NextCallObj]"></asp:SqlDataSource>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Samples" HeaderStyle-HorizontalAlign="Left">
                <ItemTemplate>
                    <asp:DropDownList ID="ddlSample" runat="server" DataSourceID="SamplesDS" 
                        DataTextField="ProductName" DataValueField="ProductID" Width="215px">
                        <asp:ListItem>Select</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
                        ControlToValidate="ddlSample" ErrorMessage="*" InitialValue="Select"></asp:RequiredFieldValidator>
                    <asp:SqlDataSource ID="SamplesDS" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
                        SelectCommand="SELECT DISTINCT ProductID, ProductName FROM Products WHERE (CompanyID = 1) AND (Deleted = 'false') AND (ProductTypeID > 1) AND (LineID = @RepLineIDFromAdmin)">
                        <SelectParameters>
                            <asp:SessionParameter Name="RepLineIDFromAdmin" SessionField="RepLineIDFromAdmin" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </ItemTemplate>
            </asp:TemplateField>


            <asp:CommandField ShowDeleteButton="True" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" />
        </Columns>
        
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" HorizontalAlign="Left" />
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

    <br />
    <p align="left" style="background-color: #CCCCFF">
        <asp:Table ID="tbl2" runat="server" Width="97%">
            <asp:TableRow ID="tbl2tr1" runat="server">
                <asp:TableCell ID="tbl2td1" runat="server" HorizontalAlign="Left">
                    <asp:CheckBox ID="chkCompleted" runat="server" Text="Is Final" BackColor="#CCCCFF" /><br /><br />
                </asp:TableCell>
                <asp:TableCell ID="tbl2td2" runat="server" HorizontalAlign="Right">
                    <asp:CheckBox ID="chkDelete" runat="server" Text="Delete This Visit" BackColor="#CCCCFF" />
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="tbl2tr2" runat="server">
                <asp:TableCell ID="tbl2td3" runat="server" ColumnSpan="2" HorizontalAlign="Center">
                    <telerik:RadButton ID="radSave" runat="server" Text="Save" Skin="WebBlue"
                        OnClick="btnSave_Click" Font-Names="Times New Roman" Font-Size="Medium" 
                        Height="49px" Width="128px" BorderStyle="Outset">
                    </telerik:RadButton>   
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        
        <br />
        <asp:Label ID="lblError" runat="server" Text="No Error"></asp:Label>
        <asp:HiddenField ID="hidVisitID" runat="server" Value="0" />
    </p>
</asp:Content>
