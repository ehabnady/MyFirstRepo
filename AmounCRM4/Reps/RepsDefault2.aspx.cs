using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AmounCRM4.Reps
{
    public partial class RepsDefault2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //RadPanelBar1.Items[0].Expanded = true;
            if (Session["EmployeeID"].ToString() == "")
            {
                Response.Redirect("~/Login2.aspx");
            }
            else
            {
                if (Session["EmployeeType"].ToString() == "Admin")
                {
                    this.Master.FindControl("tblLinksAdmin").Visible = true;
                    this.Master.FindControl("tblLinksReps").Visible = false;
                    this.Master.FindControl("tblLinksDMs").Visible = false;
                }
                else if (Session["EmployeeType"].ToString() == "Rep")
                {
                    this.Master.FindControl("tblLinksAdmin").Visible = false;
                    this.Master.FindControl("tblLinksReps").Visible = true;
                    this.Master.FindControl("tblLinksDMs").Visible = false;
                }
            }
        }
    }
}