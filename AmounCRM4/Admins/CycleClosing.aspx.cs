using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AmounCRM4.Admins
{
    public partial class CycleClosing : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeIDFromAdmin"].ToString() == "")
            {
                Response.Redirect("~/Login2.aspx");
            }
        }

        protected void btnClosing_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtCycleDesc.Text == "" || txtYearID.Text == "" || ddlQuarter.SelectedIndex == -1 || ddlMonth.SelectedIndex == -1
                    || dtpFrom.SelectedDate == null || dtpTo.SelectedDate == null)
                {
                    txtResult.Visible = true;
                    txtResult.ReadOnly = false;
                    txtResult.Text = "All Are Required. Please Fill Them";
                    txtResult.ReadOnly = true;
                    return;
                }

                int x = 3, y = 4;
                if (x == y)
                {
                    dsCycleClosing.UpdateParameters[0].DefaultValue = Session["CycleIDFromAdmin"].ToString();
                    dsCycleClosing.Update();

                    dsCycleClosing.InsertParameters["CycleDesc"].DefaultValue = txtCycleDesc.Text;
                    dsCycleClosing.InsertParameters["YearID"].DefaultValue = txtYearID.Text;
                    dsCycleClosing.InsertParameters["QuarterID"].DefaultValue = ddlQuarter.SelectedValue;
                    dsCycleClosing.InsertParameters["MonthID"].DefaultValue = ddlMonth.SelectedValue;
                    dsCycleClosing.InsertParameters["FromDate"].DefaultValue = dtpFrom.SelectedDate.Value.ToShortDateString();
                    dsCycleClosing.InsertParameters["ToDate"].DefaultValue = dtpTo.SelectedDate.Value.ToShortDateString();
                    dsCycleClosing.InsertParameters["IsCurrent"].DefaultValue = "1";
                    dsCycleClosing.InsertParameters["PlanningDays"].DefaultValue = "1";
                    dsCycleClosing.Insert(); 

                    dsCycleClosing.SelectParameters[0].DefaultValue = (int.Parse(Session["CycleIDFromAdmin"].ToString()) + 1).ToString();
                    dsCycleClosing.Select(DataSourceSelectArguments.Empty);

                    txtResult.Visible = true;
                    txtResult.ReadOnly = false;
                    txtResult.Text = "Closing The Current Cycle & Openning The New Cycle Completed Successfully";
                    txtResult.ReadOnly = true;
                }
            }
            catch (Exception ex)
            {
                txtResult.Visible = true;
                txtResult.ReadOnly = false;
                txtResult.Text = "An Error Occured, " + ex.Message;
                txtResult.ReadOnly = true;
            }
        }
    }
}