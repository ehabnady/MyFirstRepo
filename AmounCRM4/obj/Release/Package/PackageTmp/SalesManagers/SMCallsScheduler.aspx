<%@ Page Title="Planning" Language="C#" MasterPageFile="~/SalesManagers/SiteMaster2.Master" AutoEventWireup="true" CodeBehind="SMCallsScheduler.aspx.cs" 
    Inherits="AmounCRM4.SalesManagers.SMCallsScheduler" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        #Label1Panel {
            display: inline !important;
        }

        .lblError {
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
    <title>Plans</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true"></telerik:RadWindowManager>

    <div>
        <asp:Panel ID="searchPanel" runat="server" GroupingText="Calendar" Width="94%" BackColor="LightBlue" Font-Names="Times New Roman" Font-Size="Large"
            ForeColor="Blue">

            <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1">
                <AjaxSettings>
                    <telerik:AjaxSetting AjaxControlID="RadScheduler1">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="RadScheduler1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                </AjaxSettings>

                <AjaxSettings>
                    <telerik:AjaxSetting AjaxControlID="cbBricks">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="cbAffs"></telerik:AjaxUpdatedControl>
                            <%--LoadingPanelID="RadAjaxLoadingPanel4"--%>
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                </AjaxSettings>
            </telerik:RadAjaxManager>
            <%--<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel4" runat="server"></telerik:RadAjaxLoadingPanel>--%>
            <%--<telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" HorizontalAlign="NotSet">
                        </telerik:RadAjaxPanel>--%>

            <table width="94%">
                <tr>
                    <td>District Manager</td>
                    <td>
                        <telerik:RadComboBox ID="cbDMs" runat="server" DataSourceID="dsDMs" DataTextField="EmployeeFullName" DataValueField="EmployeeID"
                            Skin="WebBlue" AutoPostBack="true" AppendDataBoundItems="true" OnSelectedIndexChanged="cbDMs_SelectedIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem Text="District Managers" Value="0" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>

                    <td>Rep Name:</td>
                    <td>
                        <telerik:RadComboBox ID="cbReps" runat="server" DataSourceID="dsReps" DataTextField="EmployeeFullName" DataValueField="EmployeeID"
                            Skin="WebBlue" AutoPostBack="true" AppendDataBoundItems="true" OnSelectedIndexChanged="cbReps_SelectedIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem Text="Reps" Value="0" />
                            </Items>
                        </telerik:RadComboBox>
                         <%--AutoPostBack="true" OnSelectedIndexChanged="cbBricks_SelectedIndexChanged" Width="300"--%>
                    </td>

                    <td>Brick:</td>
                    <td>
                        <telerik:RadComboBox ID="cbBricks" runat="server" DataSourceID="dsBricks" DataTextField="AmounBrickName" DataValueField="AmounBrickID"
                            Skin="WebBlue" Width="300" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem Text="Bricks" Value="0" />
                            </Items>
                        </telerik:RadComboBox>
                        <%--OnSelectedIndexChanged="cbBricks_SelectedIndexChanged"      AutoPostBack="true"     --%>
                    </td>

                    <td>Doctor:</td>
                    <td>
                        <telerik:RadComboBox ID="cbAffs" runat="server" Skin="WebBlue" Width="300" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem Text="Doctors" Value="0" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                </tr>

                <tr>
                    <td colspan="8" align="right">
                        <telerik:RadButton ID="btnGetDoctors" runat="server" Text="Get Doctors" OnClick="btnGetDoctors_Click" Height="30px" BackColor="White"
                            Font-Names="Times New Roman" Font-Size="Medium" ForeColor="#0000CC" Visible="true">
                        </telerik:RadButton>
                        <telerik:RadButton ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" Height="30px" BackColor="White"
                            Font-Names="Times New Roman" Font-Size="Medium" ForeColor="#0000CC" Visible="true">
                        </telerik:RadButton>
                    </td>
                </tr>
            </table>

            <asp:SqlDataSource ID="dsDMs" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
                SelectCommand="SELECT DISTINCT [EmployeeID], [EmployeeFullName] FROM [View_Employees] WHERE ([DirectManagerID] = @EmployeeID) ORDER BY [EmployeeFullName]">
                <SelectParameters>
                    <asp:SessionParameter Name="EmployeeID" SessionField="EmployeeIDFromSM" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="dsReps" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
                SelectCommand="SELECT DISTINCT [EmployeeID], [EmployeeFullName] FROM [View_Employees] WHERE ([DirectManagerID] = @DMID) ORDER BY [EmployeeFullName]">
                <SelectParameters>
                    <%--<asp:SessionParameter Name="EmployeeID" SessionField="EmployeeIDFromSM" Type="Int32" />--%>
                    <asp:ControlParameter ControlID="cbDMs" PropertyName="SelectedValue" Name="DMID" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="dsBricks" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
                SelectCommand="SELECT [AmounBrickID], [AmounBrickName], [RepAreaID] FROM [View_EmployeesBricks] WHERE ([EmployeeID] = @EmployeeID) ORDER BY [AmounBrickName]">
                <SelectParameters>
                    <%--<asp:SessionParameter Name="EmployeeID" SessionField="EmployeeIDFromDM" Type="Int32" />--%>
                    <asp:ControlParameter ControlID="cbReps" PropertyName="SelectedValue" Name="EmployeeID" />
                </SelectParameters>
            </asp:SqlDataSource>
            
            <asp:SqlDataSource ID="dsAffsOut" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                SelectCommand="SELECT Distinct AffiliationID, AffiliationName2, PhysicianClass, SpecialtyID FROM View_Affiliations_Scheduler WHERE (EmployeeID = @EmployeeID) AND (BrickID = @BrickID) AND (PhysicianClass IN (@PhysicianClass)) AND (SpecialtyID = @SpecialtyID) ORDER BY AffiliationName2 Desc">
                <SelectParameters>
                    <asp:ControlParameter Name="EmployeeID" ControlID="cbReps" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter Name="BrickID" ControlID="cbBricks" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </asp:Panel>

    </div>
    <br />
    <div>

        <asp:Label ID="Label1" runat="server" BackColor="White" ForeColor="Red"></asp:Label><br />
        <br />
        <br />

        <%--<telerik:RadAjaxManager runat="server" ID="RadAjaxManager1">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="RadScheduler1">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadScheduler1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>--%>


        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>
        <telerik:RadAjaxPanel ID="RAP1" runat="server" HorizontalAlign="NotSet">
            <%-- OR ([RecurrenceRule] <> '') OR ([RecurrenceParentID] IS NOT NULL)--%>
            <asp:SqlDataSource ID="appointmentsDS" runat="server" OnSelecting="appointmentsDS_Selecting" OnSelected="appointmentsDS_Selected"
                ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                SelectCommand="SELECT AppointmentID, Subject, Description, StartDate, EndDate, AffiliationID, RecurrenceRule, RecurrenceParentID, Reminder, Annotations, DeletedAppointment FROM Appointments WHERE ((DeletedAppointment IS NULL OR DeletedAppointment = 0)) AND (EmployeeID IN (@EmployeeID)) AND ([StartDate] < @RangeEnd AND [EndDate] > @RangeStart)"
                InsertCommand="INSERT INTO [Appointments] ([Subject], [StartDate], [EndDate], [AffiliationID], 
                    [RecurrenceRule], [RecurrenceParentID], [Annotations], [Description], 
                    [Reminder], [LastModified], [EmployeeID], [LineID], [BrickID], [CycleID]) 
                VALUES (@Subject, @StartDate, @EndDate, @AffiliationID, @RecurrenceRule, @RecurrenceParentID, 
                    @Annotations, @Description, @Reminder, @LastModified, @EmployeeID, @LineID, @BrickID, @CycleID)"
                UpdateCommand="UPDATE [Appointments] SET [Subject] = @Subject, [StartDate] = @StartDate, [EndDate] = @EndDate, 
                [AffiliationID] = @AffiliationID, [RecurrenceRule] = @RecurrenceRule, 
                [RecurrenceParentID] = @RecurrenceParentID, [Annotations] = @Annotations, [Description] = @Description, 
                [Reminder] = @Reminder, [LastModified] = @LastModified WHERE [AppointmentID] = @AppointmentID"
                DeleteCommand="UPDATE [Appointments] SET DeletedAppointment = 1 WHERE [AppointmentID] = @AppointmentID">
                <DeleteParameters>
                    <asp:Parameter Name="AppointmentID" Type="Int32"></asp:Parameter>
                </DeleteParameters>
                <SelectParameters>
                    <asp:ControlParameter Name="EmployeeID" ControlID="cbReps" PropertyName="SelectedValue" Type="Int32" />
                    <asp:Parameter Name="RangeStart" Type="DateTime" DefaultValue="01/01/2016"></asp:Parameter>
                    <asp:Parameter Name="RangeEnd" Type="DateTime" DefaultValue="01/01/2016"></asp:Parameter>
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
                    <asp:Parameter Name="BrickID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="CycleID" Type="Int32"></asp:Parameter>
                </InsertParameters>
            </asp:SqlDataSource>


            <telerik:RadScheduler ID="RadScheduler1" runat="server" Skin="Outlook" Font-Size="Small" ExportSettings-OpenInNewWindow="true"
                AllowInsert="false" AllowEdit="false" AllowDelete="false"
                Style="margin-right: 4px; width: auto; height: auto" LastDayOfWeek="Wednesday" FirstDayOfWeek="Saturday"
                StartInsertingInAdvancedForm="false" DataDescriptionField="Description" DataEndField="EndDate"
                DataKeyField="AppointmentID" DataRecurrenceField="RecurrenceRule"
                DataRecurrenceParentKeyField="RecurrenceParentID" DataReminderField="Reminder"
                DataSourceID="appointmentsDS" DataStartField="StartDate" DataSubjectField="Subject"
                CustomAttributeNames="Annotations,LastModified" AdvancedForm-EnableCustomAttributeEditing="false"
                OnAppointmentCreated="RadScheduler1_AppointmentCreated"
                OnAppointmentDataBound="RadScheduler1_AppointmentDataBound"
                OnAppointmentInsert="RadScheduler1_AppointmentInsert"
                OnAppointmentUpdate="RadScheduler1_AppointmentUpdate"
                OnAppointmentDelete="RadScheduler1_AppointmentDelete"
                OnAppointmentContextMenuItemClicked="RadScheduler1_AppointmentContextMenuItemClicked"
                OnFormCreated="RadScheduler1_FormCreated"
                OnFormCreating="RadScheduler1_FormCreating" OnTimeSlotCreated="RadScheduler1_TimeSlotCreated"
                DayEndTime="20:00:00" EnableCustomAttributeEditing="True" SelectedView="MonthView">
                <ExportSettings>
                    <Pdf PaperOrientation="Landscape" AllowPrinting="true" PaperSize="A4" Title="Scheduler Title" Subject="Scheduler Subject" PageTitle="Page Title"></Pdf>
                </ExportSettings>
                <AdvancedForm />
                
                <MonthView VisibleAppointmentsPerDay="250" UserSelectable="true" />
                <WeekView DayEndTime="17:00:00" UserSelectable="false" />
                <DayView DayEndTime="17:00:00" HeaderDateFormat="(ddd) dd-MMM-yyyy" UserSelectable="false" />
                <MultiDayView DayEndTime="17:00:00" UserSelectable="false" />
                <AgendaView UserSelectable="false" />
                <TimelineView UserSelectable="false" />

                <AppointmentTemplate>
                    <div style="width: auto;">
                        <p style="font-style: italic; text-align:right">
                            <%# Eval("Subject") %>
                        </p>
                    </div>
                </AppointmentTemplate>
                <AppointmentContextMenuSettings EnableDefault="false" />
                <AppointmentContextMenus>
                    <telerik:RadSchedulerContextMenu ID="cm1" runat="server">
                        <Items>
                            <telerik:RadMenuItem Text="Edit" Value="CommandEdit" Visible="false" />
                            <telerik:RadMenuItem Text="Delete" Value="CommandDelete" Visible="false" />
                            <telerik:RadMenuItem IsSeparator="true" Visible="false" />
                            <telerik:RadMenuItem Text="Create Call" Value="Create" Visible="false" />
                            <telerik:RadMenuItem Text="Edit Call" Value="EditCall" Visible="false" />
                            <telerik:RadMenuItem Text="Display Call" Value="DisplayCall" />
                        </Items>
                    </telerik:RadSchedulerContextMenu>
                </AppointmentContextMenus>

                <TimeSlotContextMenuSettings EnableDefault="True" />
                <AdvancedForm Modal="true" Enabled="true" />
            </telerik:RadScheduler>
        </telerik:RadAjaxPanel>
    </div>
</asp:Content>
