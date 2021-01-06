using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AmounCRM4.Reps
{
    public partial class CallsAnalysis : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if ((Session["EmployeeID"].ToString() == ""))
            {
                Response.Redirect("~/Login2.aspx");
            }
        }
    }
}