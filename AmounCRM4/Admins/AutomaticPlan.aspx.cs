using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Windows;

namespace AmounCRM4.Admins
{
    public partial class AutomaticPlan : System.Web.UI.Page
    {
        DataSet dsPlan;
        DataTable affs;
        DataTable Appointments_Original;
        
        SqlConnection con;
        SqlCommand com;
        SqlDataAdapter sqlDA;
        SqlParameter updateParams;
        string detailsXML;

        SqlDataAdapter sqlDA_Emps;
        public void ProcessPrep()
        {
            dsPlan = new DataSet("dsPlan");
            affs = new DataTable("affs");
            Appointments_Original = new DataTable("Appointments_Original");

            con = new SqlConnection(AreasDS.ConnectionString);
            com = new SqlCommand("", con);
            //sqlDS = new SqlDataSource(AreasDS.ConnectionString, "");
            sqlDA = new SqlDataAdapter("", AreasDS.ConnectionString);

            sqlDA_Emps = new SqlDataAdapter("", AreasDS.ConnectionString);

            affs.Columns.Add("AffiliationID", System.Type.GetType("System.Int32"));
            affs.Columns.Add("AffiliationName", System.Type.GetType("System.String"));
            //affs.Columns.Add("EntityID", System.Type.GetType("System.Int32"));
            //affs.Columns.Add("PhysicianID", System.Type.GetType("System.Int32"));
            affs.Columns.Add("PhysicianClass", System.Type.GetType("System.String"));
            //affs.Columns.Add("AreaRecID", System.Type.GetType("System.Int32"));
            affs.Columns.Add("AmounTerritoryID", System.Type.GetType("System.Int32"));
            affs.Columns.Add("BrickID", System.Type.GetType("System.Int32"));
            affs.Columns.Add("LineID", System.Type.GetType("System.Int32"));
            affs.Columns.Add("EmployeeID", System.Type.GetType("System.Int32"));

            Appointments_Original.Columns.Add("AppointmentID", System.Type.GetType("System.Int32"));
            Appointments_Original.Columns.Add("Subject", System.Type.GetType("System.String"));
            Appointments_Original.Columns.Add("Description", System.Type.GetType("System.String"));
            Appointments_Original.Columns.Add("StartDate", System.Type.GetType("System.DateTime"));
            Appointments_Original.Columns.Add("EndDate", System.Type.GetType("System.DateTime"));

            Appointments_Original.Columns.Add("AffiliationID", System.Type.GetType("System.Int32"));
            //Appointments.Columns.Add("EntityID", System.Type.GetType("System.Int32"));
            //Appointments.Columns.Add("PhysicianID", System.Type.GetType("System.Int32"));

            //apps.Columns.Add("RecurrenceRule", System.Type.GetType("System.String"));
            //apps.Columns.Add("RecurrenceParentID", System.Type.GetType("System.Int32"));
            //apps.Columns.Add("Reminder", System.Type.GetType("System.String"));
            Appointments_Original.Columns.Add("Annotations", System.Type.GetType("System.String"));
            Appointments_Original.Columns.Add("LastModified", System.Type.GetType("System.String"));
            Appointments_Original.Columns.Add("EmployeeID", System.Type.GetType("System.Int32"));
            Appointments_Original.Columns.Add("LineID", System.Type.GetType("System.Int32"));
            //Appointments.Columns.Add("AreaRecID", System.Type.GetType("System.Int32"));
            Appointments_Original.Columns.Add("BrickID", System.Type.GetType("System.Int32"));
            Appointments_Original.Columns.Add("CycleID", System.Type.GetType("System.Int32"));

            updateParams = new SqlParameter();
            dsPlan.Tables.Add(affs);
            dsPlan.Tables.Add(Appointments_Original);
        }

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

        protected void cbCycles_ItemDataBound(object sender, Telerik.Web.UI.RadComboBoxItemEventArgs e)
        {
            e.Item.Attributes.Add("FromDate", ((DataRowView)e.Item.DataItem)["FromDate"].ToString());
            e.Item.Attributes.Add("ToDate", ((DataRowView)e.Item.DataItem)["ToDate"].ToString());
            //e.Item.Text = ((DataRowView)e.Item.DataItem)["CycleName"].ToString();
            //e.Item.Value = ((DataRowView)e.Item.DataItem)["CycleID"].ToString();
        }

        protected void btnGetAreas_Click(object sender, EventArgs e)
        {
            string areasParam = "0";
            foreach (ListItem li in chklLines.Items)
            {
                if (li.Selected == true)
                {
                    areasParam += ", " + li.Value;
                }
            }

            //AreasDS.SelectCommand += " Where NewLineID IN (" + areasParam + ") ORDER BY NewAreaName";//GroupID IN (
            chklAreas.DataSourceID = "AreasDS";
            chklAreas.DataTextField = "RepAreaName";
            chklAreas.DataValueField = "RepAreaID";
            //DataSourceID="AreasDS" DataTextField="AmounTerritoryName" DataValueField="RecID"
            chklAreas.DataBind();
        }

        protected void chkCheckAll_CheckedChanged(object sender, EventArgs e)
        {
            if (chkCheckAll.Checked == true)
            {
                foreach (ListItem li in chklLines.Items)
                {
                    li.Selected = true;
                }
            }
            else
            {
                foreach (ListItem li in chklLines.Items)
                {
                    li.Selected = false;
                }
            }
        }

        protected void chkCheckAllAreas_CheckedChanged(object sender, EventArgs e)
        {
            if (chkCheckAllAreas.Checked == true)
            {
                foreach (ListItem li in chklAreas.Items)
                {
                    li.Selected = true;
                }
            }
            else
            {
                foreach (ListItem li in chklAreas.Items)
                {
                    li.Selected = false;
                }
            }
        }

        protected void btnAutoPlan_Click(object sender, EventArgs e)
        {
            if (cbCycles.SelectedValue == "")
            {
                FailureText.Text = "Alert!" + "<br />" + "Please select a cycle";
            }
            else if (int.Parse(cbCycles.SelectedValue) < int.Parse(Session["CycleID"].ToString()))
            {
                FailureText.Text = "Error!" + "<br />" + "Select the current or next cycle";
            }
            else
            {
                //DialogResult res = MessageBox.Show("This action will delete all created appointments for the selected cycle and areas", "Alert!", MessageBoxButtons.OKCancel, MessageBoxIcon.Question, MessageBoxDefaultButton.Button1, MessageBoxOptions.ServiceNotification);
                //if(res == DialogResult.OK)
                string selectedAreas = "0";
                foreach (ListItem li in chklAreas.Items)
                {
                    if (li.Selected == true)
                    {
                        selectedAreas += ", " + li.Value;
                    }
                }

                string selectedEmps = "0";
                foreach (ListItem li in chklEmployees.Items)
                {
                    if (li.Selected == true)
                    {
                        selectedEmps += ", " + li.Value;
                    }
                }

                con = new SqlConnection(AreasDS.ConnectionString);
                //SqlCommand bricksCom = new SqlCommand("Select Distinct AmounBrickID From AreaHierarchy WHERE Deleted IS NULL AND RepAreaID IN (" + selectedAreas + ")", con);
                SqlCommand bricksCom = new SqlCommand("Select Distinct AmounBrickID From View_EmployeesBricks WHERE Deleted (IS NULL OR Deleted = 0) AND EmployeeID IN (" + selectedEmps + ")", con);

                string selectedBricks = "0";
                con.Open();
                SqlDataReader bricksDR = bricksCom.ExecuteReader(CommandBehavior.CloseConnection);
                while (bricksDR.Read())
                {
                    selectedBricks += ", " + bricksDR.GetValue(0);
                }

                string selectedLines = "0";
                foreach (ListItem li in chklLines.Items)
                {
                    if (li.Selected == true)
                    {
                        selectedLines += ", " + li.Value;
                    }
                }

                con = new SqlConnection(AreasDS.ConnectionString);
                SqlCommand c = new SqlCommand("Delete From Appointments_Original Where CycleID = " + int.Parse(cbCycles.SelectedValue.ToString()) + " and BrickID IN (" + selectedBricks + ") AND LineID IN (" + selectedLines + ")", con);
                con.Open();
                int iiii = c.ExecuteNonQuery();
                con.Close();

                GetSelectedAreas();
            }
        }

        private void GetSelectedAreas()
        {
            try
            {
                string selectedAreas = "0";
                foreach (ListItem li in chklAreas.Items)
                {
                    if (li.Selected == true)
                    {
                        selectedAreas += ", " + li.Value;
                    }
                }

                string selectedLines = "0";
                foreach (ListItem li in chklLines.Items)
                {
                    if (li.Selected == true)
                    {
                        selectedLines += ", " + li.Value;
                    }
                }

                string selectedEmps = "0";
                foreach (ListItem li in chklEmployees.Items)
                {
                    if (li.Selected == true)
                    {
                        selectedEmps += ", " + li.Value;
                    }
                }

                ProcessPrep();

                //Filling Affiliations Table
                //com.CommandText = "SELECT AffiliationID, AffiliationName, PhysicianClass, BrickID, AmounTerritoryID, LineID, EmployeeID, SpecialtyValue FROM View_Affiliations_Admin WHERE EmployeeID IS NOT NULL AND SpecialtyValue > 0 AND LastModifierID IS NOT NULL AND AmounTerritoryID IN (" + selectedAreas + ") AND LineID IN (" + selectedLines + ") ORDER BY LineID, EmployeeID, TotalValue DESC, SpecialtyValue DESC";
                com.CommandText = "SELECT AffiliationID, AffiliationName, PhysicianClass, BrickID, AmounTerritoryID, LineID, EmployeeID, SpecialtyValue FROM View_Affiliations_Admin WHERE EmployeeID IS NOT NULL AND SpecialtyValue > 0 AND LastModifierID IS NOT NULL AND EmployeeID IN (" + selectedEmps + ") AND LineID IN (" + selectedLines + ") ORDER BY LineID, EmployeeID, TotalValue DESC, SpecialtyValue DESC";

                sqlDA.SelectCommand = com;
                affs.Rows.Clear();
                sqlDA.Fill(dsPlan, "affs");

                //Filling Appointments_Original Table
                int j = 0;
                string phCls;
                int totNum = 1; // = 1 instead of = 0
                DateTime initDate = calFirstDay.SelectedDate.AddHours(10);
                int prevAreaID = int.Parse(affs.Rows[0]["EmployeeID"].ToString());
                txtTotalNoOfVisits.Text = (int.Parse(txtNoOfDays.Text) * int.Parse(txtNoOfVisitsPerDay.Text)).ToString();

                if (affs.Rows.Count == 0)
                {
                    FailureText.Text = "Check your data" + "<br />" + "The you selected is not true, please check your selection criteria";
                }

                foreach (DataRow aff in affs.Rows)
                {
                    if ((totNum <= int.Parse(txtTotalNoOfVisits.Text)) && (prevAreaID == int.Parse(aff["EmployeeID"].ToString())))
                    {
                        phCls = aff["PhysicianClass"].ToString();
                        if (phCls == "A")
                        {
                            j = int.Parse(txtClassA.Text);
                        }
                        if (phCls == "B")
                        {
                            j = int.Parse(txtClassB.Text);
                        }
                        if (phCls == "C")
                        {
                            j = int.Parse(txtClassC.Text);
                        }
                        for (int i = 1; i <= j; i++)
                        {
                            DataRow dr = Appointments_Original.NewRow();
                            //dr[0] = Serial;
                            dr[1] = "Visit No. " + i + "of" + j + " For " + aff["AffiliationName"].ToString();
                            dr[2] = "";

                            if ((totNum % int.Parse(txtNoOfVisitsPerDay.Text) == 1) && (totNum > 1))
                            {
                                if (initDate.DayOfWeek == DayOfWeek.Wednesday)
                                {
                                    initDate = initDate.AddDays(3);
                                    initDate = new DateTime(initDate.Year, initDate.Month, initDate.Day, 10, 0, 0);
                                    dr[3] = initDate;// new DateTime(2015, int.Parse(cbCycles.SelectedValue), 1, 10, 0, 0);//DateTime.Parse(cbCycles.Attributes["FromDate"]).AddHours(10);
                                    dr[4] = initDate.AddMinutes(30);// new DateTime(2015, int.Parse(cbCycles.SelectedValue), 1, 11, 0, 0);// DateTime.Parse(cbCycles.SelectedItem.Attributes["FromDate"]).AddHours(11);
                                }
                                else
                                {
                                    initDate = initDate.AddDays(1);
                                    initDate = new DateTime(initDate.Year, initDate.Month, initDate.Day, 10, 0, 0);
                                    dr[3] = initDate;// new DateTime(2015, int.Parse(cbCycles.SelectedValue), 1, 10, 0, 0);//DateTime.Parse(cbCycles.Attributes["FromDate"]).AddHours(10);
                                    dr[4] = initDate.AddMinutes(30);// new DateTime(2015, int.Parse(cbCycles.SelectedValue), 1, 11, 0, 0);// DateTime.Parse(cbCycles.SelectedItem.Attributes["FromDate"]).AddHours(11);
                                }
                            }
                            else
                            {
                                dr[3] = initDate;// new DateTime(2015, int.Parse(cbCycles.SelectedValue), 1, 10, 0, 0);//DateTime.Parse(cbCycles.Attributes["FromDate"]).AddHours(10);
                                dr[4] = initDate.AddMinutes(30);// new DateTime(2015, int.Parse(cbCycles.SelectedValue), 1, 11, 0, 0);// DateTime.Parse(cbCycles.SelectedItem.Attributes["FromDate"]).AddHours(11);
                            }

                            dr[5] = aff["AffiliationID"].ToString();
                            //dr[5] = aff["EntityID"].ToString();
                            //dr[6] = aff["PhysicianID"].ToString();
                            dr[6] = "Appointment";
                            dr[7] = DateTime.Now;
                            dr[8] = aff["EmployeeID"].ToString();//EmployeeID
                            dr[9] = aff["LineID"].ToString();//LineID
                            dr[10] = aff["BrickID"].ToString();//AreaRecID
                            dr[11] = int.Parse(cbCycles.SelectedValue);//CycleID
                            Appointments_Original.Rows.Add(dr);
                            totNum++;
                            initDate = initDate.AddMinutes(30);
                            prevAreaID = int.Parse(aff["EmployeeID"].ToString());
                        }
                    }
                    else
                    {
                        if (prevAreaID != int.Parse(aff["EmployeeID"].ToString()))
                        {
                            totNum = 1;
                            initDate = calFirstDay.SelectedDate.AddHours(10);
                            prevAreaID = int.Parse(aff["EmployeeID"].ToString());
                            phCls = aff["PhysicianClass"].ToString();
                            if (phCls == "A")
                            {
                                j = int.Parse(txtClassA.Text);
                            }
                            if (phCls == "B")
                            {
                                j = int.Parse(txtClassB.Text);
                            }
                            if (phCls == "C")
                            {
                                j = int.Parse(txtClassC.Text);
                            }
                            for (int i = 1; i <= j; i++)
                            {
                                DataRow dr = Appointments_Original.NewRow();
                                //dr[0] = Serial;
                                dr[1] = "Visit No. " + i + "of" + j + " For " + aff["AffiliationName"].ToString();
                                dr[2] = "";

                                if ((totNum % int.Parse(txtNoOfVisitsPerDay.Text) == 1) && (totNum > 1))
                                {
                                    if (initDate.DayOfWeek == DayOfWeek.Thursday)
                                    {
                                        initDate = initDate.AddDays(2);
                                        initDate = new DateTime(initDate.Year, initDate.Month, initDate.Day, 10, 0, 0);
                                        dr[3] = initDate;// new DateTime(2015, int.Parse(cbCycles.SelectedValue), 1, 10, 0, 0);//DateTime.Parse(cbCycles.Attributes["FromDate"]).AddHours(10);
                                        dr[4] = initDate.AddMinutes(30);// new DateTime(2015, int.Parse(cbCycles.SelectedValue), 1, 11, 0, 0);// DateTime.Parse(cbCycles.SelectedItem.Attributes["FromDate"]).AddHours(11);
                                    }
                                    else
                                    {
                                        initDate = initDate.AddDays(1);
                                        initDate = new DateTime(initDate.Year, initDate.Month, initDate.Day, 10, 0, 0);
                                        dr[3] = initDate;// new DateTime(2015, int.Parse(cbCycles.SelectedValue), 1, 10, 0, 0);//DateTime.Parse(cbCycles.Attributes["FromDate"]).AddHours(10);
                                        dr[4] = initDate.AddMinutes(30);// new DateTime(2015, int.Parse(cbCycles.SelectedValue), 1, 11, 0, 0);// DateTime.Parse(cbCycles.SelectedItem.Attributes["FromDate"]).AddHours(11);
                                    }
                                }
                                else
                                {
                                    dr[3] = initDate;// new DateTime(2015, int.Parse(cbCycles.SelectedValue), 1, 10, 0, 0);//DateTime.Parse(cbCycles.Attributes["FromDate"]).AddHours(10);
                                    dr[4] = initDate.AddMinutes(30);// new DateTime(2015, int.Parse(cbCycles.SelectedValue), 1, 11, 0, 0);// DateTime.Parse(cbCycles.SelectedItem.Attributes["FromDate"]).AddHours(11);
                                }

                                dr[5] = aff["AffiliationID"].ToString();
                                //dr[5] = aff["EntityID"].ToString();
                                //dr[6] = aff["PhysicianID"].ToString();
                                dr[6] = "Appointment";
                                dr[7] = DateTime.Now;
                                dr[8] = aff["EmployeeID"].ToString();//EmployeeID
                                dr[9] = aff["LineID"].ToString();//LineID
                                dr[10] = aff["BrickID"].ToString();//AreaRecID
                                dr[11] = int.Parse(cbCycles.SelectedValue);//CycleID
                                Appointments_Original.Rows.Add(dr);
                                totNum++;
                                initDate = initDate.AddMinutes(30);
                                prevAreaID = int.Parse(aff["EmployeeID"].ToString());
                            }
                        }
                    }
                }

                detailsXML = dsPlan.GetXml();

                com.CommandType = CommandType.StoredProcedure;
                com.CommandTimeout = 0;
                com.CommandText = "InsertAppointments_Original";
                updateParams = new SqlParameter("@Appointments_Original", SqlDbType.NText);
                updateParams.Value = detailsXML;
                com.Parameters.Add(updateParams);

                con.Open();
                object o = com.ExecuteScalar();
                con.Close();

                clearAfterSave();
                FailureText.Text = "Process Status" + "<br />" + "Running Completed Successfully, Thank You.";
            }
            catch (Exception ex)
            {
                FailureText.Text = "Wrong Transaction" + "<br />" + "Something wrong occured, please review your inputs or call your BT team";
                FailureText.Text += "<br />" + ex.Source + ": " + "<br />" + ex.Message;
            }
        }

        private void clearAfterSave()
        {
            affs.Rows.Clear();
            Appointments_Original.Rows.Clear();
            detailsXML = "";
            updateParams.Value = null;
        }

        protected void chkRegionsAll_CheckedChanged(object sender, EventArgs e)
        {
            if (chkRegionsAll.Checked == true)
            {
                foreach (ListItem li in chklRegions.Items)
                {
                    li.Selected = true;
                }
            }
            else
            {
                foreach (ListItem li in chklRegions.Items)
                {
                    li.Selected = false;
                }
            }
        }

        protected void chkEmployeesAll_CheckedChanged(object sender, EventArgs e)
        {
            if (chkEmployeesAll.Checked == true)
            {
                foreach (ListItem li in chklEmployees.Items)
                {
                    li.Selected = true;
                }
            }
            else
            {
                foreach (ListItem li in chklEmployees.Items)
                {
                    li.Selected = false;
                }
            }
        }

        protected void chkSupervisorsAll_CheckedChanged(object sender, EventArgs e)
        {
            if (chkSupervisorsAll.Checked == true)
            {
                foreach (ListItem li in chklSupervisors.Items)
                {
                    li.Selected = true;
                }
            }
            else
            {
                foreach (ListItem li in chklSupervisors.Items)
                {
                    li.Selected = false;
                }
            }
        }

        protected void btnGetSupervisors_Click(object sender, EventArgs e)
        {
            string supervisorsParam = "0";
            foreach (ListItem li in chklLines.Items)
            {
                if (li.Selected == true)
                {
                    supervisorsParam += ", " + li.Value;
                }
            }

            string supervisorsParam2 = "0";
            foreach (ListItem li in chklRegions.Items)
            {
                if (li.Selected == true)
                {
                    supervisorsParam2 += ", " + li.Value;
                }
            }

            SupervisorsDS.SelectCommand += " AND RegionID IN (" + supervisorsParam2 + ") AND LineID IN (" + supervisorsParam + ")";
            //AreasDS.SelectCommand += " Where NewLineID IN (" + areasParam + ") ORDER BY NewAreaName";//GroupID IN (
            chklSupervisors.DataSourceID = "SupervisorsDS";
            chklSupervisors.DataTextField = "DirectManagerName";
            chklSupervisors.DataValueField = "DirectManagerID";
            //DataSourceID="AreasDS" DataTextField="AmounTerritoryName" DataValueField="RecID"
            chklSupervisors.DataBind();

            string empsParam = "0";
            foreach (ListItem li in chklRegions.Items)
            {
                if (li.Selected == true)
                {
                    empsParam += ", " + li.Value;
                }
            }

            //AreasDS.SelectCommand += " Where NewLineID IN (" + areasParam + ") ORDER BY NewAreaName";//GroupID IN (
            EmployeesDS.SelectCommand += " AND RegionID IN (" + supervisorsParam2 + ") AND LineID IN (" + supervisorsParam + ")";
            chklEmployees.DataSourceID = "EmployeesDS";
            chklEmployees.DataTextField = "EmployeeFullName";
            chklEmployees.DataValueField = "EmployeeID";
            //DataSourceID="AreasDS" DataTextField="AmounTerritoryName" DataValueField="RecID"
            chklEmployees.DataBind();
        }

        protected void btnGetEmployees_Click(object sender, EventArgs e)
        {
            string empsParam = "0";
            foreach (ListItem li in chklLines.Items)
            {
                if (li.Selected == true)
                {
                    empsParam += ", " + li.Value;
                }
            }

            string empsParam2 = "0";
            foreach (ListItem li in chklSupervisors.Items)
            {
                if (li.Selected == true)
                {
                    empsParam2 += ", " + li.Value;
                }
            }

            EmployeesDS.SelectCommand += " AND LineID IN (" + empsParam + ") AND DirectManagerID IN (" + empsParam2 + ")";
            chklEmployees.DataSourceID = "EmployeesDS";
            chklEmployees.DataTextField = "EmployeeFullName";
            chklEmployees.DataValueField = "EmployeeID";
            //DataSourceID="AreasDS" DataTextField="AmounTerritoryName" DataValueField="RecID"
            chklEmployees.DataBind();
        }
    }
}
