<%@ Page Title="Calss Scheduler" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="CallsSchedulerFromAdmin.aspx.cs"
    Inherits="AmounCRM4.Reps.CallsSchedulerFromAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        #Label1Panel
        {
            display: inline !important;
        }

        .lblError
        {
            border: 1px solid darkred;
            background-color: black;
            color: white;
            font: bold 16px "Segoe UI", Arial, sans-serif;
            vertical-align: middle;
            height: 30px;
            line-height: 28px;
            position: absolute;
            padding-left: 5px;
            width: 743px;
            z-index: 1001;
            cursor: pointer;
        }
    </style>

    <script language="javascript" type="text/jscript">

        function pageLoad() {
            var Scheduler = $find("<%= RadScheduler1.ClientID %>");
            Scheduler.add_appointmentDataBound(ClientAppointmentDataBoundHandler);
        }

        function ClientAppointmentDataBoundHandler(sender, e) {

            //var apt = e.get_appointment().findByID(1);
            //if (apt.getAttribute("Annotations") == "Appointment") {
            //    apt.set_foreColor("white");
            //    apt.set_backColor("red");
            //}

            //string timestamp = e.Appointment.Attributes["LastModified"];
            //if (string.IsNullOrEmpty(timestamp))
            //{
            //    timestamp = "Never";
            //}

            //// Set the appointment's tooltip to show when the appointment was last modified.
            //e.Appointment.ToolTip = "Last modified on: " + timestamp;

            //e.Appointment.BackColor = Color.White;
            ////Conditional Coloring Based On Appointment Case
            //if (e.Appointment.Attributes["Annotations"] == "Appointment")
            //{
            //    e.Appointment.ForeColor = Color.White;
            //    e.Appointment.BackColor = Color.Red;
            //}
            //if (e.Appointment.Attributes["Annotations"] == "Created")
            //{
            //    e.Appointment.ForeColor = Color.Black;
            //    e.Appointment.BackColor = Color.Yellow;
            //}
            //if (e.Appointment.Attributes["Annotations"] == "Final Save")
            //{
            //    e.Appointment.ForeColor = Color.White;
            //    e.Appointment.BackColor = Color.Green;
            //}

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">

    <div>
        <asp:Panel ID="searchPanel" runat="server" GroupingText="Search Calls" Width="94%" BackColor="LightBlue" Font-Names="Times New Roman" Font-Size="Large" ForeColor="Blue">
            <table width="94%">
                <tr>
                    <td style="width: auto; font-family: 'Times New Roman'">Line:</td>
                    <td style="width: auto; font-family: 'Times New Roman'; text-align: left">
                        <asp:DropDownList ID="ddlLines" ViewStateMode="Enabled" runat="server" AutoPostBack="True" DataSourceID="dsLines"
                            DataTextField="LineName" DataValueField="LineID" EnableViewState="true" BackColor="White" Font-Names="Times New Roman"
                            Font-Size="Medium" ForeColor="#0000CC">
                            <%--<asp:ListItem Text="Promotional Lines" Value="0" Enabled="true" Selected="True" />--%>
                        </asp:DropDownList>
                    </td>
                    <td style="width: auto; font-family: 'Times New Roman'">Area Hierarchy:</td>
                    <td style="width: auto; font-family: 'Times New Roman'; text-align: left">
                        <asp:DropDownList ID="ddlManagers" ViewStateMode="Enabled" runat="server" AutoPostBack="True" DataSourceID="dsManagers"
                            DataTextField="ManagerName" DataValueField="ManagerID" EnableViewState="true" BackColor="White" Font-Names="Times New Roman"
                            Font-Size="Medium" ForeColor="#0000CC" OnSelectedIndexChanged="ddlManagers_SelectedIndexChanged">
                            <%--<asp:ListItem Text="Regional Managers" Value="0" Enabled="true" Selected="True" />--%>
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddlSupervisors" ViewStateMode="Enabled" runat="server" AutoPostBack="True" DataSourceID="dsSuper"
                            DataTextField="SupervisorName" DataValueField="SupervisorID" EnableViewState="true" BackColor="White" Font-Names="Times New Roman"
                            Font-Size="Medium" ForeColor="#0000CC">
                            <%--<asp:ListItem Text="Supervisors" Value="0" Enabled="true" Selected="True" />--%>
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddlReps" ViewStateMode="Enabled" runat="server" AutoPostBack="true" DataSourceID="dsReps"
                            DataTextField="EmployeeName" DataValueField="EmployeeID" EnableViewState="true" BackColor="White" Font-Names="Times New Roman"
                            Font-Size="Medium" ForeColor="#0000CC" OnSelectedIndexChanged="ddlReps_SelectedIndexChanged">
                            <%--<asp:ListItem Text="Representatives" Value="0" Enabled="true" Selected="True" />--%>
                        </asp:DropDownList>
                    </td>
                    <td style="width: auto; font-family: 'Times New Roman'; visibility:hidden"><asp:Label ID="lblCycle" runat="server" Text="Cycle:" Visible="false"></asp:Label></td>
                    <td style="width: auto; font-family: 'Times New Roman'; text-align: left; visibility:hidden">
                        <asp:DropDownList ID="ddlCycles" ViewStateMode="Enabled" runat="server" AutoPostBack="false" DataSourceID="dsCycles"
                            DataTextField="CycleDesc" DataValueField="CycleID" EnableViewState="true" BackColor="White" Font-Names="Times New Roman"
                            Font-Size="Medium" ForeColor="#0000CC" Visible="false">
                            <%--<asp:ListItem Text="Cycles" Value="0"  Enabled="true" Selected="True" />--%>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>Affiliation:</td>
                    <td colspan="2" align="left"><asp:TextBox ID="txtAffID" runat="server" MaxLength="6"></asp:TextBox>
                        <telerik:RadButton ID="btnSearch" runat="server" Text="Refresh & Reload" OnClick="btnSearch_Click" Height="30px" BackColor="White" 
                            Font-Names="Times New Roman" Font-Size="Medium" ForeColor="#0000CC" Visible="true"></telerik:RadButton>
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtCycleID" runat="server" MaxLength="2"></asp:TextBox>
                        <telerik:RadButton ID="btnNew" runat="server" Text="New" Height="30px" BackColor="White" 
                            Font-Names="Times New Roman" Font-Size="Medium" ForeColor="#0000CC" Visible="true" OnClick="btnNew_Click"></telerik:RadButton>
                        
                    </td>
                </tr>
            </table>
            <asp:SqlDataSource ID="dsCycles" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                SelectCommand="SELECT DISTINCT [CycleID], [CycleDesc] FROM [Cycles] ORDER BY [CycleID]"></asp:SqlDataSource>

            <asp:SqlDataSource ID="dsLines" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                SelectCommand="SELECT DISTINCT [LineID], [LineName] FROM [PromotionalLines] WHERE [DELETED] = 0 ORDER BY [LineID]"></asp:SqlDataSource>

            <asp:SqlDataSource ID="dsManagers" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                SelectCommand="SELECT DISTINCT [ManagerID], [ManagerName] FROM [Employees] WHERE ([LineID] = @LineID) ORDER BY [ManagerName]">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlLines" Name="LineID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="dsSuper" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                SelectCommand="SELECT DISTINCT [SupervisorID], [SupervisorName] FROM [Employees] WHERE (([LineID] = @LineID) AND ([ManagerID] = @ManagerID) AND (DELETED IS NULL)) ORDER BY [SupervisorName]">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlLines" Name="LineID" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="ddlManagers" Name="ManagerID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="dsReps" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                SelectCommand="SELECT DISTINCT [EmployeeID], [EmployeeName] FROM [Employees] WHERE (([EmployeeType] = 'Rep') AND ([LineID] = @LineID) AND ([SupervisorID] = @SupervisorID) AND ([Deleted] IS NULL)) ORDER BY [EmployeeName]">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlLines" Name="LineID" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="ddlSupervisors" Name="SupervisorID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="dsFastNew" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" DeleteCommand="DELETE FROM [Appointments] WHERE [AppointmentID] = @AppointmentID" InsertCommand="INSERT INTO [Appointments] ([Subject], [Description], [StartDate], [EndDate], [EntityID], [PhysicianID], [RecurrenceRule], [RecurrenceParentID], [Reminder], [Annotations], [LastModified], [EmployeeID], [LineID], [AreaRecID], [CycleID], [AffiliationID], [IsOriginal]) VALUES (@Subject, @Description, @StartDate, @EndDate, @EntityID, @PhysicianID, @RecurrenceRule, @RecurrenceParentID, @Reminder, @Annotations, @LastModified, @EmployeeID, @LineID, @AreaRecID, @CycleID, @AffiliationID, @IsOriginal)" SelectCommand="SELECT [Subject], [Description], [StartDate], [EndDate], [EntityID], [PhysicianID], [RecurrenceRule], [RecurrenceParentID], [Reminder], [Annotations], [LastModified], [EmployeeID], [LineID], [AreaRecID], [CycleID], [AffiliationID], [IsOriginal], [AppointmentID] FROM [Appointments]" UpdateCommand="UPDATE [Appointments] SET [Subject] = @Subject, [Description] = @Description, [StartDate] = @StartDate, [EndDate] = @EndDate, [EntityID] = @EntityID, [PhysicianID] = @PhysicianID, [RecurrenceRule] = @RecurrenceRule, [RecurrenceParentID] = @RecurrenceParentID, [Reminder] = @Reminder, [Annotations] = @Annotations, [LastModified] = @LastModified, [EmployeeID] = @EmployeeID, [LineID] = @LineID, [AreaRecID] = @AreaRecID, [CycleID] = @CycleID, [AffiliationID] = @AffiliationID, [IsOriginal] = @IsOriginal WHERE [AppointmentID] = @AppointmentID">
                <DeleteParameters>
                    <asp:Parameter Name="AppointmentID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Subject" Type="String" />
                    <asp:Parameter Name="Description" Type="String" />
                    <asp:Parameter Name="StartDate" Type="DateTime" />
                    <asp:Parameter Name="EndDate" Type="DateTime" />
                    <asp:Parameter Name="EntityID" Type="Int32" />
                    <asp:Parameter Name="PhysicianID" Type="Int32" />
                    <asp:Parameter Name="RecurrenceRule" Type="String" />
                    <asp:Parameter Name="RecurrenceParentID" Type="Int32" />
                    <asp:Parameter Name="Reminder" Type="String" />
                    <asp:Parameter Name="Annotations" Type="String" />
                    <asp:Parameter Name="LastModified" Type="String" />
                    <asp:Parameter Name="EmployeeID" Type="Int32" />
                    <asp:Parameter Name="LineID" Type="Int32" />
                    <asp:Parameter Name="AreaRecID" Type="Int32" />
                    <asp:Parameter Name="CycleID" Type="Int32" />
                    <asp:Parameter Name="AffiliationID" Type="Int32" />
                    <asp:Parameter Name="IsOriginal" Type="Boolean" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Subject" Type="String" />
                    <asp:Parameter Name="Description" Type="String" />
                    <asp:Parameter Name="StartDate" Type="DateTime" />
                    <asp:Parameter Name="EndDate" Type="DateTime" />
                    <asp:Parameter Name="EntityID" Type="Int32" />
                    <asp:Parameter Name="PhysicianID" Type="Int32" />
                    <asp:Parameter Name="RecurrenceRule" Type="String" />
                    <asp:Parameter Name="RecurrenceParentID" Type="Int32" />
                    <asp:Parameter Name="Reminder" Type="String" />
                    <asp:Parameter Name="Annotations" Type="String" />
                    <asp:Parameter Name="LastModified" Type="String" />
                    <asp:Parameter Name="EmployeeID" Type="Int32" />
                    <asp:Parameter Name="LineID" Type="Int32" />
                    <asp:Parameter Name="AreaRecID" Type="Int32" />
                    <asp:Parameter Name="CycleID" Type="Int32" />
                    <asp:Parameter Name="AffiliationID" Type="Int32" />
                    <asp:Parameter Name="IsOriginal" Type="Boolean" />
                    <asp:Parameter Name="AppointmentID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </asp:Panel>

    </div>
    <br />
    <div>

        <asp:Label ID="Label1" runat="server" BackColor="White" ForeColor="Red"></asp:Label><br />
        <br />
        <br />

        <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="RadScheduler1">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadScheduler1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>
        <telerik:RadAjaxPanel ID="RAP1" runat="server" HorizontalAlign="NotSet">

            <asp:SqlDataSource ID="appointmentsDS" runat="server" OnSelecting="appointmentsDS_Selecting" OnSelected="appointmentsDS_Selected"
                ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                SelectCommand="SELECT AppointmentID, Subject, Description, StartDate, EndDate, AffiliationID, RecurrenceRule, RecurrenceParentID, Reminder, Annotations, DeletedAppointment FROM Appointments WHERE (DeletedAppointment Is NULL) AND (EmployeeID = @Param1) AND ([StartDate] < @RangeEnd AND [EndDate] > @RangeStart) OR ([RecurrenceRule] <> '') OR ([RecurrenceParentID] IS NOT NULL)"
                InsertCommand="INSERT INTO [Appointments] ([Subject], [StartDate], [EndDate], [AffiliationID], 
                    [RecurrenceRule], [RecurrenceParentID], [Annotations], [Description], 
                    [Reminder], [LastModified], [EmployeeID], [LineID], [AreaRecID], [CycleID]) 
                VALUES (@Subject, @StartDate, @EndDate, @AffiliationID, @RecurrenceRule, @RecurrenceParentID, 
                    @Annotations, @Description, @Reminder, @LastModified, @EmployeeID, @LineID, @AreaID, @CycleID)"
                UpdateCommand="UPDATE [Appointments] SET [Subject] = @Subject, [StartDate] = @StartDate, [EndDate] = @EndDate, 
                [AffiliationID] = @AffiliationID, [RecurrenceRule] = @RecurrenceRule, 
                [RecurrenceParentID] = @RecurrenceParentID, [Annotations] = @Annotations, [Description] = @Description, 
                [Reminder] = @Reminder, [LastModified] = @LastModified WHERE [AppointmentID] = @AppointmentID"
                DeleteCommand="UPDATE [Appointments] SET DeletedAppointment = 1 WHERE [AppointmentID] = @AppointmentID">
                <DeleteParameters>
                    <asp:Parameter Name="AppointmentID" Type="Int32"></asp:Parameter>
                </DeleteParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlReps" Name="Param1" PropertyName="SelectedValue" />
                    <asp:Parameter Name="RangeStart" Type="DateTime" DefaultValue="01/01/2015"></asp:Parameter>
                    <asp:Parameter Name="RangeEnd" Type="DateTime" DefaultValue="01/01/2015"></asp:Parameter>
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Subject" Type="String"></asp:Parameter>
                    <asp:Parameter Name="StartDate" Type="DateTime"></asp:Parameter>
                    <asp:Parameter Name="EndDate" Type="DateTime"></asp:Parameter>
                    <asp:Parameter Name="AffiliationID" Type="Int32"></asp:Parameter>
                    <%--                        <asp:Parameter Name="PhysicianID" Type="Int32"></asp:Parameter>
                        <asp:Parameter Name="EntityID" Type="Int32"></asp:Parameter>--%>
                    <asp:Parameter Name="RecurrenceRule" Type="String"></asp:Parameter>
                    <asp:Parameter Name="RecurrenceParentID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="Annotations" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Description" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Reminder" Type="String"></asp:Parameter>
                    <asp:Parameter Name="LastModified" Type="String"></asp:Parameter>
                    <asp:Parameter Name="AppointmentID" Type="Int32"></asp:Parameter>
                </UpdateParameters>
                <InsertParameters>
                    <asp:Parameter Name="Subject" Type="String"></asp:Parameter>
                    <asp:Parameter Name="StartDate" Type="DateTime"></asp:Parameter>
                    <asp:Parameter Name="EndDate" Type="DateTime"></asp:Parameter>
                    <asp:Parameter Name="AffiliationID" Type="Int32"></asp:Parameter>
                    <%--                        <asp:Parameter Name="PhysicianID" Type="Int32"></asp:Parameter>
                        <asp:Parameter Name="EntityID" Type="Int32"></asp:Parameter>--%>
                    <asp:Parameter Name="RecurrenceRule" Type="String"></asp:Parameter>
                    <asp:Parameter Name="RecurrenceParentID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="Annotations" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Description" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Reminder" Type="String"></asp:Parameter>
                    <asp:Parameter Name="LastModified" Type="String"></asp:Parameter>
                    <asp:Parameter Name="EmployeeID" Type="String"></asp:Parameter>
                    <asp:Parameter Name="LineID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="AreaID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="CycleID" Type="Int32"></asp:Parameter>
                </InsertParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="affDS" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                SelectCommand="SELECT [AffiliationID], [AffiliationName] FROM [Affiliations] WHERE ([AreaRecID] = @RepAreaIDFromAdmin)">
                <SelectParameters>
                    <asp:SessionParameter Name="RepAreaIDFromAdmin" SessionField="RepAreaIDFromAdmin" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

            <%--<asp:SqlDataSource ID="phDS" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                    SelectCommand="SELECT [PhysicianID], [PhysicianName] FROM [Physicians] WHERE ([AreaID] = @AreaID)">
                    <SelectParameters>
                        <asp:SessionParameter Name="AreaID" SessionField="AreaID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <asp:SqlDataSource ID="enDS" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                    SelectCommand="SELECT [EntityID], [EntityName] FROM [Entities] WHERE ([AreaID] = @AreaID)">
                    <SelectParameters>
                        <asp:SessionParameter Name="AreaID" SessionField="AreaID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>--%>

            <telerik:RadScheduler ID="RadScheduler1" runat="server" Skin="Outlook" Font-Size="Small"
                Style="margin-right: 4px; width: auto; height: auto" LastDayOfWeek="Thursday" FirstDayOfWeek="Saturday"
                StartInsertingInAdvancedForm="True" DataDescriptionField="Description" DataEndField="EndDate"
                DataKeyField="AppointmentID" DataRecurrenceField="RecurrenceRule"
                DataRecurrenceParentKeyField="RecurrenceParentID" DataReminderField="Reminder"
                DataSourceID="appointmentsDS" DataStartField="StartDate" DataSubjectField="Subject"
                CustomAttributeNames="Annotations,LastModified" AdvancedForm-EnableCustomAttributeEditing="false"
                OnAppointmentCreated="RadScheduler1_AppointmentCreated"
                OnAppointmentDataBound="RadScheduler1_AppointmentDataBound"
                OnAppointmentInsert="RadScheduler1_AppointmentInsert"
                OnAppointmentUpdate="RadScheduler1_AppointmentUpdate"
                OnAppointmentContextMenuItemClicked="RadScheduler1_AppointmentContextMenuItemClicked"
                OnFormCreated="RadScheduler1_FormCreated"
                OnFormCreating="RadScheduler1_FormCreating"
                DayEndTime="20:00:00" EnableCustomAttributeEditing="True" SelectedView="MonthView">
                <ExportSettings>
                    <Pdf PageTopMargin="1in" PageBottomMargin="1in" PageLeftMargin="1in" PageRightMargin="1in"></Pdf>
                </ExportSettings>
                <AdvancedForm />
                <ResourceTypes>
                    <telerik:ResourceType DataSourceID="affDS" ForeignKeyField="AffiliationID" KeyField="AffiliationID"
                        Name="Affiliation" TextField="AffiliationName" />
                    <%--<telerik:ResourceType DataSourceID="enDS" ForeignKeyField="EntityID" KeyField="EntityID" 
                            Name="Entity" TextField="EntityName" />
                        <telerik:ResourceType DataSourceID="phDS" ForeignKeyField="PhysicianID" KeyField="PhysicianID" 
                            Name="Physician" TextField="PhysicianName" />--%>
                </ResourceTypes>
                <MonthView VisibleAppointmentsPerDay="250" />
                <WeekView DayEndTime="17:00:00" />
                <DayView DayEndTime="17:00:00" HeaderDateFormat="(ddd) dd-MMM-yyyy" />
                <MultiDayView DayEndTime="17:00:00" />
                <AgendaView UserSelectable="True" />
                <AppointmentTemplate>
                    <p style="font-style: italic;">
                        <%# Eval("Subject") %>
                        <!--+ " - " + <%# Eval("Annotations") %> + " - " + <%# Eval("Description") %>-->
                    </p>
                </AppointmentTemplate>
                <AppointmentContextMenuSettings EnableDefault="false" />
                <AppointmentContextMenus>
                    <telerik:RadSchedulerContextMenu ID="cm1" runat="server">
                        <Items>
                            <telerik:RadMenuItem Text="Edit" Value="CommandEdit" />
                            <telerik:RadMenuItem Text="Delete" Value="CommandDelete" />
                            <telerik:RadMenuItem IsSeparator="true" />
                            <telerik:RadMenuItem Text="Create Call" Value="Create" />
                            <telerik:RadMenuItem Text="Edit Call" Value="EditCall" />
                            <telerik:RadMenuItem Text="Display Call" Value="DisplayCall" />
                        </Items>
                    </telerik:RadSchedulerContextMenu>
                </AppointmentContextMenus>
                
                <TimeSlotContextMenuSettings EnableDefault="True" />
                <AdvancedForm Width="300" Modal="true" Enabled="true" />
            </telerik:RadScheduler>
        </telerik:RadAjaxPanel>
    </div>
</asp:Content>
