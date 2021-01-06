using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AmounCRM4
{
    public partial class FeedbackSite4 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Header.DataBind();

            if (!Page.IsPostBack)
            {
                if (Session["EmployeeTypeFromSales"].ToString() != "SalesRep")
                {
                    lblEmployeeName.Text = "";
                    lblCycleName.Text = "";
                    lblAreaName.Text = "";
                    tblLinksSalesReps.Visible = false;
                }

                if (Session["EmployeeTypeFromSales"].ToString() == "SalesRep")
                {
                    lblEmployeeName.Text = Session["EmployeeNameFromSales"].ToString();
                    lblCycleName.Text = Session["CycleNameFromSales"].ToString();

                    lblAreaName.Text = "No of Visits: " + Session["NoOfVisitsPerDayFromSales"].ToString();
                    //lblAreaName.Visible = true;

                    lblWorkingDays.Text = "Working Days: " + Session["WorkingDaysFromSales"].ToString();
                    //lblWorkingDays.Visible = true;

                    lblNow.Text = DateTime.Now.ToShortDateString();
                }
            }
        }

        protected void LoginStatus1_LoggingOut(object sender, LoginCancelEventArgs e)
        {
            Session["EmployeeIDFromSales"] = "";
            Session["AreaIDFromSales"] = "";
            Session["LineIDFromSales"] = "";
            Session["EmployeeHRCodeFromSales"] = "0";
            Session["CycleIDFromSales"] = 0;

            Session["PlannedVisitIDFromSales"] = 0;
            Session["PlannedVisitDateFromSales"] = "";
            Session["ParticipantIDFromSales"] = 0;
            Session["IsEditCallFromSales"] = 0;
            Session["SpecialtyIDFromSales"] = 0;

            Session["EmployeeNameFromSales"] = "";
            Session["AreaNameFromSales"] = "";
            Session["LineNameFromSales"] = "";
            Session["CycleNameFromSales"] = "";
            Session["EmployeeTypeFromSales"] = "";

            Session["MonthIDFromSales"] = 0;
            Session["StartDateFromSales"] = "";
            Session["EndDateFromSales"] = "";
            Session["FirstWorkingDayFromSales"] = "";

            Session["IsPilotFromSales"] = "";
            Session["NoOfVisitsPerDayFromSales"] = 0;

            Session["WorkingDaysFromSales"] = 0;
            Session["MessagesCountFromSales"] = 0;

            lblEmployeeName.Text = "";
            lblCycleName.Text = "";
            lblAreaName.Text = "";
        }

        protected void logOutLink_Click(object sender, EventArgs e)
        {
            Session["EmployeeIDFromSales"] = "";
            Session["AreaIDFromSales"] = "";
            Session["LineIDFromSales"] = "";
            Session["EmployeeHRCodeFromSales"] = "0";
            Session["CycleIDFromSales"] = 0;

            Session["PlannedVisitIDFromSales"] = 0;
            Session["PlannedVisitDateFromSales"] = "";
            Session["ParticipantIDFromSales"] = 0;
            Session["IsEditCallFromSales"] = 0;
            Session["SpecialtyIDFromSales"] = 0;

            Session["EmployeeNameFromSales"] = "";
            Session["AreaNameFromSales"] = "";
            Session["LineNameFromSales"] = "";
            Session["CycleNameFromSales"] = "";
            Session["EmployeeTypeFromSales"] = "";

            Session["MonthIDFromSales"] = 0;
            Session["StartDateFromSales"] = "";
            Session["EndDateFromSales"] = "";
            Session["FirstWorkingDayFromSales"] = "";

            Session["IsPilotFromSales"] = "";
            Session["NoOfVisitsPerDayFromSales"] = 0;

            Session["WorkingDaysFromSales"] = 0;
            Session["MessagesCountFromSales"] = 0;

            lblEmployeeName.Text = "";
            lblCycleName.Text = "";
            lblAreaName.Text = "";

            Response.Redirect("~/Login2.aspx");
        }
    }
}