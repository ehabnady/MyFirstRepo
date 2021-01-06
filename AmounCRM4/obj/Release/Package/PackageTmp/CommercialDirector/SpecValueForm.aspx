<%@ Page Title="Cycle-Level Parameters" Language="C#" MasterPageFile="~/CommercialDirector/SiteMaster2.Master" AutoEventWireup="true" 
    CodeBehind="SpecValueForm.aspx.cs" Inherits="AmounCRM4.CommercialDirector.SpecValueForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <title>Detailing Priority & Specialty Weight By Line</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">


    <table style="margin-left:40px"><tr><td>


    <div>
    <asp:Label ID="lbl" runat="server" Text="Temp Specialty Value (Will be implemented last week of every month)"></asp:Label>
    <br /><br />

        <asp:HyperLink ID="hl1" runat="server" NavigateUrl="~/CommercialDirector/DetailingPriority2.aspx" Text="Go to Detailing Priority"></asp:HyperLink>
        <br /><br />

    <telerik:RadGrid ID="grdDetailingTemp" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True" ShowGroupPanel="True" Skin="WebBlue"
        EnableHeaderContextAggregatesMenu="True" EnableHeaderContextFilterMenu="True" 
        EnableHeaderContextMenu="True" ShowFooter="True" DataSourceID="dsTempSaving" CellSpacing="-1" GridLines="Both" Width="95%" HorizontalAlign="Center"
        AutoGenerateEditColumn="true" 
        OnItemDataBound="grdDetailingTemp_ItemDataBound" OnItemCommand="grdDetailingTemp_ItemCommand"
        OnInsertCommand="grdDetailingTemp_InsertCommand" OnEditCommand="grdDetailingTemp_EditCommand"
        OnUpdateCommand="grdDetailingTemp_UpdateCommand" PageSize="400"
        >

        <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="SpecialtyValue">
            <Excel Format="Xlsx" />
        </ExportSettings>

        <ClientSettings AllowDragToGroup="True" AllowColumnsReorder="True" EnablePostBackOnRowClick="true">
            <Selecting AllowRowSelect="True"></Selecting>
            <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
            <Resizing AllowColumnResize="True" AllowRowResize="True" EnableRealTimeResize="True" AllowResizeToFit="True" EnableNextColumnResize="True"></Resizing>
        </ClientSettings>

        <MasterTableView AutoGenerateColumns="False" DataKeyNames="RecID" EnableHeaderContextAggregatesMenu="True" ShowGroupFooter="True" CommandItemDisplay="Top">
            <CommandItemSettings ShowExportToExcelButton="True" ShowRefreshButton="true" ShowAddNewRecordButton="true" AddNewRecordText="New"></CommandItemSettings>
            <PagerStyle AlwaysVisible="True" PageSizes="100;200;300;400;500" Mode="NextPrevAndNumeric" />

            <Columns>
                <telerik:GridTemplateColumn ReadOnly="True" HeaderText="Rec ID" SortExpression="RecID" UniqueName="RecID" DataType="System.Int32" DataField="RecID"
                    Groupable="true" GroupByExpression="RecID Group By RecID" ColumnGroupName="RecID">
                    <HeaderStyle Width="250px" />
                    <ItemTemplate>
                        <asp:Label ID="lblRecID" runat="server" Text='<%# Eval("RecID") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="lblRecID_E" runat="server" Text='<%# Eval("RecID") %>'></asp:Label>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:Label ID="lblRecID_I" runat="server" Text="" Visible="false"></asp:Label>
                    </InsertItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Line Name" SortExpression="LineName" UniqueName="LineName" FilterControlAltText="Filter LineName column" 
                    DataField="LineName" Groupable="true" GroupByExpression="LineName Group By LineName" ColumnGroupName="LineName">
                    <HeaderStyle Width="250px" />
                    <ItemTemplate>
                        <asp:Label ID="lblLineName" runat="server" Text='<%# Eval("LineName") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadDropDownList ID="ddlLineName_E" runat="server" DataSourceID="dsLines" DataTextField="LineName" DataValueField="LineID" AppendDataBoundItems="true" SelectedValue='<%# Eval("LineID") %>' Enabled="false">
                            <Items>
                                <telerik:DropDownListItem Text="Select" Value="0" />
                            </Items>
                        </telerik:RadDropDownList>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <telerik:RadDropDownList ID="ddlLineName_I" runat="server" DataSourceID="dsLines" DataTextField="LineName" DataValueField="LineID" AppendDataBoundItems="true" SelectedValue='<%# Eval("LineID") %>'>
                            <Items>
                                <telerik:DropDownListItem Text="Select" Value="0" />
                            </Items>
                        </telerik:RadDropDownList>
                    </InsertItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Specialty" SortExpression="SpecialityCode" UniqueName="SpecialityCode" DataType="System.String" DataField="SpecialityCode"
                     Groupable="true" GroupByExpression="SpecialityCode Group By SpecialityCode" ColumnGroupName="SpecialityCode">
                    <HeaderStyle Width="250px" />
                    <ItemTemplate>
                        <asp:Label ID="lblSpecialityCode" runat="server" Text='<%# Eval("SpecialityCode") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadDropDownList ID="ddlSpecialityCode_E" runat="server" DataSourceID="dsSpecialties" DataTextField="SpecialityCode" DataValueField="SpecialityID" AppendDataBoundItems="true" SelectedValue='<%# Eval("SpecialtyID") %>' Enabled="false">
                            <Items>
                                <telerik:DropDownListItem Text="Select" Value="0" />
                            </Items>
                        </telerik:RadDropDownList>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <telerik:RadDropDownList ID="ddlSpecialityCode_I" runat="server" DataSourceID="dsSpecialties" DataTextField="SpecialityCode" DataValueField="SpecialityID" AppendDataBoundItems="true" SelectedValue='<%# Eval("SpecialtyID") %>'>
                            <Items>
                                <telerik:DropDownListItem Text="Select" Value="0" />
                            </Items>
                        </telerik:RadDropDownList>
                    </InsertItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Value" SortExpression="SpecValue" UniqueName="SpecValue" DataType="System.Double" DataField="SpecValue"
                    Groupable="true" GroupByExpression="SpecValue Group By SpecValue" ColumnGroupName="SpecValue">
                    <HeaderStyle Width="250px" />
                    <ItemTemplate>
                        <asp:Label ID="txtSpecValue" runat="server" Text='<%# Eval("SpecValue") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtSpecValue_E" runat="server" Text='<%# Eval("SpecValue") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="txtSpecValue_I" runat="server" Text='<%# Eval("SpecValue") %>'></asp:TextBox>
                    </InsertItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Is Deleted" SortExpression="Deleted" AllowSorting="false" AllowFiltering="false" UniqueName="Deleted" DataType="System.Boolean" DataField="Deleted"
                    Groupable="true" GroupByExpression="Deleted Group By Deleted" ColumnGroupName="Deleted">
                    <HeaderStyle Width="250px" />
                    <ItemTemplate>
                        <asp:CheckBox ID="chkDeleted" runat="server" Text='<%# Eval("Deleted") %>' Visible="true" Enabled="false"></asp:CheckBox>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="chkDeleted_E" runat="server" Text='<%# Eval("Deleted") %>'></asp:CheckBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:CheckBox ID="chkDeleted_I" runat="server" Checked="false" Enabled="false"></asp:CheckBox>
                    </InsertItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
            
        </MasterTableView>
    </telerik:RadGrid>

    </div>

    <asp:SqlDataSource runat="server" ID="dsLines" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
        SelectCommand="SELECT [LineID], [LineName] FROM [PromotionalLines] Where Deleted IS NULL"></asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="dsSpecialties" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
        SelectCommand="SELECT [SpecialityID], [SpecialityCode] FROM [Specialities] Where Deleted = 0 OR Deleted IS NULL Order By [SpecialityCode]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsTempSaving" runat="server" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
        SelectCommand="Select RecID, LineID, LineName, SpecialtyID, SpecialityCode, SpecValue, Deleted From View_SpecValByLineTemp Where (Deleted = 0 OR Deleted IS NULL)"
        InsertCommand="INSERT INTO SpecPriorityByLineTemp (LineID, SpecialtyID, SpecValue) Values (@ddlLine_Det, @ddlSpec_Det, @txtSpecValue_Det)"
        UpdateCommand="UPDATE SpecPriorityByLineTemp Set LineID = @ddlLine_DetU, SpecialtyID = @ddlSpec_DetU, SpecValue = @txtSpecValue_DetU, Deleted = @chkDel_DetU Where RecID = @lblRecID_DetU">
        <InsertParameters>
            <asp:Parameter DbType="Int32" Name="ddlLine_Det" />
            <asp:Parameter DbType="Int32" Name="ddlSpec_Det" />
            <asp:Parameter DbType="Int32" Name="txtSpecValue_Det" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter DbType="Int32" Name="lblRecID_DetU" />
            <asp:Parameter DbType="Int32" Name="ddlLine_DetU" />
            <asp:Parameter DbType="Int32" Name="ddlSpec_DetU" />
            <asp:Parameter DbType="Int32" Name="txtSpecValue_DetU" />
            <asp:Parameter DbType="Boolean" Name="chkDel_DetU" />
        </UpdateParameters>
    </asp:SqlDataSource>

        </td></tr></table>

    <p><br /><br /></p>
    <div>
                                <asp:Label ID="lblStatus" runat="server" Text="Status: " Font-Italic="true"></asp:Label>

    </div>
</asp:Content>
