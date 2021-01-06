<%@ Page Title="Cycle-Level Parameters" Language="C#" MasterPageFile="~/CommercialDirector/SiteMaster2.Master" AutoEventWireup="true" 
    CodeBehind="DetailingPriority.aspx.cs" Inherits="AmounCRM4.CommercialDirector.DetailingPriority" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <title>Detailing Priority & Specialty Weight By Line</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">

    <table style="margin-left:40px"><tr><td>

    <asp:Label ID="lblTitle1" runat="server" Text="Current Detailing Priority"></asp:Label>
    <br /><br />
    <telerik:RadGrid ID="grdDetailing" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True" ShowGroupPanel="True" Skin="WebBlue" EnableHeaderContextAggregatesMenu="True" 
        EnableHeaderContextFilterMenu="True" EnableHeaderContextMenu="True" ShowFooter="True" DataSourceID="dsDetailing" CellSpacing="-1" GridLines="Both" Width="95%" HorizontalAlign="Center">

        <ClientSettings AllowDragToGroup="True" AllowColumnsReorder="True">
            <Selecting AllowRowSelect="True"></Selecting>
            <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
            <Resizing AllowColumnResize="True" AllowRowResize="True" EnableRealTimeResize="True" AllowResizeToFit="True" EnableNextColumnResize="True"></Resizing>
        </ClientSettings>
        <MasterTableView AutoGenerateColumns="False" DataKeyNames="RecID" EnableHeaderContextAggregatesMenu="True" ShowGroupFooter="True" CommandItemDisplay="Top">
            <CommandItemSettings ShowExportToExcelButton="True" ShowRefreshButton="true" ShowAddNewRecordButton="False"></CommandItemSettings>

            <Columns>
                <telerik:GridBoundColumn DataField="RecID" ReadOnly="True" HeaderText="Rec ID" SortExpression="RecID" UniqueName="RecID" DataType="System.Int32" FilterControlAltText="Filter RecID column">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="LineName" HeaderText="Line" SortExpression="LineName" UniqueName="LineName" FilterControlAltText="Filter LineName column">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SpecialityCode" HeaderText="Specialty" SortExpression="SpecialityCode" UniqueName="SpecialityCode" FilterControlAltText="Filter SpecialityCode column">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="BrandName" HeaderText="Brand" SortExpression="BrandName" UniqueName="BrandName" FilterControlAltText="Filter BrandName column">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="BrandPriority" HeaderText="Priority" SortExpression="BrandPriority" UniqueName="BrandPriority" DataType="System.Int32" FilterControlAltText="Filter BrandPriority column">
                </telerik:GridBoundColumn>
            </Columns>
            <PagerStyle PageSizes="20;30;50"></PagerStyle>
        </MasterTableView>
        <PagerStyle PageSizes="20;30;50"></PagerStyle>
    </telerik:RadGrid>
    <asp:SqlDataSource runat="server" ID="dsDetailing" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
        SelectCommand="SELECT [RecID], [LineName], [SpecialityCode], [BrandName], [BrandPriority] FROM [View_BrandPriorityBySpecLine]"></asp:SqlDataSource>

    <br /><br />

        <asp:Label ID="lblTitle2" runat="server" Text="Add / Modify Detailing"></asp:Label>
    <br /><br />

    <div>
        <table ID="tblTempEdit" runat="server">
            <tr>
                <td>Record No.: </td>
                <td><asp:label ID="lblRecID_Det" runat="server" Text=""></asp:label></td>
            </tr>

            <tr>
                <td>Line: </td>
                <td><asp:DropDownList ID="ddlLine_Det" runat="server" DataSourceID="dsLines" DataTextField="LineName" DataValueField="LineID" AppendDataBoundItems="true">
                    <asp:ListItem Selected="True" Text="Select" Value="0"></asp:ListItem>
                    </asp:DropDownList></td>
            </tr>

            <tr>
                <td>Brands: </td>
                <td><asp:DropDownList ID="ddlBrands_Det" runat="server" DataSourceID="dsBrands" DataTextField="BrandName" DataValueField="BrandID" AppendDataBoundItems="true">
                    <asp:ListItem Selected="True" Text="Select" Value="0"></asp:ListItem>
                    </asp:DropDownList></td>
            </tr>

            <tr>
                <td>Specialties: </td>
                <td><asp:DropDownList ID="ddlSpec_Det" runat="server" DataSourceID="dsSpecialties" DataTextField="SpecialityCode" DataValueField="SpecialityID" AppendDataBoundItems="true">
                    <asp:ListItem Selected="True" Text="Select" Value="0"></asp:ListItem>
                    </asp:DropDownList></td>
            </tr>

            <tr>
                <td>Brand Priority: </td>
                <td>
                    <asp:DropDownList ID="ddlPriority_Det" runat="server">
                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                        <asp:ListItem Text="First" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Second" Value="2"></asp:ListItem>
                        <asp:ListItem Text="Third" Value="3"></asp:ListItem>
                        <asp:ListItem Text="Not Detailable" Value="5"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>

            <tr>
                <td>Deleted: </td>
                <td><asp:CheckBox ID="chkDel_Det" runat="server" Checked="false" /></td>
            </tr>

            <tr>
                <td colspan="2">
                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <asp:Label ID="lblStatus" runat="server" Text="Status: " Font-Italic="true"></asp:Label>
                </td>
            </tr>
        </table>
    </div>

    <br /><br />

    <div>
    <asp:Label ID="lbl" runat="server" Text="Temp Detailing Priority (Not Implemented)"></asp:Label>
    <br /><br />

    <telerik:RadGrid ID="grdDetailingTemp" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True" ShowGroupPanel="True" Skin="WebBlue"
        EnableHeaderContextAggregatesMenu="True" EnableHeaderContextFilterMenu="True" OnItemCommand="grdDetailingTemp_ItemCommand"
        EnableHeaderContextMenu="True" ShowFooter="True" DataSourceID="dsBrandPriorityBySpecLineTemp" CellSpacing="-1" GridLines="Both" Width="95%" HorizontalAlign="Center">

        <ClientSettings AllowDragToGroup="True" AllowColumnsReorder="True" EnablePostBackOnRowClick="true">
            <Selecting AllowRowSelect="True"></Selecting>
            <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
            <Resizing AllowColumnResize="True" AllowRowResize="True" EnableRealTimeResize="True" AllowResizeToFit="True" EnableNextColumnResize="True"></Resizing>
        </ClientSettings>
        <MasterTableView AutoGenerateColumns="False" DataKeyNames="RecID" EnableHeaderContextAggregatesMenu="True" ShowGroupFooter="True" CommandItemDisplay="Top">
            <CommandItemSettings ShowExportToExcelButton="True" ShowRefreshButton="true" ShowAddNewRecordButton="false"></CommandItemSettings>

            <Columns>
                <telerik:GridBoundColumn DataField="RecID" ReadOnly="True" HeaderText="Rec ID" SortExpression="RecID" UniqueName="RecID" DataType="System.Int32" FilterControlAltText="Filter RecID column">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="LineID" HeaderText="Line ID" SortExpression="LineID" UniqueName="LineID" FilterControlAltText="Filter LineID column">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="LineName" HeaderText="Line" SortExpression="LineName" UniqueName="LineName" FilterControlAltText="Filter LineName column">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SpecialtyID" HeaderText="Specialty ID" SortExpression="SpecialtyID" UniqueName="SpecialtyID" FilterControlAltText="Filter SpecialtyID column">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SpecialityCode" HeaderText="Specialty" SortExpression="SpecialityCode" UniqueName="SpecialityCode" FilterControlAltText="Filter SpecialityCode column">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="BrandID" HeaderText="Brand ID" SortExpression="BrandID" UniqueName="BrandID" FilterControlAltText="Filter BrandID column">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="BrandName" HeaderText="Brand" SortExpression="BrandName" UniqueName="BrandName" FilterControlAltText="Filter BrandName column">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="BrandPriority" HeaderText="Priority" SortExpression="BrandPriority" UniqueName="BrandPriority" DataType="System.Int32" FilterControlAltText="Filter BrandPriority column">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Deleted" HeaderText="Is Deleted" SortExpression="Deleted" UniqueName="Deleted" DataType="System.Boolean" FilterControlAltText="Filter Deleted column">
                </telerik:GridBoundColumn>
            </Columns>
            <PagerStyle PageSizes="20;30;50"></PagerStyle>
        </MasterTableView>
        <PagerStyle PageSizes="20;30;50"></PagerStyle>
    </telerik:RadGrid>
    <asp:SqlDataSource runat="server" ID="dsBrandPriorityBySpecLineTemp" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
        SelectCommand="Select RecID, LineID, LineName, BrandID, BrandName, SpecialtyID, SpecialityCode, BrandPriority, Deleted From View_BrandPriorityBySpecLineTemp"></asp:SqlDataSource>

        <p><br /></p>
    </div>

    <asp:SqlDataSource runat="server" ID="dsDetailing2" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
        SelectCommand="SELECT [RecID], [LineID], [BrandID], [SpecialtyID], [BrandPriority], [Deleted] FROM [BrandPriorityBySpecLine]"></asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="dsLines" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
        SelectCommand="SELECT [LineID], [LineName] FROM [PromotionalLines] Where Deleted IS NULL"></asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="dsSpecialties" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
        SelectCommand="SELECT [SpecialityID], [SpecialityCode] FROM [Specialities]"></asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="dsBrands" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
        SelectCommand="SELECT [BrandID], [BrandName] FROM [View_Brands]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsTempSaving" runat="server" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
        SelectCommand="Select RecID, LineID, LineName, BrandID, BrandName, SpecialtyID, SpecialityCode, BrandPriority From View_BrandPriorityBySpecLineTemp"
        InsertCommand="INSERT INTO BrandPriorityBySpecLineTemp (LineID, BrandID, SpecialtyID, BrandPriority) Values (@ddlLine_Det, @ddlBrands_Det, @ddlSpec_Det, @ddlPriority_Det)"
        UpdateCommand="UPDATE BrandPriorityBySpecLineTemp Set LineID = @ddlLine_DetU, BrandID = @ddlBrands_DetU, SpecialtyID = @ddlSpec_DetU, BrandPriority = @ddlPriority_DetU Where RecID = @lblRecID_DetU">
        <InsertParameters>
            <asp:ControlParameter ControlID="ddlLine_Det" DbType="Int32" PropertyName="SelectedValue" Name="ddlLine_Det" />
            <asp:ControlParameter ControlID="ddlBrands_Det" DbType="Int32" PropertyName="SelectedValue" Name="ddlBrands_Det" />
            <asp:ControlParameter ControlID="ddlSpec_Det" DbType="Int32" PropertyName="SelectedValue" Name="ddlSpec_Det" />
            <asp:ControlParameter ControlID="ddlPriority_Det" DbType="Int32" PropertyName="SelectedValue" Name="ddlPriority_Det" />
            <asp:ControlParameter ControlID="chkDel_Det" DbType="Boolean" PropertyName="Text" Name="chkDel_Det" />
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="lblRecID_Det" DbType="Int32" PropertyName="Text" Name="lblRecID_DetU" />
            <asp:ControlParameter ControlID="ddlLine_Det" DbType="Int32" PropertyName="SelectedValue" Name="ddlLine_DetU" />
            <asp:ControlParameter ControlID="ddlBrands_Det" DbType="Int32" PropertyName="SelectedValue" Name="ddlBrands_DetU" />
            <asp:ControlParameter ControlID="ddlSpec_Det" DbType="Int32" PropertyName="SelectedValue" Name="ddlSpec_DetU" />
            <asp:ControlParameter ControlID="ddlPriority_Det" DbType="Int32" PropertyName="SelectedValue" Name="ddlPriority_DetU" />
            <asp:ControlParameter ControlID="chkDel_Det" DbType="Boolean" PropertyName="Text" Name="chkDel_DetU" />
        </UpdateParameters>
    </asp:SqlDataSource>

        </td></tr></table>
</asp:Content>
