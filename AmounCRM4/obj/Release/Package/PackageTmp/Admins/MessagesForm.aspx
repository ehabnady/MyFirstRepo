<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="MessagesForm.aspx.cs" Inherits="AmounCRM4.Admins.MessagesForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <script language="javascript" type="text/javascript">
        function deleteResponsibilities() {
            if (confirm("This action will delete all responsibilities")) {
                document.getElementById('<%= hidDelConf.ClientID %>').value = "1";
            }
            else {
                document.getElementById('<%= hidDelConf.ClientID %>').value = "0";
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <asp:Table ID="tblHead" runat="server" BorderWidth="2px" Width="80%" GridLines="Both" HorizontalAlign="Center"
        BackColor="LightBlue">
        <asp:TableRow ID="tr11" runat="server">
            <asp:TableCell ID="td11" runat="server">
                <asp:Label ID="lblSubject" runat="server" Text="Subject"></asp:Label>
            </asp:TableCell>

            <asp:TableCell ID="td22" runat="server">
                <asp:TextBox ID="txtSubject" runat="server" ValidateRequestMode="Enabled" ValidationGroup="MsgValidation" Width="400"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredStartDateValidator" runat="server" ControlToValidate="txtSubject" ErrorMessage="*" ValidationGroup="MsgValidation" CssClass="auto-style4"></asp:RequiredFieldValidator>

            </asp:TableCell>


            <asp:TableCell ID="td55" runat="server">
                <asp:Label ID="lblMsgType" runat="server" Text="Message Type"></asp:Label>
            </asp:TableCell>
            <asp:TableCell ID="td66" runat="server">
                <asp:DropDownList ID="ddlMsgType" runat="server" DataSourceID="MsgTypeDataSource" DataTextField="CRM_MessageTypeName" DataValueField="CRM_MessageTypeID" AutoPostBack="true" OnSelectedIndexChanged="ddlMsgType_onSelectedIndexChanged" ValidateRequestMode="Enabled" ValidationGroup="MsgValidation"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlMsgType" ErrorMessage="*" ValidationGroup="MsgValidation" CssClass="auto-style4"></asp:RequiredFieldValidator>

            </asp:TableCell>
        </asp:TableRow>

        <asp:TableRow ID="tr22" runat="server">
            <asp:TableCell ID="td33" runat="server">
                <asp:Label ID="lblMsgDescription" runat="server" Text="Message"></asp:Label>

            </asp:TableCell>
            <asp:TableCell ID="td44" runat="server">
                <asp:TextBox ID="txtMsgDescription" runat="server" ValidateRequestMode="Enabled" ValidationGroup="MsgValidation" Wrap="true" TextMode="MultiLine" Width="400"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtMsgDescription" ErrorMessage="*" ValidationGroup="MsgValidation" CssClass="auto-style4"></asp:RequiredFieldValidator>

            </asp:TableCell>
            <asp:TableCell ID="td102" runat="server">
                <asp:Label ID="lblLine" runat="server" Text="Line"></asp:Label>
            </asp:TableCell>
            <asp:TableCell ID="td103" runat="server">
                <asp:DropDownList ID="ddlLine" runat="server"  OnSelectedIndexChanged="ddlLine_onSelectedIndexChanged" AutoPostBack="true">
                    <asp:ListItem Text="Select Line" Value="14" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="Line 1" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Line 2" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Line 3" Value="3"></asp:ListItem>
                    <asp:ListItem Text="Line 4" Value="4"></asp:ListItem>
                    <asp:ListItem Text="Line 5" Value="5"></asp:ListItem>
                    <asp:ListItem Text="Line 6" Value="6"></asp:ListItem>
                    <asp:ListItem Text="Line 7" Value="7"></asp:ListItem>

                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlLine" ErrorMessage="*" ValidationGroup="MsgValidation" CssClass="auto-style4"></asp:RequiredFieldValidator>

            </asp:TableCell>

        </asp:TableRow>
        <asp:TableRow ID="tr33" runat="server">
            <asp:TableCell ID="td77" runat="server">
                <asp:Label ID="lblStartDate" runat="server" Text="Start Date"></asp:Label>
            </asp:TableCell>
            <asp:TableCell ID="td88" runat="server">
                <telerik:RadDatePicker ID="dpStartDate" runat="server" ValidateRequestMode="Enabled" 
                    ValidationGroup="MsgValidation" Skin="WebBlue">
                    <Calendar runat="server" FirstDayOfWeek="Saturday" Skin="WebBlue"></Calendar>
                </telerik:RadDatePicker>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="dpStartDate" ErrorMessage="*" ValidationGroup="MsgValidation" CssClass="auto-style4"></asp:RequiredFieldValidator>

            </asp:TableCell>
            <asp:TableCell ID="td99" runat="server">
                <asp:Label ID="lblEndDate" runat="server" Text="End Date"></asp:Label>
            </asp:TableCell>
            <asp:TableCell ID="td101" runat="server">
                <telerik:RadDatePicker ID="dpEndDate" runat="server" ValidateRequestMode="Enabled" 
                    ValidationGroup="MsgValidation" Skin="WebBlue">
                    <Calendar runat="server" FirstDayOfWeek="Saturday" Skin="WebBlue"></Calendar>
                </telerik:RadDatePicker>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="dpEndDate" ErrorMessage="*" ValidationGroup="MsgValidation" CssClass="auto-style4"></asp:RequiredFieldValidator>

            </asp:TableCell>
        </asp:TableRow>

    </asp:Table>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>

    <asp:Table ID="tblDetail" runat="server" BorderWidth="2px" Width="80%" GridLines="Both" HorizontalAlign="Center"
        BackColor="LightBlue">
        <asp:TableRow ID="tr1" runat="server">
            <asp:TableCell ID="td1" runat="server" HorizontalAlign="Left" ColumnSpan="4">
                <asp:Label ID="lblSM" runat="server" Text="Sales Managers"></asp:Label>
                <br />
                <asp:Button ID="btnGetDM" runat="server" OnClick="btnGetDM_Click" Text="Get DMs" />
                <br />
                <asp:CheckBox ID="cbAllSMs" runat="server" OnCheckedChanged="chkAllSMs_CheckedChanged" Text="Select All SMs" TextAlign="Right"
                    AutoPostBack="true" />
            </asp:TableCell>

            <asp:TableCell ID="td2" runat="server" HorizontalAlign="Left" ColumnSpan="4">
                <asp:CheckBoxList ID="cblManagers" runat="server" DataSourceID="dsManagers"
                    DataTextField="EmployeeFullName" DataValueField="EmployeeID"
                    RepeatDirection="Horizontal" RepeatColumns="6">
                </asp:CheckBoxList>
            </asp:TableCell>
        </asp:TableRow>


        <asp:TableRow ID="tr2" runat="server">
            <asp:TableCell ID="td3" runat="server" HorizontalAlign="Left" ColumnSpan="4">
                <asp:Label ID="lblDM" runat="server" Text="District Managers"></asp:Label>
                <br />
                <asp:Button ID="btnGetReps" runat="server" OnClick="btnGetReps_Click" Text="Get Reps" />
                <br />
                <asp:CheckBox ID="cbAllDMs" runat="server" OnCheckedChanged="chkAllDMs_CheckedChanged" Text="Select All DMs" TextAlign="Right"
                    AutoPostBack="true" />
            </asp:TableCell>
            <asp:TableCell ID="td4" runat="server" HorizontalAlign="Left" ColumnSpan="4">
                <asp:CheckBoxList ID="cblDMs" runat="server"
                    RepeatDirection="Horizontal" RepeatColumns="6">
                </asp:CheckBoxList>
            </asp:TableCell>
        </asp:TableRow>

        <asp:TableRow ID="tr3" runat="server">
            <asp:TableCell ID="td5" runat="server" HorizontalAlign="Left" ColumnSpan="4">
                <asp:Label ID="lblREP" runat="server" Text="Sales Reps"></asp:Label>
                <br />
                <asp:CheckBox ID="cbAllReps" runat="server" OnCheckedChanged="chkAllReps_CheckedChanged" Text="Select All Reps" TextAlign="Right"
                    AutoPostBack="true" />
            </asp:TableCell>
            <asp:TableCell ID="td6" runat="server" HorizontalAlign="Left" ColumnSpan="4">
                <asp:CheckBoxList ID="cblReps" runat="server"
                    RepeatDirection="Horizontal" RepeatColumns="6">
                </asp:CheckBoxList>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableFooterRow ID="tf" runat="server" BorderStyle="None">
            <asp:TableCell ID="td7" runat="server" BorderStyle="None">
                <asp:Button ID="btnSave" runat="server" Text="Send" OnClick="btnSave_Click" ValidationGroup="MsgValidation" ValidateRequestMode="Enabled" />

            </asp:TableCell>
            <asp:TableCell ID="td8" runat="server" BorderStyle="None">
                <asp:Label ID="lblMsgMessage" runat="server" Text=""></asp:Label>
            </asp:TableCell>
        </asp:TableFooterRow>
    </asp:Table>

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function pageLoad() {

            }
        </script>
    </telerik:RadCodeBlock>

    <asp:SqlDataSource ID="MsgTypeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT [CRM_MessageTypeID], [CRM_MessageTypeName] FROM [CRM_MessageTypes] WHERE ([Deleted] IS NULL or [Deleted]=0 )"></asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="dsViewEmpsBricks"
        ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
        SelectCommand="SELECT LineID AS Line, TopManagerName AS [SalesManager], DirectManagerName AS Supervisor, EmployeeHRCode AS [HRCode], EmployeeFullName AS [RepName], RepAreaName AS Area, AmounBrickID AS [BrickID], AmounBrickName AS [BrickName] FROM View_EmployeesBricks WHERE (EmployeeType = 'Rep') ORDER BY Line, [SalesManager], Supervisor, [HRCode], Area, [BrickName]"></asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="dsToBeApplied"
        ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
        SelectCommand="SELECT LineID AS Line, TopManagerName AS [SalesManager], DirectManagerName AS Supervisor, EmployeeHRCode AS [HRCode], EmployeeFullName AS [RepName], RepAreaName AS Area, AmounBrickID AS [BrickID], AmounBrickName AS [BrickName], Deleted FROM View_EmployeesBricks2 WHERE (EmployeeType = 'Rep' AND ToBeApplied = 1) ORDER BY Line, [SalesManager], Supervisor, [HRCode], Area, [BrickName]"></asp:SqlDataSource>

    <input type="hidden" id="hidDelConf" runat="server" value="" />

    <asp:SqlDataSource runat="server" ID="dsManagers"
        ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
        SelectCommand="SELECT EmployeeID, EmployeeFullName FROM View_Employees WHERE (EmployeeType = 'Sales Manager') ">
        
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="dsDMs"
        ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
        SelectCommand="SELECT DISTINCT DirectManagerID AS EmployeeID, DirectManagerName AS EmployeeFullName FROM View_Employees WHERE (EmployeeType = 'Rep') "></asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="dsReps"
        ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
        SelectCommand="SELECT Distinct EmployeeID, EmployeeFullName FROM View_Employees WHERE (EmployeeType = 'Rep') AND (DirectManagerID = @DirectManagerID2) AND (DeletedEmployee IS NULL OR DeletedEmployee = 0) Order By EmployeeFullName">
        <SelectParameters>
            <asp:ControlParameter ControlID="cblDMs" PropertyName="SelectedValue" Type="Int32" Name="DirectManagerID2" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT * FROM [View_Employees] WHERE ([LineID] = @LineID)">
        <SelectParameters>
            <asp:FormParameter FormField="ddlLine" Name="LineID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="dsAreas"
        ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
        SelectCommand="SELECT DISTINCT RepAreaID, RepAreaName FROM View_EmployeesBricks WHERE (DirectManagerID = @DirectManagerID3) Order By RepAreaName">
        <SelectParameters>
            <asp:ControlParameter ControlID="cblDMs" PropertyName="SelectedValue" Type="Int32" Name="DirectManagerID3" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="dsSave" runat="server"
        ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
        DeleteCommand="UPDATE [EmployeesBricks2] SET [Deleted] = 1, [ToBeApplied] = 1 WHERE [EmployeeID] >= @EmployeeID"
        InsertCommand="INSERT INTO [EmployeesBricks2] ([EmployeeID], [BrickID], [Deleted], [ToBeApplied]) VALUES (@EmployeeID, @BrickID, @Deleted, 1)"
        SelectCommand="SELECT [RecID], [EmployeeID], [BrickID], [Deleted] FROM [EmployeesBricks]"
        UpdateCommand="UPDATE [EmployeesBricks2] SET [EmployeeID] = @EmployeeID, [BrickID] = @BrickID, [Deleted] = @Deleted, [ToBeApplied] = 1 WHERE [RecID] = @RecID">
        <DeleteParameters>
            <asp:Parameter Name="EmployeeID" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="EmployeeID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="BrickID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="Deleted" Type="Boolean"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="EmployeeID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="BrickID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="Deleted" Type="Boolean"></asp:Parameter>
            <asp:Parameter Name="RecID" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="dsRollBack" runat="server" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
        DeleteCommand="Delete From [EmployeesBricks2] Where Brick"></asp:SqlDataSource>
</asp:Content>
