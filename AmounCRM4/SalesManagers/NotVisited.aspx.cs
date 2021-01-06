using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace AmounCRM4.SalesManagers
{
    public partial class NotVisited : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeType"].ToString() != "Sales Manager")
            {
                Response.Redirect("~/Login2.aspx");
            }
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            gridNotPlanned.ExportSettings.Excel.Format = GridExcelExportFormat.Xlsx;
            gridNotPlanned.ExportSettings.IgnorePaging = true;
            gridNotPlanned.ExportSettings.ExportOnlyData = true;
            gridNotPlanned.ExportSettings.OpenInNewWindow = true;
            gridNotPlanned.MasterTableView.ExportToExcel();
        }
    }
}