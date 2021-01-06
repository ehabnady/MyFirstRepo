using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace AmounCRM4.SalesManagers
{
    public partial class CallRate : System.Web.UI.Page
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
            gridAchRatio.ExportSettings.Excel.Format = GridExcelExportFormat.Xlsx;
            gridAchRatio.ExportSettings.IgnorePaging = true;
            gridAchRatio.ExportSettings.ExportOnlyData = true;
            gridAchRatio.ExportSettings.OpenInNewWindow = true;
            gridAchRatio.MasterTableView.ExportToExcel();
        }
    }
}