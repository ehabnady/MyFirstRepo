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
    public partial class CallsScheduler : System.Web.UI.Page
    {
        //int repAreaID;

        //int plannedPhVisits;
        //SqlDataReader dr;
        SqlCommand cmd;
        SqlConnection con;
        DataView dv;
        DataTable dtAffsOut;
        //int affIndex;
        //SqlParameter affiliation;
        //SqlParameter entity;
        //SqlParameter physician;
        //SqlParameter syear;
        //SqlParameter smonth;
        //SqlParameter sday;
        //SqlParameter curPlannedVisitID;

        string myEx = " ";

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
                RadWindowManager1.RadAlert(ex.Source + " - " + ex.Message, 400, 200, "Alert!", null, "");
            }
        }

        //private void RegisterScript()
        //{
        //    Label1.Text = "Invalid move! There are appointments arranged for this time period.";
        //    ScriptManager.RegisterClientScriptBlock(this, GetType(), "LabelUpdated",
        //            "$telerik.$('.lblError').show().animate({ opacity: 0.9 }, 2000).fadeOut('slow');", true);
        //}

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeID"].ToString() == "")
            {
                Response.Redirect("~/Login2.aspx");
            }

            if (!Page.IsPostBack)
            {
                //Session["RepAreaID"] = "0";
                dtAffsOut = new DataTable();
            }
            Label1.Text = "";
            /*
             * <Calendar runat="server" FirstDayOfWeek="Saturday" EnableWeekends="false">
                                    <SpecialDays>
                                        <telerik:RadCalendarDay Date="07/06/2017" IsWeekend="true" IsSelectable="false" IsDisabled="true" Repeatable="Week">
                                            <ItemStyle BackColor="Black" ForeColor="Yellow" />
                                        </telerik:RadCalendarDay>
                                        <telerik:RadCalendarDay Date="07/07/2017" IsWeekend="true" IsSelectable="false" IsDisabled="true" Repeatable="Week">
                                            <ItemStyle BackColor="Black" ForeColor="Yellow" />
                                        </telerik:RadCalendarDay>
                                    </SpecialDays>                                    
                                </Calendar>
             * */

            

            
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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                string searchPhrase = "SELECT AppointmentID, [Subject], Description, StartDate, EndDate, AffiliationID, RecurrenceRule, RecurrenceParentID, Reminder, Annotations FROM Appointments WHERE ((DeletedAppointment IS NULL OR DeletedAppointment = 0) AND EmployeeID = " + int.Parse(Session["EmployeeID"].ToString()) + ")";
                //if (txtAffID.Text != "")
                //{
                //    searchPhrase += " AND AffiliationID = " + int.Parse(txtAffID.Text);
                //}
                if ((cbBricks.SelectedValue != "") && (cbBricks.SelectedValue != "0"))
                {
                    searchPhrase += " AND BrickID = " + int.Parse(cbBricks.SelectedValue);
                }
                if (cbAffs.SelectedValue != "")
                {
                    searchPhrase += " AND AffiliationID = " + int.Parse(cbAffs.SelectedValue);
                }

                appointmentsDS.SelectCommand = searchPhrase;
                RadScheduler1.DataBind();
                Label1.Text = "";
            }
            catch (Exception ex)
            {
                Label1.Text = ex.Source + "<br />" + ex.Message;
                RadWindowManager1.RadAlert(ex.Source + "<br />" + ex.Message, 400, 200, "Alert!", null, "");
            }
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
                if (DateTime.Now.Day > int.Parse(Session["AllowedDaysForPlanning"].ToString()))
                {
                    //Label1.Text = "You can not change a plan after a seventh day in month";
                    //return;
                }
                if (RadDateTimePicker1.SelectedDate < DateTime.Parse(Session["StartDate"].ToString()) || RadDateTimePicker1.SelectedDate.Value > DateTime.Parse(Session["EndDate"].ToString())) //Dimmed to allow a rep to plan to the next month
                {
                    Label1.Text = "Date Range Is Wrong, It Must Be Within a Current Cycle";// or a Next Cycle
                    //RegisterScript();
                    //MessageBox.Show("Date Range Is Wrong, It Must Be Within a Current Cycle", "Overlapped Appointment", MessageBoxButtons.OK, MessageBoxIcon.Information, MessageBoxDefaultButton.Button1, MessageBoxOptions.ServiceNotification);
                    return;
                }

                if (RadDateTimePicker2.SelectedDate != null)
                {
                    if (RadDateTimePicker2.SelectedDate < DateTime.Parse(Session["StartDate"].ToString()) || RadDateTimePicker2.SelectedDate.Value > DateTime.Parse(Session["EndDate"].ToString())) //Dimmed to allow a rep to plan to the next month
                    {
                        Label1.Text = "Date Range Is Wrong, It Must Be Within a Current Cycle or a Next Cycle";
                        //RegisterScript();
                        //MessageBox.Show("Date Range Is Wrong, It Must Be Within a Current Cycle", "Overlapped Appointment", MessageBoxButtons.OK, MessageBoxIcon.Information, MessageBoxDefaultButton.Button1, MessageBoxOptions.ServiceNotification);
                        return;
                    }
                }
                

                if ((RadDateTimePicker1.SelectedDate != null) && (cbAffs.SelectedValue != ""))
                {
                    insertAppointment(RadDateTimePicker1.SelectedDate.Value);
                }
                else
                {
                    Label1.Text = "Please select a date and a doctor";
                    RadWindowManager1.RadAlert("Please select a date and a doctor", 400, 200, "Alert!", null, "");
                    return;
                }
                
                if ((RadDateTimePicker2.SelectedDate != RadDateTimePicker1.SelectedDate) && (RadDateTimePicker2.SelectedDate != null))
                {
                    insertAppointment(RadDateTimePicker2.SelectedDate.Value);
                }
            }
            catch (Exception ex)
            {
                Label1.Text = ex.Message;
                RadWindowManager1.RadAlert(ex.Source + "<br />" + ex.Message, 400, 200, "Alert!", null, "");
            }
            finally
            {
                //con.Close();
            }
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

        private void OldInsertMethod(object sender, AppointmentInsertEventArgs e)
        {
            /*
            if (e.Appointment.Start < DateTime.Parse(Session["StartDate"].ToString()) || e.Appointment.Start > DateTime.Parse(Session["EndDate"].ToString()))
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
            cmd.Parameters["curPlannedRepID"].Value = int.Parse(Session["EmployeeID"].ToString());

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
                appointmentsDS.InsertParameters["EmployeeID"].DefaultValue = Session["EmployeeID"].ToString();
                appointmentsDS.InsertParameters["LineID"].DefaultValue = Session["LineID"].ToString();
                appointmentsDS.InsertParameters["AreaID"].DefaultValue = Session["AreaID"].ToString();
                appointmentsDS.InsertParameters["CycleID"].DefaultValue = Session["CycleID"].ToString();// ddlCycles.SelectedValue;
            }
            else
            {
                e.Appointment.Description = "One of Amoun Team will visit this physician in this day";
                Label1.Text = "One of Amoun Team will visit this physician in this day";
                RadWindowManager1.RadAlert("One of Amoun Team will visit this physician in this day", 400, 200, "Alert!", null, "");
                //RegisterScript();
                Label1.Text = "Overlapped Appointment <br /> One of Amoun Team has a visit to this physician in this day";
                RadWindowManager1.RadAlert("Overlapped Appointment <br /> One of Amoun Team has a visit to this physician in this day", 400, 200, "Alert!", null, "");
                e.Cancel = true;
            }
            con.Close();
            */
        }

        //private void OldUpdateMethod(object sender, AppointmentUpdateEventArgs e)
        //{
        //    if (e.ModifiedAppointment.Start < DateTime.Parse(Session["StartDateFromAdmin"].ToString()) || e.ModifiedAppointment.Start > DateTime.Parse(Session["EndDateFromAdmin"].ToString()))
        //    {
        //        Label1.Text = "Date Range Is Wrong, It Must Be Within a Current Cycle";
        //        //RegisterScript();
        //        //MessageBox.Show("Date Range Is Wrong, It Must Be Within a Current Cycle", "Overlapped Appointment", MessageBoxButtons.OK, MessageBoxIcon.Information, MessageBoxDefaultButton.Button1, MessageBoxOptions.ServiceNotification);
        //        e.Cancel = true;
        //    }
        //    e.ModifiedAppointment.Attributes["LastModified"] = DateTime.Now.ToString();

        //    con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ToString());
        //    affiliation = new SqlParameter();
        //    //entity = new SqlParameter();
        //    //physician = new SqlParameter();
        //    syear = new SqlParameter();
        //    smonth = new SqlParameter();
        //    sday = new SqlParameter();

        //    cmd = new SqlCommand();

        //    cmd.Parameters.Add("affiliation", SqlDbType.Int);
        //    //cmd.Parameters.Add("entity", SqlDbType.Int);
        //    //cmd.Parameters.Add("physician", SqlDbType.Int);
        //    cmd.Parameters.Add("syear", SqlDbType.Int);
        //    cmd.Parameters.Add("smonth", SqlDbType.Int);
        //    cmd.Parameters.Add("sday", SqlDbType.Int);
        //    cmd.Parameters.Add("curPlannedVisitID", SqlDbType.Int);
        //    cmd.Parameters.Add("curPlannedRepID", SqlDbType.Int);

        //    cmd.Parameters["affiliation"].Value = e.Appointment.Resources.GetResourceByType("Affiliation").Key.ToString();
        //    //cmd.Parameters["entity"].Value = e.Appointment.Resources.GetResourceByType("Entity").Key.ToString();
        //    //cmd.Parameters["physician"].Value = e.Appointment.Resources.GetResourceByType("Physician").Key.ToString();
        //    cmd.Parameters["syear"].Value = e.ModifiedAppointment.Start.Year;
        //    cmd.Parameters["smonth"].Value = e.ModifiedAppointment.Start.Month;
        //    cmd.Parameters["sday"].Value = e.ModifiedAppointment.Start.Day;
        //    cmd.Parameters["curPlannedVisitID"].Value = e.ModifiedAppointment.ID;
        //    cmd.Parameters["curPlannedRepID"].Value = int.Parse(Session["EmployeeID"].ToString());

        //    cmd.CommandText = "SELECT COUNT(*) FROM Appointments WHERE ( AffiliationID = " + cmd.Parameters["affiliation"].Value +
        //        " AND YEAR([StartDate]) = " + cmd.Parameters["syear"].Value +
        //        " AND MONTH([StartDate]) = " + cmd.Parameters["smonth"].Value +
        //        " AND Day([StartDate]) = " + cmd.Parameters["sday"].Value +
        //        " AND [AppointmentID] <> " + cmd.Parameters["curPlannedVisitID"].Value +
        //        " AND [EmployeeID] <> " + cmd.Parameters["curPlannedRepID"].Value +
        //        " )";
        //    //cmd.CommandText = "SELECT COUNT(*) FROM Appointments WHERE ( PhysicianID = " + cmd.Parameters["physician"].Value +
        //    //    " AND EntityID = " + cmd.Parameters["entity"].Value +
        //    //    " AND YEAR([StartDate]) = " + cmd.Parameters["syear"].Value +
        //    //    " AND MONTH([StartDate]) = " + cmd.Parameters["smonth"].Value +
        //    //    " AND Day([StartDate]) = " + cmd.Parameters["sday"].Value +
        //    //    " AND [AppointmentID] <> " + cmd.Parameters["curPlannedVisitID"].Value +
        //    //    " )";

        //    //cmd.CommandText = "SELECT COUNT(*) FROM Appointments WHERE ( UserID = " + cmd.Parameters[1].Value + " AND RoomID = " + cmd.Parameters[0].Value + ")";
        //    cmd.Connection = con;
        //    con.Open();

        //    plannedPhVisits = 0;
        //    dr = cmd.ExecuteReader();
        //    if (dr.HasRows == true)
        //    {
        //        while (dr.Read())
        //        {
        //            plannedPhVisits = int.Parse(dr[0].ToString());
        //        }
        //    }
        //    if (plannedPhVisits == 0)
        //    {
        //        /*
        //        appointmentsDS.InsertParameters["RepID"].DefaultValue = Session["EmployeeID"].ToString();
        //        appointmentsDS.InsertParameters["GroupID"].DefaultValue = Session["LineID"].ToString();
        //        appointmentsDS.InsertParameters["AreaID"].DefaultValue = One of Amoun Team will visit this physician in this daySession["AreaID"].ToString();
        //        appointmentsDS.InsertParameters["CycleID"].DefaultValue = Session["CycleID"].ToString();
        //         * */
        //    }
        //    else
        //    {
        //        e.Appointment.Description = "One of Amoun Team will visit this physician in this day";
        //        Label1.Text = "One of Amoun Team will visit this physician in this day";
        //        RadWindowManager1.RadAlert("One of Amoun Team will visit this physician in this day", 400, 200, "Alert!", null, "");
        //        //RegisterScript();
        //        Label1.Text = "Overlapped Appointment" + "<br />" + "One of Amoun team has a visit to this physician in this day";
        //        RadWindowManager1.RadAlert("Overlapped Appointment <br /> One of Amoun team has a visit to this physician in this day", 400, 200, "Alert!", null, "");
        //        e.Cancel = true;
        //    }
        //    con.Close();
        //}

        protected void radDate1_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            if (RadDateTimePicker1.SelectedDate != null)
            {
                if (RadDateTimePicker1.SelectedDate < DateTime.Parse(Session["StartDate"].ToString()) || RadDateTimePicker1.SelectedDate.Value > DateTime.Parse(Session["EndDate"].ToString())) //((RadDateTimePicker1.SelectedDate < DateTime.Parse(Session["StartDate"].ToString())))//(RadDateTimePicker1.SelectedDate > DateTime.Now) || (RadDateTimePicker1.SelectedDate >= DateTime.Parse(Session["EndDate"].ToString())) ||  Dimmed to enable planning
                {
                    RadWindowManager1.RadAlert("Select Righ Appointment Date", 400, 200, "Wrong Date!", null, "");
                    RadDateTimePicker1.SelectedDate = null;
                    return;
                }

                if (((List<DateTime>)(Session["SpecialDays"])).Contains(RadDateTimePicker1.SelectedDate.Value))
                {
                    RadWindowManager1.RadAlert("This appointment will be added in a national vaccation day", 400, 200, "National Vaccation Day!", null, "");
                    return;
                }
                if (RadDateTimePicker1.SelectedDate.Value.DayOfWeek == DayOfWeek.Thursday)
                {
                    RadWindowManager1.RadAlert("This appointment will be added in Thursday", 400, 200, "Thursday!", null, "");
                    return;
                }
            }
        }

        protected void cbBricks_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            try
            {
                string selectText = "SELECT Distinct AffiliationID, AffiliationName2, AffiliationName3, PhysicianClass, SpecialtyID, SpecialtyValue, TotalValue, BrickID FROM View_Affiliations_Scheduler WHERE (PhysicianClass IN ('A+', 'A') AND SpecialtyValue > 0 AND LastModifierID IS NOT NULL AND EmployeeID = " + int.Parse(Session["EmployeeID"].ToString()) + " AND LineID = " + int.Parse(Session["LineID"].ToString()) + ")";// + " AND CycleID = " + int.Parse(Session["CycleID"].ToString()) Dimmed to allow planning from not targeted
                //string selectText = "SELECT Distinct AffiliationID, AffiliationName2, PhysicianClass, SpecialtyID FROM View_Affiliations_Scheduler WHERE (RepAreaID = " + int.Parse(Session["AreaID"].ToString()) + " AND LineID = " + int.Parse(Session["LineID"].ToString()) + ")";

                if (DateTime.Now.Day <= int.Parse(Session["AllowedDaysForPlanning"].ToString()))
                {
                    //selectText += " AND [Is Targeted] = 'Targeted' AND (BrickID = @BrickID)";
                }

                if (cbBricks.SelectedIndex > 0)
                {
                    selectText += " AND (BrickID = @BrickID)";
                    dsAffsOut.SelectCommand = selectText;
                    dsAffsOut.SelectParameters[0].DefaultValue = cbBricks.SelectedValue;
                }

                if (cbClass.SelectedIndex > 0)
                {
                    selectText += " AND (PhysicianClass IN (@PhysicianClass))";
                    dsAffsOut.SelectCommand = selectText;
                    dsAffsOut.SelectParameters[1].DefaultValue = "'" + cbClass.SelectedValue + "'";
                }
                //else
                //{
                //    selectText += " AND (PhysicianClass IN (@PhysicianClass))";
                //    dsAffsOut.SelectCommand = selectText;
                //    dsAffsOut.SelectParameters[1].DefaultValue = "'A', 'B', 'C'";
                //}

                if (cbSpec.SelectedIndex > 0)
                {
                    selectText += " AND (SpecialtyID = @SpecialtyID)";
                    dsAffsOut.SelectCommand = selectText;
                    dsAffsOut.SelectParameters[2].DefaultValue = cbSpec.SelectedValue;
                }
                //else
                //{
                //    selectText += " AND (SpecialtyID >= @SpecialtyID)";
                //    dsAffsOut.SelectCommand = selectText;
                //    dsAffsOut.SelectParameters[2].DefaultValue = "0";
                //}
                //dsAffsOut.SelectCommand = selectText;
                //dsAffsOut.SelectParameters[0].DefaultValue = cbBricks.SelectedValue;

                selectText += " ORDER BY TotalValue Desc, SpecialtyValue DESC";
                dsAffsOut.SelectCommand = selectText;
                dsAffsOut.DataBind();

                dtAffsOut = ((DataView)dsAffsOut.Select(DataSourceSelectArguments.Empty)).ToTable();
                Session["dtAffsOut"] = dtAffsOut;

                cbAffs.DataSource = dsAffsOut;
                cbAffs.DataTextField = "AffiliationName3";//AffiliationName2
                cbAffs.DataValueField = "AffiliationID";
                cbAffs.DataBind();
                //dsAffsOut.SelectParameters[0].DefaultValue = cbBricks.SelectedValue;
                //selectText += " ORDER BY AffiliationName2 Desc";
            }
            catch (Exception ex)
            {
                return;
            }
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

        //protected void cbAffs_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        //{
        //    dv = (DataView)dsAffsOut.Select(DataSourceSelectArguments.Empty);
        //    dv.Sort = "AffiliationID";
        //    int affIndex = dv.Find(cbAffs.SelectedValue);
        //}

        protected void RadDateTimePicker2_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            if (RadDateTimePicker2.SelectedDate != null)
            {
                if (RadDateTimePicker2.SelectedDate < DateTime.Parse(Session["StartDate"].ToString()) || RadDateTimePicker2.SelectedDate.Value > DateTime.Parse(Session["EndDate"].ToString())) //(RadDateTimePicker2.SelectedDate < DateTime.Parse(Session["StartDate"].ToString()))//(RadDateTimePicker2.SelectedDate > DateTime.Now) || (RadDateTimePicker2.SelectedDate >= DateTime.Parse(Session["EndDate"].ToString())) ||  Dimmed to enable planning
                {
                    RadWindowManager1.RadAlert("Select Righ Appointment Date", 400, 200, "Wrong Date!", null, "");
                    RadDateTimePicker2.SelectedDate = null;
                    return;
                }

                if (((List<DateTime>)(Session["SpecialDays"])).Contains(RadDateTimePicker2.SelectedDate.Value))
                {
                    RadWindowManager1.RadAlert("This appointment will be added in a national vaccation day", 400, 200, "National Vaccation Day!", null, "");
                    return;
                }
                if (RadDateTimePicker2.SelectedDate.Value.DayOfWeek == DayOfWeek.Thursday)
                {
                    RadWindowManager1.RadAlert("This appointment will be added in Thursday", 400, 200, "Thursday!", null, "");
                    return;
                }
            }
        }

        private void insertAppointment(DateTime appDT)
        {
            if ((cbAffs.SelectedValue == "") || (cbAffs.SelectedValue == null) || (cbAffs.SelectedValue == "0"))
            {
                Label1.Text = "Please select a doctor you want to visit";
                RadWindowManager1.RadAlert("Please select a doctor you want to visit", 400, 200, "Select Doctor!", null, "");
                return;
            }

            string querySt = "Select COUNT(AppointmentID) From Appointments WHERE (DeletedAppointment IS NULL OR DeletedAppointment = 0) AND AffiliationID = " + cbAffs.SelectedValue + " AND CycleID = " + Session["CycleID"].ToString() + " AND EmployeeID = " + Session["EmployeeID"].ToString();
            con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ToString());
            con.Open();
            SqlCommand queryCom = new SqlCommand(querySt, con);
            SqlDataReader queryReader = queryCom.ExecuteReader();
            int appsCount = 0;
            while (queryReader.Read())
            {
                appsCount = int.Parse(queryReader[0].ToString());
            }
            if ((appsCount == 2) && (cbAffs.SelectedItem.Text[0].ToString().Equals("A+")) || (appsCount == 1) && (cbAffs.SelectedItem.Text[0].ToString().Equals("A")))
            {
                //Label1.Text = "You Cannot Add More Appointments To This Doctor. He Reached a Max Number of Appointments";
                //RadWindowManager1.RadAlert("You Cannot Add More Appointments To This Doctor", 400, 200, "Exceeding Visits!", null, "");
                //return;
            }
            if (((appsCount == 2) && (cbAffs.SelectedItem.Text.ToString().StartsWith("A+"))) || ((appsCount == 1) && (cbAffs.SelectedItem.Text.ToString().StartsWith("A "))))
            {
                Label1.Text = "You Cannot Add More Appointments To This Doctor. He Reached a Max Number of Appointments";
                RadWindowManager1.RadAlert("You Cannot Add More Appointments To This Doctor", 400, 200, "Exceeding Visits!", null, "");
                return;
            }
            con.Close();

            con.Open();
            string querySt2 = "Select AppointmentID, StartDate From Appointments WHERE (DeletedAppointment IS NULL OR DeletedAppointment = 0) AND AffiliationID = " + cbAffs.SelectedValue + " AND CycleID = " + Session["CycleID"].ToString() + " AND EmployeeID = " + Session["EmployeeID"].ToString();
            SqlCommand queryCom2 = new SqlCommand(querySt2, con);
            SqlDataReader queryReader2 = queryCom2.ExecuteReader();
            while (queryReader2.Read())
            {
                if (RadDateTimePicker1.SelectedDate.Value.ToShortDateString() == (DateTime.Parse(queryReader2[1].ToString())).Date.ToShortDateString())
                {
                    Label1.Text = "You Cannot Add Two or More Appointments To The Same Doctor In The Same Day";
                    //RadWindowManager1.RadAlert("You Cannot Add Two or More Appointments To The Same Doctor In The Same Day", 400, 200, "Exceeding Visits!", null, "");
                    //return;
                }
                if ((RadDateTimePicker2.SelectedDate != null) && (RadDateTimePicker2.SelectedDate.Value.ToShortDateString() == (DateTime.Parse(queryReader2[1].ToString())).Date.ToShortDateString()))
                {
                    Label1.Text = "You Cannot Add Two or More Appointments To The Same Doctor In The Same Day";
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

            //if (appDT != null)
            //{
            //    if (((List<DateTime>)(Session["SpecialDays"])).Contains(appDT.Date))
            //    {
            //        RadWindowManager1.RadAlert("This appointment will be added in a national vaccation day", 400, 200, "National Vaccation Day!", null, "");
            //        return;
            //    }
            //}

            Label1.Text = "";
            //int firstSat = getFirstSat(int.Parse(Session["MonthID"].ToString()));

            DataView dvAffsOut = ((DataTable)Session["dtAffsOut"]).DefaultView;
            dvAffsOut.RowFilter = "AffiliationID = " + int.Parse(cbAffs.SelectedValue);

            dsFastNew.InsertParameters["Subject"].DefaultValue = cbAffs.SelectedItem.Text; //cbAffs.SelectedValue + " - " + cbAffs.SelectedItem.Text;
            dsFastNew.InsertParameters["Description"].DefaultValue = "Added to Cycle: " + "Y" + appDT.Year.ToString() + "-" + appDT.Month.ToString();
            dsFastNew.InsertParameters["StartDate"].DefaultValue = (new DateTime(appDT.Year, appDT.Month, appDT.Day, appDT.Hour, appDT.Minute, appDT.Second)).ToString();//(new DateTime(int.Parse(Session["CurrentYear"].ToString()), int.Parse(Session["MonthID"].ToString()), 5, 8, 30, 0)).ToString();
            dsFastNew.InsertParameters["EndDate"].DefaultValue = (new DateTime(appDT.Year, appDT.Month, appDT.Day, appDT.Hour, appDT.Minute + 30, appDT.Second)).ToString();//(new DateTime(int.Parse(Session["CurrentYear"].ToString()), int.Parse(Session["MonthID"].ToString()), 5, 9, 0, 0)).ToString();
            dsFastNew.InsertParameters["AffiliationID"].DefaultValue = cbAffs.SelectedValue; /*txtAffID.Text;*/
            dsFastNew.InsertParameters["EmployeeID"].DefaultValue = Session["EmployeeID"].ToString();
            dsFastNew.InsertParameters["LineID"].DefaultValue = Session["LineID"].ToString();
            dsFastNew.InsertParameters["BrickID"].DefaultValue = dvAffsOut[0][7].ToString();//cbBricks.SelectedValue;//dv[affIndex]["BrickID"].ToString();//Session["AreaID"].ToString();
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

        protected void btnCopy_Click(object sender, EventArgs e)
        {
            try
            {
                if (DateTime.Now.Day > int.Parse(Session["AllowedDaysForPlanning"].ToString()))
                {
                    //Label1.Text = "You can not change a plan after a seventh day in month";
                    //return;
                }
                if (RadDateTimePicker1.SelectedDate < DateTime.Parse(Session["StartDate"].ToString()) || RadDateTimePicker1.SelectedDate.Value > DateTime.Parse(Session["EndDate"].ToString())) //Dimmed to allow a rep to plan to the next month
                {
                    Label1.Text = "Date Range Is Wrong, It Must Be Within a Current Cycle or a Next Cycle";
                    //RegisterScript();
                    //MessageBox.Show("Date Range Is Wrong, It Must Be Within a Current Cycle", "Overlapped Appointment", MessageBoxButtons.OK, MessageBoxIcon.Information, MessageBoxDefaultButton.Button1, MessageBoxOptions.ServiceNotification);
                    return;
                }
                if (RadDateTimePicker2.SelectedDate < DateTime.Parse(Session["StartDate"].ToString()) || RadDateTimePicker2.SelectedDate.Value > DateTime.Parse(Session["EndDate"].ToString())) //Dimmed to allow a rep to plan to the next month
                {
                    Label1.Text = "Date Range Is Wrong, It Must Be Within a Current Cycle or a Next Cycle";
                    //RegisterScript();
                    //MessageBox.Show("Date Range Is Wrong, It Must Be Within a Current Cycle", "Overlapped Appointment", MessageBoxButtons.OK, MessageBoxIcon.Information, MessageBoxDefaultButton.Button1, MessageBoxOptions.ServiceNotification);
                    return;
                }
                
                if ((RadDateTimePicker2.SelectedDate != RadDateTimePicker1.SelectedDate) && (RadDateTimePicker2.SelectedDate != null) && (RadDateTimePicker1.SelectedDate != null))
                {
                    int i = insertAppointment2(RadDateTimePicker1.SelectedDate.Value, RadDateTimePicker2.SelectedDate.Value);
                    if (i == 0)
                    {
                        Label1.Text = "You cannot create appointments to the doctors in this day";
                    }
                    if (i == 200)
                    {
                        Label1.Text = "Errors occured during this process, refresh and try again";
                        //Label1.Text = myEx;
                    }
                }
                else
                {
                    Label1.Text = "Please select both dates";
                    RadWindowManager1.RadAlert("Please select both dates", 400, 200, "Alert!", null, "");
                    return;
                }
            }
            catch (Exception ex)
            {
                Label1.Text = ex.Message;
                //RadWindowManager1.RadAlert(ex.Source + "<br />" + ex.Message, 400, 200, "Alert!", null, "");
                return;
            }
            finally
            {
                //con.Close();
            }
        }

        private int insertAppointment2(DateTime appDT, DateTime appDT2)
        {
            try
            {
                con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ToString());
                //SqlCommand queryCom = new SqlCommand("GetAppsCountPerAff", con);
                //queryCom.Parameters.AddWithValue("appsDate", appDT.Date.ToShortDateString());
                //queryCom.Parameters.AddWithValue("cycleID", Session["CycleID"].ToString());
                //queryCom.Parameters.AddWithValue("employeeID", Session["EmployeeID"].ToString());
                //queryCom.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter("GetAppsCountPerAff", con.ConnectionString);
                da.SelectCommand.Parameters.AddWithValue("appsDate", appDT.Date.ToShortDateString());
                da.SelectCommand.Parameters.AddWithValue("cycleID", Session["CycleID"].ToString());
                da.SelectCommand.Parameters.AddWithValue("employeeID", Session["EmployeeID"].ToString());
                da.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataTable t = new DataTable();

                con.Open();
                da.Fill(t);
                t.DefaultView.RowFilter = "(PhysicianClass = 'A+' AND AppsCount < 2) OR (PhysicianClass = 'A' AND AppsCount < 1)";
                DataView dv = t.DefaultView;
                dv.RowFilter = "(PhysicianClass = 'A+' AND AppsCount < 2) OR (PhysicianClass = 'A' AND AppsCount < 1)";
                
                //SqlDataSource ds = new SqlDataSource(con.ConnectionString, queryCom.CommandText);
                //ds.SelectCommandType = SqlDataSourceCommandType.StoredProcedure;
                //ds.SelectParameters.Add("@appsDate", appDT.Date.ToShortDateString());
                //ds.SelectParameters.Add("cycleID", Session["CycleID"].ToString());
                //ds.SelectParameters.Add("employeeID", Session["EmployeeID"].ToString());
                //ds.SelectParameters[0].DbType = DbType.DateTime;
                //ds.SelectParameters[1].DbType = DbType.Int32;
                //ds.SelectParameters[2].DbType = DbType.Int32;
                //ds.DataBind();
                //DataView dv = (DataView) ds.Select(DataSourceSelectArguments.Empty);                
                //dv.RowFilter = "(PhysicianClass = 'A' AND AppsCount < 2) OR (PhysicianClass = 'B' AND AppsCount < 1)";

                foreach (DataRow r in dv.ToTable().Rows)
                {
                    dsFastNew.InsertParameters["Subject"].DefaultValue = r[1].ToString(); //cbAffs.SelectedValue + " - " + cbAffs.SelectedItem.Text;
                    dsFastNew.InsertParameters["Description"].DefaultValue = "Added to Cycle: " + "Y" + appDT2.Year.ToString() + "-" + appDT2.Month.ToString();
                    dsFastNew.InsertParameters["StartDate"].DefaultValue = (new DateTime(appDT2.Year, appDT2.Month, appDT2.Day, appDT2.Hour, appDT2.Minute, appDT2.Second)).ToString();//(new DateTime(int.Parse(Session["CurrentYear"].ToString()), int.Parse(Session["MonthID"].ToString()), 5, 8, 30, 0)).ToString();
                    dsFastNew.InsertParameters["EndDate"].DefaultValue = (new DateTime(appDT2.Year, appDT2.Month, appDT2.Day, appDT2.Hour, appDT2.Minute + 30, appDT2.Second)).ToString();//(new DateTime(int.Parse(Session["CurrentYear"].ToString()), int.Parse(Session["MonthID"].ToString()), 5, 9, 0, 0)).ToString();
                    dsFastNew.InsertParameters["AffiliationID"].DefaultValue = r[0].ToString();
                    dsFastNew.InsertParameters["EmployeeID"].DefaultValue = Session["EmployeeID"].ToString();
                    dsFastNew.InsertParameters["LineID"].DefaultValue = Session["LineID"].ToString();
                    dsFastNew.InsertParameters["BrickID"].DefaultValue = r[3].ToString();
                    dsFastNew.InsertParameters["CycleID"].DefaultValue = (Session["CycleID"]).ToString();
                    dsFastNew.InsertParameters["IsOriginal"].DefaultValue = "";
                    dsFastNew.InsertParameters["Annotations"].DefaultValue = "Appointment";
                    dsFastNew.InsertParameters["LastModified"].DefaultValue = DateTime.Now.ToString();
                    dsFastNew.InsertParameters["RecurrenceRule"].DefaultValue = "";
                    dsFastNew.InsertParameters["RecurrenceParentID"].DefaultValue = "";
                    dsFastNew.InsertParameters["Reminder"].DefaultValue = "";

                    dsFastNew.Insert();
                }
                con.Close();
                int execStatus = dv.ToTable().Rows.Count;
                Label1.Text = "Appointment(s) saved for " + execStatus + " doctors";
                return execStatus;
            }
            catch (Exception ex)
            {
                myEx = myEx = ex.Message;
                int execStatus = 200;
                return execStatus;
            }
        }

        //protected void RadDateTimePicker1_PreRender(object sender, EventArgs e)
        //{
        //    RadDateTimePicker1.Calendar.FirstDayOfWeek = FirstDayOfWeek.Saturday;
        //    RadDateTimePicker1.Calendar.EnableWeekends = false;

        //    //RadCalendarDay dayThu = new RadCalendarDay();
        //    //dayThu.Date = new DateTime(2017, 7, 6);
        //    //dayThu.IsWeekend = true;
        //    //dayThu.IsSelectable = false;
        //    //dayThu.IsDisabled = true;
        //    //dayFri.ItemStyle.BackColor = Color.Black;
        //    //dayFri.ItemStyle.ForeColor = Color.White;
        //    //dayThu.Repeatable = Telerik.Web.UI.Calendar.RecurringEvents.Week;
        //    //RadDateTimePicker1.Calendar.SpecialDays.Add(dayThu);

        //    RadCalendarDay dayFri = new RadCalendarDay();
        //    dayFri.Date = new DateTime(2017, 7, 7);
        //    dayFri.IsWeekend = true;
        //    dayFri.IsSelectable = false;
        //    dayFri.IsDisabled = true;
        //    //dayFri.ItemStyle.BackColor = Color.Black;
        //    //dayFri.ItemStyle.ForeColor = Color.White;
        //    dayFri.Repeatable = Telerik.Web.UI.Calendar.RecurringEvents.Week;
        //    RadDateTimePicker1.Calendar.SpecialDays.Add(dayFri);
        //}
    }
}