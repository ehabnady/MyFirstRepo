using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AmounCRM4.CommercialDirector
{
    public partial class PivotAnalyzer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeIDFromComDir"].ToString() == "0")
            {
                Response.Redirect("~/Login2.aspx");
            }

        }

        protected void ObjectDataSource2_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            int i = ((DataTable)e.ReturnValue).Rows.Count;
        }
    }
}