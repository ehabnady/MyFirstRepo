using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AmounCRM4.DMs
{
    public partial class Notifications : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //lblWorkingDays.Text = "Working Days: " + Session["WorkingDays"].ToString() + " Days.";
        }

        protected void myID2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            Boolean isEmpty = true;
            for (int j = 1; j < e.Row.Cells.Count; j++)
            {
                if (e.Row.Cells[j].Text.ToString() != "" && e.Row.Cells[j].Text.ToString() != "&nbsp;")
                {
                    isEmpty = false;
                    //break;
                }
            }
            if (isEmpty == true)
            {
                e.Row.Visible = false;
            }
        }
    }
}