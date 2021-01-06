<%@ Page Title="Calls Scheduler" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="CallsScheduler.aspx.cs" Inherits="AmounCRM4.Reps.CallsScheduler" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        #Label1Panel {
            display: inline !important;
        }

        .hiddenButton{
            visibility:hidden;
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

        .Disabled
        {
            background: silver !important;   
            /*cursor: not-allowed;*/   
        }
        .Disabled.rsAptCreate   
        {   
            background: silver !important;   
        }  
        .rsSunCol 
        { 
            background: none !important;     
        } 

    </style>

    <script language="javascript" type="text/jscript">

        function pageLoad() {
            <%--var Scheduler = $find("<%= RadScheduler1.ClientID %>");
            Scheduler.add_appointmentDataBound(ClientAppointmentDataBoundHandler);--%>
        }

        function confirm() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("You are trying to plan in a national vaccation day. Do you want to proceed?"))
            {
                confirm_value.value = "Yes";
            }
            else
            {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
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

                    <telerik:AjaxSetting AjaxControlID="cbClass">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="cbAffs"></telerik:AjaxUpdatedControl>
                            <%--LoadingPanelID="RadAjaxLoadingPanel4"--%>
                        </UpdatedControls>
                    </telerik:AjaxSetting>

                    <telerik:AjaxSetting AjaxControlID="cbSpec">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="cbAffs"></telerik:AjaxUpdatedControl>
                            <%--LoadingPanelID="RadAjaxLoadingPanel4"--%>
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                </AjaxSettings>

                <AjaxSettings>
                    <telerik:AjaxSetting AjaxControlID="RadDateTimePicker1">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="RadDateTimePicker1" LoadingPanelID="RadAjaxLoadingPanel3" />
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                </AjaxSettings>

                <%--<AjaxSettings>
                                <telerik:AjaxSetting AjaxControlID="cbAffs">
                                    <UpdatedControls>
                                        <telerik:AjaxUpdatedControl ControlID="cbAffs" LoadingPanelID="RadAjaxLoadingPanel4"></telerik:AjaxUpdatedControl>
                                    </UpdatedControls>
                                </telerik:AjaxSetting>
                            </AjaxSettings>--%>
            </telerik:RadAjaxManager>
            <%--<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel4" runat="server"></telerik:RadAjaxLoadingPanel>--%>
            <%--<telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" HorizontalAlign="NotSet">
                        </telerik:RadAjaxPanel>--%>

            <table width="94%">
                <tr>
                    <td>Brick:</td>
                    <td>
                        <telerik:RadComboBox ID="cbBricks" runat="server" DataSourceID="dsBricks" DataTextField="AmounBrickName" DataValueField="AmounBrickID"
                            Skin="WebBlue" AutoPostBack="true" OnSelectedIndexChanged="cbBricks_SelectedIndexChanged" Width="300" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem Text="Bricks" Value="0" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td>Class:</td>
                    <td>
                        <telerik:RadComboBox ID="cbClass" runat="server" Skin="WebBlue" AutoPostBack="true" OnSelectedIndexChanged="cbBricks_SelectedIndexChanged" Width="300">
                            <Items>
                                <telerik:RadComboBoxItem Text="Class" Value="0" Selected="true" />
                                <telerik:RadComboBoxItem Text="A+" Value="A+" />
                                <telerik:RadComboBoxItem Text="A" Value="A" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td>Specialty:</td>
                    <td>
                        <telerik:RadComboBox ID="cbSpec" runat="server" Skin="WebBlue" AutoPostBack="true" OnSelectedIndexChanged="cbBricks_SelectedIndexChanged" Width="300"
                            DataSourceID="dsSpecs" DataTextField="SpecialityCode" DataValueField="SpecialtyID" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem Text="Specialty" Value="0" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td>Doctor:</td>
                    <td>
                        <telerik:RadComboBox ID="cbAffs" runat="server" Skin="WebBlue" Width="300"></telerik:RadComboBox>
                    </td>
                    <td>Visit Date:</td>
                    <td>
                        <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" HorizontalAlign="NotSet">
                            <%--<telerik:RadDateTimePicker ID="radDate1" runat="server" Enabled="true"
                                            Width="300" OnSelectedDateChanged="radDate1_SelectedDateChanged" EnableViewState="true" ViewStateMode="Enabled">
                                        </telerik:RadDateTimePicker>--%>
                            <telerik:RadDatePicker ID="RadDateTimePicker1" runat="server" Enabled="true" AutoPostBack="true"
                                Width="300" OnSelectedDateChanged="radDate1_SelectedDateChanged" EnableViewState="true" ViewStateMode="Enabled">
                                <Calendar runat="server" FirstDayOfWeek="Saturday">
                                    <SpecialDays>
                                        <%--<telerik:RadCalendarDay Date="07/06/2017" IsWeekend="true" IsSelectable="false" IsDisabled="true" Repeatable="Week">
                                        </telerik:RadCalendarDay>--%>
                                        <telerik:RadCalendarDay Date="07/07/2017" IsWeekend="true" IsSelectable="false" IsDisabled="true" Repeatable="Week">                                            
                                        </telerik:RadCalendarDay>
                                    </SpecialDays>
                                </Calendar>
                            </telerik:RadDatePicker>

                            <telerik:RadDatePicker ID="RadDateTimePicker2" runat="server" Enabled="true" Width="300" AutoPostBack="true"
                                EnableViewState="true" ViewStateMode="Enabled" OnSelectedDateChanged="RadDateTimePicker2_SelectedDateChanged">
                                <Calendar runat="server" FirstDayOfWeek="Saturday">
                                    <SpecialDays>
                                        <%--<telerik:RadCalendarDay Date="07/06/2017" IsWeekend="true" IsSelectable="false" IsDisabled="true" Repeatable="Week">
                                        </telerik:RadCalendarDay>--%>
                                        <telerik:RadCalendarDay Date="07/07/2017" IsWeekend="true" IsSelectable="false" IsDisabled="true" Repeatable="Week">
                                        </telerik:RadCalendarDay>
                                    </SpecialDays>                                    
                                </Calendar>
                            </telerik:RadDatePicker>
                        </telerik:RadAjaxPanel>
                    </td>
                    <td colspan="2">
                        <telerik:RadButton ID="btnSearch" runat="server" Text="Search & Refresh" OnClick="btnSearch_Click" Height="30px" BackColor="White"
                            Font-Names="Times New Roman" Font-Size="Medium" ForeColor="#0000CC" Visible="true">
                        </telerik:RadButton>
                        <telerik:RadButton ID="btnNew" runat="server" Text="Create New Appointment" Height="30px" BackColor="White"
                            Font-Names="Times New Roman" Font-Size="Medium" ForeColor="#0000CC" Visible="true" OnClick="btnNew_Click">
                        </telerik:RadButton>
                        <telerik:RadButton ID="btnCopy" runat="server" Text="Copy Day" Height="30px" BackColor="White"
                            Font-Names="Times New Roman" Font-Size="Medium" ForeColor="#0000CC" Visible="false" OnClick="btnCopy_Click">
                        </telerik:RadButton>
                    </td>
                </tr>
            </table>

            <asp:SqlDataSource ID="dsBricks" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>" 
                SelectCommand="SELECT [AmounBrickID], [AmounBrickName], [RepAreaID] FROM [View_EmployeesBricks] WHERE ([EmployeeID] = @EmployeeID) ORDER BY [AmounBrickName]">
                <SelectParameters>
                    <asp:SessionParameter Name="EmployeeID" SessionField="EmployeeID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="dsSpecs" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                SelectCommand="SELECT SpecialtyID, SpecialityCode, LineID FROM View_SpecValByLine WHERE LineID = @LineID AND SpecValue > 0 order by SpecValue DESC, SpecialityCode ASC">
                <SelectParameters>
                    <asp:SessionParameter Name="LineID" SessionField="LineID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="dsAffsOut" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                SelectCommand="SELECT Distinct AffiliationID, AffiliationName2, PhysicianClass, SpecialtyID FROM View_Affiliations_Scheduler WHERE (BrickID = @BrickID) AND (PhysicianClass IN (@PhysicianClass)) AND (SpecialtyID = @SpecialtyID) ORDER BY AffiliationName2 Desc"
                >
                <SelectParameters>
                    <asp:ControlParameter Name="BrickID" ControlID="cbBricks" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter Name="PhysicianClass" ControlID="cbClass" PropertyName="SelectedValue" Type="String" />
                    <asp:ControlParameter Name="SpecialtyID" ControlID="cbSpec" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <%--<asp:TextBox ID="txtAffID" runat="server" MaxLength="6" Visible="false"></asp:TextBox>--%>









            <asp:SqlDataSource ID="dsFastNew" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                DeleteCommand="DELETE FROM [Appointments] WHERE [AppointmentID] = @AppointmentID"
                InsertCommand="INSERT INTO [Appointments] ([Subject], [Description], [StartDate], [EndDate], [RecurrenceRule], [RecurrenceParentID], [Reminder], [Annotations], [LastModified], [EmployeeID], [LineID], [BrickID], [CycleID], [AffiliationID], [IsOriginal]) VALUES (@Subject, @Description, @StartDate, @EndDate, @RecurrenceRule, @RecurrenceParentID, @Reminder, @Annotations, @LastModified, @EmployeeID, @LineID, @BrickID, @CycleID, @AffiliationID, @IsOriginal)"
                SelectCommand="SELECT [Subject], [Description], [StartDate], [EndDate], [EntityID], [PhysicianID], [RecurrenceRule], [RecurrenceParentID], [Reminder], [Annotations], [LastModified], [EmployeeID], [LineID], [BrickID], [CycleID], [AffiliationID], [IsOriginal], [AppointmentID] FROM [Appointments]"
                UpdateCommand="UPDATE [Appointments] SET [Subject] = @Subject, [Description] = @Description, [StartDate] = @StartDate, [EndDate] = @EndDate, [EntityID] = @EntityID, [PhysicianID] = @PhysicianID, [RecurrenceRule] = @RecurrenceRule, [RecurrenceParentID] = @RecurrenceParentID, [Reminder] = @Reminder, [Annotations] = @Annotations, [LastModified] = @LastModified, [EmployeeID] = @EmployeeID, [LineID] = @LineID, [BrickID] = @BrickID, [CycleID] = @CycleID, [AffiliationID] = @AffiliationID, [IsOriginal] = @IsOriginal WHERE [AppointmentID] = @AppointmentID">
                <DeleteParameters>
                    <asp:Parameter Name="AppointmentID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Subject" Type="String" />
                    <asp:Parameter Name="Description" Type="String" />
                    <asp:Parameter Name="StartDate" Type="DateTime" />
                    <asp:Parameter Name="EndDate" Type="DateTime" />
                    <%--                    <asp:Parameter Name="EntityID" Type="Int32" />
                    <asp:Parameter Name="PhysicianID" Type="Int32" />--%>
                    <asp:Parameter Name="RecurrenceRule" Type="String" />
                    <asp:Parameter Name="RecurrenceParentID" Type="Int32" />
                    <asp:Parameter Name="Reminder" Type="String" />
                    <asp:Parameter Name="Annotations" Type="String" />
                    <asp:Parameter Name="LastModified" Type="String" />
                    <asp:Parameter Name="EmployeeID" Type="Int32" />
                    <asp:Parameter Name="LineID" Type="Int32" />
                    <asp:Parameter Name="BrickID" Type="Int32" />
                    <asp:Parameter Name="CycleID" Type="Int32" />
                    <asp:Parameter Name="AffiliationID" Type="Int32" />
                    <asp:Parameter Name="IsOriginal" Type="Boolean" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Subject" Type="String" />
                    <asp:Parameter Name="Description" Type="String" />
                    <asp:Parameter Name="StartDate" Type="DateTime" />
                    <asp:Parameter Name="EndDate" Type="DateTime" />
                    <%--<asp:Parameter Name="EntityID" Type="Int32" />
                    <asp:Parameter Name="PhysicianID" Type="Int32" />--%>
                    <asp:Parameter Name="RecurrenceRule" Type="String" />
                    <asp:Parameter Name="RecurrenceParentID" Type="Int32" />
                    <asp:Parameter Name="Reminder" Type="String" />
                    <asp:Parameter Name="Annotations" Type="String" />
                    <asp:Parameter Name="LastModified" Type="String" />
                    <asp:Parameter Name="EmployeeID" Type="Int32" />
                    <asp:Parameter Name="LineID" Type="Int32" />
                    <asp:Parameter Name="BrickID" Type="Int32" />
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
                SelectCommand="SELECT AppointmentID, Subject, Description, StartDate, EndDate, AffiliationID, RecurrenceRule, RecurrenceParentID, Reminder, Annotations, DeletedAppointment FROM Appointments WHERE ((DeletedAppointment IS NULL OR DeletedAppointment = 0)) AND (EmployeeID = @EmployeeID) AND ([StartDate] < @RangeEnd AND [EndDate] > @RangeStart)"
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
                    <asp:SessionParameter Name="EmployeeID" SessionField="EmployeeID" Type="Int32" />
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

            <asp:SqlDataSource ID="affDS" runat="server" ConnectionString="<%$ ConnectionStrings:AmounCrmConnectionString %>"
                SelectCommand="SELECT [AffiliationID], [AffiliationName] FROM [View_Affiliations_Admin] WHERE ([PhysicianClass] <> 'C') AND ([EmployeeID] = @EmployeeID) Order By [AffiliationName]">
                <SelectParameters>
                    <asp:SessionParameter Name="EmployeeID" SessionField="EmployeeID" Type="Int32" />
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

            <telerik:RadScheduler ID="RadScheduler1" runat="server" Skin="Outlook" Font-Size="Small" ExportSettings-OpenInNewWindow="true"
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
                OnAppointmentDelete="RadScheduler1_AppointmentDelete"
                OnAppointmentContextMenuItemClicked="RadScheduler1_AppointmentContextMenuItemClicked"
                OnFormCreated="RadScheduler1_FormCreated"
                OnFormCreating="RadScheduler1_FormCreating"
                DayEndTime="20:00:00" EnableCustomAttributeEditing="True" SelectedView="MonthView"
                OnTimeSlotCreated="RadScheduler1_TimeSlotCreated"
                >
                <ExportSettings>
                    <Pdf PaperOrientation="Landscape" AllowPrinting="true" PaperSize="A4" Title="Scheduler Title" Subject="Scheduler Subject" PageTitle="Page Title"></Pdf>
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
                    <div style="width: auto">
                        <p style="font-style: italic;">
                            <%# Eval("Subject") %>
                            <!--+ " - " + <%# Eval("Annotations") %> + " - " + <%# Eval("Description") %>-->
                        </p>
                    </div>
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

                <TimeSlotContextMenuSettings EnableDefault="false" />
                <AdvancedForm Modal="true" Enabled="true" />
            </telerik:RadScheduler>
        </telerik:RadAjaxPanel>
    </div>
</asp:Content>
