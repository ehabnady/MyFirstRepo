using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AmounCRM4.Surveys
{
    public partial class FeedbackReports_Managers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeHRCodeFromSM"].ToString() != "950997" && Session["EmployeeHRCodeFromDir"].ToString() != "101176")//Eman Mounier
            {
                Response.Redirect("~/Login2.aspx");
            }
        }
    }
}