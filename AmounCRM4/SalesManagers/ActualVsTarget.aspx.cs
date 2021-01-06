using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AmounCRM4.SalesManagers
{
    public partial class ActualVsTarget : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeType"].ToString() != "Sales Manager")
            {
                Response.Redirect("../Login2.aspx");
            }
        }
    }
}