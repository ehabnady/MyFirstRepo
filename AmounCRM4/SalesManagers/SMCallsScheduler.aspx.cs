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

namespace AmounCRM4.SalesManagers
{
    public partial class SMCallsScheduler : System.Web.UI.Page
    {
        //int repAreaID;

        //int plannedPhVisits;
        //SqlDataReader dr;
        SqlCommand cmd;
        SqlConnection con;
        //SqlParameter affiliation;
        //SqlParameter entity;
        //SqlParameter physician;
        //SqlParameter syear;
        //SqlParameter smonth;
        //SqlParameter sday;
        //SqlParameter curPlannedVisitID;

        string allEmps = "0";
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

            if (Session["EmployeeIDFromSM"].ToString() == "0")
            {
                Response.Redirect("~/Login2.aspx");
            }

            if (!Page.IsPostBack)
            {
                //Session["RepAreaID"] = "0";
                //dsBricks.SelectParameters[0].DefaultValue = cbReps.SelectedValue;
                dsBricks.DataBind();
                cbBricks.DataBind();
                //cbReps.DataBind();
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
            e.Cancel = true;
        }

        protected void RadScheduler1_AppointmentUpdate(object sender, AppointmentUpdateEventArgs e)
        {
            e.Cancel = true;
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
                    //string s = "Select Distinct AffiliationID, AreaRecID From View_ListOfAppointments_Admin WHERE AppointmentID = " + int.Parse(e.Appointment.ID.ToString());
                    string s = "Select Distinct AffiliationID, SpecialtyID, LineID From View_Appointments_Scheduler WHERE AppointmentID = " + int.Parse(e.Appointment.ID.ToString());

                    cmd = new SqlCommand(s, con);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            Session["ParticipantID"] = dr["AffiliationID"].ToString();
                            Session["SpecialtyID"] = dr["SpecialtyID"].ToString();
                            Session["LineID_Sch"] = dr["LineID"].ToString();
                            //affDS.SelectParameters[0].DefaultValue = Session["AreaID"].ToString();//Session["RepAreaIDFromAdmin"] instead of repAreaID
                            //affDS.SelectParameters[1].DefaultValue = Session["LineID"].ToString();//Session["RepAreaIDFromAdmin"] instead of repAreaID
                        }
                    }
                    dr.Close();
                }
                else
                {
                    //Session["ParticipantIDFromAdmin"] = e.Appointment.Resources.GetResourceByType("Affiliation").Key.ToString();
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
                    if (DateTime.Now.Day < e.Appointment.Start.Day && DateTime.Now.Month <= int.Parse(Session["MonthID"].ToString()))
                    {
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
                    if (DateTime.Now.Day < e.Appointment.Start.Day)
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
                    Label1.Text = "Alert!" + "<br />" + "This appointment was finally saved or you did not creat a call for it";
                    RadWindowManager1.RadAlert("This appointment was finally saved or you did not creat a call for it", 400, 200, "Alert!", null, "");
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
                        string s = "Select Distinct AffiliationID, SpecialtyID, LineID, IsDoubleVisit From View_Appointments_Scheduler WHERE AppointmentID = " + int.Parse(e.Appointment.ID.ToString());

                        cmd = new SqlCommand(s, con);
                        con.Open();
                        SqlDataReader dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                Session["ParticipantID"] = dr["AffiliationID"].ToString();
                                Session["SpecialtyID"] = dr["SpecialtyID"].ToString();
                                Session["LineID_Sch"] = dr["LineID"].ToString();
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
            e.Command.Parameters["@EmployeeID"].Value = cbReps.SelectedValue.ToString();
            e.Command.Parameters["@RangeStart"].Value = RadScheduler1.VisibleRangeStart;
            e.Command.Parameters["@RangeEnd"].Value = RadScheduler1.VisibleRangeEnd;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                foreach (RadComboBoxItem item in cbReps.Items)
                {
                    allEmps += ", " + item.Value;
                }

                string searchPhrase = @"SELECT AppointmentID, [Subject], Description, StartDate, EndDate, AffiliationID, RecurrenceRule, 
                                        RecurrenceParentID, Reminder, Annotations FROM Appointments 
                                        WHERE ((DeletedAppointment IS NULL OR DeletedAppointment = 0) AND EmployeeID IN (" + allEmps + "))";
                //if (txtAffID.Text != "")
                //{
                //    searchPhrase += " AND AffiliationID = " + int.Parse(txtAffID.Text);
                //}
                if ((cbReps.SelectedValue != "0") && (cbAffs.SelectedValue == "0"))
                {
                    searchPhrase += " AND EmployeeID = " + int.Parse(cbReps.SelectedValue);
                }
                if ((cbBricks.SelectedValue != "0") && (cbAffs.SelectedValue == "0"))
                {
                    searchPhrase += " AND BrickID = " + int.Parse(cbBricks.SelectedValue);
                }
                if (cbAffs.SelectedValue != "0")
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

        protected void cbBricks_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            
        }

        protected void RadScheduler1_AppointmentDelete(object sender, AppointmentDeleteEventArgs e)
        {
            e.Cancel = true;
        }

        protected void btnGetDoctors_Click(object sender, EventArgs e)
        {
            try
            {
                string selectText = @"SELECT Distinct AffiliationID, AffiliationName2, AffiliationName3, PhysicianClass, SpecialtyID, SpecialtyValue, 
                                        TotalValue FROM View_Affiliations_Scheduler WHERE (PhysicianClass IN ('A', 'B', 'A+') AND SpecialtyValue > 0 
                                        AND LastModifierID IS NOT NULL AND TopManagerID = " + int.Parse(Session["EmployeeIDFromSM"].ToString()) + ")";// + " AND CycleID = " + int.Parse(Session["CycleID"].ToString()) Dimmed to allow planning from not targeted

                if (cbReps.SelectedIndex > 0)
                {
                    selectText += " AND (EmployeeID = @EmployeeID)";
                    dsAffsOut.SelectCommand = selectText;
                    dsAffsOut.SelectParameters[0].DefaultValue = cbReps.SelectedValue;
                }

                if (cbBricks.SelectedIndex > 0)
                {
                    selectText += " AND (BrickID = @BrickID)";
                    dsAffsOut.SelectCommand = selectText;
                    dsAffsOut.SelectParameters[1].DefaultValue = cbBricks.SelectedValue;
                }

                selectText += " ORDER BY TotalValue Desc, SpecialtyValue DESC";
                dsAffsOut.SelectCommand = selectText;

                //cbBricks.Items.Clear();
                //cbBricks.DataBind();

                dsAffsOut.DataBind();
                //cbAffs.DataSourceID = "dsAffsOut";
                cbAffs.DataSource = dsAffsOut;
                cbAffs.DataTextField = "AffiliationName3";
                cbAffs.DataValueField = "AffiliationID";
                cbAffs.Items.Clear();
                cbAffs.AppendDataBoundItems = true;
                cbAffs.Items.Add(new RadComboBoxItem("Doctors", "0"));
                cbAffs.DataBind();

                //dsAffsOut.SelectParameters[0].DefaultValue = cbBricks.SelectedValue;
                //selectText += " ORDER BY AffiliationName2 Desc";
            }
            catch (Exception ex)
            {
                return;
            }
        }

        protected void cbReps_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            cbBricks.Items.Clear();
            cbBricks.AppendDataBoundItems = true;
            cbBricks.Items.Add(new RadComboBoxItem("Bricks", "0"));
            cbBricks.DataBind();
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
        }

        protected void cbDMs_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            cbReps.Items.Clear();
            cbReps.AppendDataBoundItems = true;
            cbReps.Items.Add(new RadComboBoxItem("Reps", "0"));
            cbReps.DataBind();

            cbBricks.Items.Clear();
            cbBricks.AppendDataBoundItems = true;
            cbBricks.Items.Add(new RadComboBoxItem("Bricks", "0"));
            cbBricks.DataBind();
        }
    }
}
