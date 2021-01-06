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
    public partial class Visits_Plan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeType"].ToString() != "Sales Manager")
            {
                Response.Redirect("~/Login2.aspx");
            }
            else
            {
                FillAppsHeader();
            }
        }

        protected void FillAppsHeader()
        {
            RadPanelItem item = RadPanelBar1.Items[0];
            Label lT = (Label)item.Header.FindControl("lblAppsTotal");
            Label lA = (Label)item.Header.FindControl("lblAppsClassA");
            Label lB = (Label)item.Header.FindControl("lblAppsClassB");
            //Label lC = (Label)item.Header.FindControl("lblAppsClassC");

            lT.Text = "All Appointments:            " + ((DataView)ListOfAppointmentsDS.Select(DataSourceSelectArguments.Empty)).ToTable().Rows.Count.ToString();
            lA.Text = "Class A+: " + ((DataView)ListOfAppointmentsDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'A+'").Length.ToString();
            lB.Text = "Class A: " + ((DataView)ListOfAppointmentsDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'A'").Length.ToString();
            //lC.Text = "Class C: " + ((DataView)ListOfAppointmentsDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'C'").Length.ToString();
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            gridApps.ExportSettings.Excel.Format = GridExcelExportFormat.Xlsx;
            gridApps.ExportSettings.IgnorePaging = true;
            gridApps.ExportSettings.ExportOnlyData = true;
            gridApps.ExportSettings.OpenInNewWindow = true;
            gridApps.MasterTableView.ExportToExcel();
        }
    }
}