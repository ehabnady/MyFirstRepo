using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AmounCRM4.CommercialDirector
{
    public partial class NotVisitedDoctors : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeIDFromComDir"].ToString() == "0")
            {
                Response.Redirect("~/Login2.aspx");
            }
        }

        protected void dsNotVisited_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }
    }
}