<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="UpdateDoctorsForm.aspx.cs" Inherits="AmounCRM4.Admins.UpdateDoctorsForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="6" 
        OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" 
        OnRowDataBound="GridView1_RowDataBound">
     <Columns>  
                <asp:TemplateField>  
                    <ItemTemplate>  
                        <asp:Button ID="btn_Edit" runat="server" Text="Edit" CommandName="Edit" />  
                    </ItemTemplate>  
                    <EditItemTemplate>  
                        <asp:Button ID="btn_Update" runat="server" Text="Update" CommandName="Update"/>  
                        <asp:Button ID="btn_Cancel" runat="server" Text="Cancel" CommandName="Cancel"/>  
                    </EditItemTemplate>  
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
                        <asp:Label ID="lbl_Brick" runat="server" Text='<%#Eval("UBrick") %>'></asp:Label>  
                    </ItemTemplate>  
                    <EditItemTemplate>  
                        <asp:DropDownList ID="ddlBrick" runat="server" >
                        </asp:DropDownList>
                    </EditItemTemplate>  
                </asp:TemplateField>    
         <asp:TemplateField HeaderText="NoOfPatients">  
                    <ItemTemplate>  
                        <asp:Label ID="lbl_NoOfPatients" runat="server" Text='<%#Eval("UNoOfPatients") %>'></asp:Label>  
                    </ItemTemplate>  
                    <EditItemTemplate>  
                        <asp:DropDownList ID="ddlNoOfPatients" runat="server"> </asp:DropDownList>
                    </EditItemTemplate>  
                </asp:TemplateField>    
         <asp:TemplateField HeaderText="PHabit">  
                    <ItemTemplate>  
                        <asp:Label ID="lbl_PHabit" runat="server" Text='<%#Eval("UPHabit") %>'></asp:Label>  
                    </ItemTemplate>  
                    <EditItemTemplate>  
                        <asp:DropDownList ID="ddlPHabit" runat="server"> </asp:DropDownList>
                    </EditItemTemplate>  
                </asp:TemplateField>    
            </Columns>  
            <HeaderStyle BackColor="#663300" ForeColor="#ffffff"/>  
            <RowStyle BackColor="#e7ceb6"/>  
    </asp:GridView>
     <asp:SqlDataSource ID="AreaDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
            SelectCommand="SELECT [AmounBrickID], [AmounBrickName] FROM [View_EmployeesBricks] WHERE ([Deleted] IS NULL)">
        </asp:SqlDataSource>
</asp:Content>
