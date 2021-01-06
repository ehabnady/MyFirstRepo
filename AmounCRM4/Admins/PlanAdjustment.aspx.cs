using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AmounCRM4.Admins
{
    public partial class PlanAdjustment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            txtForDel.Text = (int.Parse(txtCurrentPlan.Text) - int.Parse(txtOriginalPlan.Text)).ToString();

            DataTable dt = new DataTable("dt");
            dt.Columns.Add("AppointmentID");

            SqlConnection con = new SqlConnection(dsAreas.ConnectionString);
            SqlCommand cmd = new SqlCommand("Select AppointmentID From Appointments Where (DeletedAppointment = 'false' or DeletedAppointment is null) and Annotations = 'Appointment' AND CycleID = " + int.Parse(Session["CycleIDFromAdmin"].ToString()) + " AND AreaRecID = " + int.Parse(ddlArea.SelectedValue.ToString()), con);
            SqlDataAdapter daForDel = new SqlDataAdapter(cmd);
            daForDel.Fill(dt);

            int i = int.Parse(txtForDel.Text);
            int j = 1;
            foreach (DataRow row in dt.Rows)
            {
                if (j <= i)
                {
                    dsAppsUpdate.UpdateParameters[0].DefaultValue = row[0].ToString();
                    dsAppsUpdate.Update();
                    j++;
                }
            }
            Response.Write("<script language='javascript'>alert('Extra Appointments Deleted')</script>");

            txtCurrentPlan.Text = "0";
            txtOriginalPlan.Text = "0";
            txtForDel.Text = "0";
        }

        protected void ddlArea_SelectedIndexChanged(object sender, EventArgs e)
        {
            dsAppsCount.SelectParameters[0].DefaultValue = ddlArea.SelectedValue;
            dsAppsCount.DataBind();
            DataView dv = (DataView)dsAppsCount.Select(DataSourceSelectArguments.Empty);
            txtCurrentPlan.Text = dv[0][0].ToString();

            txtOriginalPlan.Text = "0";
            txtForDel.Text = "0";
        }
    }
}