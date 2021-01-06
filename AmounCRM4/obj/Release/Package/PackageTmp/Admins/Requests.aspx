<%@ Page Title="DB Requests Manipulation" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true"
    CodeBehind="Requests.aspx.cs" Inherits="AmounCRM4.Admins.Requests" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <title>DB Requests Manipulation</title>
    <style type="text/css">
        .auto-style3 {
            font-size: large;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <div align="center">
      
        <asp:DropDownList ID="ddlActionsforall" runat="server" CssClass="auto-style3" >
            <asp:ListItem Value="0">Select</asp:ListItem>
            <asp:ListItem Value="1">Create</asp:ListItem>
            <asp:ListItem Value="2">Update One Line</asp:ListItem>
            <asp:ListItem Value="3">Update All Lines</asp:ListItem>
            <asp:ListItem Value="4">Delete From One Line</asp:ListItem>
            <asp:ListItem Value="5">Delete From All Lines</asp:ListItem>
            <asp:ListItem Value="6">Reject (Commercial)</asp:ListItem>
            <asp:ListItem Value="7">Reject (Cairo)</asp:ListItem>
            <asp:ListItem Value="8">Reject (Upper)</asp:ListItem>
            <asp:ListItem Value="9">Reject (Admin)</asp:ListItem>
            <asp:ListItem Value="10">Exist</asp:ListItem>

        </asp:DropDownList>
        <asp:Button ID="btnCheckAll" runat="server" OnClick="btnCheckAll_Click" Text="Update Filtered Records" CssClass="auto-style3"  />
        <br /><br /><br />

        <telerik:RadGrid ID="grdReqs" 
            runat="server"    DataSourceID="dsRequestsView"
            AllowFilteringByColumn="True" AllowPaging="True"
        EnableGroupsExpandAll="True" EnableHeaderContextFilterMenu="True" EnableHeaderContextAggregatesMenu="True"
        AllowSorting="True" GroupPanelPosition="Top" ShowGroupPanel="True" Height="600px"
        Skin="WebBlue" EnableHeaderContextMenu="True" GridLines="Both" PageSize="50" ShowFooter="True">
        <ExportSettings ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" FileName="ListOfRepsVacations">
            <Excel Format="Xlsx" />
        </ExportSettings>

        <ClientSettings AllowDragToGroup="True" AllowExpandCollapse="true">
            <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            <Resizing AllowResizeToFit="true" AllowRowResize="true" AllowColumnResize="true" EnableRealTimeResize="true" ResizeGridOnColumnResize="true" />
        </ClientSettings>
         
           
            <MasterTableView DataSourceID="dsRequestsView"
              AutoGenerateColumns="False" ShowHeader="true" ShowGroupFooter="true" AllowPaging="true"
            AllowSorting="true" CommandItemDisplay="Top" EnableViewState="true">
            <CommandItemSettings ExportToExcelText="Export" ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="False" />
            <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />

                <Columns>
                    <telerik:GridBoundColumn DataField="RequestType" HeaderText="RequestType" SortExpression="RequestType" UniqueName="RequestType" FilterControlAltText="Filter RequestType column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RecID" HeaderText="RecID" SortExpression="RecID" UniqueName="RecID" DataType="System.Int32" FilterControlAltText="Filter RecID column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RealAffID" HeaderText="RealAffID" SortExpression="RealAffID" UniqueName="RealAffID" DataType="System.Int32" FilterControlAltText="Filter RealAffID column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="AffiliationName" HeaderText="AffiliationName" SortExpression="AffiliationName" UniqueName="AffiliationName" FilterControlAltText="Filter AffiliationName column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="LineID" HeaderText="LineID" SortExpression="LineID" UniqueName="LineID" DataType="System.Int32" FilterControlAltText="Filter LineID column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SpecialtyCode" HeaderText="SpecialtyCode" SortExpression="SpecialtyCode" UniqueName="SpecialtyCode" FilterControlAltText="Filter SpecialtyCode column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RequestDescription" HeaderText="RequestDescription" SortExpression="RequestDescription" UniqueName="RequestDescription" FilterControlAltText="Filter RequestDescription column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Notes" HeaderText="Notes" SortExpression="RequiredNotes" UniqueName="RequiredNotes" FilterControlAltText="Filter RequiredNotes column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="NoOfPatientUpdate" HeaderText="NoOfPatientUpdate" SortExpression="NoOfPatientUpdate" UniqueName="NoOfPatientUpdate" FilterControlAltText="Filter NoOfPatientUpdate column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PrescriptionHabitUpdate" HeaderText="PrescriptionHabitUpdate" SortExpression="PrescriptionHabitUpdate" UniqueName="PrescriptionHabitUpdate" FilterControlAltText="Filter RequiredPrescriptionHabitUpdate column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WatingTimeUpdate" HeaderText="WatingTimeUpdate" SortExpression="WatingTimeUpdate" UniqueName="WatingTimeUpdate" FilterControlAltText="Filter WatingTimeUpdate column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="BrickUpdate" HeaderText="BrickUpdate" SortExpression="BrickUpdate" UniqueName="BrickUpdate" FilterControlAltText="Filter BrickUpdate column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="NoOfOperationUpdated" HeaderText="NoOfOperationUpdated" SortExpression="NoOfOperationUpdated" UniqueName="NoOfOperationUpdated" FilterControlAltText="Filter NoOfOperationUpdated column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="AddressUpdated" HeaderText="AddressUpdated" SortExpression="AddressUpdated" UniqueName="AddressUpdated" FilterControlAltText="Filter AddressUpdated column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SalesDirector" HeaderText="SalesDirector" SortExpression="SalesDirector" UniqueName="SalesDirector" FilterControlAltText="Filter SalesDirector column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RequestDate" HeaderText="RequestDate" SortExpression="RequestDate" UniqueName="RequestDate" DataType="System.DateTime" FilterControlAltText="Filter RequestDate column" DataFormatString="{0:dd/MM/yyyy}" ></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ExportDate" HeaderText="ExportDate" SortExpression="ExportDate" UniqueName="ExportDate" DataType="System.DateTime" FilterControlAltText="Filter ExportDate column" DataFormatString="{0:dd/MM/yyyy}"></telerik:GridBoundColumn>

                    
                    <telerik:GridTemplateColumn HeaderText="Required Action" UniqueName="RequiredAction" AllowFiltering="false" AllowSorting="false">
                        <ItemTemplate>
                            <telerik:RadDropDownList ID="ddlActions" runat="server" Culture="en-US" Width="90%" Skin="WebBlue" AppendDataBoundItems="true">
                                <Items>
                                    <telerik:DropDownListItem Text="Select" Value="0" Selected="true" />
                                    <telerik:DropDownListItem Text="Create" Value="1" />
                                    <telerik:DropDownListItem Text="Update One Line" Value="2" />
                                    <telerik:DropDownListItem Text="Update All Lines" Value="3" />
                                    <telerik:DropDownListItem Text="Delete From One Line" Value="4" />
                                    <telerik:DropDownListItem Text="Delete From All Lines" Value="5" />
                                    <telerik:DropDownListItem Text="Reject (Commercial)" Value="6" />
                                    <telerik:DropDownListItem Text="Reject (Cairo)" Value="7" />
                                    <telerik:DropDownListItem Text="Reject (Upper)" Value="8" />
                                    <telerik:DropDownListItem Text="Reject (Admin)" Value="9" />
                                    <telerik:DropDownListItem Text="Exist" Value="10" />
                                </Items>
                            </telerik:RadDropDownList>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
                <PagerStyle AlwaysVisible="True" PageSizes="50;100;150;200;300;400;500" Mode="NextPrevAndNumeric" />

            </MasterTableView>
        </telerik:RadGrid>
    </div>



    <asp:SqlDataSource runat="server" ID="dsRequestsView" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
        SelectCommand="select RequestType,RecID,RealAffID,AffiliationName,LineID,SpecialtyCode,RequestDescription,Notes,NoOfPatientUpdate,PrescriptionHabitUpdate,WatingTimeUpdate,BrickUpdate,NoOfOperationUpdated,AddressUpdated,SalesDirector,RequestDate,ExportDate from View_ChangeRequests_AllAll where (Status ='Sales Director' or Status ='Commercial Director')"></asp:SqlDataSource>


    <div align="center">
        <asp:Button ID="btnExecute" runat="server" Text="Proceed" OnClick="btnExecute_Click" Height="30px" BackColor="White" Font-Names="Times New Roman" Font-Size="Medium" ForeColor="#0000CC" />
    </div>
    <div align="center">
        <asp:Label ID="LblMessages" runat="server" Text="Results: "></asp:Label>
    </div>
</asp:Content>
