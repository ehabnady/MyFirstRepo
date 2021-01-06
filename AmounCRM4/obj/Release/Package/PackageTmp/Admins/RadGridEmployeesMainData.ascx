<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RadGridEmployeesMainData.ascx.cs" Inherits="AmounCRM4.Admins.RadGridEmployeesMainData" %>
<div>
    <asp:UpdatePanel ID="EmpMainDataPanel1" runat="server">
        <ContentTemplate>
            <telerik:RadGrid ID="RadGrid1" RenderMode="Lightweight" GridLines="None" AutoGenerateColumns="false"
                PageSize="10" AllowPaging="true" AllowSorting="true" runat="server"
                OnItemDataBound="OnItemDataBoundHandler" DataSourceID="ProductsDataSource" AllowAutomaticUpdates="true"
                AllowAutomaticInserts="True" ShowStatusBar="true" Skin="Silk">

                <MasterTableView ShowFooter="false" DataKeyNames="ProductID" EditMode="InPlace" CommandItemDisplay="TopAndBottom">
                    <Columns>
                        <telerik:GridBoundColumn DataField="ProductName" HeaderText="ProductName" HeaderStyle-Width="300px" ItemStyle-Width="300px" />
                        <telerik:GridTemplateColumn UniqueName="Supplier" HeaderText="Supplier" SortExpression="CompanyName" ItemStyle-Width="400px">
                            <FooterTemplate>Template footer</FooterTemplate>
                            <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <%#DataBinder.Eval(Container.DataItem, "CompanyName")%>
                            </ItemTemplate>

                            <EditItemTemplate>
                                <telerik:RadComboBox runat="server" ID="RadComboBox1" RenderMode="Lightweight" EnableLoadOnDemand="True"
                                    DataTextField="CompanyName" OnItemsRequested="RadComboBox1_ItemsRequested" DataValueField="SupplierID"
                                    AutoPostBack="true" HighlightTemplatedItems="true" Skin="Silk" Height="140px" Width="220px"
                                    DropDownWidth="420px" OnSelectedIndexChanged="OnSelectedIndexChangedHandler">
                                    <HeaderTemplate>
                                        <ul>
                                            <li class="col1">Company</li>
                                            <li class="col2">ContactName</li>
                                        </ul>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <ul>
                                            <li class="col1"><%# DataBinder.Eval(Container, "Text")%> </li>
                                            <li class="col2"><%# DataBinder.Eval(Container, "Attributes['ContactName']")%></li>
                                        </ul>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                            </EditItemTemplate>

                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Category" ItemStyle-Width="240px">
                            <ItemTemplate>
                                <%#DataBinder.Eval(Container.DataItem, "CategoryName")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox runat="server" ID="RadComboBox2" RenderMode="Lightweight" Skin="Silk" DataTextField="CategoryName"
                                    DataValueField="CategoryID" DataSourceID="CategoriesDataSource" SelectedValue='<%#Bind("CategoryID") %>'>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridEditCommandColumn FooterText="EditCommand footer" UniqueName="EditCommandColumn"
                            HeaderText="Edit" HeaderStyle-Width="100px" UpdateText="Update">
                        </telerik:GridEditCommandColumn>

                    </Columns>

                </MasterTableView>

            </telerik:RadGrid>

        </ContentTemplate>

    </asp:UpdatePanel>

</div>

<asp:SqlDataSource ID="ProductsDataSource" runat="server"
    ConnectionString="<%$ ConnectionStrings:NorthwindConnectionString35 %>"
    SelectCommand="SELECT products.[ProductID], products.[ProductName], products.[SupplierID], products.[CategoryID], suppliers.[CompanyName], 
    suppliers.[ContactName], categories.[CategoryName] FROM [Products] AS products 
    INNER JOIN Suppliers AS suppliers ON products.SupplierID = suppliers.SupplierID
    INNER JOIN Categories AS categories 
    ON products.CategoryID = categories.CategoryID"
    InsertCommand="INSERT INTO [Products] ([ProductName], [SupplierID], [CategoryID]) VALUES (@ProductName, @SupplierID, @CategoryID)"
    UpdateCommand="UPDATE [Products] SET  [ProductName] = @ProductName, [SupplierID] = @SupplierID, [CategoryID] = @CategoryID WHERE [ProductID] = @ProductID">
    <InsertParameters>
        <asp:Parameter Name="ProductName" Type="String" />
        <asp:SessionParameter SessionField="SupplierID" Name="SupplierID" Type="Int32" />
        <asp:Parameter Name="CategoryID" Type="Int32" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="ProductID" Type="Int32" />
        <asp:Parameter Name="ProductName" Type="String" />
        <asp:SessionParameter SessionField="SupplierID" Name="SupplierID" Type="Int32" />
        <asp:Parameter Name="CategoryID" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="CategoriesDataSource" runat="server"
    ConnectionString="<%$ ConnectionStrings:NorthwindConnectionString35 %>"
    SelectCommand="SELECT [CategoryID], [CategoryName] FROM [Categories]"></asp:SqlDataSource>
