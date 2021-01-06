<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" 
    CodeBehind="UpdateDoctors2.aspx.cs" Inherits="AmounCRM4.UpdateDoctors2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
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
        .dropdown { 
            font:12px/0.8 Arial; 
            border:solid 1px ; 
            border-radius:4px; 
            -moz-border-radius:4px; 
            -webkit-border-radius:4px; 
            cursor:pointer; 
            width:auto;
        }
        .gridv th,td { padding:5px }
        .rightText { text-align:right;}
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <asp:Label ID="lblStatus" runat="server" ForeColor="Red"></asp:Label>
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" AutoGenerateEditButton="True" 
    OnRowCreated="GridView1_RowCreated" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowEditing="GridView1_RowEditing"   
    OnRowUpdating="GridView1_RowUpdating" CssClass="gridv" ShowFooter = "true" OnPageIndexChanging = "OnPaging" PageSize="12" 
    AllowPaging ="true" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
     <Columns>  
              
               <asp:TemplateField HeaderText="1-ID">  
                    <ItemTemplate>  
                        <asp:Label ID="lbl_ID" runat="server" Text='<%#Eval("ID") %>'></asp:Label>  
                    </ItemTemplate>  
                    <EditItemTemplate>  
                        <asp:Label ID="lbl_ID" runat="server" Text='<%#Eval("ID") %>'></asp:Label>    
                    </EditItemTemplate> 
                   <FooterTemplate>
        <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick = "AddNewCustomer" />
    </FooterTemplate>
                   </asp:TemplateField>  

        

                <asp:TemplateField ItemStyle-HorizontalAlign="Right" HeaderText="2-Doctor Name">  
                    <ItemTemplate>  
                        <asp:Label ID="lbl_Name" runat="server" Text='<%#Eval("Uname") %>'></asp:Label>  
                    </ItemTemplate>  
                    <EditItemTemplate>  
                        <asp:TextBox ID="txt_Name" runat="server" Text='<%#Eval("Uname") %>'></asp:TextBox>  
                    </EditItemTemplate> 
                                       <FooterTemplate><asp:TextBox ID="txt_Name"  onselectstart="return false" ondragstart="return false" onkeypress="return(KeyPressOrder(this,event))" onkeydown="(KeyPressOrder(this,event))" Wrap="true" Font-Italic="true" ForeColor="#666666" Text="أسم الدكتور" CssClass="rightText" runat="server" ></asp:TextBox> </FooterTemplate>
 
                </asp:TemplateField>  
                <asp:TemplateField ItemStyle-HorizontalAlign="Right" HeaderText="3-Address">  
                    <ItemTemplate>  
                        <asp:Label ID="lbl_Address" runat="server" Text='<%#Eval("Uaddress") %>'></asp:Label>  
                    </ItemTemplate>  
                    <EditItemTemplate>  
                        <asp:TextBox ID="txt_Address" runat="server" Text='<%#Eval("Uaddress") %>'></asp:TextBox>  
                    </EditItemTemplate>
                    <FooterTemplate ><asp:TextBox ID="txt_Address" onselectstart="return false" ondragstart="return false" onkeypress="return(KeyPressOrder(this,event))" onkeydown="(KeyPressOrder(this,event))" Text="عنوان العيادة" CssClass="rightText" Wrap="true" Font-Italic="true" ForeColor="#666666" runat="server"></asp:TextBox> </FooterTemplate>  
                </asp:TemplateField>
        
                <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderText="4-Speciality">  
                     <HeaderTemplate>
            4-Speciality:
            <asp:DropDownList ID="ddlSpecialitySE" runat="server" CssClass="dropdown" DataSourceID="SpecialityDataSource" DataTextField="SpecialityCode" 
                DataValueField="SpecialtyID" 
            OnSelectedIndexChanged = "SpecialityChanged" AutoPostBack = "true" AppendDataBoundItems="true">
            <asp:ListItem Text = "Select" Value = ""></asp:ListItem><asp:ListItem Text = "ALL" Value = "0"></asp:ListItem>
            </asp:DropDownList>
        </HeaderTemplate>
                    <ItemTemplate>  
                          <asp:Label ID="lbl_Speciality" runat="server"    Text='<%#Bind("SpecialityCode") %>'></asp:Label>  
                    </ItemTemplate> 
                    <%--<EditItemTemplate> 
                        <asp:DropDownList ID="ddlSpeciality" runat="server" CssClass="dropdown" DataSourceID="SpecialityDataSource" DataTextField="SpecialityCode" DataValueField="SpecialityID" SelectedValue='<%# Bind("SpecialtyID") %>'>
                        </asp:DropDownList>
                    </EditItemTemplate> --%> 
                   <FooterTemplate><asp:DropDownList ID="ddlSpeciality" runat="server" CssClass="dropdown" Font-Italic="true" ForeColor="#666666" DataSourceID="SpecialityDataSource" DataTextField="SpecialityCode" DataValueField="SpecialtyID" AppendDataBoundItems="true" ><asp:ListItem Text="Select Speciality" Value="0" Selected="True" ></asp:ListItem></asp:DropDownList></FooterTemplate>
                </asp:TemplateField>    

               <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderText="5-Brick">  
                   <HeaderTemplate>
            5-Brick:
            <asp:DropDownList ID="ddlBrickSE" runat="server" CssClass="dropdown" DataSourceID="SqlDataSource1" DataTextField="AmounBrickName" DataValueField="AmounBrickID" 
            OnSelectedIndexChanged = "BrickChanged" AutoPostBack = "true" AppendDataBoundItems="true">
            <asp:ListItem Text = "Select" Value = ""></asp:ListItem><asp:ListItem Text = "ALL" Value = "0"></asp:ListItem>
            </asp:DropDownList>
        </HeaderTemplate>
                    <ItemTemplate>  
                          <asp:Label ID="lbl_Brick" runat="server"   Text='<%#Bind("txtbrick") %>'></asp:Label>  
                    </ItemTemplate> 
                    <EditItemTemplate> 
                        <asp:DropDownList ID="ddlBrick" runat="server" CssClass="dropdown" DataSourceID="SqlDataSource1" DataTextField="AmounBrickName" 
                            DataValueField="AmounBrickID" SelectedValue='<%# Bind("UBrick") %>'>
                        </asp:DropDownList>
                    </EditItemTemplate>  
                   <FooterTemplate><asp:DropDownList ID="ddlBrick" runat="server" CssClass="dropdown" Font-Italic="true" ForeColor="#666666" DataSourceID="SqlDataSource1" DataTextField="AmounBrickName" DataValueField="AmounBrickID" AppendDataBoundItems="true" ><asp:ListItem Text="Select Brick" Value="0" Selected="True" ></asp:ListItem></asp:DropDownList></FooterTemplate>
                </asp:TemplateField>    




         <asp:TemplateField HeaderText="6-No. Of Patients">  
                    <ItemTemplate> 
                         <asp:Label ID="lbl_NoOfPatients" runat="server" Text='<%#Bind("txtNoOfPatients") %>'></asp:Label>  
                    </ItemTemplate>  
                    <EditItemTemplate>  
                          <asp:DropDownList ID="ddlNoOfPatients" runat="server" CssClass="dropdown" DataSourceID="NOPDataSource" DataTextField="RangeName" DataValueField="RangeValue" SelectedValue='<%# Bind("UNoOfPatients") %>'> </asp:DropDownList>
                    <asp:Label ID="lbl_NoOfPatients" runat="server" Text='<%#Eval("txtNoOfPatients") %>'></asp:Label>  
                         </EditItemTemplate>  
             <FooterTemplate> <asp:DropDownList ID="ddlNoOfPatients" runat="server" CssClass="dropdown" Font-Italic="true" ForeColor="#666666" DataSourceID="NOPDataSource" DataTextField="RangeName" DataValueField="RangeValue" AppendDataBoundItems="true" ><asp:ListItem Text="Select No.Of Patients" Value="0" Selected="True" ></asp:ListItem></asp:DropDownList></FooterTemplate>
                </asp:TemplateField>    
         <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderText="7-Prescription Habit"> 

<%--              <HeaderTemplate>
            7-Prescription Habit:
            <asp:DropDownList ID="ddlPHabitSE" runat="server" CssClass="dropdown" DataSourceID="PHDataSource" DataTextField="RangeName" DataValueField="RangeValue" 
            OnSelectedIndexChanged = "PHabitChanged" AutoPostBack = "true" AppendDataBoundItems="true">
            <asp:ListItem Text = "Select" Value = ""></asp:ListItem><asp:ListItem Text = "ALL" Value = "-10"></asp:ListItem>
                <asp:ListItem Text = "Not Set" Value = "0"></asp:ListItem>
            </asp:DropDownList>
        </HeaderTemplate>--%>
              
                    <ItemTemplate>  
                             <asp:Label ID="lbl_PHabit" runat="server" Text='<%#Bind("txtPHabit") %>'></asp:Label>  

                    </ItemTemplate>  
                    <EditItemTemplate>  
                                <asp:DropDownList ID="ddlPHabit" runat="server" DataSourceID="PHDataSource" DataTextField="RangeName" DataValueField="RangeValue" AppendDataBoundItems="true" SelectedValue='<%# Bind("UPHabit") %>'><asp:ListItem Text="Select" Value="0" Selected="True" ></asp:ListItem> </asp:DropDownList>

                    </EditItemTemplate> 
             <FooterTemplate> <asp:DropDownList ID="ddlPHabit" runat="server" CssClass="dropdown" Font-Italic="true" ForeColor="#666666" DataSourceID="PHDataSource" DataTextField="RangeName" DataValueField="RangeValue" AppendDataBoundItems="true" ><asp:ListItem Text="Select Prescription Habit" Value="0" Selected="True" ></asp:ListItem> </asp:DropDownList></FooterTemplate> 
                </asp:TemplateField>  
          <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderText="8-Delete"> 
             <ItemTemplate>  
                          <asp:Label ID="lbl_Deleted" runat="server"   Text='<%#Bind("UDeleted") %>'></asp:Label>  
                    
             </ItemTemplate> 
             <EditItemTemplate>
                             <asp:DropDownList ID="ddlDeleted" runat="server" SelectedValue='<%# Bind("UDeleted") %>'>
                                 <asp:ListItem>Yes</asp:ListItem>  
                                    <asp:ListItem>No</asp:ListItem>  
                             </asp:DropDownList>
             </EditItemTemplate>  
            <FooterTemplate> <%--<asp:DropDownList ID="ddlDeleted" runat="server" >
                                
                             </asp:DropDownList>--%></FooterTemplate>
         </asp:TemplateField>   
       
            </Columns>  
            <HeaderStyle
                    BackColor="#3366cc"
                    BorderColor="Gray" 
                    Font-Bold="True" 
                    ForeColor="White" 
                    Height="20px" />
                    
                <RowStyle HorizontalAlign="Center" Height="20px" />
    </asp:GridView>
     <asp:SqlDataSource ID="AreaDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
            SelectCommand="SELECT [AmounBrickID], [AmounBrickName] FROM [View_EmployeesBricks] WHERE ([Deleted] IS NULL)">
        </asp:SqlDataSource>
    <asp:SqlDataSource ID="NOPDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT [RangeName], [RangeValue] FROM [NoOfPatients]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="PHDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT [RangeValue], [RangeName] FROM [PrescriptionHappit]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT [AmounBrickID], [AmounBrickName] FROM [View_EmployeesBricks] WHERE (([Deleted] IS NULL OR Deleted = 0) AND ([EmployeeID] = @EmployeeID))">
        <SelectParameters>
            <asp:SessionParameter Name="EmployeeID" SessionField="EmployeeID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SpecialityDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" SelectCommand="SELECT [SpecialtyID], [SpecialityCode] FROM [View_SpecValByLine] WHERE (([SpecValue] &gt; @SpecValue) AND ([LineID] = @LineID))">
        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="SpecValue" Type="Double" />
            <asp:SessionParameter Name="LineID" SessionField="LineID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:TextBox ID="txtSpValue" runat="server" Visible="False"></asp:TextBox>
    <asp:TextBox ID="txtBrickVal" runat="server" Visible="False"></asp:TextBox>
    <asp:TextBox ID="txtPHabitVal" runat="server" Visible="False"></asp:TextBox>
</asp:Content>