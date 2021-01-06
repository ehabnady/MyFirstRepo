using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace AmounCRM4
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            Telerik.Reporting.Services.WebApi.ReportsControllerConfiguration.RegisterRoutes(System.Web.Http.GlobalConfiguration.Configuration);
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            Session["AllowedDaysForPlanning"] = 7;
            Session["CurrentYear"] = 2018;
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

            Session["IsPilot"] = "";
            Session["NoOfVisitsPerDay"] = 0;

            Session["WorkingDays"] = 0;
            Session["MessagesCount"] = 0;
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
            Session["CycleIDFromSM"] = 0;
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

            //Session["NewAreaID"] = 0;
            //Session["NewAreaName"] = "";
            //Session["NewAreaNameWithLine"] = "";
            //Session["NewSupervisionAreaID"] = 0;
            //Session["NewSupervisionAreaName"] = "";
            //Session["NewLineID"] = 0;

            //Session["NewAreaIDFromDM"] = 0;
            //Session["NewAreaNameFromDM"] = "";
            //Session["NewAreaNameWithLineFromDM"] = "";
            //Session["NewSupervisionAreaIDFromDM"] = "";
            //Session["NewSupervisionAreaNameFromDM"] = "";
            //Session["NewLineIDFromDM"] = 0;

            Session["SpecialDays"] = "";
            Session["dtAffsOut"] = "";

            Session["AmounRegionIDFromSM"] = 0;
            Session["AmounRegionNameFromSM"] = "";
            /////////End of Sales Managers

            ////////Sales Director
            Session["EmployeeIDFromDir"] = 0;
            Session["AreaIDFromDir"] = 0;
            Session["LineIDFromDir"] = 0;
            Session["CycleIDFromDir"] = 0;
            Session["EmployeeHRCodeFromDir"] = 0;
            Session["PlannedVisitIDFromDir"] = 0;
            Session["PlannedVisitDateFromDir"] = "";
            Session["EmployeeNameFromDir"] = "";
            Session["AreaNameFromDir"] = "";
            Session["LineNameFromDir"] = "";

            Session["EmployeeTypeFromDir"] = "";
            Session["EmployeeType"] = "";
            Session["SupervisionAreaIDFromDir"] = 0;
            Session["SupervisionAreaNameFromDir"] = "";

            Session["AmounRegionIDFromDir"] = 0;
            Session["AmounRegionNameFromDir"] = "";
            ///////End of Sales Director

            ////////Commercial Director
            Session["EmployeeIDFromComDir"] = 0;
            Session["AreaIDFromComDir"] = 0;
            Session["LineIDFromComDir"] = 0;
            Session["CycleIDFromComDir"] = 0;
            Session["EmployeeHRCodeFromComDir"] = 0;
            Session["PlannedVisitIDFromComDir"] = 0;
            Session["PlannedVisitDateFromComDir"] = "";
            Session["EmployeeNameFromComDir"] = "";
            Session["AreaNameFromComDir"] = "";
            Session["LineNameFromComDir"] = "";

            Session["EmployeeTypeFromComDir"] = "";
            Session["EmployeeType"] = "";
            Session["SupervisionAreaIDFromComDir"] = 0;
            Session["SupervisionAreaNameFromComDir"] = "";

            Session["AmounRegionIDFromComDir"] = 0;
            Session["AmounRegionNameFromComDir"] = "";

            Session["GlobalEmpID"] = "0";
            Session["GlobalEmpName"] = "";
            Session["GlobalEmpIDName"] = "";

            Session["DetailingPriorityUpdate"] = "0";
            Session["SpecValUpdate"] = "0";
            Session["SurveyUpdate"] = "0";
            ///////End of Commercial Director

            ///////Sales Reps
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
            //////////End of Sales Reps

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}