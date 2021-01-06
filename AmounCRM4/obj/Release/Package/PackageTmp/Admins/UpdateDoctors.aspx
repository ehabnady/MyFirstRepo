<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="UpdateDoctors.aspx.cs" Inherits="AmounCRM4.Admins.UpdateDoctors" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    
    <style type="text/css">
        .dropdown { 
            font:12px/0.8 Arial; 
            border:solid 1px #6FA602; 
            border-radius:4px; 
            -moz-border-radius:4px; 
            -webkit-border-radius:4px; 
            cursor:pointer; 
            width:auto;
        }
        .gridv th,td { padding:5px }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" AutoGenerateEditButton="True"  OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowEditing="GridView1_RowEditing"  OnRowDataBound="GridView1_RowDataBound" OnRowUpdating="GridView1_RowUpdating" CssClass="gridv">
     <Columns>  
                <%--<asp:TemplateField>  
                    <ItemTemplate>  
                        <asp:Button ID="btn_Edit" runat="server" Text="Edit" CommandName="Edit" />  
                    </ItemTemplate>  
                    <EditItemTemplate>  
                        <asp:Button ID="btn_Update" runat="server" Text="Update" CommandName="Update"/>  
                        <asp:Button ID="btn_Cancel" runat="server" Text="Cancel" CommandName="Cancel"/>  
                    </EditItemTemplate>  
                </asp:TemplateField>  --%>
               <asp:TemplateField HeaderText="ID">  
                    <ItemTemplate>  
                        <asp:Label ID="lbl_ID" runat="server" Text='<%#Eval("ID") %>'></asp:Label>  
                    </ItemTemplate>  
                   </asp:TemplateField>  
                <asp:TemplateField HeaderText="Name">  
                    <ItemTemplate>  
                        <asp:Label ID="lbl_Name" runat="server" Text='<%#Eval("Uname") %>'></asp:Label>  
                    </ItemTemplate>  
                    <EditItemTemplate>  
                        <asp:TextBox ID="txt_Name" runat="server" Text='<%#Eval("Uname") %>'></asp:TextBox>  
                    </EditItemTemplate>  
                </asp:TemplateField>  
                <asp:TemplateField HeaderText="Address">  
                    <ItemTemplate>  
                        <asp:Label ID="lbl_Address" runat="server" Text='<%#Eval("Uaddress") %>'></asp:Label>  
                    </ItemTemplate>  
                    <EditItemTemplate>  
                        <asp:TextBox ID="txt_Address" runat="server" Text='<%#Eval("Uaddress") %>'></asp:TextBox>  
                    </EditItemTemplate>  
                </asp:TemplateField>
               <asp:TemplateField HeaderText="Brick">  
                    <ItemTemplate>  
                          <asp:Label ID="lbl_Brick" runat="server" Text='<%#Bind("txtbrick") %>'></asp:Label>  
                    </ItemTemplate> 
                 
                    <EditItemTemplate> 
                        <asp:DropDownList ID="ddlBrick" runat="server" CssClass="dropdown" >
                        </asp:DropDownList>
                    </EditItemTemplate>  
                </asp:TemplateField>    
         <asp:TemplateField HeaderText="NoOfPatients">  
                    <ItemTemplate> 
                         <asp:Label ID="lbl_NoOfPatients" runat="server" Text='<%#Bind("txtNoOfPatients") %>'></asp:Label>  
                    </ItemTemplate>  
                    <EditItemTemplate>  
                          <asp:DropDownList ID="ddlNoOfPatients" runat="server" CssClass="dropdown"> </asp:DropDownList>
                    </EditItemTemplate>  
                </asp:TemplateField>    
         <asp:TemplateField HeaderText="PHabit">  
                    <ItemTemplate>  
                             <asp:Label ID="lbl_PHabit" runat="server" Text='<%#Bind("txtPHabit") %>'></asp:Label>  

                    </ItemTemplate>  
                    <EditItemTemplate>  
                                <asp:DropDownList ID="ddlPHabit" runat="server" AppendDataBoundItems="true" ><asp:ListItem Text="select" Value="0" Selected="True"></asp:ListItem> </asp:DropDownList>

                    </EditItemTemplate>  
                </asp:TemplateField>    
            </Columns>  
            <HeaderStyle
                    BackColor="#989898" 
                    BorderColor="Gray" 
                    Font-Bold="True" 
                    ForeColor="White" 
                    Height="20px" />
                    
                <RowStyle HorizontalAlign="Center" Height="20px" />
    </asp:GridView>
     <asp:SqlDataSource ID="AreaDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
            SelectCommand="SELECT [AmounBrickID], [AmounBrickName] FROM [View_EmployeesBricks] WHERE ([Deleted] IS NULL)">
        </asp:SqlDataSource>
</asp:Content>