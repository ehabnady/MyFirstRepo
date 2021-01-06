using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;

namespace AmounCRM4.Admins
{
    public partial class DoctorsList : System.Web.UI.Page
    {
        private static SqlCommand cmdMan;
        private static SqlConnection conMan;

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

        protected void btnExport_Click(object sender, EventArgs e)
        {
            conMan = new SqlConnection(ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ConnectionString);
            conMan.Open();
            string cmdManStr = "update Affiliations_Proposed set [ExportDate] ='"+ DateTime.Now.ToString("MM/dd/yyyy") + "' where (Status = 'Sales Director' or Status = 'Commercial Director') and ExportDate is null" ;
            cmdMan = new SqlCommand(cmdManStr, conMan);
            int Export = cmdMan.ExecuteNonQuery();
            conMan.Close();

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