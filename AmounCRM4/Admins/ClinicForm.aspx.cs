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
    public partial class ClinicForm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            //if ((Session["EmployeeIDFromAdmin"].ToString() != "471") && (Session["EmployeeIDFromAdmin"].ToString() != "472"))
            //{
            //    btnClinicSave.Enabled = false;
            //}
            //else
            //{
            //    btnClinicSave.Enabled = true;
            //}

            if (!IsPostBack)
            {
                //LoadEntity();
                ddlEntityType.AppendDataBoundItems = true;
                ddlEntityTypeID.AppendDataBoundItems = true;
                ddlAreaID.AppendDataBoundItems = true;
                btnUpdate.Visible = false;
            }
        }
        private void clearFields()
        {
            txtEntityID.Text = "";
            txtEntityName.Text = "";
            txtEntityCode.Text = "";
            txtEntityAddress.Text = "";
            ddlEntityTypeID.SelectedIndex = 0;
            txtTel1.Text = "";
            txtTel2.Text = "";
            txtTel3.Text = "";
            txtFax.Text = "";
            txtEntityEmailAddress.Text = "";
            txtEntityWebSite.Text = "";
            ddlAreaID.SelectedIndex = 0;
        }
        private void LoadEntity()
        {
            using (ClinicDBContext db = new ClinicDBContext())
            {
                var clinicdata = from clinic_tbl in db.Entities where (clinic_tbl.Deleted == null || clinic_tbl.Deleted == false) select clinic_tbl;
                GridViewClinic.DataSource = clinicdata.ToList();
                GridViewClinic.DataBind();
            }
        }
        protected void btnEntitySearch_Click(object sender, EventArgs e)
        {
            ClinicSearchQuery();
        }

        private void ClinicSearchTempQuery()
        {
            int EntityType = int.Parse(ddlEntityType.SelectedValue);
            using (EntityTempDBContext db = new EntityTempDBContext())
            {
                if (txtEntityNameSe.Text == "" && ddlEntityType.SelectedIndex != 0)
                {
                    var clinicdata = from clinic_tbl in db.EntityTemps where (clinic_tbl.Deleted == null || clinic_tbl.Deleted == false) && clinic_tbl.Status== null && clinic_tbl.EntityTypeID == EntityType select clinic_tbl;
                    GridViewClinic.DataSource = clinicdata.ToList();
                    GridViewClinic.DataBind();
                }
                else if (txtEntityNameSe.Text != "" && ddlEntityType.SelectedIndex != 0)
                {
                    var clinicdata = from clinic_tbl in db.EntityTemps where (clinic_tbl.Deleted == null || clinic_tbl.Deleted == false) && clinic_tbl.Status == null && clinic_tbl.EntityTypeID == EntityType && clinic_tbl.EntityName.Contains(txtEntityNameSe.Text) select clinic_tbl;
                    GridViewClinic.DataSource = clinicdata.ToList();
                    GridViewClinic.DataBind();
                }
                else if (txtEntityNameSe.Text != "" && ddlEntityType.SelectedIndex == 0)
                {
                    var clinicdata = from clinic_tbl in db.EntityTemps where (clinic_tbl.Deleted == null || clinic_tbl.Deleted == false) && clinic_tbl.Status == null && clinic_tbl.EntityName.Contains(txtEntityNameSe.Text) select clinic_tbl;
                    GridViewClinic.DataSource = clinicdata.ToList();
                    GridViewClinic.DataBind();
                }
                else if (txtEntityCodeSe.Text != "")
                {
                    int EntCode = int.Parse(txtEntityCodeSe.Text);
                    var clinicdata = from clinic_tbl in db.EntityTemps where (clinic_tbl.Deleted == null || clinic_tbl.Deleted == false) && clinic_tbl.Status == null && clinic_tbl.EntityID == EntCode select clinic_tbl;
                    GridViewClinic.DataSource = clinicdata.ToList();
                    GridViewClinic.DataBind();
                }
                else
                {
                    ClinclblSaveStatus.Text = "Please Enter Entity Name or Type to Search";
                }

                //GridViewClinic.Columns[2].Visible = false;
                //GridViewClinic.Columns[3].Visible = false;
            }
        }

        private void ClinicSearchQuery()
        {
            int EntityType = int.Parse(ddlEntityType.SelectedValue);
            using (EntitiesViewDBContext db = new EntitiesViewDBContext())
            {
                if (txtEntityNameSe.Text == "" && ddlEntityType.SelectedIndex != 0)
                {
                    var clinicdata = from clinic_tbl in db.View_Entities where (clinic_tbl.Deleted == null || clinic_tbl.Deleted == false) && clinic_tbl.EntityTypeID == EntityType select clinic_tbl;
                    GridViewClinic.DataSource = clinicdata.ToList();
                    GridViewClinic.DataBind();
                }
                else if (txtEntityNameSe.Text != "" && ddlEntityType.SelectedIndex != 0)
                {
                    var clinicdata = from clinic_tbl in db.View_Entities where (clinic_tbl.Deleted == null || clinic_tbl.Deleted == false) && clinic_tbl.EntityTypeID == EntityType && clinic_tbl.EntityName.Contains(txtEntityNameSe.Text) select clinic_tbl;
                    GridViewClinic.DataSource = clinicdata.ToList();
                    GridViewClinic.DataBind();
                }
                else if (txtEntityNameSe.Text != "" && ddlEntityType.SelectedIndex == 0)
                {
                    var clinicdata = from clinic_tbl in db.View_Entities where (clinic_tbl.Deleted == null || clinic_tbl.Deleted == false) && clinic_tbl.EntityName.Contains(txtEntityNameSe.Text) select clinic_tbl;
                    GridViewClinic.DataSource = clinicdata.ToList();
                    GridViewClinic.DataBind();
                }
                else if (txtEntityCodeSe.Text != "")
                {
                    int EntCode = int.Parse(txtEntityCodeSe.Text);
                    var clinicdata = from clinic_tbl in db.View_Entities where (clinic_tbl.Deleted == null || clinic_tbl.Deleted==false) && clinic_tbl.EntityID == EntCode select clinic_tbl;
                    GridViewClinic.DataSource = clinicdata.ToList();
                    GridViewClinic.DataBind();
                }
                else
                {
                    ClinclblSaveStatus.Text = "Please Enter Entity Name or Type to Search";
                }

                //GridViewClinic.Columns[2].Visible = false;
                //GridViewClinic.Columns[3].Visible = false;
            }
        }

        protected void btnClinicSave_Click(object sender, EventArgs e)
        {
            if (txtEntityName.Text == "")
            {
                ClinclblSaveStatus.Text = "Please Fill a Entity Name";
                lblNameReq.Visible = true;
            }
            else if (ddlEntityTypeID.SelectedIndex == 0)
            {
                ClinclblSaveStatus.Text = "Please Select Entity Type";
                lbltypeReq.Visible = true;
            }
            else if (ddlAreaID.SelectedIndex == 0)
            {
                ClinclblSaveStatus.Text = "Please Select Area";
                lblAreaReq.Visible = true;
            }
            else
            {
                using (ClinicDBContext newEn = new ClinicDBContext())
                {
                    Entity en = new Entity();
                    en.EntityName = txtEntityName.Text;
                    //en.EntityCode = int.Parse(txtEntityCode.Text);
                    en.EntityAddress = txtEntityAddress.Text;
                    en.EntityTypeID = int.Parse(ddlEntityTypeID.SelectedValue);
                    en.Tel1 = txtTel1.Text;
                    en.Tel2 = txtTel2.Text;
                    en.Tel3 = txtTel3.Text;
                    en.Fax = txtFax.Text;
                    en.EntityEmailAddress = txtEntityEmailAddress.Text;
                    en.EntityWebSite = txtEntityWebSite.Text;
                    en.BrickID = int.Parse(ddlAreaID.SelectedValue);
                    en.Deleted = false;
                    en.EntryDate = DateTime.Now;
                    en.EntryEmployeeID = int.Parse(Session["EmployeeHRCodeFromAdmin"].ToString());
                    newEn.Entities.Add(en);
                    int roweffected = newEn.SaveChanges();
                    if (roweffected > 0)
                    {
                        ClinclblSaveStatus.Text = "Saved";
                        lblNameReq.Visible = false;
                        lbltypeReq.Visible = false;
                        lblAreaReq.Visible = false;
                        clearFields();

                    }
                    else
                    {
                        ClinclblSaveStatus.Text = "Error";
                    }

                }
            }
            using (EntitiesViewDBContext db = new EntitiesViewDBContext())
            {
                int maxent = db.View_Entities.Max(en => en.EntityID);
                var clinicdata = from clinic_tbl in db.View_Entities where (clinic_tbl.Deleted == null || clinic_tbl.Deleted == false) && clinic_tbl.EntityID == maxent select clinic_tbl;
                GridViewClinic.DataSource = clinicdata.ToList();
                GridViewClinic.DataBind();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            //ClinclblSaveStatus.Text = SelectedClinc.ToString();
            if (txtEntityName.Text == "")
            {
                ClinclblSaveStatus.Text = "Please Fill a Entity Name";
                lblNameReq.Visible = true;
            }
            else if (ddlEntityTypeID.SelectedIndex == 0)
            {
                ClinclblSaveStatus.Text = "Please Select Entity Type";
                lbltypeReq.Visible = true;
            }
            else if (ddlAreaID.SelectedIndex == 0)
            {
                ClinclblSaveStatus.Text = "Please Select Brick";
                lblAreaReq.Visible = true;
            }
            else
            {
                using (EntityTempDBContext entityUpdate = new EntityTempDBContext())
                {

                    int ID = int.Parse(txtEntityID.Text);
                    EntityTemp updateEn = new EntityTemp();

                    updateEn.EntityID = ID;
                    updateEn.EntityName = txtEntityName.Text;
                    //updateEn.EntityCode = int.Parse(txtEntityCode.Text);
                    updateEn.EntityAddress = txtEntityAddress.Text;
                    updateEn.EntityTypeID = int.Parse(ddlEntityTypeID.SelectedValue);
                    updateEn.Tel1 = txtTel1.Text;
                    updateEn.Tel2 = txtTel2.Text;
                    updateEn.Tel3 = txtTel3.Text;
                    updateEn.Fax = txtFax.Text;
                    updateEn.EntityEmailAddress = txtEntityEmailAddress.Text;
                    updateEn.EntityWebSite = txtEntityWebSite.Text;
                    updateEn.BrickID = int.Parse(ddlAreaID.SelectedValue);
                    updateEn.BrickName = ddlAreaID.SelectedItem.ToString();
                    updateEn.Deleted = null;
                    updateEn.EntryDate = DateTime.Now;
                    updateEn.EntryEmployeeID = int.Parse(Session["EmployeeHRCodeFromAdmin"].ToString());

                    entityUpdate.EntityTemps.Add(updateEn);
                    int roweffected = entityUpdate.SaveChanges();
                    if (roweffected > 0)
                    {
                        ClinclblSaveStatus.Text = "Updated";



                        using (EntityTempDBContext Refreshdb = new EntityTempDBContext())
                        {
                            int code = int.Parse(txtEntityID.Text);
                            var clinicdata = from clinic_tbl in Refreshdb.EntityTemps where (clinic_tbl.Deleted == null || clinic_tbl.Deleted == false) && clinic_tbl.EntityID == code select clinic_tbl;
                            GridViewClinic.DataSource = clinicdata.ToList();
                            GridViewClinic.DataBind();
                        }

                        
                        //ClinicSearchQuery();
                        btnClinicSave.Visible = true;
                        btnUpdate.Visible = false;
                        clearFields();
                    }
                    else
                    {
                        ClinclblSaveStatus.Text = "Error";
                    }

                }
            }
        }

        protected void GridViewClinic_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtEntityCode.Enabled=false;
            btnUpdate.Visible = true;
            btnClinicSave.Visible = false;
            GridViewRow clinicRow = GridViewClinic.SelectedRow;
            txtEntityID.Text = clinicRow.Cells[1].Text.Replace("&nbsp;", "");
            txtEntityName.Text = clinicRow.Cells[2].Text.Replace("&nbsp;", "");
            txtEntityCode.Text = clinicRow.Cells[1].Text.Replace("&nbsp;", "");
            txtEntityAddress.Text = clinicRow.Cells[4].Text.Replace("&nbsp;", "");
            ddlEntityTypeID.SelectedValue = clinicRow.Cells[5].Text.Replace("&nbsp;", "");
            txtTel1.Text = clinicRow.Cells[7].Text.Replace("&nbsp;", "");
            txtTel2.Text = clinicRow.Cells[8].Text.Replace("&nbsp;", "");
            txtTel3.Text = clinicRow.Cells[9].Text.Replace("&nbsp;", "");
            txtFax.Text = clinicRow.Cells[10].Text.Replace("&nbsp;", "");
            txtEntityEmailAddress.Text = clinicRow.Cells[11].Text.Replace("&nbsp;", "");
            txtEntityWebSite.Text = clinicRow.Cells[12].Text.Replace("&nbsp;", "");
            ddlAreaID.SelectedValue = clinicRow.Cells[6].Text.Replace("&nbsp;", "");
            txtBrickID.Text= clinicRow.Cells[6].Text.Replace("&nbsp;", "");
        }

        protected void ddlAreaID_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtBrickID.Text = ddlAreaID.SelectedValue;

        }

        protected void ddlAreaSe_SelectedIndexChanged1(object sender, EventArgs e)
        {

        }

        protected void GridViewClinic_RowCreated(object sender, GridViewRowEventArgs e)
        {
            GridViewRow gvr = e.Row;
            if (gvr.RowType == DataControlRowType.Header)
            {
                gvr.Cells[1].Text = "Code";
                gvr.Cells[2].Text = "Name";
                gvr.Cells[4].Text = "Address";
                //gvr.Cells[16].Text = "Brick";
            }
            e.Row.Cells[3].Visible = false;
            e.Row.Cells[5].Visible = false;
            e.Row.Cells[6].Visible = false;
            e.Row.Cells[7].Visible = false;
            e.Row.Cells[8].Visible = false;
            e.Row.Cells[9].Visible = false;
            e.Row.Cells[10].Visible = false;
            e.Row.Cells[11].Visible = false;
            e.Row.Cells[12].Visible = false;
            e.Row.Cells[13].Visible = false;
            e.Row.Cells[14].Visible = false;
            e.Row.Cells[15].Visible = false;
            //e.Row.Cells[17].Visible = false;


        }

        protected void btnAllUpdates_Click(object sender, EventArgs e)
        {
            //SqlCommand EnTempcmd = new SqlCommand("Select * from EntityTemp where Status is null", con);
            //SqlDataAdapter ENTempsda = new SqlDataAdapter(EnTempcmd);
            //DataTable ENTempdt = new DataTable();
            //ENTempsda.Fill(ENTempdt);

            //foreach (DataRow ENTemprow in ENTempdt.Rows)
            //{
            //    con.Open();
            //    SqlCommand cmd = new SqlCommand("Update Entities set EntityName=N'" + ENTemprow["EntityName"].ToString() + "' ,EntityAddress=N'" + ENTemprow["EntityAddress"] + "',EntityTypeID=" + ENTemprow["EntityTypeID"] + ",BrickID=" + ENTemprow["BrickID"] + " ,EntryEmployeeID=" + ENTemprow["EntryEmployeeID"] + ", EntryDate='" + ENTemprow["EntryDate"] + "' where EntityID=" + ENTemprow["EntityID"].ToString(), con);
            //    //SqlCommand cmd = new SqlCommand("Update DoctorsUpdate set Name=N'" + name.Text + "' where ID=" + Convert.ToInt32(id.Text), myConn);
            //    cmd.ExecuteNonQuery();
            //    con.Close();
            //    con.Open();
            //    SqlCommand cmd2 = new SqlCommand("Update EntityTemp set Status=1 where EntityID=" + ENTemprow["EntityID"].ToString(), con);
            //    //SqlCommand cmd = new SqlCommand("Update DoctorsUpdate set Name=N'" + name.Text + "' where ID=" + Convert.ToInt32(id.Text), myConn);
            //    cmd2.ExecuteNonQuery();
            //    con.Close();

            //}
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            ClinicSearchTempQuery();
        }
    }
}