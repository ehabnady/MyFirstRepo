using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace AmounCRM4.Reps
{
    public partial class Statistics : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ObjectDataSource21_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            //int i = ((DataTable)e.ReturnValue).Rows.Count;
        }
    }
}