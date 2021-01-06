<%@ Page Title="Plan with Multiple Selections" Language="C#" MasterPageFile="~/Site2.Master" AutoEventWireup="true" CodeBehind="CallsScheduler3.aspx.cs" Inherits="AmounCRM4.Reps.CallsScheduler3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        #Label1Panel {
            display: inline !important;
        }

        .hiddenButton {
            visibility: hidden;
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

        .Disabled {
            background: silver !important;
            /*cursor: not-allowed;*/
        }

            .Disabled.rsAptCreate {
                background: silver !important;
            }

        .rsSunCol {
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
            if (confirm("You are trying to plan in a national vaccation day. Do you want to proceed?")) {
                confirm_value.value = "Yes";
            }
            else {
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
        <asp:Panel ID="searchPanel" runat="server" GroupingText="Doctors Selection" Width="100%" BackColor="#4f5d75" Font-Names="Times New Roman"
            Font-Size="Large" ForeColor="White" HorizontalAlign="Center">

            <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1">
                <AjaxSettings>
                    <telerik:AjaxSetting AjaxControlID="RadScheduler1">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="RadScheduler1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                </AjaxSettings>
            </telerik:RadAjaxManager>

            <table width="100%">
                <tr style="width:100%">
                    <td colspan="6" align="center" style="width:100%">
                        <telerik:RadGrid ID="grd1" runat="server" AllowSorting="True" AllowFilteringByColumn="True" Skin="WebBlue" Width="100%" Height="500"
                            AllowMultiRowEdit="True" AllowMultiRowSelection="True" DataSourceID="dsAllAffs" AllowPaging="True" ShowGroupPanel="True">
                            <ExportSettings ExportOnlyData="True" IgnorePaging="True" OpenInNewWindow="True">
                                <Pdf PaperSize="A4"></Pdf>
                            </ExportSettings>
                            <ClientSettings AllowDragToGroup="True" AllowColumnsReorder="True" ReorderColumnsOnClient="True">
                                <Resizing AllowColumnResize="true" AllowResizeToFit="true" EnableRealTimeResize="true" EnableNextColumnResize="true"
                                    ResizeGridOnColumnResize="true" ShowRowIndicatorColumn="true" AllowRowResize="true" />
                                <Selecting AllowRowSelect="True"></Selecting>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
                            </ClientSettings>
                            <PagerStyle PageSizes="50,100,150,200" Mode="NextPrevNumericAndAdvanced" AlwaysVisible="true" />
                            <MasterTableView AllowMultiColumnSorting="True" EnableHeaderContextMenu="True" EnableHeaderContextAggregatesMenu="True"
                                EnableHeaderContextFilterMenu="True" AutoGenerateColumns="False" DataKeyNames="AffiliationID" DataSourceID="dsAllAffs">

                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="Select" UniqueName="SelectRow" AllowFiltering="false" AllowSorting="false" 
                                        HeaderStyle-Width="5%" ItemStyle-Width="5%" FooterStyle-Width="5%">
                                        <HeaderTemplate>
                                            <asp:CheckBox ID="chkAll" runat="server" OnCheckedChanged="chkAll_CheckedChanged" AutoPostBack="true" />
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkSelect" runat="server" />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="AffiliationID" HeaderText="ID" SortExpression="AffiliationID" UniqueName="AffiliationID" DataType="System.Int32" 
                                        FilterControlAltText="Filter AffiliationID column"
                                        HeaderStyle-Width="10%" ItemStyle-Width="10%" FooterStyle-Width="10%"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AffiliationName3" HeaderText="Doctor's Data" SortExpression="AffiliationName3" UniqueName="AffiliationName3" FilterControlAltText="Filter AffiliationName3 column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SpecialityCode" HeaderText="Specialty" SortExpression="SpecialityCode" UniqueName="SpecialityCode" FilterControlAltText="Filter SpecialityCode column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="BrickID" HeaderText="Brick" SortExpression="BrickID" UniqueName="BrickID" DataType="System.Int32" 
                                        FilterControlAltText="Filter BrickID column" ShowFilterIcon="true"
                                        HeaderStyle-Width="10%" ItemStyle-Width="10%" FooterStyle-Width="10%"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AmounBrickName" HeaderText="Brick Name" SortExpression="AmounBrickName" UniqueName="AmounBrickName" DataType="System.String" FilterControlAltText="Filter AmounBrickName column"></telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn HeaderText="First Visit" UniqueName="PlannedDate" DataType="System.DateTime" AllowFiltering="false" AllowSorting="false">
                                        <ItemTemplate>
                                            <telerik:RadDatePicker ID="picVisitDate" runat="server" Culture="en-US" Width="90%"
                                                Skin="WebBlue"
                                                FocusedDate='<%# System.DateTime.Today %>'
                                                MinDate='<%# DateTime.Parse(Session["StartDate"].ToString()) %>'
                                                MaxDate='<%# DateTime.Parse(Session["EndDate"].ToString()) %>'>
                                                <Calendar ID="calVisitDate" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="true"
                                                    EnableMonthYearFastNavigation="False" FastNavigationNextText="&amp;lt;&amp;lt;" FirstDayOfWeek="Saturday">
                                                    <SpecialDays>
                                                        <telerik:RadCalendarDay Date="07/07/2017" IsWeekend="true" IsSelectable="false" IsDisabled="true" Repeatable="Week">
                                                        </telerik:RadCalendarDay>
                                                    </SpecialDays>
                                                    <DisabledDayStyle BackColor="LightGray" />
                                                </Calendar>
                                            </telerik:RadDatePicker>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Second Visit" UniqueName="PlannedDate2" DataType="System.DateTime" AllowFiltering="false" AllowSorting="false">
                                        <ItemTemplate>
                                            <telerik:RadDatePicker ID="picVisitDate2" runat="server" Culture="en-US" Width="90%"
                                                Skin="WebBlue"
                                                FocusedDate='<%# System.DateTime.Today %>'
                                                MinDate='<%# DateTime.Parse(Session["StartDate"].ToString()) %>'
                                                MaxDate='<%# DateTime.Parse(Session["EndDate"].ToString()) %>'>
                                                <Calendar ID="calVisitDate" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="true"
                                                    EnableMonthYearFastNavigation="False" FastNavigationNextText="&amp;lt;&amp;lt;" FirstDayOfWeek="Saturday">
                                                    <SpecialDays>
                                                        <telerik:RadCalendarDay Date="07/07/2017" IsWeekend="true" IsSelectable="false" IsDisabled="true" Repeatable="Week">
                                                        </telerik:RadCalendarDay>
                                                    </SpecialDays>
                                                    <DisabledDayStyle BackColor="LightGray" />
                                                </Calendar>
                                            </telerik:RadDatePicker>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>


                                    <telerik:GridBoundColumn DataField="PhysicianClass" Visible="false" HeaderText="Ph. Class" SortExpression="PhysicianClass" UniqueName="PhysicianClass" FilterControlAltText="Filter PhysicianClass column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SpecialtyID" Visible="false" HeaderText="SpecialtyID" SortExpression="SpecialtyID" UniqueName="SpecialtyID" DataType="System.Int32" FilterControlAltText="Filter SpecialtyID column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AffiliationName2" Visible="false" HeaderText="AffiliationName2" SortExpression="AffiliationName2" UniqueName="AffiliationName2" FilterControlAltText="Filter AffiliationName2 column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SpecialtyValue" Visible="false" HeaderText="SpecialtyValue" SortExpression="SpecialtyValue" UniqueName="SpecialtyValue" DataType="System.Double" FilterControlAltText="Filter SpecialtyValue column"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TotalValue" Visible="false" HeaderText="TotalValue" SortExpression="TotalValue" UniqueName="TotalValue" DataType="System.Double" FilterControlAltText="Filter TotalValue column"></telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource runat="server" ID="dsAllAffs" ConnectionString='<%$ ConnectionStrings:AmounCrmConnectionString %>'
                            SelectCommand="SELECT DISTINCT AffiliationID, SpecialtyID, AffiliationName2, AffiliationName3, PhysicianClass, SpecialtyValue, TotalValue, BrickID, SpecialityCode, AmounBrickName FROM View_Affiliations_Scheduler WHERE (PhysicianClass IN ('A+', 'A')) AND (SpecialtyValue > 0) AND (LastModifierID IS NOT NULL) AND (EmployeeID = @EmployeeID) AND (LineID = @LineID) ORDER BY TotalValue DESC, SpecialtyValue DESC">
                            <SelectParameters>
                                <asp:SessionParameter SessionField="EmployeeID" Name="EmployeeID"></asp:SessionParameter>
                                <asp:SessionParameter SessionField="LineID" Name="LineID"></asp:SessionParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <br />

                        <div>
                            <table>
                                <tr>
                                    <td style="text-align:right">
                                        First Visit:
                                        <telerik:RadDatePicker ID="dtVisit1" runat="server" Culture="en-US" Width="90%" 
                                            OnSelectedDateChanged="dtVisit1_SelectedDateChanged" AutoPostBack="true"
                                            Skin="WebBlue"
                                            FocusedDate='<%# System.DateTime.Today %>'
                                            MinDate='<%# DateTime.Parse(Session["StartDate"].ToString()) %>'
                                            MaxDate='<%# DateTime.Parse(Session["EndDate"].ToString()) %>'>
                                            <Calendar ID="calVisitDate" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="true"
                                                EnableMonthYearFastNavigation="False" FastNavigationNextText="&amp;lt;&amp;lt;" FirstDayOfWeek="Saturday">
                                                <SpecialDays>
                                                    <telerik:RadCalendarDay Date="07/07/2017" IsWeekend="true" IsSelectable="false" IsDisabled="true" Repeatable="Week">
                                                    </telerik:RadCalendarDay>
                                                </SpecialDays>
                                                <DisabledDayStyle BackColor="LightGray" />
                                            </Calendar>
                                        </telerik:RadDatePicker>
                                    </td>
                                    <td>
                                        Second Visit:
                                        <telerik:RadDatePicker ID="dtVisit2" runat="server" Culture="en-US" Width="90%"
                                            OnSelectedDateChanged="dtVisit2_SelectedDateChanged" AutoPostBack="true"
                                            Skin="WebBlue"
                                            FocusedDate='<%# System.DateTime.Today %>'
                                            MinDate='<%# DateTime.Parse(Session["StartDate"].ToString()) %>'
                                            MaxDate='<%# DateTime.Parse(Session["EndDate"].ToString()) %>'>
                                            <Calendar ID="Calendar1" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="true"
                                                EnableMonthYearFastNavigation="False" FastNavigationNextText="&amp;lt;&amp;lt;" FirstDayOfWeek="Saturday">
                                                <SpecialDays>
                                                    <telerik:RadCalendarDay Date="07/07/2017" IsWeekend="true" IsSelectable="false" IsDisabled="true" Repeatable="Week">
                                                    </telerik:RadCalendarDay>
                                                </SpecialDays>
                                                <DisabledDayStyle BackColor="LightGray" />
                                            </Calendar>
                                        </telerik:RadDatePicker>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <br />

                        <p>
                            <asp:Button ID="btnSave3" runat="server" Text="Save Plan for Dated Doctors" OnClick="btnSave3_Click" Height="30px" BackColor="White"
                                Font-Names="Times New Roman" Font-Size="Medium" ForeColor="#0000CC" />
                            <asp:Button ID="btnSearch3" runat="server" Text="Get Plans for Displayed Doctors" OnClick="btnSearch3_Click" Height="30px" BackColor="White"
                                Font-Names="Times New Roman" Font-Size="Medium" ForeColor="#0000CC" />
                        </p>
                    </td>
                </tr>
            </table>

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

            <telerik:RadScheduler ID="RadScheduler1" runat="server" Skin="WebBlue" Font-Size="Small" ExportSettings-OpenInNewWindow="true"
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
                OnTimeSlotCreated="RadScheduler1_TimeSlotCreated">
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
                            <%--                            <telerik:RadMenuItem Text="Edit" Value="CommandEdit" />--%>
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
