using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace AmounCRM4.Admins
{
    public partial class MobileEdit : System.Web.UI.Page
    {
        SqlConnection conn;
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["EmployeeID"].ToString() == "")
                {
                    Response.Redirect("~/Login2.aspx");
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            conn = new SqlConnection(dsAffs.ConnectionString);
            conn.Open();

            foreach (GridViewRow row in grdAffs.Rows)
            {
                int i;
                string mobileNumber = ((TextBox)row.Cells[5].FindControl("txtMobile")).Text;
                int AffID = int.Parse(row.Cells[0].Text);

                string updateQuery = @"UPDATE Entities SET Tel1 = '" + mobileNumber +
                                        @"' FROM (SELECT EntityID FROM View_Affiliations_Admin Where AffiliationID = " + AffID + ") as i WHERE i.EntityID = Entities.EntityID";
                cmd = new SqlCommand(updateQuery, conn);

                if (mobileNumber != "" && mobileNumber.Length == 11 && int.TryParse(mobileNumber, out i))
                {
                    int result = cmd.ExecuteNonQuery();
                }
            }

            btnSearch_Click(sender, e);
            conn.Close();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            searchAffs();
            grdAffs.DataBind();
        }

        protected void grdAffs_Sorting(object sender, GridViewSortEventArgs e)
        {
            searchAffs();
            if (grdAffs.SortDirection == SortDirection.Ascending)
            {
                grdAffs.Sort(e.SortExpression, SortDirection.Descending);
            }
            else
            {
                grdAffs.Sort(e.SortExpression, SortDirection.Ascending);
            }
            grdAffs.DataBind();
        }

        private void searchAffs()
        {
            string searchQuery = "SELECT DISTINCT [AffiliationID], [AffiliationName], [PhysicianID], [SpecialtyID], [BrickID] FROM [View_Affiliations_Admin] WHERE ([EmployeeID] = " + int.Parse(Session["EmployeeID"].ToString());

            if (txtAffID.Text != "")
            {
                dsAffs.SelectCommand += " AND AffiliationID = " + int.Parse(txtAffID.Text);
            }
            else
            {
                if (ddlSpecialty.SelectedIndex > 0)
                {
                    dsAffs.SelectCommand += " AND SpecialtyID = " + int.Parse(ddlSpecialty.SelectedValue);
                }
                if (ddlBricks.SelectedIndex > 0)
                {
                    dsAffs.SelectCommand += " AND BrickID = " + int.Parse(ddlBricks.SelectedValue);
                }
            }
        }

        protected void grdAffs_Sorted(object sender, EventArgs e)
        {
            //
        }
    }
}