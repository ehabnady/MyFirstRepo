using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AmounCRM4.Admins
{
    public partial class Targeting : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeIDFromAdmin"].ToString() == "")
            {
                Response.Redirect("~/Login2.aspx");
            }
        }

        protected void btnCreateTargetList_Click(object sender, EventArgs e)
        {
            //dsTargetList.Delete();

            //dsTargetList.InsertParameters[0].DefaultValue = Session["CycleIDFromAdmin"].ToString();
            //dsTargetList.Insert();

            //dsTargetList.Select(DataSourceSelectArguments.Empty);
        }
    }
}