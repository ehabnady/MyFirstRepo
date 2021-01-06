using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AmounCRM4.Admins
{
    public partial class PhysicianForm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            //if ((Session["EmployeeIDFromAdmin"].ToString() != "471") && (Session["EmployeeIDFromAdmin"].ToString() != "472"))
            //{
            //    btnPhysicianSave.Enabled = false;
            //}
            //else
            //{
            //    btnPhysicianSave.Enabled = true;
            //}

            if (!IsPostBack)
            {
                //LoadPhysician();
                ddlAreaSe.AppendDataBoundItems = true;
                ddlAreaId.AppendDataBoundItems = true;
                btnPhysicianUpdate.Visible = false;
            }

        }
        private void LoadPhysician()
        {
            using (PhysicianViewDBContext db = new PhysicianViewDBContext())
            {
                var alldata = from physicion_tbl in db.View_Physicians where physicion_tbl.Deleted == null select physicion_tbl;
                GridView1.DataSource = alldata.ToList();
                GridView1.DataBind();
            }
        }
        private void clearFields()
        {
            txtPhysicianName.Text = "";
            txtphysicianID.Text = "";
            txtPhysicianName.Text = "";
            txtMobileNumber.Text ="";
            txtTelNumber.Text = "";
            txtPhysicianEmailAddress.Text = "";
            ddlAreaId.SelectedIndex = 0;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            int area = int.Parse(ddlAreaSe.SelectedValue);
            using (PhysicianViewDBContext db = new PhysicianViewDBContext())
            {
                if (txtPhysicianNameSe.Text == "" && ddlAreaSe.SelectedIndex != 0)
                {
                    var alldata = from physicion_tbl in db.View_Physicians where physicion_tbl.Deleted == null  select physicion_tbl;
                    GridView1.DataSource = alldata.ToList();
                    GridView1.DataBind();
                   
                }
                else if (txtPhysicianNameSe.Text != "" && ddlAreaSe.SelectedIndex ==0)
                {
                    var alldata = from physicion_tbl in db.View_Physicians where physicion_tbl.Deleted == null && physicion_tbl.PhysicianName.Contains(txtPhysicianNameSe.Text)  select physicion_tbl;
                    GridView1.DataSource = alldata.ToList();
                    GridView1.DataBind();
                }
                else if (txtPhysicianNameSe.Text != "" && ddlAreaSe.SelectedIndex != 0)
                {
                    var alldata = from physicion_tbl in db.View_Physicians where physicion_tbl.Deleted == null && physicion_tbl.PhysicianName.Contains(txtPhysicianNameSe.Text)  select physicion_tbl;
                    GridView1.DataSource = alldata.ToList();
                    GridView1.DataBind();
                }
                else if (txtPhyCodeSe.Text != "" )
                {
                    int phCode = int.Parse(txtPhyCodeSe.Text); 
                    var alldata = from physicion_tbl in db.View_Physicians where physicion_tbl.Deleted == null && physicion_tbl.PhysicianID== phCode select physicion_tbl;
                    GridView1.DataSource = alldata.ToList();
                    GridView1.DataBind();
                }
                else
                {
                    lblSaveStatus.Text = "Please Enter Physican Name or Area to Search";
                }
            }
        }

        protected void btnPhysicianSave_Click(object sender, EventArgs e)
        {
            if (txtPhysicianName.Text == "" )
            {
                lblSaveStatus.Text = "Please Fill a Physician Name";
                lblPhReq.Visible = true;
            }
            else if (ddlAreaId.SelectedIndex==0)
            {
                lblSaveStatus.Text = "Please Select Area";
                lblAreaReq.Visible = true;
            }
            else
            {
                using (PhysicianBDContext newph = new PhysicianBDContext())
                {
                    Physician ph = new Physician();
                    ph.PhysicianName = txtPhysicianName.Text;
                    ph.TelNumber = txtTelNumber.Text;
                    ph.PhysicianEmailAddress = txtPhysicianEmailAddress.Text;
                    ph.MobileNumber = txtMobileNumber.Text;
                    ph.SpecialtyID = int.Parse(ddlAreaId.SelectedValue);
                    ph.Deleted = null;
                    ph.BirthDate = dpBrithDate.SelectedDate;
                    ph.EntryDate = DateTime.Now;
                    ph.EntryEmployeeID = int.Parse(Session["EmployeeHRCodeFromAdmin"].ToString());
                    newph.Physicians.Add(ph);
                    int roweffected = newph.SaveChanges();
                    if (roweffected > 0)
                    {
                        lblSaveStatus.Text = "Saved";

                        
                        lblPhReq.Visible = false;
                        lblAreaReq.Visible = false;
                        clearFields();
                    }
                    else
                    {
                        lblSaveStatus.Text = "Error";
                    }

                    
                }
            }
            using (PhysicianViewDBContext db = new PhysicianViewDBContext())
            {
                int maxphy = db.View_Physicians.Max(ph => ph.PhysicianID);
                var alldata = from physicion_tbl in db.View_Physicians where physicion_tbl.Deleted == null && physicion_tbl.PhysicianID == maxphy select physicion_tbl;
                GridView1.DataSource = alldata.ToList();
                GridView1.DataBind();
            }
        }

        protected void btnPhysicianUpdate_Click(object sender, EventArgs e)
        {
            using (PhysiciansTempDBContext NewPhyTemp = new PhysiciansTempDBContext())
            {
                PhysiciansTemp updateph = new PhysiciansTemp();
                int PhysicianID = int.Parse(txtphysicianID.Text);
                updateph.PhysicianID = PhysicianID;
                updateph.PhysicianName = txtPhysicianName.Text;
                updateph.TelNumber = txtTelNumber.Text;
                updateph.PhysicianEmailAddress = txtPhysicianEmailAddress.Text;
                updateph.MobileNumber = txtMobileNumber.Text;
                updateph.SpecialtyID = int.Parse(ddlAreaId.SelectedValue);
                updateph.SpecialtyName = ddlAreaId.SelectedItem.ToString();
                updateph.Deleted = null;
                updateph.BirthDate = dpBrithDate.SelectedDate;
                updateph.EntryEmployeeID = int.Parse(Session["EmployeeHRCodeFromAdmin"].ToString());
                updateph.EntryDate = DateTime.Now;
                NewPhyTemp.PhysiciansTemps.Add(updateph);
                int roweffected = NewPhyTemp.SaveChanges();
                if (roweffected > 0)
                {
                    lblSaveStatus.Text = "Updated";
                    using (PhysiciansTempDBContext refreshdb = new PhysiciansTempDBContext())
                    {
                        var alldata = from physicion_tbl in refreshdb.PhysiciansTemps where physicion_tbl.Deleted == null && physicion_tbl.PhysicianName == txtPhysicianName.Text select physicion_tbl;
                        GridView1.DataSource = alldata.ToList();
                        GridView1.DataBind();
                    }
                    clearFields();
                }
                else
                {
                    lblSaveStatus.Text = "Error";
                }
                //LoadPhysician();
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnPhysicianUpdate.Visible = true;
            btnPhysicianSave.Visible = false;
            GridViewRow PhysicianRow = GridView1.SelectedRow;
            txtphysicianID.Text = PhysicianRow.Cells[1].Text.Replace("&nbsp;", "");
            txtPhysicianName.Text = PhysicianRow.Cells[2].Text.Replace("&nbsp;", "");
            txtMobileNumber.Text = PhysicianRow.Cells[3].Text.Replace("&nbsp;", "");
            txtTelNumber.Text = PhysicianRow.Cells[4].Text.Replace("&nbsp;", "");
            txtPhysicianEmailAddress.Text = PhysicianRow.Cells[5].Text.Replace("&nbsp;", "");
            ddlAreaId.SelectedValue = PhysicianRow.Cells[6].Text.Replace("&nbsp;", "");
        }

        protected void ddlAreaSe_SelectedIndexChanged1(object sender, EventArgs e)
        {

        }

        protected void ddlAreaId_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            
        }

        protected void AreaDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }

        protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
        {
            GridViewRow gvr = e.Row;
            if (gvr.RowType == DataControlRowType.Header)
            {
                gvr.Cells[1].Text = "Code";
                gvr.Cells[2].Text = "Name";
                gvr.Cells[12].Text = "Speciality";
            }
            e.Row.Cells[3].Visible = false;
            e.Row.Cells[4].Visible = false;
            e.Row.Cells[5].Visible = false;
            e.Row.Cells[6].Visible = false;

            e.Row.Cells[7].Visible = false;
            e.Row.Cells[8].Visible = false;
            e.Row.Cells[9].Visible = false;
            e.Row.Cells[10].Visible = false;
            e.Row.Cells[11].Visible = false;

           

        }

        protected void btnUpdateAll_Click(object sender, EventArgs e)
        {
            //SqlCommand PHTempcmd = new SqlCommand("Select * from PhysiciansTemp where Status is null", con);
            //SqlDataAdapter PHTempsda = new SqlDataAdapter(PHTempcmd);
            //DataTable PHTempdt = new DataTable();
            //PHTempsda.Fill(PHTempdt);

            //foreach (DataRow PHTemprow in PHTempdt.Rows)
            //{
            //    con.Open();
            //    SqlCommand cmd = new SqlCommand("Update Physicians set PhysicianName=N'" + PHTemprow["PhysicianName"].ToString() + "',SpecialtyID=" + PHTemprow["SpecialtyID"] + ",BirthDate='" + PHTemprow["BirthDate"] + "' ,EntryEmployeeID=" + PHTemprow["EntryEmployeeID"] + ", EntryDate='" + PHTemprow["EntryDate"] + "' where PhysicianID=" + PHTemprow["PhysicianID"].ToString(), con);
            //    //SqlCommand cmd = new SqlCommand("Update DoctorsUpdate set Name=N'" + name.Text + "' where ID=" + Convert.ToInt32(id.Text), myConn);
            //    cmd.ExecuteNonQuery();
            //    con.Close();
            //    con.Open();
            //    SqlCommand cmd2 = new SqlCommand("Update PhysiciansTemp set Status=1 where PhysicianID=" + PHTemprow["PhysicianID"].ToString(), con);
            //    //SqlCommand cmd = new SqlCommand("Update DoctorsUpdate set Name=N'" + name.Text + "' where ID=" + Convert.ToInt32(id.Text), myConn);
            //    cmd2.ExecuteNonQuery();
            //    con.Close();

            //}
        }

        protected void btnSearchTemp_Click(object sender, EventArgs e)
        {
            int area = int.Parse(ddlAreaSe.SelectedValue);
            using (PhysiciansTempDBContext db = new PhysiciansTempDBContext())
            {

                if (txtPhysicianNameSe.Text == "" && ddlAreaSe.SelectedIndex != 0)
                {
                    var alldata = from physicion_tbl in db.PhysiciansTemps where physicion_tbl.Status == null && physicion_tbl.SpecialtyID== area select physicion_tbl;
                    GridView1.DataSource = alldata.ToList();
                    GridView1.DataBind();

                }
                else if (txtPhysicianNameSe.Text != "" && ddlAreaSe.SelectedIndex == 0)
                {
                    var alldata = from physicion_tbl in db.PhysiciansTemps where physicion_tbl.Status == null && physicion_tbl.PhysicianName.Contains(txtPhysicianNameSe.Text) select physicion_tbl;
                    GridView1.DataSource = alldata.ToList();
                    GridView1.DataBind();
                }
                else if (txtPhysicianNameSe.Text != "" && ddlAreaSe.SelectedIndex != 0)
                {
                    var alldata = from physicion_tbl in db.PhysiciansTemps where physicion_tbl.Status == null && physicion_tbl.PhysicianName.Contains(txtPhysicianNameSe.Text) && physicion_tbl.SpecialtyID == area select physicion_tbl;
                    GridView1.DataSource = alldata.ToList();
                    GridView1.DataBind();
                }
                else if (txtPhyCodeSe.Text != "")
                {
                    int phcode = int.Parse(txtPhyCodeSe.Text);
                    var alldata = from physicion_tbl in db.PhysiciansTemps where physicion_tbl.Status == null && physicion_tbl.PhysicianID == phcode select physicion_tbl;
                    GridView1.DataSource = alldata.ToList();
                    GridView1.DataBind();
                }
                else
                {
                    var alldata = from physicion_tbl in db.PhysiciansTemps where physicion_tbl.Status == null select physicion_tbl;
                    GridView1.DataSource = alldata.ToList();
                    GridView1.DataBind();
                }
            }
        }
    }
}