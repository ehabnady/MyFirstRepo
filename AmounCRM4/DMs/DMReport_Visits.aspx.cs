using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace AmounCRM4.DMs
{
    public partial class DMReport_Visits : System.Web.UI.Page
    {
        DataView dvApp;
        DataTable dtApp;
        protected void Page_Load(object sender, EventArgs e)
        {
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
            dvApp = (DataView)(ListOfCallsDS.Select(DataSourceSelectArguments.Empty));
            dtApp = dvApp.ToTable();

            lblVisitsCount.Text = dtApp.Select("CycleID = " + int.Parse(Session["CycleIDFromDM"].ToString())).Length.ToString();
            lblClassA_Visit.Text = dtApp.Select("PhysicianClass = 'A' AND CycleID = " + int.Parse(Session["CycleIDFromDM"].ToString())).Length.ToString();
            lblClassB_Visit.Text = dtApp.Select("PhysicianClass = 'B' AND CycleID = " + int.Parse(Session["CycleIDFromDM"].ToString())).Length.ToString();
            lblClassC_Visit.Text = dtApp.Select("PhysicianClass = 'C' AND CycleID = " + int.Parse(Session["CycleIDFromDM"].ToString())).Length.ToString();
        }
    }
}