using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AmounCRM4
{
    public partial class Login : System.Web.UI.Page
    {
        SqlDataReader dr;
        SqlCommand cmd;
        SqlParameter param1;
        SqlParameter param2;
        SqlConnection con;

        SqlDataReader dr2;
        SqlCommand cmd2;

        SqlDataReader dr3;
        SqlCommand cmd3;

        SqlCommand cmd4;

        protected void Page_Load(object sender, EventArgs e)
        {
            return;
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ToString());

                param1 = new SqlParameter("Param1", UserName.Value);
                param1.Value = UserName.Value;
                param2 = new SqlParameter("Param2", Password.Value);
                param2.Value = Password.Value;

                cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.Parameters.Add(param1);
                cmd.Parameters.Add(param2);
                cmd.CommandText = @"SELECT [EmployeeID], [EmployeeHRCode], [LineID], [AreaRecID], [EmployeeName], [LineName], [AmounTerritoryName], [EmployeeType], [EmployeeUserName], [MustChangePassword], 
                                    [LastChangeDate], [NextChangeDate], [SupervisionAreaID], [SupervisionArea], [AmounRegionID], [AmounRegionName], [IsPilot], [NoOfVisitsPerDay]
                                    FROM [View_Reps3] WHERE ([DeletedEmployee] IS NULL OR [DeletedEmployee] = 0) AND ([EmployeeUserName] = '" + param1.Value.ToString() + "' AND EmployeePassword = '" + param2.Value.ToString() + "' COLLATE SQL_Latin1_General_CP1_CS_AS)";
                //, [NewAreaID], [NewAreaName], [NewAreaNameWithLine], [NewSuperAreaID], [NewSuperAreaName], [NewLineID]

                if (UserName.Value == "990165")
                {
                    //cmd.CommandText = @"SELECT [EmployeeID], [EmployeeHRCode], [LineID], [AreaRecID], [EmployeeName], [LineName], [AmounTerritoryName], [EmployeeType], [EmployeeUserName], [MustChangePassword], 
                    //                [LastChangeDate], [NextChangeDate], [SupervisionAreaID], [SupervisionArea], [AmounRegionID], [AmounRegionName], [IsPilot], [NoOfVisitsPerDay]
                    //                FROM [View_Reps3] WHERE ([DeletedEmployee] IS NULL OR [DeletedEmployee] = 0) AND (EmployeeType = 'Commercial Director')";
                }

                cmd2 = new SqlCommand();
                cmd2.Connection = con;
                cmd2.CommandText = "SELECT CycleID, CycleDesc, FromDate, ToDate, MonthID, PlanningDays, WorkingDays FROM Cycles WHERE IsCurrent = 1";

                con.Open();
                dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        if (dr["EmployeeType"].ToString() == "Admin")
                        {
                            if (dr["MustChangePassword"].ToString() == "True" || DateTime.Parse(dr["NextChangeDate"].ToString()) <= DateTime.Parse(DateTime.Now.ToShortDateString()))
                            {
                                Response.Redirect("~/ChangePassword.aspx");
                                return;
                            }
                            Session["EmployeeIDFromAdmin"] = dr["EmployeeID"].ToString();
                            Session["AreaIDFromAdmin"] = dr["AreaRecID"].ToString();
                            Session["LineIDFromAdmin"] = dr["LineID"].ToString();
                            Session["EmployeeHRCodeFromAdmin"] = dr["EmployeeHRCode"];
                            Session["PlannedVisitIDFromAdmin"] = 0;
                            Session["PlannedVisitDateFromAdmin"] = "";
                            Session["EmployeeNameFromAdmin"] = dr["EmployeeName"].ToString();
                            Session["AreaNameFromAdmin"] = dr["AmounTerritoryName"].ToString();
                            Session["LineNameFromAdmin"] = dr["LineName"].ToString();
                            Session["EmployeeTypeFromAdmin"] = dr["EmployeeType"];

                            Session["EmployeeType"] = dr["EmployeeType"];

                            Session["GlobalEmpID"] = Session["EmployeeIDFromAdmin"].ToString();
                            Session["GlobalEmpName"] = Session["EmployeeNameFromAdmin"].ToString();
                            Session["GlobalEmpIDName"] = Session["GlobalEmpID"].ToString() + " - " + Session["GlobalEmpName"].ToString();
                        }
                        if (dr["EmployeeType"].ToString() == "Rep")
                        {
                            if (dr["MustChangePassword"].ToString() == "True" || DateTime.Parse(dr["NextChangeDate"].ToString()) <= DateTime.Parse(DateTime.Now.ToShortDateString()))
                            {
                                Response.Redirect("~/ChangePassword.aspx");
                                return;
                            }
                            Session["EmployeeID"] = dr["EmployeeID"].ToString();
                            Session["AreaID"] = dr["AreaRecID"].ToString();
                            Session["LineID"] = dr["LineID"].ToString();
                            Session["EmployeeHRCode"] = dr["EmployeeHRCode"];
                            Session["PlannedVisitID"] = 0;
                            Session["PlannedVisitDate"] = "";
                            Session["EmployeeName"] = dr["EmployeeName"].ToString();
                            Session["AreaName"] = dr["AmounTerritoryName"].ToString();
                            Session["LineName"] = dr["LineName"].ToString();

                            Session["EmployeeType"] = dr["EmployeeType"];

                            Session["IsPilot"] = dr["IsPilot"].ToString();
                            Session["NoOfVisitsPerDay"] = dr["NoOfVisitsPerDay"].ToString();

                            Session["GlobalEmpID"] = Session["EmployeeID"].ToString();
                            Session["GlobalEmpName"] = Session["EmployeeName"].ToString();
                            Session["GlobalEmpIDName"] = Session["GlobalEmpID"].ToString() + " - " + Session["GlobalEmpName"].ToString();

                            //Session["NewAreaID"] = int.Parse(dr["NewAreaID"].ToString());
                            //Session["NewAreaName"] = dr["NewAreaName"].ToString();
                            //Session["NewAreaNameWithLine"] = dr["NewAreaNameWithLine"].ToString();
                            //Session["NewSupervisionAreaID"] = int.Parse(dr["NewSuperAreaID"].ToString());
                            //Session["NewSupervisionAreaName"] = dr["NewSuperAreaName"].ToString();
                            //Session["NewLineID"] = int.Parse(dr["NewLineID"].ToString());

                            //if (Session["IsPilot"] == null)
                            //{
                            //    Response.Redirect("~/UpdateDoctors2.aspx");
                            //}

                            Session["MessagesCount"] = 0;

                        }
                        if (dr["EmployeeType"].ToString() == "DM")
                        {
                            if (dr["MustChangePassword"].ToString() == "True" || DateTime.Parse(dr["NextChangeDate"].ToString()) <= DateTime.Parse(DateTime.Now.ToShortDateString()))
                            {
                                Response.Redirect("~/ChangePassword.aspx");
                                return;
                            }
                            Session["EmployeeIDFromDM"] = dr["EmployeeID"].ToString();
                            Session["AreaIDFromDM"] = dr["AreaRecID"].ToString();
                            Session["LineIDFromDM"] = dr["LineID"].ToString();
                            Session["EmployeeHRCodeFromDM"] = dr["EmployeeHRCode"];
                            Session["PlannedVisitIDFromDM"] = 0;
                            Session["PlannedVisitDateFromDM"] = "";
                            Session["EmployeeNameFromDM"] = dr["EmployeeName"].ToString();
                            Session["AreaNameFromDM"] = dr["AmounTerritoryName"].ToString();
                            Session["LineNameFromDM"] = dr["LineName"].ToString();

                            Session["EmployeeTypeFromDM"] = dr["EmployeeType"];
                            Session["EmployeeType"] = dr["EmployeeType"];
                            Session["SupervisionAreaIDFromDM"] = dr["SupervisionAreaID"].ToString();
                            Session["SupervisionAreaNameFromDM"] = dr["SupervisionArea"].ToString();

                            Session["GlobalEmpID"] = Session["EmployeeIDFromDM"].ToString();
                            Session["GlobalEmpName"] = Session["EmployeeNameFromDM"].ToString();
                            Session["GlobalEmpIDName"] = Session["GlobalEmpID"].ToString() + " - " + Session["GlobalEmpName"].ToString();

                            //Session["NewAreaIDFromDM"] = int.Parse(dr["NewAreaID"].ToString());
                            //Session["NewAreaNameFromDM"] = dr["NewAreaName"].ToString();
                            //Session["NewAreaNameWithLineFromDM"] = dr["NewAreaNameWithLine"].ToString();
                            //Session["NewSupervisionAreaIDFromDM"] = int.Parse(dr["NewSuperAreaID"].ToString());
                            //Session["NewSupervisionAreaNameFromDM"] = dr["NewSuperAreaName"].ToString();
                            //Session["NewLineIDFromDM"] = int.Parse(dr["NewLineID"].ToString());
                        }
                        if (dr["EmployeeType"].ToString() == "Sales Manager")
                        {
                            if (dr["MustChangePassword"].ToString() == "True" || DateTime.Parse(dr["NextChangeDate"].ToString()) <= DateTime.Parse(DateTime.Now.ToShortDateString()))
                            {
                                Response.Redirect("~/ChangePassword.aspx");
                                return;
                            }
                            Session["EmployeeIDFromSM"] = dr["EmployeeID"].ToString();
                            Session["AreaIDFromSM"] = dr["AreaRecID"].ToString();
                            Session["LineIDFromSM"] = dr["LineID"].ToString();
                            Session["EmployeeHRCodeFromSM"] = dr["EmployeeHRCode"];
                            Session["PlannedVisitIDFromSM"] = 0;
                            Session["PlannedVisitDateFromSM"] = "";
                            Session["EmployeeNameFromSM"] = dr["EmployeeName"].ToString();
                            Session["AreaNameFromSM"] = dr["AmounTerritoryName"].ToString();
                            Session["LineNameFromSM"] = dr["LineName"].ToString();

                            Session["EmployeeTypeFromSM"] = dr["EmployeeType"];
                            Session["EmployeeType"] = dr["EmployeeType"];
                            Session["SupervisionAreaIDFromSM"] = dr["SupervisionAreaID"].ToString();
                            Session["SupervisionAreaNameFromSM"] = dr["SupervisionArea"].ToString();

                            Session["AmounRegionIDFromSM"] = dr["AmounRegionID"].ToString();
                            Session["AmounRegionNameFromSM"] = dr["AmounRegionName"].ToString();

                            Session["GlobalEmpID"] = Session["EmployeeIDFromSM"].ToString();
                            Session["GlobalEmpName"] = Session["EmployeeNameFromSM"].ToString();
                            Session["GlobalEmpIDName"] = Session["GlobalEmpID"].ToString() + " - " + Session["GlobalEmpName"].ToString();

                        }
                        if (dr["EmployeeType"].ToString() == "Sales Director")
                        {
                            if (dr["MustChangePassword"].ToString() == "True" || DateTime.Parse(dr["NextChangeDate"].ToString()) <= DateTime.Parse(DateTime.Now.ToShortDateString()))
                            {
                                Response.Redirect("~/ChangePassword.aspx");
                                return;
                            }
                            Session["EmployeeIDFromDir"] = dr["EmployeeID"].ToString();
                            Session["AreaIDFromDir"] = dr["AreaRecID"].ToString();
                            Session["LineIDFromDir"] = dr["LineID"].ToString();
                            Session["EmployeeHRCodeFromDir"] = dr["EmployeeHRCode"];
                            Session["PlannedVisitIDFromDir"] = 0;
                            Session["PlannedVisitDateFromDir"] = "";
                            Session["EmployeeNameFromDir"] = dr["EmployeeName"].ToString();
                            Session["AreaNameFromDir"] = dr["AmounTerritoryName"].ToString();
                            Session["LineNameFromDir"] = dr["LineName"].ToString();

                            Session["EmployeeTypeFromDir"] = dr["EmployeeType"];
                            Session["EmployeeType"] = dr["EmployeeType"];
                            Session["SupervisionAreaIDFromDir"] = dr["SupervisionAreaID"].ToString();
                            Session["SupervisionAreaNameFromDir"] = dr["SupervisionArea"].ToString();

                            Session["AmounRegionIDFromDir"] = dr["AmounRegionID"].ToString();
                            Session["AmounRegionNameFromDir"] = dr["AmounRegionName"].ToString();

                            Session["GlobalEmpID"] = Session["EmployeeIDFromDir"].ToString();
                            Session["GlobalEmpName"] = Session["EmployeeNameFromDir"].ToString();
                            Session["GlobalEmpIDName"] = Session["GlobalEmpID"].ToString() + " - " + Session["GlobalEmpName"].ToString();


                        }

                        if ((dr["EmployeeType"].ToString() == "Commercial Director") || (dr["EmployeeType"].ToString() == "Commercial Manager"))
                        {
                            if (dr["MustChangePassword"].ToString() == "True" || DateTime.Parse(dr["NextChangeDate"].ToString()) <= DateTime.Parse(DateTime.Now.ToShortDateString()))
                            {
                                Response.Redirect("~/ChangePassword.aspx");
                                return;
                            }
                            Session["EmployeeIDFromComDir"] = dr["EmployeeID"].ToString();
                            Session["AreaIDFromComDir"] = dr["AreaRecID"].ToString();
                            Session["LineIDFromComDir"] = dr["LineID"].ToString();
                            Session["EmployeeHRCodeFromComDir"] = dr["EmployeeHRCode"];
                            Session["PlannedVisitIDFromComDir"] = 0;
                            Session["PlannedVisitDateFromComDir"] = "";
                            Session["EmployeeNameFromComDir"] = dr["EmployeeName"].ToString();
                            Session["AreaNameFromComDir"] = dr["AmounTerritoryName"].ToString();
                            Session["LineNameFromComDir"] = dr["LineName"].ToString();

                            Session["EmployeeTypeFromComDir"] = dr["EmployeeType"];
                            Session["EmployeeType"] = dr["EmployeeType"];
                            Session["SupervisionAreaIDFromComDir"] = dr["SupervisionAreaID"].ToString();
                            Session["SupervisionAreaNameFromComDir"] = dr["SupervisionArea"].ToString();

                            Session["AmounRegionIDFromComDir"] = dr["AmounRegionID"].ToString();
                            Session["AmounRegionNameFromComDir"] = dr["AmounRegionName"].ToString();

                            Session["GlobalEmpID"] = Session["EmployeeIDFromComDir"].ToString();
                            Session["GlobalEmpName"] = Session["AreaNameFromComDir"].ToString();
                            Session["GlobalEmpIDName"] = Session["GlobalEmpID"].ToString() + " - " + Session["GlobalEmpName"].ToString();
                        }
                    }
                    con.Close();

                    con.Open();
                    dr2 = cmd2.ExecuteReader();
                    while (dr2.Read())
                    {
                        Session["CycleID"] = dr2["CycleID"].ToString();
                        Session["CycleName"] = dr2["CycleDesc"].ToString();
                        Session["MonthID"] = dr2["MonthID"].ToString();
                        Session["StartDate"] = dr2["FromDate"].ToString();
                        Session["EndDate"] = dr2["ToDate"].ToString();

                        Session["CycleIDFromAdmin"] = dr2["CycleID"].ToString();
                        Session["CycleNameFromAdmin"] = dr2["CycleDesc"].ToString();
                        Session["MonthIDFromAdmin"] = dr2["MonthID"].ToString();
                        Session["StartDateFromAdmin"] = dr2["FromDate"].ToString();
                        Session["EndDateFromAdmin"] = dr2["ToDate"].ToString();

                        Session["CycleIDFromDM"] = dr2["CycleID"].ToString();
                        Session["CycleNameFromDM"] = dr2["CycleDesc"].ToString();
                        Session["MonthIDFromDM"] = dr2["MonthID"].ToString();
                        Session["StartDateFromDM"] = dr2["FromDate"].ToString();
                        Session["EndDateFromDM"] = dr2["ToDate"].ToString();

                        Session["CycleIDFromSM"] = dr2["CycleID"].ToString();
                        Session["CycleNameFromSM"] = dr2["CycleDesc"].ToString();
                        Session["MonthIDFromSM"] = dr2["MonthID"].ToString();
                        Session["StartDateFromSM"] = dr2["FromDate"].ToString();
                        Session["EndDateFromSM"] = dr2["ToDate"].ToString();

                        Session["CycleIDFromDir"] = dr2["CycleID"].ToString();
                        Session["CycleNameFromDir"] = dr2["CycleDesc"].ToString();
                        Session["MonthIDFromDir"] = dr2["MonthID"].ToString();
                        Session["StartDateFromDir"] = dr2["FromDate"].ToString();
                        Session["EndDateFromDir"] = dr2["ToDate"].ToString();

                        Session["CycleIDFromComDir"] = dr2["CycleID"].ToString();
                        Session["CycleNameFromComDir"] = dr2["CycleDesc"].ToString();
                        Session["MonthIDFromComDir"] = dr2["MonthID"].ToString();
                        Session["StartDateFromComDir"] = dr2["FromDate"].ToString();
                        Session["EndDateFromComDir"] = dr2["ToDate"].ToString();

                        Session["AllowedDaysForPlanning"] = dr2["PlanningDays"].ToString();
                        Session["WorkingDays"] = dr2["WorkingDays"].ToString();

                    }
                    con.Close();

                    con.Open();
                    List<DateTime> arrSpecialDays = new List<DateTime> { new DateTime(1900, 1, 1) };
                    cmd3 = new SqlCommand("Select VaccationID, VaccationDate, DayID, MonthID, YearID, CycleID From NationalVaccations Where Deleted IS NULL", con);
                    dr3 = cmd3.ExecuteReader();
                    {
                        while (dr3.Read())
                        {
                            arrSpecialDays.Add((new DateTime(int.Parse(dr3["YearID"].ToString()), int.Parse(dr3["MonthID"].ToString()), int.Parse(dr3["DayID"].ToString()))));
                        }
                    }
                    Session["SpecialDays"] = arrSpecialDays;
                    con.Close();

                    Session["MessagesCount"] = 0;

                    if (Session["EmployeeType"].ToString() == "Admin")
                    {
                        //Response.Redirect("~/Reps/RepsDefault3.aspx");
                        Response.Redirect("~/Admins/DoctorsList.aspx");
                    }

                    if (Session["EmployeeType"].ToString() == "Rep")
                    {
                        string messagesCount = @"SELECT COUNT(Distinct [CRM_MessageID]) FROM [View_CRM_Messages] 
                                WHERE ((([LineID] = 14) OR ([SalesRepID] = " + int.Parse(Session["EmployeeID"].ToString()) + ")) AND EndDate >= GETDATE())";
                        con.Open();
                        cmd4 = new SqlCommand();
                        cmd4.Connection = con;
                        cmd4.CommandText = messagesCount;
                        int iiiii = int.Parse(cmd4.ExecuteScalar().ToString());
                        Session["MessagesCount"] = iiiii;
                        con.Close();

                        if (Session["IsPilot"].ToString() == "Not Pilot")
                        {
                            //Response.Redirect("UpdateDoctors2.aspx");
                            Response.Redirect("~/Reps/Repreport_Dashboard2.aspx");
                        }
                        else
                        {
                            Response.Redirect("~/Reps/Repreport_Dashboard2.aspx");
                        }
                    }

                    if (Session["EmployeeType"].ToString() == "DM")
                    {
                        string messagesCount = @"SELECT COUNT(Distinct [CRM_MessageID]) FROM [View_CRM_Messages] 
                                WHERE ((([LineID] = 14) OR ([DistrictManagerID] = " + int.Parse(Session["EmployeeIDFromDM"].ToString()) + ")) AND EndDate >= GETDATE())";
                        con.Open();
                        cmd4 = new SqlCommand();
                        cmd4.Connection = con;
                        cmd4.CommandText = messagesCount;
                        Session["MessagesCount"] = int.Parse(cmd4.ExecuteScalar().ToString());
                        con.Close();

                        Response.Redirect("~/DMs/DMReport_Dashboard.aspx");
                    }

                    if (Session["EmployeeType"].ToString() == "Sales Manager")
                    {
                        Response.Redirect("~/SalesManagers/SMReport_Dashboard.aspx");
                    }

                    if (Session["EmployeeType"].ToString() == "Sales Director")
                    {
                        Response.Redirect("~/SalesDirector/SDReport_Dashboard.aspx");
                    }

                    if ((Session["EmployeeType"].ToString() == "Commercial Director") || (Session["EmployeeType"].ToString() == "Commercial Manager"))
                    {
                        Response.Redirect("~/CommercialDirector/DetailingPriority2.aspx");
                    }
                }
                else
                {
                    FailureText.Text = "Username or Password is invalid. Plese try again";
                }
            }
            catch (Exception ex)
            {
                //MessageBox.Show(ex.Message, ex.Source, MessageBoxButtons.OK, MessageBoxIcon.Error, MessageBoxDefaultButton.Button1, MessageBoxOptions.ServiceNotification);
                FailureText.Text = ex.Message;
                //MessageBox.Show("Error");
            }
        }

        protected void ChangePasswordLinkButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/ChangePassword.aspx");
        }

        protected void Password_TextChanged(object sender, EventArgs e)
        {

        }
    }
}