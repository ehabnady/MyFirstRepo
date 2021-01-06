using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace AmounCRM4.CommercialDirector
{
    public partial class TargetPlanVisits : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeIDFromComDir"].ToString() == "0")
            {
                Response.Redirect("~/Login2.aspx");
            }
        }

        protected void dsTPV_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }
    }
}