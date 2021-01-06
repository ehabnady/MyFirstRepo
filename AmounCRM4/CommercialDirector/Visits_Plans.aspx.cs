using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

namespace AmounCRM4.CommercialDirector
{
    public partial class Visits_Plans : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeIDFromComDir"].ToString() == "0")
            {
                Response.Redirect("~/Login2.aspx");
            }
            FillAppsHeader();
        }

        protected void FillAppsHeader()
        {
            RadPanelItem item = RadPanelBar1.Items[0];
            Label lT = (Label)item.Header.FindControl("lblAppsTotal");
            Label lA = (Label)item.Header.FindControl("lblAppsClassA");
            Label lB = (Label)item.Header.FindControl("lblAppsClassB");

            //Comment until finishing Sales Director Partt in Dataset
            lT.Text = "All Appointments:            " + ((DataView)ListOfAppointmentsDS.Select(DataSourceSelectArguments.Empty)).ToTable().Rows.Count.ToString();
            lA.Text = "Class A: " + ((DataView)ListOfAppointmentsDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'A'").Length.ToString();
            lB.Text = "Class B: " + ((DataView)ListOfAppointmentsDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'B'").Length.ToString();
            //lC.Text = "Class C: " + ((DataView)ListOfAppointmentsDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'C'").Length.ToString();
        }
    }
}