using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace AmounCRM4
{
    public partial class Site2 : System.Web.UI.MasterPage
    {
        SqlConnection con;
        SqlCommand cmd4;

        protected void Page_Load(object sender, EventArgs e)
        {
            hlNotificationsRep2.Text = "";
            hlNotificationsDM.Text = "";

            if (int.Parse(Session["MessagesCount"].ToString()) > 0)
            {
                hlNotificationsRep2.Text = " (" + Session["MessagesCount"].ToString() + " )";
                hlNotificationsRep2.ToolTip = hlNotificationsRep2.Text;
                hlNotificationsRep2.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                hlNotificationsRep2.Text = "";
                hlNotificationsRep2.ToolTip = "No Messages Sent to You";
                hlNotificationsRep2.ForeColor = System.Drawing.Color.Transparent;
            }

            if (int.Parse(Session["MessagesCount"].ToString()) > 0)
            {
                hlNotificationsDM.Text += "Notifications ( " + Session["MessagesCount"].ToString() + " )";
                hlNotificationsDM.ToolTip = hlNotificationsDM.Text;
                hlNotificationsDM.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                hlNotificationsDM.Text += "Notifications ( " + Session["MessagesCount"].ToString() + " )";
                hlNotificationsDM.ToolTip = "No Messages Sent to You";
                hlNotificationsDM.ForeColor = System.Drawing.Color.Transparent;
            }

            Page.Header.DataBind();

            if (!Page.IsPostBack)
            {
                if (Session["EmployeeType"].ToString() == "")
                {
                    lblEmployeeName.Text = "";
                    lblCycleName.Text = "";
                    lblAreaName.Text = "";
                }

                if (Session["EmployeeType"].ToString() != "")
                {
                    if (Session["EmployeeType"].ToString() == "Admin")
                    {
                        lblEmployeeName.Text = Session["EmployeeNameFromAdmin"].ToString();
                        lblCycleName.Text = Session["CycleNameFromAdmin"].ToString();

                        if (
                            (Session["EmployeeHRCodeFromAdmin"].ToString() == "10450") ||
                            (Session["EmployeeHRCodeFromAdmin"].ToString() == "920054") ||
                            (Session["EmployeeHRCodeFromAdmin"].ToString() == "40656") ||
                            (Session["EmployeeHRCodeFromAdmin"].ToString() == "30202") ||
                            (Session["EmployeeHRCodeFromAdmin"].ToString() == "20261") ||
                            (Session["EmployeeHRCodeFromAdmin"].ToString() == "70385")
                            )
                        {
                            tblLinksAdmin.Visible = true;
                            tblLinksReps.Visible = false;
                            tblLinksDMs.Visible = false;
                        }
                        else
                        {
                            tblLinksAdmin.Visible = false;
                            tblLinksReps.Visible = false;
                            tblLinksDMs.Visible = false;
                        }
                    }
                    if (Session["EmployeeType"].ToString() == "Rep")
                    {
                        lblEmployeeName.Text = Session["EmployeeName"].ToString();
                        lblCycleName.Text = Session["CycleName"].ToString();

                        lblAreaName.Text = "No of Visits: " + Session["NoOfVisitsPerDay"].ToString();
                        lblAreaName.Visible = true;

                        lblWorkingDays.Text = "Working Days: " + Session["WorkingDays"].ToString();
                        lblWorkingDays.Visible = true;

                        tblLinksAdmin.Visible = false;
                        tblLinksReps.Visible = true;
                        tblLinksDMs.Visible = false;

                        if (Session["IsPilot"].ToString() == "Not Pilot")
                        {
                            tblLinksReps.Visible = false;
                            tblLinksReps.Visible = true;
                        }
                    }
                    if (Session["EmployeeType"].ToString() == "DM")
                    {
                        lblEmployeeName.Text = Session["EmployeeNameFromDM"].ToString();
                        lblCycleName.Text = Session["CycleNameFromDM"].ToString();
                        lblAreaName.Text = Session["SupervisionAreaNameFromDM"].ToString();

                        tblLinksAdmin.Visible = false;
                        tblLinksReps.Visible = false;
                        tblLinksDMs.Visible = true;
                    }
                }
            }
        }

        protected void LoginStatus1_LoggingOut(object sender, LoginCancelEventArgs e)
        {
            Session["EmployeeID"] = "";
            Session["AreaID"] = "";
            Session["LineID"] = "";
            Session["EmployeeHRCode"] = 0;
            Session["CycleID"] = 0;

            Session["PlannedVisitID"] = 0;
            Session["PlannedVisitDate"] = "";
            Session["ParticipantID"] = 0;

            Session["EmployeeName"] = "";
            Session["AreaName"] = "";
            Session["LineName"] = "";
            Session["CycleName"] = "";
            Session["EmployeeType"] = "";

            Session["EmployeeIDFromAdmin"] = "";
            Session["AreaIDFromAdmin"] = "";
            Session["LineIDFromAdmin"] = "";
            Session["EmployeeHRCodeFromAdmin"] = 0;
            Session["CycleIDFromAdmin"] = 0;

            Session["PlannedVisitIDFromAdmin"] = 0;
            Session["PlannedVisitDateFromAdmin"] = "";
            Session["ParticipantIDFromAdmin"] = 0;

            Session["EmployeeNameFromAdmin"] = "";
            Session["AreaNameFromAdmin"] = "";
            Session["LineNameFromAdmin"] = "";
            Session["CycleNameFromAdmin"] = "";
            Session["EmployeeTypeFromAdmin"] = "";

            lblEmployeeName.Text = "";
            lblCycleName.Text = "";
            lblAreaName.Text = "";
        }

        protected void logOutLink_Click(object sender, EventArgs e)
        {
            Session["EmployeeID"] = "";
            Session["AreaID"] = "";
            Session["LineID"] = "";
            Session["EmployeeHRCode"] = 0;
            Session["CycleID"] = 0;

            Session["PlannedVisitID"] = 0;
            Session["PlannedVisitDate"] = "";
            Session["ParticipantID"] = 0;

            Session["EmployeeName"] = "";
            Session["AreaName"] = "";
            Session["LineName"] = "";
            Session["CycleName"] = "";
            Session["EmployeeType"] = "";

            Session["EmployeeIDFromAdmin"] = "";
            Session["AreaIDFromAdmin"] = "";
            Session["LineIDFromAdmin"] = "";
            Session["EmployeeHRCodeFromAdmin"] = 0;
            Session["CycleIDFromAdmin"] = 0;

            Session["PlannedVisitIDFromAdmin"] = 0;
            Session["PlannedVisitDateFromAdmin"] = "";
            Session["ParticipantIDFromAdmin"] = 0;

            Session["EmployeeNameFromAdmin"] = "";
            Session["AreaNameFromAdmin"] = "";
            Session["LineNameFromAdmin"] = "";
            Session["CycleNameFromAdmin"] = "";
            Session["EmployeeTypeFromAdmin"] = "";

            lblEmployeeName.Text = "";
            lblCycleName.Text = "";
            lblAreaName.Text = "";

            Response.Redirect("~/Login.aspx");
        }
    }
}