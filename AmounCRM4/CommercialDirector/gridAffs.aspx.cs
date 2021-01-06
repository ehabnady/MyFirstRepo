using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace AmounCRM4.CommercialDirector
{
    public partial class gridAffs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeIDFromComDir"].ToString() == "0")
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

            lT.Text = "All Doctors:          " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Rows.Count.ToString();
            lA.Text = "Class A: " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'A'").Length.ToString();
            lB.Text = "Class B: " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'B'").Length.ToString();
            //lC.Text = "Class C: " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'C'").Length.ToString();
        }
    }
}