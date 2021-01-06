using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Web.Data;
using Telerik.Web.Design;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Windows;

namespace AmounCRM4.Reps
{
    public partial class CallsSchedulerFromAdmin : System.Web.UI.Page
    {
        int repAreaID;

        int plannedPhVisits;
        SqlDataReader dr;
        SqlCommand cmd;
        SqlConnection con;
        SqlParameter affiliation;
        //SqlParameter entity;
        //SqlParameter physician;
        SqlParameter syear;
        SqlParameter smonth;
        SqlParameter sday;
        SqlParameter curPlannedVisitID;

        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);

            RadScheduler1.StartInsertingInAdvancedForm = true;
            RadScheduler1.StartEditingInAdvancedForm = true;
            //RadScheduler1.SelectedView = SchedulerViewType.MonthView;
        }

        //private void RegisterScript()
        //{
        //    Label1.Text = "Invalid move! There are appointments arranged for this time period.";
        //    ScriptManager.RegisterClientScriptBlock(this, GetType(), "LabelUpdated",
        //            "$telerik.$('.lblError').show().animate({ opacity: 0.9 }, 2000).fadeOut('slow');", true);
        //}

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeIDFromAdmin"].ToString() == "")
            {
                Response.Redirect("~/Login2.aspx");
            }

            if(!Page.IsPostBack)
            {
                ddlCycles.SelectedValue = Session["CycleIDFromAdmin"].ToString();
                Session["RepAreaIDFromAdmin"] = "0";
            }
            Label1.Text = "";
        }

        protected void RadScheduler1_AppointmentCreated(object sender, AppointmentCreatedEventArgs e)
        {
            if (e.Appointment.RecurrenceState == RecurrenceState.Master || e.Appointment.RecurrenceState == RecurrenceState.Occurrence)
            {
                System.Web.UI.WebControls.Panel recurrenceStateDiv = new System.Web.UI.WebControls.Panel();
                recurrenceStateDiv.CssClass = "rsAptRecurrence";
                e.Container.Controls.AddAt(0, recurrenceStateDiv);
            }
            if (e.Appointment.RecurrenceState == RecurrenceState.Exception)
            {
                System.Web.UI.WebControls.Panel recurrenceStateDiv = new System.Web.UI.WebControls.Panel();
                recurrenceStateDiv.CssClass = "rsAptRecurrenceException";
                e.Container.Controls.AddAt(0, recurrenceStateDiv);
            }
            Label1.Text = "";
        }

        protected void RadScheduler1_AppointmentDataBound(object sender, SchedulerEventArgs e)
        {
            string timestamp = e.Appointment.Attributes["LastModified"];
            if (string.IsNullOrEmpty(timestamp))
            {
                timestamp = "Never";
            }

            // Set the appointment's tooltip to show when the appointment was last modified.
            e.Appointment.ToolTip = "Last modified on: " + timestamp;

            e.Appointment.BackColor = Color.White;
            //Conditional Coloring Based On Appointment Case
            if (e.Appointment.Attributes["Annotations"] == "Appointment")
            {
                e.Appointment.ForeColor = Color.White;
                e.Appointment.BackColor = Color.Red;
            }
            if (e.Appointment.Attributes["Annotations"] == "Created")
            {
                e.Appointment.ForeColor = Color.Black;
                e.Appointment.BackColor = Color.Yellow;
            }
            if (e.Appointment.Attributes["Annotations"] == "Final Save")
            {
                e.Appointment.ForeColor = Color.White;
                e.Appointment.BackColor = Color.Green;
            }
        }

        protected void RadScheduler1_AppointmentInsert(object sender, AppointmentInsertEventArgs e)
        {
            if (e.Appointment.Start < DateTime.Parse(Session["StartDateFromAdmin"].ToString()) || e.Appointment.Start > DateTime.Parse(Session["EndDateFromAdmin"].ToString()))
            {
                Label1.Text = "Date Range Is Wrong, It Must Be Within a Current Cycle";
                //RegisterScript();
                //MessageBox.Show("Date Range Is Wrong, It Must Be Within a Current Cycle", "Overlapped Appointment", MessageBoxButtons.OK, MessageBoxIcon.Information, MessageBoxDefaultButton.Button1, MessageBoxOptions.ServiceNotification);
                e.Cancel = true;
            }
            e.Appointment.Attributes["LastModified"] = DateTime.Now.ToString();
            e.Appointment.Attributes["Annotations"] = "Appointment";

            con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ToString());
            affiliation = new SqlParameter();
            //entity = new SqlParameter();
            //physician = new SqlParameter();
            syear = new SqlParameter();
            smonth = new SqlParameter();
            sday = new SqlParameter();
            curPlannedVisitID = new SqlParameter();

            cmd = new SqlCommand();

            cmd.Parameters.Add("affiliation", SqlDbType.Int);
            //cmd.Parameters.Add("entity", SqlDbType.Int);
            //cmd.Parameters.Add("physician", SqlDbType.Int);
            cmd.Parameters.Add("syear", SqlDbType.Int);
            cmd.Parameters.Add("smonth", SqlDbType.Int);
            cmd.Parameters.Add("sday", SqlDbType.Int);
            cmd.Parameters.Add("curPlannedVisitID", SqlDbType.Int);
            cmd.Parameters.Add("curPlannedRepID", SqlDbType.Int);

            cmd.Parameters["affiliation"].Value = e.Appointment.Resources.GetResourceByType("Affiliation").Key.ToString();
            //cmd.Parameters["entity"].Value = e.Appointment.Resources.GetResourceByType("Entity").Key.ToString();
            //cmd.Parameters["physician"].Value = e.Appointment.Resources.GetResourceByType("Physician").Key.ToString();
            cmd.Parameters["syear"].Value = e.Appointment.Start.Year;
            cmd.Parameters["smonth"].Value = e.Appointment.Start.Month;
            cmd.Parameters["sday"].Value = e.Appointment.Start.Day;
            cmd.Parameters["curPlannedVisitID"].Value = 0;
            cmd.Parameters["curPlannedRepID"].Value = int.Parse(ddlReps.SelectedValue);

            cmd.CommandText = "SELECT COUNT(*) FROM Appointments WHERE ( AffiliationID = " + cmd.Parameters["affiliation"].Value +
                " AND YEAR([StartDate]) = " + cmd.Parameters["syear"].Value +
                " AND MONTH([StartDate]) = " + cmd.Parameters["smonth"].Value +
                " AND Day([StartDate]) = " + cmd.Parameters["sday"].Value +
                " AND [AppointmentID] <> " + cmd.Parameters["curPlannedVisitID"].Value +
                " AND [EmployeeID] <> " + cmd.Parameters["curPlannedRepID"].Value +
                " )";
            //cmd.CommandText = "SELECT COUNT(*) FROM Appointments WHERE ( PhysicianID = " + cmd.Parameters["physician"].Value +
            //    " AND EntityID = " + cmd.Parameters["entity"].Value +
            //    " AND YEAR([StartDate]) = " + cmd.Parameters["syear"].Value +
            //    " AND MONTH([StartDate]) = " + cmd.Parameters["smonth"].Value +
            //    " AND Day([StartDate]) = " + cmd.Parameters["sday"].Value +
            //    " AND [AppointmentID] <> " + cmd.Parameters["curPlannedVisitID"].Value +
            //    " )";

            //cmd.CommandText = "SELECT COUNT(*) FROM Appointments WHERE ( UserID = " + cmd.Parameters[1].Value + " AND RoomID = " + cmd.Parameters[0].Value + ")";
            cmd.Connection = con;
            con.Open();

            plannedPhVisits = 0;
            dr = cmd.ExecuteReader();
            if (dr.HasRows == true)
            {
                while (dr.Read())
                {
                    plannedPhVisits = int.Parse(dr[0].ToString());
                }
            }
            if (plannedPhVisits == 0)
            {
                appointmentsDS.InsertParameters["EmployeeID"].DefaultValue = ddlReps.SelectedValue;
                appointmentsDS.InsertParameters["LineID"].DefaultValue = ddlLines.SelectedValue;
                appointmentsDS.InsertParameters["AreaID"].DefaultValue = Session["RepAreaIDFromAdmin"].ToString();
                appointmentsDS.InsertParameters["CycleID"].DefaultValue = Session["CycleIDFromAdmin"].ToString();// ddlCycles.SelectedValue;
            }
            else
            {
                e.Appointment.Description = "One of Amoun Team will visit this physician in this day";
                Label1.Text = "One of Amoun Team will visit this physician in this day";
                //RegisterScript();
                Label1.Text = "Overlapped Appointment" + "<br />" +"One of Amoun Team has a visit to this physician in this day";
                e.Cancel = true;
            }
            con.Close();
        }

        protected void RadScheduler1_AppointmentUpdate(object sender, AppointmentUpdateEventArgs e)
        {
            if (e.ModifiedAppointment.Start < DateTime.Parse(Session["StartDateFromAdmin"].ToString()) || e.ModifiedAppointment.Start > DateTime.Parse(Session["EndDateFromAdmin"].ToString()))
            {
                Label1.Text = "Date Range Is Wrong, It Must Be Within a Current Cycle";
                //RegisterScript();
                //MessageBox.Show("Date Range Is Wrong, It Must Be Within a Current Cycle", "Overlapped Appointment", MessageBoxButtons.OK, MessageBoxIcon.Information, MessageBoxDefaultButton.Button1, MessageBoxOptions.ServiceNotification);
                e.Cancel = true;
            }
            e.ModifiedAppointment.Attributes["LastModified"] = DateTime.Now.ToString();

            con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ToString());
            affiliation = new SqlParameter();
            //entity = new SqlParameter();
            //physician = new SqlParameter();
            syear = new SqlParameter();
            smonth = new SqlParameter();
            sday = new SqlParameter();

            cmd = new SqlCommand();

            cmd.Parameters.Add("affiliation", SqlDbType.Int);
            //cmd.Parameters.Add("entity", SqlDbType.Int);
            //cmd.Parameters.Add("physician", SqlDbType.Int);
            cmd.Parameters.Add("syear", SqlDbType.Int);
            cmd.Parameters.Add("smonth", SqlDbType.Int);
            cmd.Parameters.Add("sday", SqlDbType.Int);
            cmd.Parameters.Add("curPlannedVisitID", SqlDbType.Int);
            cmd.Parameters.Add("curPlannedRepID", SqlDbType.Int);

            cmd.Parameters["affiliation"].Value = e.Appointment.Resources.GetResourceByType("Affiliation").Key.ToString();
            //cmd.Parameters["entity"].Value = e.Appointment.Resources.GetResourceByType("Entity").Key.ToString();
            //cmd.Parameters["physician"].Value = e.Appointment.Resources.GetResourceByType("Physician").Key.ToString();
            cmd.Parameters["syear"].Value = e.ModifiedAppointment.Start.Year;
            cmd.Parameters["smonth"].Value = e.ModifiedAppointment.Start.Month;
            cmd.Parameters["sday"].Value = e.ModifiedAppointment.Start.Day;
            cmd.Parameters["curPlannedVisitID"].Value = e.ModifiedAppointment.ID;
            cmd.Parameters["curPlannedRepID"].Value = int.Parse(ddlReps.SelectedValue);

            cmd.CommandText = "SELECT COUNT(*) FROM Appointments WHERE ( AffiliationID = " + cmd.Parameters["affiliation"].Value +
                " AND YEAR([StartDate]) = " + cmd.Parameters["syear"].Value +
                " AND MONTH([StartDate]) = " + cmd.Parameters["smonth"].Value +
                " AND Day([StartDate]) = " + cmd.Parameters["sday"].Value +
                " AND [AppointmentID] <> " + cmd.Parameters["curPlannedVisitID"].Value +
                " AND [EmployeeID] <> " + cmd.Parameters["curPlannedRepID"].Value +
                " )";
            //cmd.CommandText = "SELECT COUNT(*) FROM Appointments WHERE ( PhysicianID = " + cmd.Parameters["physician"].Value +
            //    " AND EntityID = " + cmd.Parameters["entity"].Value +
            //    " AND YEAR([StartDate]) = " + cmd.Parameters["syear"].Value +
            //    " AND MONTH([StartDate]) = " + cmd.Parameters["smonth"].Value +
            //    " AND Day([StartDate]) = " + cmd.Parameters["sday"].Value +
            //    " AND [AppointmentID] <> " + cmd.Parameters["curPlannedVisitID"].Value +
            //    " )";

            //cmd.CommandText = "SELECT COUNT(*) FROM Appointments WHERE ( UserID = " + cmd.Parameters[1].Value + " AND RoomID = " + cmd.Parameters[0].Value + ")";
            cmd.Connection = con;
            con.Open();

            plannedPhVisits = 0;
            dr = cmd.ExecuteReader();
            if (dr.HasRows == true)
            {
                while (dr.Read())
                {
                    plannedPhVisits = int.Parse(dr[0].ToString());
                }
            }
            if (plannedPhVisits == 0)
            {
                /*
                appointmentsDS.InsertParameters["RepID"].DefaultValue = Session["EmployeeID"].ToString();
                appointmentsDS.InsertParameters["GroupID"].DefaultValue = Session["LineID"].ToString();
                appointmentsDS.InsertParameters["AreaID"].DefaultValue = One of Amoun Team will visit this physician in this daySession["AreaID"].ToString();
                appointmentsDS.InsertParameters["CycleID"].DefaultValue = Session["CycleID"].ToString();
                 * */
            }
            else
            {
                e.Appointment.Description = "One of Amoun Team will visit this physician in this day";
                Label1.Text = "One of Amoun Team will visit this physician in this day";
                //RegisterScript();
                Label1.Text = "Overlapped Appointment" + "<br />" + "One of Amoun team has a visit to this physician in this day";
                e.Cancel = true;
            }
            con.Close();
        }

        protected void RadScheduler1_FormCreated(object sender, SchedulerFormCreatedEventArgs e)
        {
            // Disable the LastModified textbox in the advanced form
            if (e.Container.Mode == SchedulerFormMode.AdvancedEdit || e.Container.Mode == SchedulerFormMode.AdvancedInsert)
            {
                RadTextBox txtModifiedTimeStamp = e.Container.FindControl("AttrLastModified") as RadTextBox;
                if (txtModifiedTimeStamp != null)
                {
                    txtModifiedTimeStamp.Enabled = false;
                }
            }
            // Disable the Annotations textbox in the advanced form
            if (e.Container.Mode == SchedulerFormMode.AdvancedEdit || e.Container.Mode == SchedulerFormMode.AdvancedInsert)
            {
                RadTextBox txtAnnotations = e.Container.FindControl("AttrAnnotations") as RadTextBox;
                if (txtAnnotations != null)
                {
                    txtAnnotations.Enabled = false;
                }
            }
        }

        protected void RadScheduler1_FormCreating(object sender, SchedulerFormCreatingEventArgs e)
        {
            if (string.IsNullOrEmpty(e.Appointment.Attributes["LastModified"]))
            {
                e.Appointment.Attributes["LastModified"] = "Never";
                //affDS.SelectParameters[0].DefaultValue = Session["RepAreaIDFromAdmin"].ToString();

                if (e.Appointment.Resources.GetResourceByType("Affiliation") == null && e.Appointment.ID != null)
                {
                    con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ToString());
                    string s = "Select Distinct AffiliationID, AreaRecID From Appointments WHERE AppointmentID = " + int.Parse(e.Appointment.ID.ToString());
                    cmd = new SqlCommand(s, con);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            repAreaID = int.Parse(dr["AreaRecID"].ToString());
                            Session["RepAreaIDFromAdmin"] = repAreaID;
                            Session["ParticipantIDFromAdmin"] = dr["AffiliationID"].ToString();
                            affDS.SelectParameters[0].DefaultValue = Session["RepAreaIDFromAdmin"].ToString();//Session["RepAreaIDFromAdmin"] instead of repAreaID
                        }
                    }
                    dr.Close();
                }
                else
                {
                    //Session["ParticipantIDFromAdmin"] = e.Appointment.Resources.GetResourceByType("Affiliation").Key.ToString();
                    affDS.SelectParameters[0].DefaultValue = Session["RepAreaIDFromAdmin"].ToString();//Session["RepAreaIDFromAdmin"] instead of repAreaID
                }

                
            }
        }

        protected void RadScheduler1_AppointmentContextMenuItemClicked(object sender, AppointmentContextMenuItemClickedEventArgs e)
        {
            try
            {
                if ((e.MenuItem.Value == "Create") && (e.Appointment.Attributes["Annotations"] == "Appointment"))
                {
                    Session["repIDFromAdmin"] = ddlReps.SelectedValue;
                    Session["IsEditCallFromAdmin"] = 0;
                    Session["PlannedVisitIDFromAdmin"] = int.Parse(e.Appointment.ID.ToString());
                    Session["PlannedVisitDateFromAdmin"] = e.Appointment.Start;

                    if (e.Appointment.Resources.GetResourceByType("Affiliation") == null)
                    {
                        con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ToString());
                        string s = "Select Distinct AffiliationID, AreaRecID From Appointments WHERE AppointmentID = " + int.Parse(e.Appointment.ID.ToString());
                        cmd = new SqlCommand(s, con);
                        con.Open();
                        SqlDataReader dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                repAreaID = int.Parse(dr["AreaRecID"].ToString());
                                Session["RepAreaIDFromAdmin"] = repAreaID;
                                Session["ParticipantIDFromAdmin"] = dr["AffiliationID"].ToString();
                            }
                        }
                        dr.Close();
                    }
                    else
                    {
                        Session["ParticipantIDFromAdmin"] = e.Appointment.Resources.GetResourceByType("Affiliation").Key.ToString();
                    }

                    Session["RepLineIDFromAdmin"] = int.Parse(ddlLines.SelectedValue);
                    Session["RepCycleIDFromAdmin"] = Session["CycleIDFromAdmin"].ToString();//ddlCycles.SelectedValue;
                    //Response.Redirect("~/Reps/CallsEntryFromAdmin.aspx");
                    ScriptManager.RegisterStartupScript(Page, typeof(Page), "OpenWindow", "window.open('CallsEntryFromAdmin.aspx');", true);
                }
                if ((e.MenuItem.Value == "Create") && (e.Appointment.Attributes["Annotations"] != "Appointment"))
                {
                    Label1.Text = "Alert!" + "<br />" + "This Visit Already Created";
                }

                if (e.MenuItem.Value == "EditCall" && e.Appointment.Attributes["Annotations"] == "Created")
                {
                    Session["repIDFromAdmin"] = ddlReps.SelectedValue;
                    Session["IsEditCallFromAdmin"] = 1;
                    Session["PlannedVisitIDFromAdmin"] = int.Parse(e.Appointment.ID.ToString());
                    Session["PlannedVisitDateFromAdmin"] = e.Appointment.Start;

                    if (e.Appointment.Resources.GetResourceByType("Affiliation") == null)
                    {
                        con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ToString());
                        string s = "Select Distinct AffiliationID, AreaRecID From Appointments WHERE AppointmentID = " + int.Parse(e.Appointment.ID.ToString());
                        cmd = new SqlCommand(s, con);
                        con.Open();
                        SqlDataReader dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                repAreaID = int.Parse(dr["AreaRecID"].ToString());
                                Session["RepAreaIDFromAdmin"] = repAreaID;
                                Session["ParticipantIDFromAdmin"] = dr["AffiliationID"].ToString();
                            }
                        }
                        dr.Close();
                    }
                    else
                    {
                        Session["ParticipantIDFromAdmin"] = e.Appointment.Resources.GetResourceByType("Affiliation").Key.ToString();
                    }

                    Session["RepLineIDFromAdmin"] = int.Parse(ddlLines.SelectedValue);
                    Session["RepCycleIDFromAdmin"] = Session["CycleIDFromAdmin"].ToString();//ddlCycles.SelectedValue;
                    //Response.Redirect("~/Reps/CallsEntryFromAdmin.aspx");
                    ScriptManager.RegisterStartupScript(Page, typeof(Page), "OpenWindow", "window.open('CallsEntryFromAdmin.aspx');", true);
                }
                if (e.MenuItem.Value == "EditCall" && e.Appointment.Attributes["Annotations"] != "Created")
                {
                    Session["IsEditCallFromAdmin"] = 0;
                    Label1.Text = "Alert!" + "<br />" + "This appointment was finally saved or you did not creat a call for it";
                }

                if (e.MenuItem.Value == "DisplayCall" && e.Appointment.Attributes["Annotations"] != "Appointment")
                {
                    Session["repIDFromAdmin"] = ddlReps.SelectedValue;
                    Session["IsEditCallFromAdmin"] = 2;
                    Session["IsFinal"] = e.Appointment.Attributes["Annotations"];
                    Session["PlannedVisitIDFromAdmin"] = int.Parse(e.Appointment.ID.ToString());
                    Session["PlannedVisitDateFromAdmin"] = e.Appointment.Start;

                    if (e.Appointment.Resources.GetResourceByType("Affiliation") == null)
                    {
                        con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ToString());
                        string s = "Select Distinct AffiliationID, AreaRecID From Appointments WHERE AppointmentID = " + int.Parse(e.Appointment.ID.ToString());
                        cmd = new SqlCommand(s, con);
                        con.Open();
                        SqlDataReader dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                repAreaID = int.Parse(dr["AreaRecID"].ToString());
                                Session["RepAreaIDFromAdmin"] = repAreaID;
                                Session["ParticipantIDFromAdmin"] = dr["AffiliationID"].ToString();
                            }
                        }
                        dr.Close();
                    }
                    else
                    {
                        Session["ParticipantIDFromAdmin"] = e.Appointment.Resources.GetResourceByType("Affiliation").Key.ToString();
                    }

                    Session["RepLineIDFromAdmin"] = int.Parse(ddlLines.SelectedValue);
                    Session["RepCycleIDFromAdmin"] = Session["CycleIDFromAdmin"].ToString();// ddlCycles.SelectedValue;
                    //Response.Redirect("~/Reps/CallsEntryFromAdmin.aspx");
                    ScriptManager.RegisterStartupScript(Page, typeof(Page), "OpenWindow", "window.open('CallsEntryFromAdmin.aspx');", true);
                }
                if (e.MenuItem.Value == "DisplayCall" && e.Appointment.Attributes["Annotations"] == "Appointment")
                {
                    //Session["IsEditCallFromAdmin"] = 0;
                    Label1.Text = "Error" + "<br />" + "This appointment has no corresponding call";
                }
            }
            catch(Exception ex)
            {
                lblCycle.Text = ex.Source + ": " + ex.Message;
                //MessageBox.Show(ex.Message);
            }
        }

        protected void appointmentsDS_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@Param1"].Value = ddlReps.SelectedValue.ToString();
            e.Command.Parameters["@RangeStart"].Value = RadScheduler1.VisibleRangeStart;
            e.Command.Parameters["@RangeEnd"].Value = RadScheduler1.VisibleRangeEnd;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                if ((int.Parse(ddlReps.SelectedValue.ToString()) > 0) && (txtAffID.Text != ""))
                {
                    //appointmentsDS.SelectParameters[0].DefaultValue = ddlReps.SelectedValue;
                    //appointmentsDS.SelectParameters[1].DefaultValue = RadScheduler1.VisibleRangeStart.ToString();
                    //if (RadScheduler1.SelectedView == SchedulerViewType.MonthView)
                    //{
                    //    appointmentsDS.SelectParameters[2].DefaultValue = (new DateTime(RadScheduler1.VisibleRangeStart.Year, RadScheduler1.VisibleRangeStart.Month, DateTime.DaysInMonth(RadScheduler1.VisibleRangeStart.Year, RadScheduler1.VisibleRangeStart.Month), 11, 59, 0)).ToString();
                    //}
                    //else
                    //{
                    //    appointmentsDS.SelectParameters[2].DefaultValue = RadScheduler1.VisibleRangeEnd.ToString();
                    //}
                    //appointmentsDS.SelectCommand = "SELECT AppointmentID, Subject, Description, StartDate, EndDate, AffiliationID, RecurrenceRule, RecurrenceParentID, Reminder, Annotations FROM Appointments WHERE (EmployeeID = '" + appointmentsDS.SelectParameters[0].DefaultValue + "')" + " AND ([StartDate] < '" + appointmentsDS.SelectParameters[2].DefaultValue + "')" + " AND ([EndDate] > '" + appointmentsDS.SelectParameters[1].DefaultValue + "')" + " OR ([RecurrenceRule] <> '') OR ([RecurrenceParentID] IS NOT NULL)";
                    appointmentsDS.SelectCommand = "SELECT AppointmentID, Subject, Description, StartDate, EndDate, AffiliationID, RecurrenceRule, RecurrenceParentID, Reminder, Annotations FROM Appointments WHERE (DeletedAppointment IS NULL AND EmployeeID = '" + ddlReps.SelectedValue + "')" + " AND ([StartDate] < '" + RadScheduler1.VisibleRangeEnd.ToString() + "' AND [EndDate] > '" + RadScheduler1.VisibleRangeStart.ToString() + "')";// + " OR ([RecurrenceRule] <> '') OR ([RecurrenceParentID] IS NOT NULL)"
                    appointmentsDS.SelectCommand += " AND AffiliationID = " + int.Parse(txtAffID.Text);
                }

                //else if ((int.Parse(ddlReps.SelectedValue.ToString()) <= 0) && (int.Parse(ddlSupervisors.SelectedValue.ToString()) > 0))
                //{
                //    appointmentsDS.SelectParameters[0].DefaultValue = ddlSupervisors.SelectedValue;
                //    appointmentsDS.SelectParameters[1].DefaultValue = RadScheduler1.VisibleRangeStart.ToString();
                //    if (RadScheduler1.SelectedView == SchedulerViewType.MonthView)
                //    {
                //        appointmentsDS.SelectParameters[2].DefaultValue = (new DateTime(RadScheduler1.VisibleRangeStart.Year, RadScheduler1.VisibleRangeStart.Month, DateTime.DaysInMonth(RadScheduler1.VisibleRangeStart.Year, RadScheduler1.VisibleRangeStart.Month), 11, 59, 0)).ToString();
                //    }
                //    else
                //    {
                //        appointmentsDS.SelectParameters[2].DefaultValue = RadScheduler1.VisibleRangeEnd.ToString();
                //    }
                //    appointmentsDS.SelectCommand = "SELECT AppointmentID, Subject, Description, StartDate, EndDate, AffiliationID, RecurrenceRule, RecurrenceParentID, Reminder, Annotations FROM Appointments WHERE (EmployeeID = '" + appointmentsDS.SelectParameters[0].DefaultValue + "')" + " AND ([StartDate] < '" + appointmentsDS.SelectParameters[2].DefaultValue + "')" + " AND [EndDate] > '" + appointmentsDS.SelectParameters[1].DefaultValue + "')" + " OR ([RecurrenceRule] <> '') OR ([RecurrenceParentID] IS NOT NULL)";
                //}

                //else if ((int.Parse(ddlSupervisors.SelectedValue.ToString()) <= 0) && (int.Parse(ddlManagers.SelectedValue.ToString()) > 0))
                //{
                //    appointmentsDS.SelectParameters[0].DefaultValue = ddlManagers.SelectedValue;
                //    appointmentsDS.SelectParameters[1].DefaultValue = RadScheduler1.VisibleRangeStart.ToString();
                //    if (RadScheduler1.SelectedView == SchedulerViewType.MonthView)
                //    {
                //        appointmentsDS.SelectParameters[2].DefaultValue = (new DateTime(RadScheduler1.VisibleRangeStart.Year, RadScheduler1.VisibleRangeStart.Month, DateTime.DaysInMonth(RadScheduler1.VisibleRangeStart.Year, RadScheduler1.VisibleRangeStart.Month), 11, 59, 0)).ToString();
                //    }
                //    else
                //    {
                //        appointmentsDS.SelectParameters[2].DefaultValue = RadScheduler1.VisibleRangeEnd.ToString();
                //    }
                //    appointmentsDS.SelectCommand = "SELECT AppointmentID, Subject, Description, StartDate, EndDate, AffiliationID, RecurrenceRule, RecurrenceParentID, Reminder, Annotations FROM Appointments WHERE (EmployeeID = '" + appointmentsDS.SelectParameters[0].DefaultValue + "')" + " AND ([StartDate] < '" + appointmentsDS.SelectParameters[2].DefaultValue + "')" + " AND [EndDate] > '" + appointmentsDS.SelectParameters[1].DefaultValue + "')" + " OR ([RecurrenceRule] <> '') OR ([RecurrenceParentID] IS NOT NULL)";
                //}

                //else if ((int.Parse(ddlManagers.SelectedValue.ToString()) <= 0) && (int.Parse(ddlLines.SelectedValue.ToString()) > 0))
                //{
                //    appointmentsDS.SelectParameters[0].DefaultValue = ddlLines.SelectedValue;
                //    appointmentsDS.SelectParameters[1].DefaultValue = RadScheduler1.VisibleRangeStart.ToString();
                //    if (RadScheduler1.SelectedView == SchedulerViewType.MonthView)
                //    {
                //        appointmentsDS.SelectParameters[2].DefaultValue = (new DateTime(RadScheduler1.VisibleRangeStart.Year, RadScheduler1.VisibleRangeStart.Month, DateTime.DaysInMonth(RadScheduler1.VisibleRangeStart.Year, RadScheduler1.VisibleRangeStart.Month), 11, 59, 0)).ToString();
                //    }
                //    else
                //    {
                //        appointmentsDS.SelectParameters[2].DefaultValue = RadScheduler1.VisibleRangeEnd.ToString();
                //    }
                //    appointmentsDS.SelectCommand = "SELECT AppointmentID, Subject, Description, StartDate, EndDate, AffiliationID, RecurrenceRule, RecurrenceParentID, Reminder, Annotations FROM Appointments WHERE (EmployeeID = '" + appointmentsDS.SelectParameters[0].DefaultValue + "')" + " AND ([StartDate] < '" + appointmentsDS.SelectParameters[2].DefaultValue + "')" + " AND [EndDate] > '" + appointmentsDS.SelectParameters[1].DefaultValue + "')" + " OR ([RecurrenceRule] <> '') OR ([RecurrenceParentID] IS NOT NULL)";
                //}

                //else if ((int.Parse(ddlLines.SelectedValue.ToString()) <= 0) && (int.Parse(ddlCycles.SelectedValue.ToString()) > 0))
                //{
                //    appointmentsDS.SelectParameters[0].DefaultValue = ddlCycles.SelectedValue;
                //    appointmentsDS.SelectParameters[1].DefaultValue = RadScheduler1.VisibleRangeStart.ToString();
                //    if (RadScheduler1.SelectedView == SchedulerViewType.MonthView)
                //    {
                //        appointmentsDS.SelectParameters[2].DefaultValue = (new DateTime(RadScheduler1.VisibleRangeStart.Year, RadScheduler1.VisibleRangeStart.Month, DateTime.DaysInMonth(RadScheduler1.VisibleRangeStart.Year, RadScheduler1.VisibleRangeStart.Month), 11, 59, 0)).ToString();
                //    }
                //    else
                //    {
                //        appointmentsDS.SelectParameters[2].DefaultValue = RadScheduler1.VisibleRangeEnd.ToString();
                //    }
                //    appointmentsDS.SelectCommand = "SELECT AppointmentID, Subject, Description, StartDate, EndDate, AffiliationID, RecurrenceRule, RecurrenceParentID, Reminder, Annotations FROM Appointments WHERE (EmployeeID = '" + appointmentsDS.SelectParameters[0].DefaultValue + "')" + " AND ([StartDate] < '" + appointmentsDS.SelectParameters[2].DefaultValue + "')" + " AND [EndDate] > '" + appointmentsDS.SelectParameters[1].DefaultValue + "')" + " OR ([RecurrenceRule] <> '') OR ([RecurrenceParentID] IS NOT NULL)";
                //}

                RadScheduler1.DataBind();
                Label1.Text = "";
            }
            catch (Exception ex)
            {
                Label1.Text = ex.Source + "<br />" + ex.Message;
            }
        }

        protected void ddlReps_SelectedIndexChanged(object sender, EventArgs e)
        {
            con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ToString());
            string s = "Select Distinct AreaRecID From Employees WHERE EmployeeID = " + int.Parse(ddlReps.SelectedValue.ToString()) + " Order By AreaRecID";
            cmd = new SqlCommand(s, con);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    repAreaID = int.Parse(dr["AreaRecID"].ToString());
                    Session["RepAreaIDFromAdmin"] = repAreaID;
                }
            }
            dr.Close();
            Label1.Text = "";
        }

        protected void ddlManagers_SelectedIndexChanged(object sender, EventArgs e)
        {
            dsReps.SelectParameters[0].DefaultValue = ddlLines.SelectedValue;
            dsReps.SelectParameters[1].DefaultValue = ddlSupervisors.SelectedValue;
            dsReps.DataBind();
            ddlReps.SelectedIndex = 0;
            Label1.Text = "";
        }

        protected int getFirstSat(int MonthID)
        {
            DateTime sd = new DateTime(DateTime.Now.Year, MonthID, 1);
            DateTime ed = new DateTime(DateTime.Now.Year, MonthID, 8);
            TimeSpan diff = ed - sd;
            int firstSat = 0;
            int otherSats = 0;
            int days = diff.Days;
            for (var i = 0; i <= days; i++)
            {
                var testDate = sd.AddDays(i);
                switch (testDate.DayOfWeek)
                {
                    case DayOfWeek.Saturday:
                        if (firstSat == 0)
                        {
                            firstSat = testDate.Day;
                        }
                        else
                        {
                            otherSats = testDate.Day;
                        }
                        break;
                }
            }
            return firstSat;
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            try
            {
                Label1.Text = "";
                int firstSat = getFirstSat(int.Parse(Session["MonthIDFromAdmin"].ToString()));

                dsFastNew.InsertParameters["Subject"].DefaultValue = txtAffID.Text;
                dsFastNew.InsertParameters["Description"].DefaultValue = "Added to Cycle: " + Session["CycleIDFromAdmin"].ToString();//+ txtCycleID.Text;
                dsFastNew.InsertParameters["StartDate"].DefaultValue = (new DateTime(int.Parse(Session["CurrentYear"].ToString()), int.Parse(Session["MonthID"].ToString()), 5, 8, 30, 0)).ToString();
                dsFastNew.InsertParameters["EndDate"].DefaultValue = (new DateTime(int.Parse(Session["CurrentYear"].ToString()), int.Parse(Session["MonthID"].ToString()), 5, 9, 0, 0)).ToString();
                dsFastNew.InsertParameters["EntityID"].DefaultValue = "0";
                dsFastNew.InsertParameters["PhysicianID"].DefaultValue = "0";
                dsFastNew.InsertParameters["RecurrenceRule"].DefaultValue = "";
                dsFastNew.InsertParameters["RecurrenceParentID"].DefaultValue = "";
                dsFastNew.InsertParameters["Reminder"].DefaultValue = "";
                dsFastNew.InsertParameters["Annotations"].DefaultValue = "Appointment";
                dsFastNew.InsertParameters["LastModified"].DefaultValue = DateTime.Now.ToString();
                dsFastNew.InsertParameters["EmployeeID"].DefaultValue = ddlReps.SelectedValue;
                dsFastNew.InsertParameters["LineID"].DefaultValue = ddlLines.SelectedValue;
                dsFastNew.InsertParameters["AreaRecID"].DefaultValue = Session["RepAreaIDFromAdmin"].ToString();
                /*
                if (int.Parse(txtCycleID.Text) == 2)
                {
                    dsFastNew.InsertParameters["CycleID"].DefaultValue = "13";
                }
                */
                dsFastNew.InsertParameters["CycleID"].DefaultValue = Session["CycleIDFromAdmin"].ToString();
                dsFastNew.InsertParameters["CycleID"].DefaultValue = Session["CycleIDFromAdmin"].ToString();// txtCycleID.Text;
                dsFastNew.InsertParameters["AffiliationID"].DefaultValue = txtAffID.Text;
                dsFastNew.InsertParameters["IsOriginal"].DefaultValue = "";

                dsFastNew.Insert();
                Label1.Text = "Appointment Saved";
            }
            catch (Exception ex)
            {
                Label1.Text = ex.Message;
            }
        }

        protected void appointmentsDS_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            int i = RadScheduler1.Appointments.Count;
        }
    }
}