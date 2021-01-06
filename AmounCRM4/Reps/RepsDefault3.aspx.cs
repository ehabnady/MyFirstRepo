using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;

namespace AmounCRM4.Reps
{
    public partial class RepsDefault3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //gridAffs.Height = Unit.Parse("550");
            //gridCalls.Height = Unit.Parse("550");
            gridApps.Height = Unit.Parse("550");

            if (Session["EmployeeID"].ToString() == "")
            {
                Response.Redirect("~/Login.aspx");
            }
            else
            {
                if (Session["EmployeeType"].ToString() == "Admin")
                {
                    this.Master.FindControl("tblLinksAdmin").Visible = true;
                    this.Master.FindControl("tblLinksReps").Visible = false;
                    this.Master.FindControl("tblLinksReps").Visible = false;
                }
                else if (Session["EmployeeType"].ToString() == "Rep")
                {
                    this.Master.FindControl("tblLinksAdmin").Visible = false;
                    this.Master.FindControl("tblLinksReps").Visible = true;
                    this.Master.FindControl("tblLinksDMs").Visible = false;
                }
            }
        }

        //protected void btnExport_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        gridAffs.ExportSettings.IgnorePaging = true;
        //        gridAffs.ExportSettings.OpenInNewWindow = true;
        //        gridAffs.ExportSettings.ExportOnlyData = true;
        //        gridAffs.MasterTableView.ExportToExcel();
        //    }
        //    catch (Exception ex)
        //    {
        //        MessageBox.Show(ex.Message, ex.Source);
        //    }
        //}
    }
}