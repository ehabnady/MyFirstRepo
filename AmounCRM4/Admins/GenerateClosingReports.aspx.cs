using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AmounCRM4.Admins
{
    public partial class GenerateClosingReports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeIDFromAdmin"].ToString() == "")
            {
                Response.Redirect("~/Login2.aspx");
            }
            Session["CycleIDFromAdmin2"] = int.Parse(Session["CycleIDFromAdmin"].ToString()) - 1;
        }

        protected void btnGenerator_Click(object sender, EventArgs e)
        {
            //dsGenerator.SelectParameters[0].DefaultValue = Session["CycleIDFromAdmin"].ToString();
            //dsGenerator.Select(DataSourceSelectArguments.Empty);
        }

        protected void dsGenerator_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }

        protected void dsGenerator_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }
    }
}