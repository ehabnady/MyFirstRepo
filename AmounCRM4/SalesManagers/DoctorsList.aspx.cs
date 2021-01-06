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
    public partial class DoctorsList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeType"].ToString() != "Sales Manager")
            {
                Response.Redirect("../Login2.aspx");
            }
            else
            {
                FillAffHeader();
            }
        }

        protected void FillAffHeader()
        {
            //RadPanelItem item = RadPanelBar1.Items[0];
            //RadLabel lT = (RadLabel)item.Header.FindControl("lblAffsTotal2");
            //RadLabel lA = (RadLabel)item.Header.FindControl("lblAffsClassA2");
            //RadLabel lB = (RadLabel)item.Header.FindControl("lblAffsClassB2");
            ////Label lC = (Label)item.Header.FindControl("lblAffsClassC");

            //lT.Text = "All Physicians:          " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Rows.Count.ToString();
            //lA.Text = "Class A: " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'A'").Length.ToString();
            //lB.Text = "Class B: " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'B'").Length.ToString();
            //lC.Text = "Class C: " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'C'").Length.ToString();

            lblAffsTotal2.Text = "All Physicians:          " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Rows.Count.ToString();
            lblAffsClassA2.Text = "Class A: " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'A'").Length.ToString();
            lblAffsClassB2.Text = "Class B: " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'B'").Length.ToString();
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            gridAffs.ExportSettings.Excel.Format = GridExcelExportFormat.Xlsx;
            gridAffs.ExportSettings.IgnorePaging = true;
            gridAffs.ExportSettings.ExportOnlyData = true;
            gridAffs.ExportSettings.OpenInNewWindow = true;
            gridAffs.MasterTableView.ExportToExcel();
        }
    }
}