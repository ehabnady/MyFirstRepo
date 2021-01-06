using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Globalization;

namespace AmounCRM4.Admins
{
    public partial class MessageForm2 : System.Web.UI.Page
    {
        SqlDataSource dsDM;
        SqlDataSource dsRep;
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ConnectionString);
        SqlCommand cmd;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["EmployeeIDFromAdmin"].ToString() == "")
                {
                    Response.Redirect("~/Login2.aspx");
                }
                tblDetail.Visible = true;
                tr1.Visible = false;
                tr2.Visible = false;
                tr3.Visible = false;
            }
        }

        protected void RadComboBox2_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            string RepIDs = "9";
            string comText = "";
            foreach (var item in RadComboBox2.CheckedItems)
            {
                //if (item.Selected)
                //{
                RepIDs += ", " + item.Value;
                //}
            }
            comText = "select EmployeeID,EmployeeFullName from View_Employees where EmployeeType='Rep' and DirectManagerID in(" + RepIDs + ") ";
            //comText = "select EmployeeID,EmployeeFullName from View_Employees where EmployeeType='Rep' and DirectManagerID in(" + RepIDs + ") and lineID=" + ddlLine.SelectedValue;

            dsRep = new SqlDataSource(System.Configuration.ConfigurationManager.ConnectionStrings["AmounCRMConnectionString"].ConnectionString, comText);
            dsRep.SelectParameters.Add("RepIDs", TypeCode.String, RepIDs);
            DataView dv = (DataView)dsRep.Select(DataSourceSelectArguments.Empty);
            dsRep.DataBind();
            RadComboBox3.DataSource = dsRep;
            RadComboBox3.DataValueField = "EmployeeID";
            RadComboBox3.DataTextField = "EmployeeFullName";
            RadComboBox3.DataBind();
        }
        
        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (txtSubject.Text != "" && dpStartDate.SelectedDate != null && dpEndDate.SelectedDate != null && txtMsgDescription.Text != "")
            {
                if (dpEndDate.SelectedDate < dpStartDate.SelectedDate)
                {
                    lblMsgMessage.Text = "Invalid End Date,it must be greater than Start Date";
                    return;
                }


                string newline = txtMsgDescription.Text;
                string lines = string.Join(Environment.NewLine, newline.Split()
                    .Select((word, index) => new { word, index })
                    .GroupBy(x => x.index / 9)
                    .Select(grp => string.Join(" ", grp.Select(x => x.word))));

                string lines2 = lines.Replace("\r\n", "<br />");


                if (ddlMsgType.SelectedValue == "1")
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("insert into [AmounCRM2].[dbo].[CRM_Messages_Master] (CRM_MessageName,CRM_MessageDescription,StartDate,EndDate,CRM_MessageType) values (N'" + txtSubject.Text + "', N'" + lines2 + "','" + dpStartDate.SelectedDate.Value.ToString("M/dd/yyyy") + "','" + dpEndDate.SelectedDate.Value.ToString("M/dd/yyyy") + "'," + ddlMsgType.SelectedValue + ")", con);
                    cmd.ExecuteNonQuery();

                    SqlCommand cmd2 = new SqlCommand("select max(CRM_MessageID) from [AmounCRM2].[dbo].[CRM_Messages_Master]");
                    cmd2.CommandType = CommandType.Text;
                    cmd2.Connection = con;
                    int MsgID = (int)cmd2.ExecuteScalar();


                    SqlCommand cmd3 = new SqlCommand("insert into [AmounCRM2].[dbo].[CRM_Messages_Details] (CRM_MessageID,LineID) values (" + MsgID + ",14)", con);
                    cmd3.ExecuteNonQuery();
                    con.Close();
                    lblMsgMessage.Text = "the Message has been sent";
                    Clear();
                }

                if (ddlMsgType.SelectedValue == "2")
                {
                    List<int> SMIDs = new List<int>();
                    int SMsCount = 0;
                    foreach (var item in RadComboBox1.CheckedItems)
                    {
                        //if (item.Selected)
                        //{
                            SMIDs.Add(int.Parse(item.Value));
                            SMsCount += 1;
                        //}
                    }

                    if (SMsCount == 0)
                    {
                        RadWindowManager1.RadAlert("Please select at least one Sales Manager", 400, 300, "No Sales Managers Selected", null);
                        return;
                    }
                    else
                    {
                        List<int> DMIDs = new List<int>();
                        int DMsCount = 0;
                        foreach (var item in RadComboBox2.CheckedItems)
                        {
                            //if (item.Selected)
                            //{
                                DMIDs.Add(int.Parse(item.Value));
                                DMsCount += 1;
                            //}
                        }

                        if (DMsCount == 0)
                        {
                            RadWindowManager1.RadAlert("Please select at least one District Manager", 400, 300, "No District Managers Selected", null);
                            return;
                        }
                        else
                        {
                            List<int> RepIDs = new List<int>();
                            int RepsCount = 0;
                            foreach (var item in RadComboBox3.CheckedItems)
                            {
                                //if (item.Selected)
                                //{
                                    RepIDs.Add(int.Parse(item.Value));
                                    RepsCount += 1;
                                //}
                            }

                            if (RepsCount == 0)
                            {
                                RadWindowManager1.RadAlert("Please select at least one Sales Representive", 400, 300, "No Sales Representives Selected", null);
                                return;
                            }
                            else
                            {

                                con.Open();
                                SqlCommand cmd = new SqlCommand("insert into [AmounCRM2].[dbo].[CRM_Messages_Master] (CRM_MessageName,CRM_MessageDescription,StartDate,EndDate,CRM_MessageType) values (N'" + txtSubject.Text + "', N'" + txtMsgDescription.Text + "','" + dpStartDate.SelectedDate.Value.ToString("M/dd/yyyy") + "','" + dpEndDate.SelectedDate.Value.ToString("M/dd/yyyy") + "'," + ddlMsgType.SelectedValue + ")", con);
                                cmd.ExecuteNonQuery();

                                SqlCommand cmd2 = new SqlCommand("select max(CRM_MessageID) from [AmounCRM2].[dbo].[CRM_Messages_Master]");
                                cmd2.CommandType = CommandType.Text;
                                cmd2.Connection = con;
                                int MsgID = (int)cmd2.ExecuteScalar();

                                foreach (var item in SMIDs)
                                {
                                    SqlCommand cmd3 = new SqlCommand("insert into [AmounCRM2].[dbo].[CRM_Messages_Details] (CRM_MessageID,LineID,SalesManagerID) values (" + MsgID + "," + ddlLine.SelectedValue + "," + item + ")", con);
                                    cmd3.ExecuteNonQuery();
                                }

                                foreach (var item in DMIDs)
                                {
                                    SqlCommand cmd4 = new SqlCommand("insert into [AmounCRM2].[dbo].[CRM_Messages_Details] (CRM_MessageID,LineID,DistrictManagerID) values (" + MsgID + "," + ddlLine.SelectedValue + "," + item + ")", con);
                                    cmd4.ExecuteNonQuery();
                                }

                                foreach (var item in RepIDs)
                                {
                                    SqlCommand cmd5 = new SqlCommand("insert into [AmounCRM2].[dbo].[CRM_Messages_Details] (CRM_MessageID,LineID,SalesRepID) values (" + MsgID + "," + ddlLine.SelectedValue + "," + item + ")", con);
                                    cmd5.ExecuteNonQuery();
                                }
                                con.Close();
                                lblMsgMessage.Text = "the Message has been sent";
                                Clear();
                            }

                        }
                    }

                }
                if (ddlMsgType.SelectedValue == "3")
                {
                    List<int> SMIDs = new List<int>();
                    int SMsCount = 0;
                    foreach (var item in RadComboBox1.CheckedItems)
                    {
                        //if (item.Selected)
                        //{
                            SMIDs.Add(int.Parse(item.Value));
                            SMsCount += 1;
                        //}
                    }

                    if (SMsCount == 0)
                    {
                        RadWindowManager1.RadAlert("Please select at least one Sales Manager", 400, 300, "No Sales Managers Selected", null);
                        return;
                    }
                    else
                    {
                        List<int> DMIDs = new List<int>();
                        int DMsCount = 0;
                        foreach (var item in RadComboBox2.CheckedItems)
                        {
                            //if (item.Selected)
                            //{
                                DMIDs.Add(int.Parse(item.Value));
                                DMsCount += 1;
                            //}
                        }

                        if (DMsCount == 0)
                        {
                            RadWindowManager1.RadAlert("Please select at least one District Manager", 400, 300, "No District Managers Selected", null);
                            return;
                        }
                        else
                        {
                            con.Open();
                            SqlCommand cmd = new SqlCommand("insert into [AmounCRM2].[dbo].[CRM_Messages_Master] (CRM_MessageName,CRM_MessageDescription,StartDate,EndDate,CRM_MessageType) values (N'" + txtSubject.Text + "', N'" + txtMsgDescription.Text + "','" + dpStartDate.SelectedDate.Value.ToString("M/dd/yyyy") + "','" + dpEndDate.SelectedDate.Value.ToString("M/dd/yyyy") + "'," + ddlMsgType.SelectedValue + ")", con);
                            cmd.ExecuteNonQuery();

                            SqlCommand cmd2 = new SqlCommand("select max(CRM_MessageID) from [AmounCRM2].[dbo].[CRM_Messages_Master]");
                            cmd2.CommandType = CommandType.Text;
                            cmd2.Connection = con;
                            int MsgID = (int)cmd2.ExecuteScalar();

                            foreach (var item in SMIDs)
                            {
                                SqlCommand cmd3 = new SqlCommand("insert into [AmounCRM2].[dbo].[CRM_Messages_Details] (CRM_MessageID,LineID,SalesManagerID) values (" + MsgID + "," + ddlLine.SelectedValue + "," + item + ")", con);
                                cmd3.ExecuteNonQuery();
                            }

                            foreach (var item in DMIDs)
                            {
                                SqlCommand cmd4 = new SqlCommand("insert into [AmounCRM2].[dbo].[CRM_Messages_Details] (CRM_MessageID,LineID,DistrictManagerID) values (" + MsgID + "," + ddlLine.SelectedValue + "," + item + ")", con);
                                cmd4.ExecuteNonQuery();
                            }
                            con.Close();
                            lblMsgMessage.Text = "the Message has been sent";
                            Clear();

                        }
                    }
                }
                if (ddlMsgType.SelectedValue == "4")
                {
                    List<int> SMIDs = new List<int>();
                    int SMsCount = 0;
                    foreach (var item in RadComboBox1.CheckedItems)
                    {
                        //if (item.Selected)
                        //{
                            SMIDs.Add(int.Parse(item.Value));
                            SMsCount += 1;
                        //}
                    }

                    if (SMsCount == 0)
                    {
                        RadWindowManager1.RadAlert("Please select at least one Sales Manager", 400, 300, "No Sales Managers Selected", null);
                        return;
                    }
                    else
                    {
                        con.Open();
                        SqlCommand cmd = new SqlCommand("insert into [AmounCRM2].[dbo].[CRM_Messages_Master] (CRM_MessageName,CRM_MessageDescription,StartDate,EndDate,CRM_MessageType) values (N'" + txtSubject.Text + "', N'" + txtMsgDescription.Text + "','" + dpStartDate.SelectedDate.Value.ToString("M/dd/yyyy") + "','" + dpEndDate.SelectedDate.Value.ToString("M/dd/yyyy") + "'," + ddlMsgType.SelectedValue + ")", con);
                        cmd.ExecuteNonQuery();

                        SqlCommand cmd2 = new SqlCommand("select max(CRM_MessageID) from [AmounCRM2].[dbo].[CRM_Messages_Master]");
                        cmd2.CommandType = CommandType.Text;
                        cmd2.Connection = con;
                        int MsgID = (int)cmd2.ExecuteScalar();

                        foreach (var item in SMIDs)
                        {
                            SqlCommand cmd3 = new SqlCommand("insert into [AmounCRM2].[dbo].[CRM_Messages_Details] (CRM_MessageID,LineID,SalesManagerID) values (" + MsgID + "," + ddlLine.SelectedValue + "," + item + ")", con);
                            cmd3.ExecuteNonQuery();
                        }
                        con.Close();
                        lblMsgMessage.Text = "the Message has been sent";
                        Clear();
                    }
                }
            }
            else
            {
                lblMsgMessage.Text = "All fields with an asterisk (*) are required fields";
            }
        }

        private void Clear()
        {
            txtMsgDescription.Text = "";
            txtSubject.Text = "";
            ddlLine.SelectedValue = "14";
            dpEndDate.Clear();
            dpStartDate.Clear();
            ddlMsgType.SelectedValue = "1";


        }
        protected void RadComboBox1_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            string DMIDs = "9";
            string comText = "";
            var collection = RadComboBox1.CheckedItems;
            foreach (var item in collection)
            {
                //if (item.Selected)
                //{
                DMIDs += ", " + item.Value;
                //}
            }
            comText = "select EmployeeID,EmployeeFullName from View_Employees where EmployeeType='DM' and DirectManagerID in(" + DMIDs + ")";
            //comText = "select EmployeeID,EmployeeFullName from View_Employees where EmployeeType='DM' and DirectManagerID in(" + DMIDs + ") and lineID=" + ddlLine.SelectedValue;

            dsDM = new SqlDataSource(System.Configuration.ConfigurationManager.ConnectionStrings["AmounCRMConnectionString"].ConnectionString, comText);
            dsDM.SelectParameters.Add("DMIDs", TypeCode.String, DMIDs);
            DataView dv = (DataView)dsDM.Select(DataSourceSelectArguments.Empty);
            dsDM.DataBind();
            RadComboBox2.DataSource = dsDM;
            RadComboBox2.DataValueField = "EmployeeID";
            RadComboBox2.DataTextField = "EmployeeFullName";
            RadComboBox2.DataBind();
        }
        protected void ddlMsgType_onSelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlMsgType.SelectedValue == "1")
            {
                tblDetail.Visible = true;
                tr1.Visible = false;
                tr2.Visible = false;
                tr3.Visible = false;
            }
            else if (ddlMsgType.SelectedValue == "2")
            {
                tblDetail.Visible = true;
                tr1.Visible = true;
                tr2.Visible = true;
                tr3.Visible = true;
            }
            else if (ddlMsgType.SelectedValue == "3")
            {
                tblDetail.Visible = true;
                tr1.Visible = true;
                tr2.Visible = true;
                tr3.Visible = false;

            }
            else if (ddlMsgType.SelectedValue == "4")
            {
                tblDetail.Visible = true;
                tr1.Visible = true;
                tr2.Visible = false;
                tr3.Visible = false;
            }
        }
        protected void ddlLine_onSelectedIndexChanged(object sender, EventArgs e)
        {
            dsManagers.SelectCommand = "SELECT EmployeeID, EmployeeFullName FROM View_Employees WHERE (EmployeeType = 'Sales Manager') and ([LineID] = @LineID or [LineID] =14 ) ";
            dsManagers.SelectParameters.Clear();
            dsManagers.SelectParameters.Add("LineID", ddlLine.SelectedValue);
            dsManagers.DataBind();
        }
    }

}