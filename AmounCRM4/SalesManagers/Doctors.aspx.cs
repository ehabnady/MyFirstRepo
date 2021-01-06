using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace AmounCRM4.SalesManagers
{
    public partial class Doctors : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeIDFromSM"].ToString() == "0")
            {
                Response.Redirect("~/Login2.aspx");
            }

            FillAffHeader();
        }

        protected void FillAffHeader()
        {
            RadPanelItem item = RadPanelBar1.Items[0];
            Label lT = (Label)item.Header.FindControl("lblAffsTotal");
            Label lA = (Label)item.Header.FindControl("lblAffsClassA");
            Label lB = (Label)item.Header.FindControl("lblAffsClassB");
            //Label lC = (Label)item.Header.FindControl("lblAffsClassC");

            lT.Text = "All Physicians:          " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Rows.Count.ToString();
            lA.Text = "Class A: " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'A'").Length.ToString();
            lB.Text = "Class A+: " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'A+'").Length.ToString();
            //lC.Text = "Class C: " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'C'").Length.ToString();
        }
    }
}