using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AmounCRM4.Surveys
{
    public partial class FeedbackReports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeIDFromSales"].ToString() == "")
            {
                Response.Redirect("~/Login2.aspx");

                //if (int.Parse(Session["LineIDFromSales"].ToString()) != 14)
                //{
                //    Response.Redirect("~/Reps/Repreport_Dashboard.aspx");
                //}
            }
        }
    }
}