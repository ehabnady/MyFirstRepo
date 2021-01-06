<%@ Page Title="Cycle-Level Parameters" Language="C#" MasterPageFile="~/CommercialDirector/SiteMaster2.Master" AutoEventWireup="true" 
    CodeBehind="DetailingPriority2.aspx.cs" Inherits="AmounCRM4.CommercialDirector.DetailingPriority2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <title>Detailing Priority & Specialty Weight By Line</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">


    <table style="margin-left:40px"><tr><td>


    <div>
    <asp:Label ID="lbl" runat="server" Text="Temp Detailing Priority (Will be implemented last week of every month)"></asp:Label>
    <br /><br />

        <asp:HyperLink ID="hl1" runat="server" NavigateUrl="~/CommercialDirector/SpecValueForm.aspx" Text="Go to Specialty Value"></asp:HyperLink>
        <br /><br />
        
    <telerik:RadGrid ID="grdDetailingTemp" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True" ShowGroupPanel="True" Skin="WebBlue"
        EnableHeaderContextAggregatesMenu="True" EnableHeaderContextFilterMenu="True" 
        EnableHeaderContextMenu="True" ShowFooter="True" DataSourceID="dsBrandPriorityBySpecLineTemp" CellSpacing="-1" GridLines="Both" Width="95%" HorizontalAlign="Center"
        AutoGenerateEditColumn="true"
        OnItemDataBound="grdDetailingTemp_ItemDataBound" OnItemCommand="grdDetailingTemp_ItemCommand"
        OnInsertCommand="grdDetailingTemp_InsertCommand" OnEditCommand="grdDetailingTemp_EditCommand"
        OnUpdateCommand="grdDetailingTemp_UpdateCommand" PageSize="400"
        >

        <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="Detailing Priority">
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
                    <HeaderStyle Width="150px" />
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

                <telerik:GridTemplateColumn HeaderText="Line Name" SortExpression="LineName" UniqueName="LineName" FilterControlAltText="Filter LineName column" DataField="LineName"
                    Groupable="true" GroupByExpression="LineName Group By LineName" ColumnGroupName="LineName">
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

                <telerik:GridTemplateColumn HeaderText="Brand" SortExpression="BrandName" UniqueName="BrandName" DataType="System.String" DataField="BrandName"
                    Groupable="true" GroupByExpression="BrandName Group By BrandName" ColumnGroupName="BrandName">
                    <HeaderStyle Width="250px" />
                    <ItemTemplate>
                        <asp:Label ID="lblBrandName" runat="server" Text='<%# Eval("BrandName") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadDropDownList ID="ddlBrandName_E" runat="server" DataSourceID="dsBrands" DataTextField="BrandName" DataValueField="BrandID" AppendDataBoundItems="true" SelectedValue='<%# Eval("BrandID") %>' Enabled="false">
                            <Items>
                                <telerik:DropDownListItem Text="Select" Value="0" />
                            </Items>
                        </telerik:RadDropDownList>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <telerik:RadDropDownList ID="ddlBrandName_I" runat="server" DataSourceID="dsBrands" DataTextField="BrandName" DataValueField="BrandID" AppendDataBoundItems="true" SelectedValue='<%# Eval("BrandID") %>'>
                            <Items>
                                <telerik:DropDownListItem Text="Select" Value="0" />
                            </Items>
                        </telerik:RadDropDownList>
                    </InsertItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Priority" SortExpression="BrandPriority" UniqueName="BrandPriority" DataType="System.String" DataField="BrandPriority"
                    Groupable="true" GroupByExpression="BrandPriority Group By BrandPriority" ColumnGroupName="BrandPriority">
                    <HeaderStyle Width="250px" />
                    <ItemTemplate>
                        <asp:Label ID="lblBrandPriority" runat="server" Text='<%# Eval("BrandPriority") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadDropDownList ID="ddlBrandPriority_E" runat="server" AppendDataBoundItems="true" SelectedValue='<%# Eval("BrandPriority") %>'>
                            <Items>
                                <telerik:DropDownListItem Text="Select" Value="0"></telerik:DropDownListItem>
                                <telerik:DropDownListItem Text="First" Value="1"></telerik:DropDownListItem>
                                <telerik:DropDownListItem Text="Second" Value="2"></telerik:DropDownListItem>
                                <telerik:DropDownListItem Text="Third" Value="3"></telerik:DropDownListItem>
                                <telerik:DropDownListItem Text="Not Detailable" Value="5"></telerik:DropDownListItem>
                            </Items>
                        </telerik:RadDropDownList>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <telerik:RadDropDownList ID="ddlBrandPriority_I" runat="server" AppendDataBoundItems="true" SelectedValue='<%# Eval("BrandPriority") %>'>
                            <Items>
                                <telerik:DropDownListItem Text="Select" Value="0"></telerik:DropDownListItem>
                                <telerik:DropDownListItem Text="First" Value="1"></telerik:DropDownListItem>
                                <telerik:DropDownListItem Text="Second" Value="2"></telerik:DropDownListItem>
                                <telerik:DropDownListItem Text="Third" Value="3"></telerik:DropDownListItem>
                                <telerik:DropDownListItem Text="Not Detailable" Value="5"></telerik:DropDownListItem>
                            </Items>
                        </telerik:RadDropDownList>
                    </InsertItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Is Deleted" SortExpression="Deleted" AllowSorting="false" AllowFiltering="false" UniqueName="Deleted" DataType="System.Boolean" 
                    DataField="Deleted" Groupable="true" GroupByExpression="Deleted Group By Deleted" ColumnGroupName="Deleted">
                    <HeaderStyle Width="250px" />
                    <ItemTemplate>
                        <asp:Label ID="lblDeleted" runat="server" Text='<%# Eval("Deleted") %>'></asp:Label>
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
    <asp:SqlDataSource runat="server" ID="dsBrandPriorityBySpecLineTemp" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
        SelectCommand="Select RecID, LineID, LineName, BrandID, BrandName, SpecialtyID, SpecialityCode, BrandPriority, Deleted From View_BrandPriorityBySpecLineTemp"
        InsertCommand="INSERT INTO BrandPriorityBySpecLineTemp (LineID, BrandID, SpecialtyID, BrandPriority) Values (@ddlLine_Det, @ddlBrands_Det, @ddlSpec_Det, @ddlPriority_Det)"
        UpdateCommand="UPDATE BrandPriorityBySpecLineTemp Set LineID = @ddlLine_DetU, BrandID = @ddlBrands_DetU, SpecialtyID = @ddlSpec_DetU, BrandPriority = @ddlPriority_DetU, Deleted = @chkDel_Det_E Where RecID = @lblRecID_DetU">
        <InsertParameters>
            <asp:ControlParameter ControlID="ddlLine_Det_I" DbType="Int32" PropertyName="SelectedValue" Name="ddlLine_Det" />
            <asp:ControlParameter ControlID="ddlBrands_Det_I" DbType="Int32" PropertyName="SelectedValue" Name="ddlBrands_Det" />
            <asp:ControlParameter ControlID="ddlSpec_Det_I" DbType="Int32" PropertyName="SelectedValue" Name="ddlSpec_Det" />
            <asp:ControlParameter ControlID="ddlPriority_Det_I" DbType="Int32" PropertyName="SelectedValue" Name="ddlPriority_Det" />
            <asp:ControlParameter ControlID="chkDel_Det_I" DbType="Boolean" PropertyName="Text" Name="chkDel_Det" />
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="lblRecID_Det_E" DbType="Int32" PropertyName="Text" Name="lblRecID_DetU" />
            <asp:ControlParameter ControlID="ddlLine_Det_E" DbType="Int32" PropertyName="SelectedValue" Name="ddlLine_DetU" />
            <asp:ControlParameter ControlID="ddlBrands_Det_E" DbType="Int32" PropertyName="SelectedValue" Name="ddlBrands_DetU" />
            <asp:ControlParameter ControlID="ddlSpec_Det_E" DbType="Int32" PropertyName="SelectedValue" Name="ddlSpec_DetU" />
            <asp:ControlParameter ControlID="ddlPriority_Det_E" DbType="Int32" PropertyName="SelectedValue" Name="ddlPriority_DetU" />
            <asp:ControlParameter ControlID="chkDel_Det_E" DbType="Boolean" PropertyName="Text" Name="chkDel_DetU" />
        </UpdateParameters>
    </asp:SqlDataSource>

        <p><br /></p>
    </div>

    <asp:SqlDataSource runat="server" ID="dsDetailing2" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
        SelectCommand="SELECT [RecID], [LineID], [BrandID], [SpecialtyID], [BrandPriority], [Deleted] FROM [BrandPriorityBySpecLine]"></asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="dsLines" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
        SelectCommand="SELECT [LineID], [LineName] FROM [PromotionalLines] Where Deleted IS NULL"></asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="dsSpecialties" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
        SelectCommand="SELECT [SpecialityID], [SpecialityCode] FROM [Specialities] Where Deleted = 0 OR Deleted IS NULL Order By [SpecialityCode]"></asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="dsBrands" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
        SelectCommand="SELECT [BrandID], [BrandName] FROM [View_Brands] Order By [BrandName]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsTempSaving" runat="server" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>' 
        SelectCommand="Select RecID, LineID, LineName, BrandID, BrandName, SpecialtyID, SpecialityCode, BrandPriority From View_BrandPriorityBySpecLineTemp"
        InsertCommand="INSERT INTO BrandPriorityBySpecLineTemp (LineID, BrandID, SpecialtyID, BrandPriority) Values (@ddlLine_Det, @ddlBrands_Det, @ddlSpec_Det, @ddlPriority_Det)"
        UpdateCommand="UPDATE BrandPriorityBySpecLineTemp Set LineID = @ddlLine_DetU, BrandID = @ddlBrands_DetU, SpecialtyID = @ddlSpec_DetU, BrandPriority = @ddlPriority_DetU, Deleted = @chkDel_DetU Where RecID = @lblRecID_DetU">
        <InsertParameters>
            <asp:Parameter DbType="Int32" Name="ddlLine_Det" />
            <asp:Parameter DbType="Int32" Name="ddlBrands_Det" />
            <asp:Parameter DbType="Int32" Name="ddlSpec_Det" />
            <asp:Parameter DbType="Int32" Name="ddlPriority_Det" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter DbType="Int32" Name="lblRecID_DetU" />
            <asp:Parameter DbType="Int32" Name="ddlLine_DetU" />
            <asp:Parameter DbType="Int32" Name="ddlBrands_DetU" />
            <asp:Parameter DbType="Int32" Name="ddlSpec_DetU" />
            <asp:Parameter DbType="Int32" Name="ddlPriority_DetU" />
            <asp:Parameter DbType="Boolean" Name="chkDel_DetU" />
        </UpdateParameters>
    </asp:SqlDataSource>

        </td></tr></table>

    <p><br /><br /></p>
    <div>
                                <asp:Label ID="lblStatus" runat="server" Text="Status: " Font-Italic="true"></asp:Label>

    </div>
</asp:Content>
