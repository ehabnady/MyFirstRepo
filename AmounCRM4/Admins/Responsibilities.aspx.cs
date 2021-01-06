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
    public partial class Responsibilities : System.Web.UI.Page
    {
        SqlDataSource dsBricks;
        int lineID = 0;
        string brickIDsString = "0";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["EmployeeIDFromAdmin"].ToString() == "")
                {
                    Response.Redirect("~/Login2.aspx");
                }
            }
        }

        protected void ddlDMs_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlReps.Items.Clear();
            ddlReps.AppendDataBoundItems = true;
            ddlReps.Items.Add(new ListItem("Sales Reps", "0"));
            ddlReps.DataBind();
        }

        protected void btnGetBricks_Click(object sender, EventArgs e)
        {
            string areasIDs = "99999";
            string comText = "";
            foreach (ListItem item in chklAreas.Items)
            {
                if (item.Selected)
                {
                    areasIDs += ", " + item.Value;
                }
            }
            comText = "SELECT DISTINCT AmounBrickID, AmounBrickName, CONCAT(AmounBrickName, ' (', AmounBrickID, ')') AS AmounBrickName2 FROM AreaHierarchy WHERE (RepAreaID IN(" + areasIDs + "))";
            dsBricks = new SqlDataSource(System.Configuration.ConfigurationManager.ConnectionStrings["AmounCRMConnectionString"].ConnectionString, comText);
            dsBricks.SelectParameters.Add("areasIDs", TypeCode.String, areasIDs);
            DataView dv = (DataView) dsBricks.Select(DataSourceSelectArguments.Empty);
            dsBricks.DataBind();
            chklBricks.DataSource = dsBricks;
            chklBricks.DataValueField = "AmounBrickID";
            chklBricks.DataTextField = "AmounBrickName2";
            chklBricks.DataBind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            List<int> bricksIDs = new List<int>();
            bricksIDs.Add(0);
            int bricksCount = 0;
            foreach (ListItem item in chklBricks.Items)
            {
                if (item.Selected)
                {
                    brickIDsString += ", " + int.Parse(item.Value);
                    bricksIDs.Add(int.Parse(item.Value));
                    bricksCount += 1;
                }
            }

            if (bricksCount == 0)
            {
                RadWindowManager1.RadAlert("Please select at least one brick", 400, 300, "No Bricks Selected", null);
                return;
            }
            else
            {
                string getLineID = "Select LineID From View_Employees Where EmployeeID = " + ddlReps.SelectedValue;
                SqlCommand cmdLineID = new SqlCommand(getLineID, new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["AmounCRMConnectionString"].ConnectionString));
                cmdLineID.Connection.Open();
                SqlDataReader drLineID = cmdLineID.ExecuteReader();
                if (drLineID.HasRows)
                {
                    while (drLineID.Read())
                    {
                        lineID = int.Parse(drLineID[0].ToString());
                    }
                    
                }
                else
                {
                    RadWindowManager1.RadAlert("This Rep Has No Line, Contact Your Admin, or Try Again Later.", 400, 300, "No Related Line", null);
                    return;
                }

                string strCheckDeletionFromCurrentRep = @"Select COUNT(*) From View_EmployeesBricks2 Where Deleted = 1 AND ToBeApplied = 1 AND LineID = " + lineID + " AND AmounBrickID IN (" + brickIDsString + ")";
                SqlCommand cmdValidateDeletion = new SqlCommand(strCheckDeletionFromCurrentRep, new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["AmounCRMConnectionString"].ConnectionString));
                DataSet ds = new DataSet("ds");
                SqlDataAdapter daDeletionValidation = new SqlDataAdapter(cmdValidateDeletion);
                cmdValidateDeletion.Connection.Open();
                daDeletionValidation.Fill(ds);
                if (int.Parse(ds.Tables[0].Rows[0][0].ToString()) != bricksCount && int.Parse(ds.Tables[0].Rows[0][0].ToString()) > 0)
                {
                    RadWindowManager1.RadAlert("One or more brick(s) in this line is assigned to another rep, please delete any assignment for these bricks / line before continue ", 400, 300, "Redundant Responsibilities", null);
                    return;
                }

                string selectedBricksCount = "Select COUNT(*) From View_EmployeesBricks2 Where (Deleted IS NULL OR Deleted = 0) AND ToBeApplied = 1 AND LineID = " + lineID + " AND AmounBrickID IN (" + brickIDsString + ")";
                // AND ToBeApplied = 1 ---> New Part
                SqlCommand cmdValidation = new SqlCommand(selectedBricksCount, new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["AmounCRMConnectionString"].ConnectionString));
                cmdValidation.Connection.Open();
                SqlDataReader drValidation = cmdValidation.ExecuteReader();
                if (drValidation.HasRows)
                {
                    while (drValidation.Read())
                    {
                        if (int.Parse(drValidation[0].ToString()) > 0)
                        {
                            RadWindowManager1.RadAlert("One or more brick(s) in this line is assigned to another rep, please delete any assignment for these bricks / line before continue ", 400, 300, "Redundant Responsibilities", null);
                            return;
                        }
                        else
                        {
                            foreach (var item in bricksIDs)
                            {
                                if (int.Parse(item.ToString()) > 0)
                                {
                                    dsSave.InsertParameters[0].DefaultValue = ddlReps.SelectedValue;
                                    dsSave.InsertParameters[1].DefaultValue = item.ToString();
                                    dsSave.InsertParameters[2].DefaultValue = Boolean.FalseString;
                                    dsSave.Insert();
                                }
                            }
                        }
                    }
                }
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            List<int> bricksIDs = new List<int>();
            bricksIDs.Add(0);
            int bricksCount = 0;
            foreach (ListItem item in chklBricks.Items)
            {
                if (item.Selected)
                {
                    brickIDsString += ", " + int.Parse(item.Value);
                    bricksIDs.Add(int.Parse(item.Value));
                    bricksCount += 1;
                }
            }

            if (bricksCount == 0)
            {
                RadWindowManager1.RadAlert("Please select at least one brick", 400, 300, "No Bricks Selected", null);
                return;
            }
            else
            {
                dsSave.DeleteParameters[0].DefaultValue = ddlReps.SelectedValue;

                dsSave.DeleteCommand = @"UPDATE [EmployeesBricks2] SET [Deleted] = 1, [ToBeApplied] = 1 WHERE [EmployeeID] = " + ddlReps.SelectedValue + 
                                        " AND BrickID IN (" + brickIDsString + ")";
                //New Part
                int i = dsSave.Delete();
                if (i == 0)
                {
                    foreach (var item in bricksIDs)
                    {
                        if (int.Parse(item.ToString()) > 0)
                        {
                            dsSave.InsertParameters[0].DefaultValue = ddlReps.SelectedValue;
                            dsSave.InsertParameters[1].DefaultValue = item.ToString();
                            dsSave.InsertParameters[2].DefaultValue = Boolean.TrueString;
                            dsSave.Insert();
                        }
                    }
                }
                //End of New Part
            }
        }

        protected void ddlManagers_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlDMs.Items.Clear();
            ddlDMs.AppendDataBoundItems = true;
            //dsDMs.SelectParameters[0].DefaultValue = ddlManagers.SelectedValue;
            //dsDMs.Select(DataSourceSelectArguments.Empty);
            //dsDMs.DataBind();
            ddlDMs.Items.Add(new ListItem("District Manager", "0"));
            ddlDMs.DataBind();
        }

        protected void chkAll_CheckedChanged(object sender, EventArgs e)
        {
            if (chkAll.Checked)
            {
                foreach (ListItem chk in chklBricks.Items)
                {
                    chk.Selected = true;
                }
            }
            else
            {
                foreach (ListItem chk in chklBricks.Items)
                {
                    chk.Selected = false;
                }
            }
        }
    }
}