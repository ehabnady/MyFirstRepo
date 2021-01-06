using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;

namespace AmounCRM4.Admins
{
    public partial class Plan_Visits : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //gridAffs.Height = Unit.Parse("550");
            //gridCalls.Height = Unit.Parse("550");
            //gridApps.Height = Unit.Parse("550");

            if (Session["EmployeeIDFromAdmin"].ToString() == "")
            {
                Response.Redirect("~/Login2.aspx");
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

        protected void btnGet_Click(object sender, EventArgs e)
        {
            ListOfAppointmentsDS.SelectCommand += " Where AppointmentID > 0";
            if (ddlCycles.SelectedValue != null && ddlCycles.SelectedValue != "Select")
            {
                ListOfAppointmentsDS.SelectCommand += " AND CycleID = " + int.Parse(ddlCycles.SelectedValue);
            }
            if (ddlLines.SelectedValue != null && ddlLines.SelectedValue != "Select")
            {
                ListOfAppointmentsDS.SelectCommand += " AND NewLineID = " + int.Parse(ddlLines.SelectedValue);
            }
            if (ddlRegions.SelectedValue != null && ddlRegions.SelectedValue != "Select")
            {
                ListOfAppointmentsDS.SelectCommand += " AND NewMgtAreaName = '" + ddlRegions.SelectedValue + "'";
            }
            ListOfAppointmentsDS.Select(DataSourceSelectArguments.Empty);
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