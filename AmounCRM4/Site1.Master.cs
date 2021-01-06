using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AmounCRM4
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //hlNotificationsRep.Text += " (" + Session["MessagesCount"].ToString() + " )";
            //hlNotificationsRep.ToolTip = hlNotificationsRep.Text;

            //hlNotificationsDM.Text += " (" + Session["MessagesCount"].ToString() + " )";
            //hlNotificationsDM.ToolTip = hlNotificationsDM.Text;

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
                            tblLinksAdmin2.Visible = false;
                            tblLinksReps.Visible = false;
                            tblLinksDMs.Visible = false;
                        }
                        else
                        {
                            tblLinksAdmin.Visible = false;
                            tblLinksAdmin2.Visible = true;
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

                        lblNow.Text = DateTime.Now.ToShortDateString();

                        tblLinksAdmin.Visible = false;
                        tblLinksAdmin2.Visible = false;
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
                        //if (
                        //    (int.Parse(Session["EmployeeIDFromAdmin"].ToString()) != 820) &&
                        //    (int.Parse(Session["EmployeeIDFromAdmin"].ToString()) != 822) &&
                        //    (int.Parse(Session["EmployeeIDFromAdmin"].ToString()) != 837) &&
                        //    (int.Parse(Session["EmployeeIDFromAdmin"].ToString()) != 849) &&
                        //    (int.Parse(Session["EmployeeIDFromAdmin"].ToString()) != 852) &&
                        //    (int.Parse(Session["EmployeeIDFromAdmin"].ToString()) != 1062) &&
                        //    (int.Parse(Session["EmployeeIDFromAdmin"].ToString()) != 1073) &&
                        //    (int.Parse(Session["EmployeeIDFromAdmin"].ToString()) != 1078)
                        //   )
                        //{
                        //    tblLinksAdmin.Visible = false;
                        //    tblLinksAdmin2.Visible = false;
                        //    tblLinksReps.Visible = false;
                        //    tblLinksDMs.Visible = false;
                        //    Response.Redirect("~/Login2.aspx");
                        //}

                        lblEmployeeName.Text = Session["EmployeeNameFromDM"].ToString();
                        lblCycleName.Text = Session["CycleNameFromDM"].ToString();
                        lblAreaName.Text = Session["SupervisionAreaNameFromDM"].ToString();

                        tblLinksAdmin.Visible = false;
                        tblLinksAdmin2.Visible = false;
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

            Response.Redirect("~/Login2.aspx");
        }
    }
}