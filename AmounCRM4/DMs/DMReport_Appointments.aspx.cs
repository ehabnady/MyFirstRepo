using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using AmounCRM4.App_Data.ExecSummary2TableAdapters;
using static AmounCRM4.App_Data.ExecSummary2;


namespace AmounCRM4.DMs
{
    public partial class DMReport_Appointments : System.Web.UI.Page
    {
        DataView dvApp;
        DataTable dtApp;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //RadPanelBar1.Items[0].Expanded = true;
                if (Session["EmployeeIDFromDM"].ToString() == "")
                {
                    Response.Redirect("~/Login2.aspx");
                }
                else
                {
                    if (Session["EmployeeType"].ToString() == "Admin")
                    {
                        this.Master.FindControl("tblLinksAdmin").Visible = true;
                        this.Master.FindControl("tblLinksReps").Visible = false;
                    }
                    else if (Session["EmployeeType"].ToString() == "Rep")
                    {
                        this.Master.FindControl("tblLinksAdmin").Visible = false;
                        this.Master.FindControl("tblLinksReps").Visible = true;
                    }
                }

                //dvApp = (DataView)(ListOfAppointmentsDS.Select(DataSourceSelectArguments.Empty));
                dvApp = (DataView)(ListOfAppointmentsDS.Select(DataSourceSelectArguments.Empty));
                dtApp = dvApp.ToTable();

                lblAppsCount.Text = dtApp.Select("CycleID = " + int.Parse(Session["CycleIDFromDM"].ToString())).Length.ToString();
                lblClassA_App.Text = dtApp.Select("PhysicianClass = 'A' AND CycleID = " + int.Parse(Session["CycleIDFromDM"].ToString())).Length.ToString();
                lblClassB_App.Text = dtApp.Select("PhysicianClass = 'B' AND CycleID = " + int.Parse(Session["CycleIDFromDM"].ToString())).Length.ToString();
                lblClassC_App.Text = dtApp.Select("PhysicianClass = 'C' AND CycleID = " + int.Parse(Session["CycleIDFromDM"].ToString())).Length.ToString();
            }
	        catch (Exception)
	        {
                RadWindowManager1.RadAlert("Time Exceeded. Please try again after a while or contact your line manager", 400, 200, "Alert!", null, "");
            }

        }

    protected void ListOfAppointmentsDS_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }
    }
}