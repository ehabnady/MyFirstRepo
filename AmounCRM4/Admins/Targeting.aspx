<%@ Page Title="Create Target List" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Targeting.aspx.cs" Inherits="AmounCRM4.Admins.Targeting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <title>Create Target List</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">

    <div style="align-items: center">

        <h3 style="color: #FF0000">The Below Button Will DELETE THE TARGET LIST of current cycle before create a new list
                <br />
            If You Are Sure Click On The Create Buttone</h3>
        <br />
        <h4 style="color: #FF0000">Use This After Createing An Automatic Plan For All Reps
        </h4>

        <p>
            <asp:Button ID="btnCreateTargetList" runat="server" Text="Create Target List For The Current Cycle" OnClick="btnCreateTargetList_Click" />
        </p>

        <br />

        <telerik:RadGrid ID="grdTargetList" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True"
            ShowGroupPanel="True" Skin="WebBlue" CellSpacing="-1" DataSourceID="dsTargetList" GridLines="Both" Height="700" Width="96%">
            <PagerStyle HorizontalAlign="Left" Mode="NextPrevAndNumeric" PageSizes="50,100,150,200,500,1000" Position="Bottom" />

            <ClientSettings AllowDragToGroup="True">
                <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
                <Resizing AllowColumnResize="true" AllowResizeToFit="true" EnableRealTimeResize="true" AllowRowResize="true" />
            </ClientSettings>
            <MasterTableView DataKeyNames="Doctor ID" DataSourceID="dsTargetList" AutoGenerateColumns="False">
                <Columns>
                    <telerik:GridBoundColumn DataField="Line" HeaderText="Line" SortExpression="Line" UniqueName="Line" DataType="System.Int32" FilterControlAltText="Filter Line column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Region" HeaderText="Region" SortExpression="Region" UniqueName="Region" FilterControlAltText="Filter Region column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="District" HeaderText="District" SortExpression="District" UniqueName="District" FilterControlAltText="Filter District column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Territory" HeaderText="Territory" SortExpression="Territory" UniqueName="Territory" FilterControlAltText="Filter Territory column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Brick ID" HeaderText="Brick ID" SortExpression="Brick ID" UniqueName="BrickID" DataType="System.Int32" FilterControlAltText="Filter Brick ID column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Brick Name" HeaderText="Brick Name" SortExpression="Brick Name" UniqueName="BrickName" FilterControlAltText="Filter Brick Name column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Doctor ID" ReadOnly="True" HeaderText="Doctor ID" SortExpression="Doctor ID" UniqueName="DoctorID" DataType="System.Int32" FilterControlAltText="Filter Doctor ID column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Doctor Name" HeaderText="Doctor Name" SortExpression="Doctor Name" UniqueName="DoctorName" FilterControlAltText="Filter Doctor Name column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Specialty" HeaderText="Specialty" SortExpression="Specialty" UniqueName="Specialty" FilterControlAltText="Filter Specialty column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="HR Code" HeaderText="HR Code" SortExpression="HR Code" UniqueName="HRCode" DataType="System.Int32" FilterControlAltText="Filter HR Code column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Rep Name" HeaderText="Rep Name" SortExpression="Rep Name" UniqueName="RepName" FilterControlAltText="Filter Rep Name column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Supervisor Name" HeaderText="Supervisor Name" SortExpression="Supervisor Name" UniqueName="SupervisorName" FilterControlAltText="Filter Supervisor Name column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="No of Patients Value" HeaderText="No of Patients Value" SortExpression="No of Patients Value" UniqueName="NoofPatientsValue" DataType="System.Double" FilterControlAltText="Filter No of Patients Value column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Specialty Value" HeaderText="Specialty Value" SortExpression="Specialty Value" UniqueName="SpecialtyValue" DataType="System.Double" FilterControlAltText="Filter Specialty Value column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Prescription Habit" HeaderText="Prescription Habit" SortExpression="Prescription Habit" UniqueName="PrescriptionHabit" DataType="System.Double" FilterControlAltText="Filter Prescription Habit column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Total Value" HeaderText="Total Value" SortExpression="Total Value" UniqueName="TotalValue" DataType="System.Double" FilterControlAltText="Filter Total Value column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Class" HeaderText="Class" SortExpression="Class" UniqueName="Class" FilterControlAltText="Filter Class column"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="IsTargeted3" ReadOnly="True" HeaderText="Mandatory?" SortExpression="IsTargeted3" UniqueName="IsTargeted3" FilterControlAltText="Filter IsTargeted3 column"></telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="dsTargetList" runat="server"
        ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
        InsertCommand="InsertTargetedAffiliations" InsertCommandType="StoredProcedure"
        SelectCommand="rep_List_TargetedDoctors" SelectCommandType="StoredProcedure"
        DeleteCommand="Delete From TargetedAffiliations" DeleteCommandType="Text">
        <InsertParameters>
            <asp:Parameter Name="CycleID" Type="Int32"></asp:Parameter>
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>
