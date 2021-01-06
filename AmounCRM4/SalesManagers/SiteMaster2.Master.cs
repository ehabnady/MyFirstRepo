using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AmounCRM4.SalesManagers
{
    public partial class SiteMaster2 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["EmployeeType"].ToString() == "")
                {
                    lblWelcome.Text = "Amoun ECMS Project";
                }
                else
                {
                    lblWelcome.Text = "Welcome Dr. " + Session["EmployeeNameFromSM"].ToString();
                }
            }
        }

        protected void lnkSignOut_Click(object sender, EventArgs e)
        {
            Session["AllowedDaysForPlanning"] = 7;
            Session["CurrentYear"] = 2017;
            Session["CycleStartDate"] = "";
            Session["CycleEndDate"] = "";

            Session["EmployeeID"] = "";
            Session["AreaID"] = "";
            Session["LineID"] = "";
            Session["EmployeeHRCode"] = "0";
            Session["CycleID"] = 0;

            Session["PlannedVisitID"] = 0;
            Session["PlannedVisitDate"] = "";
            Session["ParticipantID"] = 0;
            Session["IsEditCall"] = 0;
            Session["SpecialtyID"] = 0;

            Session["EmployeeName"] = "";
            Session["AreaName"] = "";
            Session["LineName"] = "";
            Session["CycleName"] = "";
            Session["EmployeeType"] = "";

            Session["MonthID"] = 0;
            Session["StartDate"] = "";
            Session["EndDate"] = "";
            Session["FirstWorkingDay"] = "";
            ///////////

            Session["EmployeeIDFromAdmin"] = "";
            Session["AreaIDFromAdmin"] = "";
            Session["LineIDFromAdmin"] = "";
            Session["EmployeeHRCodeFromAdmin"] = "0";
            Session["CycleIDFromAdmin"] = 0;

            Session["PlannedVisitIDFromAdmin"] = 0;
            Session["PlannedVisitDateFromAdmin"] = "";
            Session["ParticipantIDFromAdmin"] = 0;
            Session["IsEditCallFromAdmin"] = 0;

            Session["EmployeeNameFromAdmin"] = "";
            Session["AreaNameFromAdmin"] = "";
            Session["LineNameFromAdmin"] = "";
            Session["CycleNameFromAdmin"] = "";
            Session["EmployeeTypeFromAdmin"] = "";

            Session["MonthIDFromAdmin"] = 0;
            Session["StartDateFromAdmin"] = "";
            Session["EndDateFromAdmin"] = "";
            /////////

            Session["EmployeeIDFromDM"] = "";
            Session["AreaIDFromDM"] = "";
            Session["LineIDFromDM"] = "";
            Session["EmployeeHRCodeFromDM"] = "0";
            Session["CycleIDFromDM"] = 0;

            Session["PlannedVisitIDFromDM"] = 0;
            Session["PlannedVisitDateFromDM"] = "";
            Session["ParticipantIDFromDM"] = 0;
            Session["IsEditCallFromDM"] = 0;

            Session["EmployeeNameFromDM"] = "";
            Session["AreaNameFromDM"] = "";
            Session["LineNameFromDM"] = "";
            Session["CycleNameFromDM"] = "";
            Session["EmployeeTypeFromDM"] = "";

            Session["MonthIDFromDM"] = 0;
            Session["StartDateFromDM"] = "";
            Session["EndDateFromDM"] = "";
            Session["FirstWorkingDayFromDM"] = "";

            Session["SupervisionAreaIDFromDM"] = 0;
            Session["SupervisionAreaNameFromDM"] = 0;

            //////////Sales Managers
            Session["EmployeeIDFromSM"] = 0;
            Session["AreaIDFromSM"] = 0;
            Session["LineIDFromSM"] = 0;
            Session["EmployeeHRCodeFromSM"] = 0;
            Session["PlannedVisitIDFromSM"] = 0;
            Session["PlannedVisitDateFromSM"] = "";
            Session["EmployeeNameFromSM"] = "";
            Session["AreaNameFromSM"] = "";
            Session["LineNameFromSM"] = "";

            Session["EmployeeTypeFromSM"] = "";
            Session["EmployeeType"] = "";
            Session["SupervisionAreaIDFromSM"] = "";
            Session["SupervisionAreaNameFromSM"] = "";
            Session["RegionNameFromSM"] = "";
            Response.Redirect("~/Login2.aspx");
        }
    }
}