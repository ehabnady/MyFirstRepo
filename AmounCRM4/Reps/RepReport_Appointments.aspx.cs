using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace AmounCRM4.Reps
{
    public partial class RepReport_Appointments : System.Web.UI.Page
    {
        DataView dvApp;
        DataTable dtApp;
        protected void Page_Load(object sender, EventArgs e)
        {
            //RadPanelBar1.Items[0].Expanded = true;
            if (Session["EmployeeID"].ToString() == "")
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

            dvApp = (DataView)(ListOfAppointmentsDS.Select(DataSourceSelectArguments.Empty));
            dtApp = dvApp.ToTable();

            lblAppsCount.Text = dtApp.Rows.Count.ToString();
            lblClassA_App.Text = dtApp.Select("PhysicianClass = 'A'").Length.ToString();
            lblClassB_App.Text = dtApp.Select("PhysicianClass = 'B'").Length.ToString();
            lblClassC_App.Text = dtApp.Select("PhysicianClass = 'C'").Length.ToString();
        }
    }
}