using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace AmounCRM4.Reps
{
    public partial class RepReport_TargetedAffiliations : System.Web.UI.Page
    {
        DataView dvAff;
        DataTable dtAff;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeID"].ToString() == "")
            {
                Response.Redirect("~/Login2.aspx");
            }
            else
            {
                if (Session["EmployeeType"].ToString() == "Admin")
                {
                    this.Master.FindControl("tblLinksAdmin").Visible = true;
                    this.Master.FindControl("tblLinksReps").Visible = false;
                }
                else if (Session["EmployeeType"].ToString() == "Rep")
                {
                    this.Master.FindControl("tblLinksAdmin").Visible = false;
                    this.Master.FindControl("tblLinksReps").Visible = true;
                }
            }

            dvAff = (DataView)(ListOfTargetedAffDS.Select(DataSourceSelectArguments.Empty));
            dtAff = dvAff.ToTable();

            lblAffsCount.Text = dtAff.Rows.Count.ToString();
            lblClassA_Aff.Text = dtAff.Select("AffiliationClass = 'A'").Length.ToString();
            lblClassB_Aff.Text = dtAff.Select("AffiliationClass = 'B'").Length.ToString();
            lblClassC_Aff.Text = dtAff.Select("AffiliationClass = 'C'").Length.ToString();
        }
    }
}