<%@ Page Title="Reps Responsibilities" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Responsibilities.aspx.cs" Inherits="AmounCRM4.Admins.Responsibilities" %>

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
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>

    <asp:Table ID="tblFrame" runat="server" BorderWidth="2px" Width="60%" GridLines="Both" HorizontalAlign="Center"
        BackColor="LightBlue">
        <asp:TableRow ID="tr1" runat="server">
            <asp:TableCell ID="td1" runat="server" HorizontalAlign="Left">
                <asp:Label ID="lbl1" runat="server" Text="Sales Managers"></asp:Label>
            </asp:TableCell>

            <asp:TableCell ID="td2" runat="server" HorizontalAlign="Left">
                <asp:DropDownList ID="ddlManagers" runat="server" DataSourceID="dsManagers"
                    DataTextField="EmployeeFullName" DataValueField="EmployeeID"
                    AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="ddlManagers_SelectedIndexChanged">
                    <asp:ListItem Text="Sales Manager" Selected="True" Value="0" />
                </asp:DropDownList>
            </asp:TableCell>

            <asp:TableCell ID="td3" runat="server" HorizontalAlign="Left">
                <asp:Label ID="lbl2" runat="server" Text="District Managers"></asp:Label>
            </asp:TableCell>

            <asp:TableCell ID="td4" runat="server" HorizontalAlign="Left">
                <asp:DropDownList ID="ddlDMs" runat="server" DataSourceID="dsDMs"
                    DataTextField="EmployeeFullName" DataValueField="EmployeeID"
                    OnSelectedIndexChanged="ddlDMs_SelectedIndexChanged"
                    AppendDataBoundItems="true" AutoPostBack="true">
                    <asp:ListItem Text="District Manager" Selected="True" Value="0" />
                </asp:DropDownList>
            </asp:TableCell>
        </asp:TableRow>

        <asp:TableRow ID="tr2" runat="server">
            <asp:TableCell ID="td5" runat="server" HorizontalAlign="Left">
                <asp:Label ID="lbl3" runat="server" Text="Sales Reps"></asp:Label>
            </asp:TableCell>

            <asp:TableCell ID="td6" runat="server" HorizontalAlign="Left">
                <asp:DropDownList ID="ddlReps" runat="server" DataSourceID="dsReps"
                    DataTextField="EmployeeFullName" DataValueField="EmployeeID"
                    AppendDataBoundItems="true">
                    <asp:ListItem Text="Sales Reps" Selected="True" Value="0" />
                </asp:DropDownList>
            </asp:TableCell>

            <asp:TableCell ID="td7" runat="server" HorizontalAlign="Left">
                <asp:Label ID="lbl4" runat="server" Text="Areas"></asp:Label>
            </asp:TableCell>

            <asp:TableCell ID="td8" runat="server" HorizontalAlign="Left">
                <asp:CheckBoxList ID="chklAreas" runat="server" DataSourceID="dsAreas" DataTextField="RepAreaName"
                    DataValueField="RepAreaID" RepeatDirection="Horizontal" RepeatColumns="4">
                </asp:CheckBoxList>
                <br />
                <asp:Button ID="btnGetBricks" runat="server" OnClick="btnGetBricks_Click" Text="Get Bricks" />
            </asp:TableCell>
        </asp:TableRow>

        <asp:TableRow ID="tr3" runat="server">
            <asp:TableCell ID="td9" runat="server" ColumnSpan="4" HorizontalAlign="Left">
                <asp:Label ID="lbl5" runat="server" Text="Bricks of Selected Areas:"></asp:Label>
                <br />
                <asp:CheckBox ID="chkAll" runat="server" OnCheckedChanged="chkAll_CheckedChanged" Text="Select All Bricks" TextAlign="Right" 
                    AutoPostBack="true" />
                <br />
            </asp:TableCell>
        </asp:TableRow>

        <asp:TableRow ID="tr4" runat="server">
            <asp:TableCell ID="td10" runat="server" HorizontalAlign="Left" ColumnSpan="4">
                <asp:CheckBoxList ID="chklBricks" runat="server" RepeatDirection="Horizontal" RepeatColumns="4">
                </asp:CheckBoxList>
            </asp:TableCell>
        </asp:TableRow>

        <asp:TableRow ID="tr5" runat="server">
            <asp:TableCell ID="td11" runat="server" ColumnSpan="4" HorizontalAlign="Left">
                <br />
                <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Save All Responsibilities" />
                <asp:Button ID="btnDelete" runat="server" OnClick="btnDelete_Click" Text="Delete Selected Responsibilities"
                    OnClientClick="deleteResponsibilities(this);" />
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>

    <p><br /></p>

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function pageLoad()
            {
                var grid = $find("<%= gvAllResponsbilities.ClientID %>");
                var columns = grid.get_masterTableView().get_columns();
                for (var i = 0; i < columns.length; i++)
                {
                    columns[i].resizeToFit(false, true);
                }
            }
        </script>
    </telerik:RadCodeBlock>

    <telerik:RadGrid ID="gvAllResponsbilities" runat="server" Skin="WebBlue" DataSourceID="dsViewEmpsBricks" AllowPaging="True" AllowFilteringByColumn="True" 
        AllowSorting="True" ShowGroupPanel="True" Width="90%" HorizontalAlign="Center" RenderMode="Lightweight" GroupPanelPosition="Top">
        <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>

        <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="Responsibilities">
            <Excel Format="Xlsx" />
        </ExportSettings>

        <ClientSettings AllowDragToGroup="True" AllowColumnHide="true" AllowExpandCollapse="true" AllowGroupExpandCollapse="true"
            AllowColumnsReorder="true">
            <Scrolling AllowScroll="True" UseStaticHeaders="True" />
            <Resizing AllowColumnResize="true" AllowResizeToFit="true" AllowRowResize="true" EnableRealTimeResize="false" ResizeGridOnColumnResize="false" />
        </ClientSettings>

        <MasterTableView DataSourceID="dsViewEmpsBricks" AutoGenerateColumns="False" ShowHeader="true" ShowFooter="true"
            EnableHeaderContextFilterMenu="true" EnableHeaderContextMenu="true" EnableHeaderContextAggregatesMenu="true" AllowFilteringByColumn="true" AllowPaging="true"
            AllowSorting="true" GridLines="Both" EnableGroupsExpandAll="true" TableLayout="Auto" CommandItemDisplay="Top">
            <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
            <CommandItemSettings RefreshText="Refresh" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="false" />
            <Columns>
                <telerik:GridBoundColumn DataField="Line" HeaderText="Line" SortExpression="Line" UniqueName="Line" DataType="System.Int32" FilterControlAltText="Filter Line column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SalesManager" HeaderText="Sales Manager" SortExpression="SalesManager" UniqueName="SalesManager" FilterControlAltText="Filter Sales Manager column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Supervisor" HeaderText="Supervisor" SortExpression="Supervisor" UniqueName="Supervisor" FilterControlAltText="Filter Supervisor column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="HRCode" HeaderText="HR Code" SortExpression="HRCode" UniqueName="HRCode" DataType="System.Int32" FilterControlAltText="Filter HR Code column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="RepName" HeaderText="Rep Name" SortExpression="RepName" UniqueName="RepName" FilterControlAltText="Filter Rep Name column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Area" HeaderText="Area" SortExpression="Area" UniqueName="Area" FilterControlAltText="Filter Area column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="BrickID" HeaderText="Brick ID" SortExpression="BrickID" UniqueName="BrickID" DataType="System.Int32" FilterControlAltText="Filter Brick ID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="BrickName" HeaderText="Brick Name" SortExpression="BrickName" UniqueName="BrickName" FilterControlAltText="Filter Brick Name column"></telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>

    <asp:SqlDataSource runat="server" ID="dsViewEmpsBricks" 
        ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
        SelectCommand="SELECT LineID AS Line, TopManagerName AS [SalesManager], DirectManagerName AS Supervisor, EmployeeHRCode AS [HRCode], EmployeeFullName AS [RepName], RepAreaName AS Area, AmounBrickID AS [BrickID], AmounBrickName AS [BrickName] FROM View_EmployeesBricks WHERE (EmployeeType = 'Rep') ORDER BY Line, [SalesManager], Supervisor, [HRCode], Area, [BrickName]"></asp:SqlDataSource>
    

    <br /><br /><br />










    <telerik:RadGrid ID="grdToBeApplied" runat="server" Skin="WebBlue" DataSourceID="dsToBeApplied" AllowPaging="True" AllowFilteringByColumn="True" 
        AllowSorting="True" ShowGroupPanel="True" Width="90%" HorizontalAlign="Center" RenderMode="Lightweight" GroupPanelPosition="Top">
        <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>

        <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="Responsibilities To Be Applied">
            <Excel Format="Xlsx" />
        </ExportSettings>

        <ClientSettings AllowDragToGroup="True" AllowColumnHide="true" AllowExpandCollapse="true" AllowGroupExpandCollapse="true"
            AllowColumnsReorder="true">
            <Scrolling AllowScroll="True" UseStaticHeaders="True" />
            <Resizing AllowColumnResize="true" AllowResizeToFit="true" AllowRowResize="true" EnableRealTimeResize="false" ResizeGridOnColumnResize="false" />
        </ClientSettings>

        <MasterTableView DataSourceID="dsToBeApplied" AutoGenerateColumns="False" ShowHeader="true" ShowFooter="true"
            EnableHeaderContextFilterMenu="true" EnableHeaderContextMenu="true" EnableHeaderContextAggregatesMenu="true" AllowFilteringByColumn="true" AllowPaging="true"
            AllowSorting="true" GridLines="Both" EnableGroupsExpandAll="true" TableLayout="Auto" CommandItemDisplay="Top">
            <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />
            <CommandItemSettings RefreshText="Refresh" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="false" />
            <Columns>
                <telerik:GridBoundColumn DataField="Line" HeaderText="Line" SortExpression="Line" UniqueName="Line" DataType="System.Int32" FilterControlAltText="Filter Line column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SalesManager" HeaderText="Sales Manager" SortExpression="SalesManager" UniqueName="SalesManager" FilterControlAltText="Filter Sales Manager column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Supervisor" HeaderText="Supervisor" SortExpression="Supervisor" UniqueName="Supervisor" FilterControlAltText="Filter Supervisor column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="HRCode" HeaderText="HR Code" SortExpression="HRCode" UniqueName="HRCode" DataType="System.Int32" FilterControlAltText="Filter HR Code column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="RepName" HeaderText="Rep Name" SortExpression="RepName" UniqueName="RepName" FilterControlAltText="Filter Rep Name column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Area" HeaderText="Area" SortExpression="Area" UniqueName="Area" FilterControlAltText="Filter Area column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="BrickID" HeaderText="Brick ID" SortExpression="BrickID" UniqueName="BrickID" DataType="System.Int32" FilterControlAltText="Filter Brick ID column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="BrickName" HeaderText="Brick Name" SortExpression="BrickName" UniqueName="BrickName" FilterControlAltText="Filter Brick Name column"></telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Deleted" HeaderText="Deleted" SortExpression="Deleted" UniqueName="Deleted" FilterControlAltText="Filter Deleted Name column"></telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>

    <asp:SqlDataSource runat="server" ID="dsToBeApplied" 
        ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
        SelectCommand="SELECT LineID AS Line, TopManagerName AS [SalesManager], DirectManagerName AS Supervisor, EmployeeHRCode AS [HRCode], EmployeeFullName AS [RepName], RepAreaName AS Area, AmounBrickID AS [BrickID], AmounBrickName AS [BrickName], Deleted FROM View_EmployeesBricks2 WHERE (EmployeeType = 'Rep' AND ToBeApplied = 1) ORDER BY Line, [SalesManager], Supervisor, [HRCode], Area, [BrickName]"></asp:SqlDataSource>
    




    <input type="hidden" id="hidDelConf" runat="server" value="" />

    <asp:SqlDataSource runat="server" ID="dsManagers"
        ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
        SelectCommand="SELECT EmployeeID, EmployeeFullName FROM View_Employees WHERE (EmployeeType = 'Sales Manager')"></asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="dsDMs"
        ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
        SelectCommand="SELECT DISTINCT DirectManagerID AS EmployeeID, DirectManagerName AS EmployeeFullName FROM View_Employees WHERE (EmployeeType = 'Rep') AND (TopManagerID = @DirectManagerID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlManagers" PropertyName="SelectedValue" Type="Int32" Name="DirectManagerID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="dsReps"
        ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
        SelectCommand="SELECT Distinct EmployeeID, EmployeeFullName FROM View_Employees WHERE (EmployeeType = 'Rep') AND (DirectManagerID = @DirectManagerID2) AND (DeletedEmployee IS NULL OR DeletedEmployee = 0) Order By EmployeeFullName">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlDMs" PropertyName="SelectedValue" Type="Int32" Name="DirectManagerID2" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="dsAreas"
        ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
        SelectCommand="SELECT DISTINCT RepAreaID, RepAreaName FROM View_EmployeesBricks WHERE (DirectManagerID = @DirectManagerID3) Order By RepAreaName">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlDMs" PropertyName="SelectedValue" Type="Int32" Name="DirectManagerID3" />
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
