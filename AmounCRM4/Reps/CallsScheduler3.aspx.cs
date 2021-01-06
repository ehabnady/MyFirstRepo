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
    public partial class CallsScheduler3 : System.Web.UI.Page
    {
        SqlCommand cmd;
        SqlConnection con;

        protected override void OnPreRender(EventArgs e)
        {
            try
            {
                base.OnPreRender(e);

                RadScheduler1.StartInsertingInAdvancedForm = true;
                RadScheduler1.StartEditingInAdvancedForm = true;
                //RadScheduler1.SelectedView = SchedulerViewType.MonthView;
            }
            catch (Exception ex)
            {
                Label1.Text = ex.Source + " - " + ex.Message;
                //RadWindowManager1.RadAlert(ex.Source + " - " + ex.Message, 400, 200, "Alert!", null, "");
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeID"].ToString() == "")
            {
                Response.Redirect("~/Login2.aspx");
            }

            if (!Page.IsPostBack)
            {

            }
            Label1.Text = "";

            string selectText = @"SELECT Distinct AffiliationID, SpecialtyID, AffiliationName2, AffiliationName3, PhysicianClass, SpecialtyValue, TotalValue, BrickID, SpecialityCode 
                                    FROM View_Affiliations_Scheduler 
                                    WHERE (PhysicianClass IN ('A+', 'A') 
                                    AND SpecialtyValue > 0 AND LastModifierID IS NOT NULL AND EmployeeID = " + int.Parse(Session["EmployeeID"].ToString()) +
                                    " AND LineID = " + int.Parse(Session["LineID"].ToString()) + ")";
            selectText += " ORDER BY TotalValue Desc, SpecialtyValue DESC";
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
                //e.Appointment.ForeColor = Color.Red;
                //e.Appointment.BorderStyle = BorderStyle.Double;
                //e.Appointment.BorderWidth = 2;
                //e.Appointment.BorderColor = Color.Red;
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
            //OldInsertMethod(sender, e); Checks whether the same affiliation has a planned visit in the same day or not
            //this is RadFilterDoesNotContainFilterExpression not make sense since an affiliation id is a line-based
            // if we do need to do this, we have to check a physician id rather than affiliation id and also there will be a problem
            //which is we save an appointment in a first saturday which is an assumed date, so a system must accept this date otherwise it is a conflict
            try
            {
                if (DateTime.Now.Day > int.Parse(Session["AllowedDaysForPlanning"].ToString()))
                {
                    //Label1.Text = "You can not change a plan after a seventh day in month";
                    //e.Cancel = true;
                }
                if (e.Appointment.Start < DateTime.Parse(Session["StartDate"].ToString()) || e.Appointment.Start > DateTime.Parse(Session["EndDate"].ToString())) //Dimmed to allow a rep to plan to the next month
                {
                    Label1.Text = "Date Range Is Wrong, it must be for the current cycle or the next cycle";
                    //RegisterScript();
                    //MessageBox.Show("Date Range Is Wrong, It Must Be Within a Current Cycle", "Overlapped Appointment", MessageBoxButtons.OK, MessageBoxIcon.Information, MessageBoxDefaultButton.Button1, MessageBoxOptions.ServiceNotification);
                    e.Cancel = true;
                }
                e.Appointment.Attributes["LastModified"] = DateTime.Now.ToString();
                e.Appointment.Attributes["Annotations"] = "Appointment";

                appointmentsDS.InsertParameters["EmployeeID"].DefaultValue = Session["EmployeeID"].ToString();
                appointmentsDS.InsertParameters["LineID"].DefaultValue = Session["LineID"].ToString();
                appointmentsDS.InsertParameters["BrickID"].DefaultValue = e.Appointment.Resources.GetResourceByType("Bricks").Key.ToString();
                appointmentsDS.InsertParameters["CycleID"].DefaultValue = Session["CycleID"].ToString();// ddlCycles.SelectedValue;
            }
            catch (Exception ex)
            {
                Label1.Text = ex.Message;
                //RegisterScript();
                //MessageBox.Show("Date Range Is Wrong, It Must Be Within a Current Cycle", "Overlapped Appointment", MessageBoxButtons.OK, MessageBoxIcon.Information, MessageBoxDefaultButton.Button1, MessageBoxOptions.ServiceNotification);
                e.Cancel = true;
            }
        }

        protected void RadScheduler1_AppointmentUpdate(object sender, AppointmentUpdateEventArgs e)
        {
            try
            {
                if (e.ModifiedAppointment.Start.DayOfWeek == DayOfWeek.Friday)
                {
                    Label1.Text = "You can not set an appointment in Friday";
                    //RegisterScript();
                    //MessageBox.Show("Date Range Is Wrong, It Must Be Within a Current Cycle", "Overlapped Appointment", MessageBoxButtons.OK, MessageBoxIcon.Information, MessageBoxDefaultButton.Button1, MessageBoxOptions.ServiceNotification);
                    RadWindowManager1.RadAlert("You can not set an appointment in Friday", 400, 200, "Error", null, "");
                    e.Cancel = true;
                    return;
                }
                if (e.ModifiedAppointment.End.DayOfWeek == DayOfWeek.Friday)
                {
                    Label1.Text = "You can not set an appointment in Friday";
                    //RegisterScript();
                    //MessageBox.Show("Date Range Is Wrong, It Must Be Within a Current Cycle", "Overlapped Appointment", MessageBoxButtons.OK, MessageBoxIcon.Information, MessageBoxDefaultButton.Button1, MessageBoxOptions.ServiceNotification);
                    RadWindowManager1.RadAlert("You can not set an appointment in Friday", 400, 200, "Error", null, "");
                    e.Cancel = true;
                    return;
                }

                if (e.ModifiedAppointment.Attributes["Annotations"] == "Appointment")
                {
                    if (DateTime.Now.Day > int.Parse(Session["AllowedDaysForPlanning"].ToString()))
                    {
                        //Label1.Text = "You can not change a plan after a seventh day in month";
                        //e.Cancel = true;
                    }
                    if (e.ModifiedAppointment.Start < DateTime.Parse(Session["StartDate"].ToString()) || e.ModifiedAppointment.Start > DateTime.Parse(Session["EndDate"].ToString()))
                    {
                        Label1.Text = "Date Range Is Wrong, It Must Be Within a Current Cycle";
                        //RegisterScript();
                        //MessageBox.Show("Date Range Is Wrong, It Must Be Within a Current Cycle", "Overlapped Appointment", MessageBoxButtons.OK, MessageBoxIcon.Information, MessageBoxDefaultButton.Button1, MessageBoxOptions.ServiceNotification);
                        RadWindowManager1.RadAlert("Date Range Is Wrong, It Must Be Within a Current Cycle", 400, 200, "Error", null, "");
                        e.Cancel = true;
                        return;
                    }
                    if (e.ModifiedAppointment.Start.Day != e.ModifiedAppointment.End.Day)
                    {
                        Label1.Text = "Start Day and End Day Must be The Same";
                        RadWindowManager1.RadAlert("Start Day and End Day Must be The Same", 400, 200, "Error", null, "");
                        e.Cancel = true;
                        return;
                    }
                    con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ToString());
                    con.Open();
                    string querySt2 = @"Select DISTINCT App1.AppointmentID, App1.AffiliationID, App1.StartDate, AffSch.PhysicianClass
                                        From Appointments AS App1
                                        Inner Join View_Affiliations_Scheduler AS AffSch ON AffSch.AffiliationID = App1.AffiliationID AND AffSch.EmployeeID = App1.EmployeeID
                                        WHERE App1.AffiliationID = " + int.Parse(e.ModifiedAppointment.Resources.GetResourceByType("Affiliation").Key.ToString()) +
                                        " AND App1.EmployeeID = " + int.Parse(Session["EmployeeID"].ToString()) +
                                        " AND App1.CycleID = " + int.Parse(Session["CycleID"].ToString()) +
                                        " AND (App1.DeletedAppointment IS NULL OR App1.DeletedAppointment = 0)"
                                        ;

                    DataTable dt1 = new DataTable();
                    SqlDataAdapter da = new SqlDataAdapter(querySt2, con);
                    da.Fill(dt1);

                    string s = "StartDate = '" + e.ModifiedAppointment.Start.ToShortDateString() + "'";
                    int countByDate = dt1.Select(s).Count();
                    if (countByDate > 0)
                    {
                        Label1.Text = "You Cannot Add Two or More Appointments To The Same Doctor In The Same Day";
                        RadWindowManager1.RadAlert("You Cannot Add Two or More Appointments To The Same Doctor In The Same Day", 400, 200, "Exceeding Visits!", null, "");
                        e.Cancel = true;
                        return;
                    }

                    string s2 = "AffiliationID = " + int.Parse(e.ModifiedAppointment.Resources.GetResourceByType("Affiliation").Key.ToString());
                    int countByAff = dt1.Select(s2).Count();
                    string phClass = dt1.Rows.Count == 0 ? "" : dt1.Rows[0][3].ToString();

                    if (int.Parse(e.Appointment.Resources.GetResourceByType("Affiliation").Key.ToString()) == int.Parse(e.ModifiedAppointment.Resources.GetResourceByType("Affiliation").Key.ToString()))
                    {
                        if ((countByAff >= 3) && (phClass.Equals("A+")))
                        {
                            Label1.Text = "You Cannot Add More Appointments To This Doctor";
                            RadWindowManager1.RadAlert("You Cannot Add More Appointments To This Doctor", 400, 200, "Exceeding Visits!", null, "");
                            e.Cancel = true;
                            return;
                        }
                        if ((countByAff >= 2) && (phClass.Equals("A")))
                        {
                            Label1.Text = "You Cannot Add More Appointments To This Doctor";
                            RadWindowManager1.RadAlert("You Cannot Add More Appointments To This Doctor", 400, 200, "Exceeding Visits!", null, "");
                            e.Cancel = true;
                            return;
                        }
                    }
                    else
                    {
                        if ((countByAff >= 2) && (phClass == "A+"))
                        {
                            Label1.Text = "You Cannot Add More Appointments To This Doctor";
                            RadWindowManager1.RadAlert("You Cannot Add More Appointments To This Doctor", 400, 200, "Exceeding Visits!", null, "");
                            e.Cancel = true;
                            return;
                        }
                        if ((countByAff >= 1) && (phClass == "A"))//A Instead of B
                        {
                            Label1.Text = "You Cannot Add More Appointments To This Doctor";
                            RadWindowManager1.RadAlert("You Cannot Add More Appointments To This Doctor", 400, 200, "Exceeding Visits!", null, "");
                            e.Cancel = true;
                            return;
                        }
                    }


                    //SqlCommand queryCom2 = new SqlCommand(querySt2, con);
                    //SqlDataReader queryReader2 = queryCom2.ExecuteReader();
                    //int i = 0;
                    //while (queryReader2.Read())
                    //{
                    //    if (e.ModifiedAppointment.Start.ToShortDateString() == (DateTime.Parse(queryReader2[2].ToString())).Date.ToShortDateString() && int.Parse(e.ModifiedAppointment.Resources.GetResourceByType("Affiliation").Key.ToString()) == int.Parse(queryReader2[1].ToString()))
                    //    {
                    //        Label1.Text = "You Cannot Add Two or More Appointments To The Same Doctor In The Same Day";
                    //        RadWindowManager1.RadAlert("You Cannot Add Two or More Appointments To The Same Doctor In The Same Day", 400, 200, "Exceeding Visits!", null, "");
                    //        e.Cancel = true;
                    //        return;
                    //    }
                    //    if (int.Parse(e.ModifiedAppointment.ID.ToString()) != int.Parse(queryReader2[0].ToString()))
                    //    {
                    //        i++;
                    //    }
                    //}

                    //if ((((i >= 2) && (queryReader2[3].ToString().Equals('A')))) || (((i >= 1) && (queryReader2[3].ToString().Equals('B')))))
                    //{
                    //    Label1.Text = "You Cannot Add More Appointments To This Doctor";
                    //    RadWindowManager1.RadAlert("You Cannot Add More Appointments To This Doctor", 400, 200, "Exceeding Visits!", null, "");
                    //    e.Cancel = true;
                    //    return;
                    //}

                    e.ModifiedAppointment.Attributes["LastModified"] = DateTime.Now.ToString();
                    RadWindowManager1.RadAlert("Appointment Changed Successfully", 400, 200, "Saved!", null, "");
                    return;
                }
                else
                {
                    e.Cancel = true;
                    return;
                }
            }
            catch (Exception ex)
            {
                Label1.Text = ex.Message;
                //RegisterScript();
                //MessageBox.Show("Date Range Is Wrong, It Must Be Within a Current Cycle", "Overlapped Appointment", MessageBoxButtons.OK, MessageBoxIcon.Information, MessageBoxDefaultButton.Button1, MessageBoxOptions.ServiceNotification);
                e.Cancel = true;
            }
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
                if (e.Appointment.Resources.GetResourceByType("Affiliation") != null)
                {
                    Session["AffID_BeforeEdit"] = e.Appointment.Resources.GetResourceByType("Affiliation").Key;
                }
                else
                {
                    Session["AffID_BeforeEdit"] = 0;
                }


                if (e.Appointment.Resources.GetResourceByType("Affiliation") == null && e.Appointment.ID != null)
                {
                    con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ToString());
                    //string s = "Select Distinct AffiliationID, AreaRecID From View_ListOfAppointments_Admin WHERE AppointmentID = " + int.Parse(e.Appointment.ID.ToString());
                    string s = "Select Distinct AffiliationID, SpecialtyID From View_Appointments_Scheduler WHERE AppointmentID = " + int.Parse(e.Appointment.ID.ToString());

                    cmd = new SqlCommand(s, con);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            Session["ParticipantID"] = dr["AffiliationID"].ToString();
                            Session["SpecialtyID"] = dr["SpecialtyID"].ToString();
                            affDS.SelectParameters[0].DefaultValue = Session["EmployeeID"].ToString();//Session["RepAreaIDFromAdmin"] instead of repAreaID
                            //affDS.SelectParameters[0].DefaultValue = Session["AreaID"].ToString();//Session["RepAreaIDFromAdmin"] instead of repAreaID
                            //affDS.SelectParameters[1].DefaultValue = Session["LineID"].ToString();//Session["RepAreaIDFromAdmin"] instead of repAreaID
                        }
                    }
                    dr.Close();
                }
                else
                {
                    //Session["ParticipantIDFromAdmin"] = e.Appointment.Resources.GetResourceByType("Affiliation").Key.ToString();
                    affDS.SelectParameters[0].DefaultValue = Session["EmployeeID"].ToString();//Session["RepAreaIDFromAdmin"] instead of repAreaID
                    //affDS.SelectParameters[0].DefaultValue = Session["AreaID"].ToString();//Session["RepAreaIDFromAdmin"] instead of repAreaID
                    //affDS.SelectParameters[1].DefaultValue = Session["LineID"].ToString();//Session["RepAreaIDFromAdmin"] instead of repAreaID
                }
            }
        }

        protected void RadScheduler1_AppointmentContextMenuItemClicked(object sender, AppointmentContextMenuItemClickedEventArgs e)
        {
            try
            {
                if ((e.MenuItem.Value == "Create") && (e.Appointment.Attributes["Annotations"] == "Appointment"))
                {
                    if (e.Appointment.Start.Date.AddDays(1) < DateTime.Now.Date)
                    {
                        Label1.Text = "This visit is too late to be added";
                        return;
                    }
                    if (DateTime.Now.Day < e.Appointment.Start.Day && DateTime.Now.Month <= int.Parse(Session["MonthID"].ToString()))
                    {
                        Label1.Text = "You cannot add a visit to days after today";
                        return;
                    }

                    Session["IsEditCall"] = 0;
                    Session["PlannedVisitID"] = int.Parse(e.Appointment.ID.ToString());
                    Session["PlannedVisitDate"] = e.Appointment.Start;
                    Session["IsDoubleVisit"] = -1;

                    if (e.Appointment.Resources.GetResourceByType("Affiliation") == null || e.Appointment.Resources.GetResourceByType("Affiliation") != null)
                    {
                        con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ToString());
                        //string s = "Select Distinct AffiliationID, AreaRecID From View_ListOfAppointments_Admin WHERE AppointmentID = " + int.Parse(e.Appointment.ID.ToString());
                        string s = "Select Distinct AffiliationID, SpecialtyID From View_Appointments_Scheduler WHERE AppointmentID = " + int.Parse(e.Appointment.ID.ToString());

                        cmd = new SqlCommand(s, con);
                        con.Open();
                        SqlDataReader dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                Session["ParticipantID"] = dr["AffiliationID"].ToString();
                                Session["SpecialtyID"] = dr["SpecialtyID"].ToString();
                            }
                        }
                        dr.Close();
                    }
                    //else
                    //{
                    //    Session["ParticipantID"] = e.Appointment.Resources.GetResourceByType("Affiliation").Key.ToString();
                    //}

                    int aaa = 1; int bbb = 0;
                    if (aaa == bbb)
                    {
                        ScriptManager.RegisterStartupScript(Page, typeof(Page), "OpenWindow", "window.open('CallsEntry.aspx');", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, typeof(Page), "OpenWindow", "window.open('Calls2.aspx');", true);
                    }
                }

                if ((e.MenuItem.Value == "Create") && (e.Appointment.Attributes["Annotations"] != "Appointment"))
                {
                    Label1.Text = "Alert!" + "<br />" + "This Visit Already Created";
                    RadWindowManager1.RadAlert("Duplicate Visits <br /> This Appointment Has a Corresponding Visit", 400, 200, "Alert!", null, "");
                }

                if (e.MenuItem.Value == "EditCall" && e.Appointment.Attributes["Annotations"] == "Created")
                {
                    if (e.Appointment.Start.Date.AddDays(1) < DateTime.Now.Date)
                    {
                        Label1.Text = "This visit is too late to be edited";
                        return;
                    }
                    if (DateTime.Now.Date < e.Appointment.Start.Date)//(DateTime.Now.Day < e.Appointment.Start.Day) && (DateTime.Now.Month == e.Appointment.Start.Month)
                    {
                        return;
                    }

                    Session["IsEditCall"] = 1;
                    Session["PlannedVisitID"] = int.Parse(e.Appointment.ID.ToString());
                    Session["PlannedVisitDate"] = e.Appointment.Start;
                    Session["IsDoubleVisit"] = 0;

                    if (e.Appointment.Resources.GetResourceByType("Affiliation") == null || e.Appointment.Resources.GetResourceByType("Affiliation") != null)
                    {
                        con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ToString());
                        //string s = "Select Distinct AffiliationID, AreaRecID From View_ListOfAppointments_Admin WHERE AppointmentID = " + int.Parse(e.Appointment.ID.ToString());
                        string s = "Select Distinct AffiliationID, SpecialtyID, IsDoubleVisit From View_Appointments_Scheduler WHERE AppointmentID = " + int.Parse(e.Appointment.ID.ToString());

                        cmd = new SqlCommand(s, con);
                        con.Open();
                        SqlDataReader dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                Session["ParticipantID"] = dr["AffiliationID"].ToString();
                                Session["SpecialtyID"] = dr["SpecialtyID"].ToString();
                                Session["IsDoubleVisit"] = dr["IsDoubleVisit"].ToString();
                            }
                        }
                        dr.Close();
                    }
                    //else
                    //{
                    //    Session["ParticipantID"] = e.Appointment.Resources.GetResourceByType("Affiliation").Key.ToString();
                    //}

                    int aaa = 1; int bbb = 0;
                    if (aaa == bbb)
                    {
                        ScriptManager.RegisterStartupScript(Page, typeof(Page), "OpenWindow", "window.open('CallsEntry.aspx');", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, typeof(Page), "OpenWindow", "window.open('Calls2.aspx');", true);
                    }
                }
                if (e.MenuItem.Value == "EditCall" && e.Appointment.Attributes["Annotations"] != "Created")
                {
                    Session["IsEditCall"] = 0;
                    //Label1.Text = "Alert!"+ "<br />" +"This appointment was finally saved or you did not creat a call for it";
                    //RadWindowManager1.RadAlert("This appointment was finally saved or you did not creat a call for it", 400, 200, "Alert!", null, "");
                    if (e.Appointment.Attributes["Annotations"] == "Appointment")
                    {
                        Label1.Text = "Alert!" + "<br />" + "You did not creat a call for this appointment";
                        RadWindowManager1.RadAlert("You did not creat a call for this appointment", 400, 200, "Alert!", null, "");
                    }
                    else
                    {
                        Label1.Text = "Alert!" + "<br />" + "This appointment was finally saved";
                        RadWindowManager1.RadAlert("This appointment was finally saved", 400, 200, "Alert!", null, "");
                    }
                }


                if (e.MenuItem.Value == "DisplayCall" && e.Appointment.Attributes["Annotations"] != "Appointment")
                {
                    Session["IsEditCall"] = 2;
                    Session["IsFinal"] = e.Appointment.Attributes["Annotations"];
                    Session["PlannedVisitID"] = int.Parse(e.Appointment.ID.ToString());
                    Session["PlannedVisitDate"] = e.Appointment.Start;
                    Session["IsDoubleVisit"] = 0;

                    if (e.Appointment.Resources.GetResourceByType("Affiliation") == null || e.Appointment.Resources.GetResourceByType("Affiliation") != null)
                    {
                        con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ToString());
                        //string s = "Select Distinct AffiliationID, AreaRecID From View_ListOfAppointments_Admin WHERE AppointmentID = " + int.Parse(e.Appointment.ID.ToString());
                        string s = "Select Distinct AffiliationID, SpecialtyID, IsDoubleVisit From View_Appointments_Scheduler WHERE AppointmentID = " + int.Parse(e.Appointment.ID.ToString());

                        cmd = new SqlCommand(s, con);
                        con.Open();
                        SqlDataReader dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                Session["ParticipantID"] = dr["AffiliationID"].ToString();
                                Session["SpecialtyID"] = dr["SpecialtyID"].ToString();
                                Session["IsDoubleVisit"] = dr["IsDoubleVisit"].ToString();
                            }
                        }
                        dr.Close();
                    }
                    //else
                    //{
                    //    Session["ParticipantID"] = e.Appointment.Resources.GetResourceByType("Affiliation").Key.ToString();
                    //}

                    int aaa = 1; int bbb = 0;
                    if (aaa == bbb)
                    {
                        ScriptManager.RegisterStartupScript(Page, typeof(Page), "OpenWindow", "window.open('CallsEntry.aspx');", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, typeof(Page), "OpenWindow", "window.open('Calls2.aspx');", true);
                    }
                }
                if (e.MenuItem.Value == "DisplayCall" && e.Appointment.Attributes["Annotations"] == "Appointment")
                {
                    Label1.Text = "Error" + "<br />" + "This appointment has no corresponding call";
                    RadWindowManager1.RadAlert("This appointment has no corresponding call", 400, 200, "Alert!", null, "");
                }

                if ((e.MenuItem.Value == "CommandDelete" || e.MenuItem.Value == "CommandEdit") && e.Appointment.Attributes["Annotations"] != "Appointment")
                {
                    Label1.Text = "Error" + "<br />" + "You cannot change or delete this appointment";
                    RadWindowManager1.RadAlert("You cannot change or delete this appointment", 400, 200, "Alert!", null, "");
                    return;
                }
            }
            catch (Exception ex)
            {
                Label1.Text = ex.Message;
                RadWindowManager1.RadAlert(ex.Source + "<br />" + ex.Message, 400, 200, "Alert!", null, "");
            }
        }

        protected void appointmentsDS_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@EmployeeID"].Value = Session["EmployeeID"].ToString();
            e.Command.Parameters["@RangeStart"].Value = RadScheduler1.VisibleRangeStart;
            e.Command.Parameters["@RangeEnd"].Value = RadScheduler1.VisibleRangeEnd;
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

        protected void appointmentsDS_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            int i = RadScheduler1.Appointments.Count;
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            RadScheduler1.ExportSettings.Pdf.PaperOrientation = Telerik.Web.UI.Scheduler.SchedulerPaperOrientation.Landscape;
            RadScheduler1.ExportSettings.Pdf.PaperSize = Telerik.Web.UI.Scheduler.SchedulerPaperSize.A4;
            RadScheduler1.ExportSettings.Pdf.PageLeftMargin = Unit.Pixel(10);
            RadScheduler1.ExportSettings.Pdf.PageRightMargin = Unit.Pixel(10);
            RadScheduler1.ExportSettings.OpenInNewWindow = true;
            RadScheduler1.ExportSettings.Pdf.PageWidth = Unit.Pixel(2400);
            RadScheduler1.ExportSettings.Pdf.PageHeight = Unit.Pixel(3400);
            RadScheduler1.ExportSettings.Pdf.AllowPaging = true;
            RadScheduler1.ExportSettings.Pdf.AllowPrinting = true;
            RadScheduler1.ExportSettings.Pdf.AllowCopy = true;
            RadScheduler1.ExportToPdf();
            Label1.Text = "Appointments Exported";
        }

        protected void RadScheduler1_AppointmentDelete(object sender, AppointmentDeleteEventArgs e)
        {
            if (e.Appointment.Attributes["Annotations"] != "Appointment")
            {
                e.Cancel = true;
                return;
            }
        }

        protected void RadScheduler1_TimeSlotCreated(object sender, TimeSlotCreatedEventArgs e)
        {
            List<DateTime> dtt = (List<DateTime>)(Session["SpecialDays"]);
            if (dtt.IndexOf(e.TimeSlot.Start.Date) == -1)
            {
                e.TimeSlot.CssClass = "rsSunCol";
            }
            else
            {
                e.TimeSlot.CssClass = "Disabled";
            }
            //foreach (DateTime dt in (List<DateTime>) (Session["SpecialDays"]))
            //{
            //    if ((DateTime.Compare(e.TimeSlot.Start.Date, dt) == 0))// || (e.TimeSlot.Start.DayOfWeek == DayOfWeek.Thursday) || (e.TimeSlot.Start.DayOfWeek == DayOfWeek.Friday)
            //    {
            //        //Set the CssClass property to visually distinguish your special days. 
            //        e.TimeSlot.CssClass = "Disabled";
            //        return;
            //    }
            //    else
            //    {
            //        e.TimeSlot.CssClass = "rsSunCol";
            //        return;
            //    }
            //}
        }

        private void newInsertAppointment(DateTime appDT, int affIDFromGrid, string affNameFromGrid, int brickIDFromGrid)
        {
            if ((affIDFromGrid.ToString() == "") || (affIDFromGrid.ToString() == null) || (affIDFromGrid.ToString() == "0"))
            {
                Label1.Text = "Please select a doctor you want to visit";
                RadWindowManager1.RadAlert("Please select a doctor you want to visit", 400, 200, "Select Doctor!", null, "");
                return;
            }

            string querySt = "Select COUNT(AppointmentID) From Appointments WHERE (DeletedAppointment IS NULL OR DeletedAppointment = 0) AND AffiliationID = " + affIDFromGrid.ToString() + " AND CycleID = " + Session["CycleID"].ToString() + " AND EmployeeID = " + Session["EmployeeID"].ToString();
            con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ToString());
            con.Open();
            SqlCommand queryCom = new SqlCommand(querySt, con);
            SqlDataReader queryReader = queryCom.ExecuteReader();
            int appsCount = 0;
            while (queryReader.Read())
            {
                appsCount = int.Parse(queryReader[0].ToString());
            }
            if ((appsCount == 2) && (affNameFromGrid[0].Equals("A+")) || (appsCount == 1) && (affNameFromGrid[0].Equals("A")))
            {
                //Label1.Text = "You Cannot Add More Appointments To This Doctor. He Reached a Max Number of Appointments"; //RadWindowManager1.RadAlert("You Cannot Add More Appointments To This Doctor", 400, 200, "Exceeding Visits!", null, ""); //return;
            }
            if (((appsCount == 2) && (affNameFromGrid.StartsWith("A+"))) || ((appsCount == 1) && (affNameFromGrid.StartsWith("A "))))
            {
                Label1.Text = "One or More Doctors(s) Reached a Max Number of Appointments";
                //RadWindowManager1.RadAlert("One or More Doctors(s) Reached a Max Number of Appointments", 400, 200, "Exceeding Visits!", null, "");
                return;
            }
            con.Close();

            con.Open();
            string querySt2 = "Select AppointmentID, StartDate From Appointments WHERE (DeletedAppointment IS NULL OR DeletedAppointment = 0) AND AffiliationID = " + affIDFromGrid.ToString() + " AND CycleID = " + Session["CycleID"].ToString() + " AND EmployeeID = " + Session["EmployeeID"].ToString();
            SqlCommand queryCom2 = new SqlCommand(querySt2, con);
            SqlDataReader queryReader2 = queryCom2.ExecuteReader();
            while (queryReader2.Read())
            {
                if (appDT.ToShortDateString() == (DateTime.Parse(queryReader2[1].ToString())).Date.ToShortDateString())
                {
                    //Label1.Text = "You Cannot Add Two or More Appointments To The Same Doctor In The Same Day";
                    //RadWindowManager1.RadAlert("You Cannot Add Two or More Appointments To The Same Doctor In The Same Day", 400, 200, "Exceeding Visits!", null, "");
                    //return;
                }
                if ((appDT.Date != null) && (appDT.Date.ToShortDateString() == (DateTime.Parse(queryReader2[1].ToString())).Date.ToShortDateString()))
                {
                    Label1.Text = "You Cannot Add Two or More Appointments To The Same Doctor In The Same Day";
                    RadWindowManager1.RadAlert("You Cannot Add Two or More Appointments To The Same Doctor In The Same Day", 400, 200, "Exceeding Visits!", null, "");
                    return;
                }
            }

            Label1.Text = "";

            dsFastNew.InsertParameters["Subject"].DefaultValue = affNameFromGrid;
            dsFastNew.InsertParameters["Description"].DefaultValue = "Added to Cycle: " + "Y" + appDT.Year.ToString() + "-" + appDT.Month.ToString();
            dsFastNew.InsertParameters["StartDate"].DefaultValue = (new DateTime(appDT.Year, appDT.Month, appDT.Day, appDT.Hour, appDT.Minute, appDT.Second)).ToString();
            dsFastNew.InsertParameters["EndDate"].DefaultValue = (new DateTime(appDT.Year, appDT.Month, appDT.Day, appDT.Hour, appDT.Minute + 30, appDT.Second)).ToString();
            dsFastNew.InsertParameters["AffiliationID"].DefaultValue = affIDFromGrid.ToString();
            dsFastNew.InsertParameters["EmployeeID"].DefaultValue = Session["EmployeeID"].ToString();
            dsFastNew.InsertParameters["LineID"].DefaultValue = Session["LineID"].ToString();
            dsFastNew.InsertParameters["BrickID"].DefaultValue = brickIDFromGrid.ToString();
            dsFastNew.InsertParameters["CycleID"].DefaultValue = (Session["CycleID"]).ToString();
            dsFastNew.InsertParameters["IsOriginal"].DefaultValue = "";
            dsFastNew.InsertParameters["Annotations"].DefaultValue = "Appointment";
            dsFastNew.InsertParameters["LastModified"].DefaultValue = DateTime.Now.ToString();
            dsFastNew.InsertParameters["RecurrenceRule"].DefaultValue = "";
            dsFastNew.InsertParameters["RecurrenceParentID"].DefaultValue = "";
            dsFastNew.InsertParameters["Reminder"].DefaultValue = "";

            dsFastNew.Insert();
            Label1.Text = "Appointment Saved";
            con.Close();
        }

        protected void btnSave3_Click(object sender, EventArgs e)
        {
            try
            {
                foreach (GridDataItem item in grd1.Items)
                {
                    if (item is GridDataItem)
                    {
                        RadDatePicker pic1 = (RadDatePicker) (item["PlannedDate"].FindControl("picVisitDate"));
                        if (pic1.SelectedDate != null)
                        {
                            DateTime tSelectedDate = DateTime.Parse(pic1.SelectedDate.ToString());
                            newInsertAppointment(tSelectedDate, int.Parse(item["AffiliationID"].Text), item["AffiliationName3"].Text, int.Parse(item["BrickID"].Text));
                        }
                        RadDatePicker pic2 = (RadDatePicker)(item["PlannedDate2"].FindControl("picVisitDate2"));
                        if ((pic2.SelectedDate != null) && (item["AffiliationName3"].Text.StartsWith("A+")))
                        {
                            DateTime tSelectedDate = DateTime.Parse(pic2.SelectedDate.ToString());
                            newInsertAppointment(tSelectedDate, int.Parse(item["AffiliationID"].Text), item["AffiliationName3"].Text, int.Parse(item["BrickID"].Text));
                        }
                    }
                }
                grd1.DataSourceID = null;
                grd1.DataSourceID = "dsAllAffs";
                grd1.DataBind();
            }
            catch (Exception ex)
            {
                Label1.Text = ex.Message;
                //RadWindowManager1.RadAlert(ex.Source + "<br />" + ex.Message, 400, 200, "Alert!", null, "");
            }
            finally
            {
                //con.Close();
            }
        }

        protected void btnSearch3_Click(object sender, EventArgs e)
        {
            try
            {
                string affsID = "0";
                foreach (GridDataItem item in grd1.Items)
                {
                    if (item is GridDataItem)
                    {
                        affsID += ", " + item["AffiliationID"].Text;
                    }
                }
                string searchPhrase = @"SELECT AppointmentID, [Subject], Description, StartDate, EndDate, AffiliationID, RecurrenceRule, RecurrenceParentID, Reminder, Annotations 
                                        FROM Appointments 
                                        WHERE ((DeletedAppointment IS NULL OR DeletedAppointment = 0) AND EmployeeID = " + int.Parse(Session["EmployeeID"].ToString()) + 
                                        " AND AffiliationID IN (" + affsID + ")" + 
                                        ")";
                appointmentsDS.SelectCommand = searchPhrase;
                RadScheduler1.DataBind();
                Label1.Text = "";

            }
            catch (Exception ex)
            {
                Label1.Text = ex.Message;
                //RadWindowManager1.RadAlert(ex.Source + "<br />" + ex.Message, 400, 200, "Alert!", null, "");
            }
            finally
            {
                //con.Close();
            }
        }

        protected void dtVisit1_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            try
            {
                foreach (GridDataItem item in grd1.Items)
                {
                    if (item is GridDataItem)
                    {
                        CheckBox chk = (CheckBox)(item["SelectRow"].FindControl("chkSelect"));
                        if (chk.Checked == true)
                        {
                            RadDatePicker pic1 = (RadDatePicker)(item["PlannedDate"].FindControl("picVisitDate"));
                            pic1.SelectedDate = dtVisit1.SelectedDate;

                            RadDatePicker pic2 = (RadDatePicker)(item["PlannedDate2"].FindControl("picVisitDate2"));
                            pic2.SelectedDate = dtVisit2.SelectedDate;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Label1.Text = ex.Message;
                //RadWindowManager1.RadAlert(ex.Source + "<br />" + ex.Message, 400, 200, "Alert!", null, "");
            }
            finally
            {
                //con.Close();
            }
        }

        protected void dtVisit2_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            try
            {
                foreach (GridDataItem item in grd1.Items)
                {
                    if (item is GridDataItem)
                    {
                        CheckBox chk = (CheckBox)(item["SelectRow"].FindControl("chkSelect"));
                        if (chk.Checked == true)
                        {
                            RadDatePicker pic1 = (RadDatePicker)(item["PlannedDate"].FindControl("picVisitDate"));
                            pic1.SelectedDate = dtVisit1.SelectedDate;

                            RadDatePicker pic2 = (RadDatePicker)(item["PlannedDate2"].FindControl("picVisitDate2"));
                            pic2.SelectedDate = dtVisit2.SelectedDate;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Label1.Text = ex.Message;
                //RadWindowManager1.RadAlert(ex.Source + "<br />" + ex.Message, 400, 200, "Alert!", null, "");
            }
            finally
            {
                //con.Close();
            }
        }

        protected void chkAll_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                foreach (GridDataItem item in grd1.Items)
                {
                    if (item is GridDataItem)
                    {
                        CheckBox chk = (CheckBox)(item["SelectRow"].FindControl("chkSelect"));
                        chk.Checked = ((CheckBox)sender).Checked;
                    }
                }
            }
            catch (Exception ex)
            {
                Label1.Text = ex.Message;
            }
            finally
            {
                //con.Close();
            }
        }
    }
}