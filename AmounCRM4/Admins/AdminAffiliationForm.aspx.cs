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
    public partial class AdminAffiliationForm : System.Web.UI.Page
    {
        GridViewRow phyRow;
        SqlCommand cmd;
        SqlConnection conn;
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                //ddlLine1.DataBind();
                //ddlLine2.DataBind();
                //ddlNoPatients.DataBind();
                ddlEntityIDSe.AppendDataBoundItems = true;
                ddlPhysicianIDSe.AppendDataBoundItems = true;
                btnUpdate.Visible = false;
                ddlPhysicianIDSe.SelectedIndex = 0;
                ddlEntityIDSe.SelectedIndex = 0;
                ddlEntityIDSe.Items.Clear();
                ddlPhysicianIDSe.Items.Clear();
            }
        }
        private void clearFields()
        {

        }

        private void Loadaffiliations()
        {

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            gvAffiliations.DataSource = null;
            gvAffiliations.DataBind();
            SearchQuery();
            txtEntityNameSe.Text = "";
            ddlEntityIDSe.Items.Clear();
            ddlPhysicianIDSe.Items.Clear();
            txtBestTimeTo.Text = "";
            txtPhusicianSe.Text = "";
            txtPhysicianCode.Text = "";
            txtNameSe.Text = "";
            txtCodeSe.Text = "";

            txtAffID.Text = "";
            txtAffiliationName.Text = "";
            txtBestTimeFrom.Text = "";
            txtBestTimeTo.Text = "";
            txtNotes.Text = "";
            txtAffClinicCode.Text = "";
            txtAffPhyCode.Text = "";
            txtSpCode.Text = "";
            ddlBrick.SelectedIndex = 0;
            ddlNoPatients1.SelectedIndex = 0;
            ddlNoPatients2.SelectedIndex = 0;
            ddlNoPatients3.SelectedIndex = 0;
            ddlNoPatients4.SelectedIndex = 0;
            ddlNoPatients5.SelectedIndex = 0;
            ddlNoPatients6.SelectedIndex = 0;
            ddlNoPatients7.SelectedIndex = 0;
            ddlLine1.SelectedIndex = 0;
            ddlLine2.SelectedIndex = 0;
            ddlLine3.SelectedIndex = 0;
            ddlLine4.SelectedIndex = 0;
            ddlLine5.SelectedIndex = 0;
            ddlLine6.SelectedIndex = 0;
            ddlLine7.SelectedIndex = 0;
            ddlWT1.SelectedIndex = 0;
            ddlWT2.SelectedIndex = 0;
            ddlWT3.SelectedIndex = 0;
            ddlWT4.SelectedIndex = 0;
            ddlWT5.SelectedIndex = 0;
            ddlWT6.SelectedIndex = 0;
            ddlWT7.SelectedIndex = 0;

            btnUpdate.Visible = false;
            btnSave.Visible = true;
            btnDelete.Visible = false;
        }


        private void SearchQueryTemp()
        {
            conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ToString());
            conn.Open();

            if (ddlPhysicianIDSe.SelectedIndex >= 0 && ddlEntityIDSe.SelectedIndex == -1)
            {
                int phyID = int.Parse(ddlPhysicianIDSe.SelectedValue);

                var select = "SELECT * FROM [AmounCRM2].[dbo].[View_Affiliations_only] where (Deleted IS NULL or Deleted=0) and PhysicianID=" + phyID;
                var dataAdapter = new SqlDataAdapter(select, conn);
                var commandBuilder = new SqlCommandBuilder(dataAdapter);
                var ds = new DataSet();
                dataAdapter.Fill(ds);
                gvAffiliations.DataSource = ds.Tables[0];
                gvAffiliations.DataBind();
            }
            else if (ddlPhysicianIDSe.SelectedIndex == -1 && ddlEntityIDSe.SelectedIndex >= 0)
            {
                int entityID = int.Parse(ddlEntityIDSe.SelectedValue);
                var select = "SELECT * FROM [AmounCRM2].[dbo].[View_Affiliations_only] where (Deleted IS NULL or Deleted=0) and EntityID=" + entityID;
                var dataAdapter = new SqlDataAdapter(select, conn);
                var commandBuilder = new SqlCommandBuilder(dataAdapter);
                var ds = new DataSet();
                dataAdapter.Fill(ds);
                gvAffiliations.DataSource = ds.Tables[0];
                gvAffiliations.DataBind();
            }
            else if (ddlPhysicianIDSe.SelectedIndex >= 0 && ddlEntityIDSe.SelectedIndex >= 0)
            {
                int phyID = int.Parse(ddlPhysicianIDSe.SelectedValue);
                int entityID = int.Parse(ddlEntityIDSe.SelectedValue);
                var select = "SELECT * FROM [AmounCRM2].[dbo].[View_Affiliations_only] where (Deleted IS NULL or Deleted=0) and EntityID=" + entityID + " and PhysicianID=" + phyID;
                var dataAdapter = new SqlDataAdapter(select, conn);
                var commandBuilder = new SqlCommandBuilder(dataAdapter);
                var ds = new DataSet();
                dataAdapter.Fill(ds);
                gvAffiliations.DataSource = ds.Tables[0];
                gvAffiliations.DataBind();
            }
            else
            {
                if (txtCodeSe.Text != "" && txtNameSe.Text == "")
                {
                    int AffID = int.Parse(txtCodeSe.Text);
                    var select = "SELECT * FROM [AmounCRM2].[dbo].[View_Affiliations_only] where (Deleted IS NULL or Deleted=0) and AffiliationID=" + AffID;
                    var dataAdapter = new SqlDataAdapter(select, conn);
                    var commandBuilder = new SqlCommandBuilder(dataAdapter);
                    var ds = new DataSet();
                    dataAdapter.Fill(ds);
                    gvAffiliations.DataSource = ds.Tables[0];
                    gvAffiliations.DataBind();
                }
                else if (txtCodeSe.Text == "" && txtNameSe.Text != "")
                {


                    var select = "SELECT * FROM [AmounCRM2].[dbo].[View_Affiliations_only] where (Deleted IS NULL or Deleted=0) and AffiliationName like N'%" + txtNameSe.Text + "%'";
                    var dataAdapter = new SqlDataAdapter(select, conn);
                    var commandBuilder = new SqlCommandBuilder(dataAdapter);
                    var ds = new DataSet();
                    dataAdapter.Fill(ds);
                    gvAffiliations.DataSource = ds.Tables[0];
                    gvAffiliations.DataBind();


                }
                else if (txtNameSe.Text != "" && ddlBrick.SelectedValue != "0")
                {
                    var select = "SELECT * FROM [AmounCRM2].[dbo].[View_Affiliations_only] where (Deleted IS NULL or Deleted=0) and AffiliationName like N'%" + txtNameSe.Text + "%'" + " and AmounBrickName=" + ddlBrick.SelectedItem;
                    var dataAdapter = new SqlDataAdapter(select, conn);
                    var commandBuilder = new SqlCommandBuilder(dataAdapter);
                    var ds = new DataSet();
                    dataAdapter.Fill(ds);
                    gvAffiliations.DataSource = ds.Tables[0];
                    gvAffiliations.DataBind();
                }
            }
        }


        private void SearchQuery()
        {

            conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ToString());
            conn.Open();

            if (ddlPhysicianIDSe.SelectedIndex >= 0 && ddlEntityIDSe.SelectedIndex == -1)
            {
                int phyID = int.Parse(ddlPhysicianIDSe.SelectedValue);

                var select = "SELECT * FROM [AmounCRM2].[dbo].[View_Affiliations_only] where (Deleted IS NULL or Deleted=0) and PhysicianID=" + phyID;
                var dataAdapter = new SqlDataAdapter(select, conn);
                var commandBuilder = new SqlCommandBuilder(dataAdapter);
                var ds = new DataSet();
                dataAdapter.Fill(ds);
                gvAffiliations.DataSource = ds.Tables[0];
                gvAffiliations.DataBind();
            }
            else if (ddlPhysicianIDSe.SelectedIndex == -1 && ddlEntityIDSe.SelectedIndex >= 0)
            {
                int entityID = int.Parse(ddlEntityIDSe.SelectedValue);
                var select = "SELECT * FROM [AmounCRM2].[dbo].[View_Affiliations_only] where (Deleted IS NULL or Deleted=0) and EntityID=" + entityID;
                var dataAdapter = new SqlDataAdapter(select, conn);
                var commandBuilder = new SqlCommandBuilder(dataAdapter);
                var ds = new DataSet();
                dataAdapter.Fill(ds);
                gvAffiliations.DataSource = ds.Tables[0];
                gvAffiliations.DataBind();
            }
            else if (ddlPhysicianIDSe.SelectedIndex >= 0 && ddlEntityIDSe.SelectedIndex >= 0)
            {
                int phyID = int.Parse(ddlPhysicianIDSe.SelectedValue);
                int entityID = int.Parse(ddlEntityIDSe.SelectedValue);
                var select = "SELECT * FROM [AmounCRM2].[dbo].[View_Affiliations_only] where (Deleted IS NULL or Deleted=0) and EntityID=" + entityID + " and PhysicianID=" + phyID;
                var dataAdapter = new SqlDataAdapter(select, conn);
                var commandBuilder = new SqlCommandBuilder(dataAdapter);
                var ds = new DataSet();
                dataAdapter.Fill(ds);
                gvAffiliations.DataSource = ds.Tables[0];
                gvAffiliations.DataBind();
            }
            else
            {
                if (txtCodeSe.Text != "" && txtNameSe.Text == "")
                {
                    int AffID = int.Parse(txtCodeSe.Text);
                    var select = "SELECT * FROM [AmounCRM2].[dbo].[View_Affiliations_only] where (Deleted IS NULL or Deleted=0) and AffiliationID=" + AffID;
                    var dataAdapter = new SqlDataAdapter(select, conn);
                    var commandBuilder = new SqlCommandBuilder(dataAdapter);
                    var ds = new DataSet();
                    dataAdapter.Fill(ds);
                    gvAffiliations.DataSource = ds.Tables[0];
                    gvAffiliations.DataBind();
                }
                else if (txtCodeSe.Text == "" && txtNameSe.Text != "" && ddlBrick.SelectedValue == "0")
                {


                    var select = "SELECT * FROM [AmounCRM2].[dbo].[View_Affiliations_only] where (Deleted IS NULL or Deleted=0) and AffiliationName like N'%" + txtNameSe.Text + "%'";
                    var dataAdapter = new SqlDataAdapter(select, conn);
                    var commandBuilder = new SqlCommandBuilder(dataAdapter);
                    var ds = new DataSet();
                    dataAdapter.Fill(ds);
                    gvAffiliations.DataSource = ds.Tables[0];
                    gvAffiliations.DataBind();


                }
                else if (txtNameSe.Text != "" && ddlBrick.SelectedValue != "0")
                {
                    var select = "SELECT * FROM [AmounCRM2].[dbo].[View_Affiliations_only] where (Deleted IS NULL or Deleted=0) and AffiliationName like N'%" + txtNameSe.Text + "%'" + " and AmounBrickName='" + ddlBrick.SelectedItem + "'";
                    var dataAdapter = new SqlDataAdapter(select, conn);
                    var commandBuilder = new SqlCommandBuilder(dataAdapter);
                    var ds = new DataSet();
                    dataAdapter.Fill(ds);
                    gvAffiliations.DataSource = ds.Tables[0];
                    gvAffiliations.DataBind();
                }
            }
        }



        protected void btnSave_Click(object sender, EventArgs e)
        {
            using (AffiliationTempDBContext newAff = new AffiliationTempDBContext())
            {
                AffiliationsTemp Aff = new AffiliationsTemp();

                using (PhysicianBDContext PHdb = new PhysicianBDContext())
                {
                    int PhyCode = int.Parse(txtAffPhyCode.Text);
                    var PhysicianData = (from physicion_tbl in PHdb.Physicians where physicion_tbl.PhysicianID == PhyCode select physicion_tbl).FirstOrDefault();
                    txtAffiliationName.Text = PhysicianData.PhysicianName;
                    txtSpCode.Text = (PhysicianData.SpecialtyID).ToString();

                }

                Aff.AffiliationName = txtAffiliationName.Text;
                Aff.PhysicianID = int.Parse(txtAffPhyCode.Text);
                Aff.EntityID = int.Parse(txtAffClinicCode.Text);
                Aff.BestTimeFrom = txtBestTimeFrom.Text;
                Aff.BestTimeTo = txtBestTimeTo.Text;
                Aff.Notes = txtNotes.Text;
                Aff.New = true;
                Aff.Status = false;
                Aff.Deleted = false;
                Aff.EntryEmployeeID = int.Parse(Session["EmployeeHRCodeFromAdmin"].ToString());
                Aff.EntryDate = DateTime.Now;

                newAff.AffiliationsTemps.Add(Aff);
                int roweffected = newAff.SaveChanges();
                if (roweffected > 0)
                {
                    affiliationslblSaveStatus.Text = "Saved";
                    using (AffiliationTempDBContext db = new AffiliationTempDBContext())
                    {
                        int maxent = db.AffiliationsTemps.Max(en => en.ID);
                        txtAffID.Text = maxent.ToString();
                    }
                }
                else
                {
                    affiliationslblSaveStatus.Text = "Error";
                }
            }
            using (PhysiciansValueTempDBContext newPhVal = new PhysiciansValueTempDBContext())
            {
                int spcode = int.Parse(txtSpCode.Text);
                PhysicianValueByLineTemp PhyVal = new PhysicianValueByLineTemp();

                for (int i = 1; i <= 7; i++)
                {
                    PhyVal.AffiliationID = int.Parse(txtAffID.Text);
                    PhyVal.LineID = i;

                    if (i == 1)
                    {
                        PhyVal.PrescriptionHappit = Double.Parse(ddlLine1.SelectedValue);
                        PhyVal.NoOfPatients = Double.Parse(ddlNoPatients1.SelectedValue);
                        PhyVal.WaitingTime = Double.Parse(ddlWT1.SelectedValue);
                    }
                    if (i == 2)
                    {
                        PhyVal.PrescriptionHappit = Double.Parse(ddlLine2.SelectedValue);
                        PhyVal.NoOfPatients = Double.Parse(ddlNoPatients2.SelectedValue);
                        PhyVal.WaitingTime = Double.Parse(ddlWT2.SelectedValue);

                    }
                    if (i == 3)
                    {
                        PhyVal.PrescriptionHappit = Double.Parse(ddlLine3.SelectedValue);
                        PhyVal.NoOfPatients = Double.Parse(ddlNoPatients3.SelectedValue);
                        PhyVal.WaitingTime = Double.Parse(ddlWT3.SelectedValue);

                    }
                    if (i == 4)
                    {
                        PhyVal.PrescriptionHappit = Double.Parse(ddlLine4.SelectedValue);
                        PhyVal.NoOfPatients = Double.Parse(ddlNoPatients4.SelectedValue);
                        PhyVal.WaitingTime = Double.Parse(ddlWT4.SelectedValue);

                    }
                    if (i == 5)
                    {
                        PhyVal.PrescriptionHappit = Double.Parse(ddlLine5.SelectedValue);
                        PhyVal.NoOfPatients = Double.Parse(ddlNoPatients5.SelectedValue);
                        PhyVal.WaitingTime = Double.Parse(ddlWT5.SelectedValue);

                    }
                    if (i == 6)
                    {
                        PhyVal.PrescriptionHappit = Double.Parse(ddlLine6.SelectedValue);
                        PhyVal.NoOfPatients = Double.Parse(ddlNoPatients6.SelectedValue);
                        PhyVal.WaitingTime = Double.Parse(ddlWT6.SelectedValue);

                    }
                    if (i == 7)
                    {
                        PhyVal.PrescriptionHappit = Double.Parse(ddlLine7.SelectedValue);
                        PhyVal.NoOfPatients = Double.Parse(ddlNoPatients7.SelectedValue);
                        PhyVal.WaitingTime = Double.Parse(ddlWT7.SelectedValue);

                    }
                    using (SpecialtyPriorityDBContext SVdb = new SpecialtyPriorityDBContext())
                    {
                        var SVData = (from SV_tbl in SVdb.SpecPriorityByLines where SV_tbl.LineID == i && SV_tbl.SpecialtyID == spcode select SV_tbl).FirstOrDefault();
                        PhyVal.SpecialtyValue = SVData.SpecValue / 10;
                    }
                    PhyVal.TotalValue = PhyVal.SpecialtyValue + PhyVal.PrescriptionHappit + PhyVal.NoOfPatients;

                    if (PhyVal.TotalValue >= 8)
                    {
                        PhyVal.PhysicianClass = "A+";
                    }
                    if (PhyVal.TotalValue < 8)
                    {
                        if (PhyVal.TotalValue >= 4.5)
                        {
                            PhyVal.PhysicianClass = "A";
                        }
                        if (PhyVal.TotalValue < 4.5)
                        {
                            PhyVal.PhysicianClass = "C";
                        }
                    }
                    PhyVal.LastModifierID = int.Parse(Session["EmployeeHRCodeFromAdmin"].ToString());
                    PhyVal.CreateDate = DateTime.Now;
                    PhyVal.CreatorID = int.Parse(Session["EmployeeHRCodeFromAdmin"].ToString());
                    PhyVal.LastModificationDate = DateTime.Now;
                    PhyVal.New = true;
                    PhyVal.Deleted = false;
                    PhyVal.Status = false;
                    newPhVal.PhysicianValueByLineTemps.Add(PhyVal);
                    int roweffected = newPhVal.SaveChanges();
                    if (roweffected > 0)
                    {
                        affiliationslblSaveStatus.Text = "Saved";

                    }
                    else
                    {
                        affiliationslblSaveStatus.Text = "Error";

                    }
                }
            }
        }



        protected void btnUpdate_Click(object sender, EventArgs e)
        {

            using (AffiliationTempDBContext db = new AffiliationTempDBContext())
            {
                AffiliationsTemp updateAff = new AffiliationsTemp();
                int ID = int.Parse(txtAffID.Text);
                //Affiliation updateAff = (from Aff_tbl in db.Affiliations where Aff_tbl.Deleted == null && Aff_tbl.AffiliationID == ID select Aff_tbl).FirstOrDefault();
                updateAff.AffiliationID = ID;
                updateAff.AffiliationName = txtAffiliationName.Text;
                updateAff.PhysicianID = int.Parse(txtAffPhyCode.Text);
                updateAff.EntityID = int.Parse(txtAffClinicCode.Text);
                updateAff.BestTimeFrom = txtBestTimeFrom.Text;
                updateAff.BestTimeTo = txtBestTimeTo.Text;
                updateAff.Notes = txtNotes.Text;
                updateAff.EntryEmployeeID = int.Parse(Session["EmployeeHRCodeFromAdmin"].ToString());
                updateAff.Deleted = false;
                updateAff.EntryDate = DateTime.Now;
                updateAff.Status = false;
                updateAff.New = false;

                db.AffiliationsTemps.Add(updateAff);
                int roweffected = db.SaveChanges();

                affiliationslblSaveStatus.Text = "Updated";

            }

            using (PhysiciansValueTempDBContext db = new PhysiciansValueTempDBContext())
            {
                int ID = int.Parse(txtAffID.Text);

                for (int i = 1; i <= 7; i++)
                {

                    if (i == 1)
                    {
                        PhValueUpdate(db, ID, i, double.Parse(ddlLine1.SelectedValue), double.Parse(ddlNoPatients1.SelectedValue), int.Parse(txtRecID1.Text), false, double.Parse(ddlWT1.SelectedValue));
                    }
                    if (i == 2)
                    {
                        PhValueUpdate(db, ID, i, double.Parse(ddlLine2.SelectedValue), double.Parse(ddlNoPatients2.SelectedValue), int.Parse(txtRecID2.Text), false, double.Parse(ddlWT2.SelectedValue));
                    }
                    if (i == 3)
                    {
                        PhValueUpdate(db, ID, i, double.Parse(ddlLine3.SelectedValue), double.Parse(ddlNoPatients3.SelectedValue), int.Parse(txtRecID3.Text), false, double.Parse(ddlWT3.SelectedValue));
                    }
                    if (i == 4)
                    {
                        PhValueUpdate(db, ID, i, double.Parse(ddlLine4.SelectedValue), double.Parse(ddlNoPatients4.SelectedValue), int.Parse(txtRecID4.Text), false, double.Parse(ddlWT4.SelectedValue));
                    }
                    if (i == 5)
                    {
                        PhValueUpdate(db, ID, i, double.Parse(ddlLine5.SelectedValue), double.Parse(ddlNoPatients5.SelectedValue), int.Parse(txtRecID5.Text), false, double.Parse(ddlWT5.SelectedValue));
                    }
                    if (i == 6)
                    {
                        PhValueUpdate(db, ID, i, double.Parse(ddlLine6.SelectedValue), double.Parse(ddlNoPatients6.SelectedValue), int.Parse(txtRecID6.Text), false, double.Parse(ddlWT6.SelectedValue));
                    }
                    if (i == 7)
                    {
                        PhValueUpdate(db, ID, i, double.Parse(ddlLine7.SelectedValue), double.Parse(ddlNoPatients7.SelectedValue), int.Parse(txtRecID7.Text), false, double.Parse(ddlWT7.SelectedValue));
                    }
                }
            }

            txtAffID.Text = "";
            txtAffiliationName.Text = "";
            txtBestTimeFrom.Text = "";
            txtBestTimeTo.Text = "";
            txtNotes.Text = "";
            txtAffClinicCode.Text = "";
            txtAffPhyCode.Text = "";
            txtSpCode.Text = "";
            ddlNoPatients1.SelectedIndex = 0;
            ddlNoPatients2.SelectedIndex = 0;
            ddlNoPatients3.SelectedIndex = 0;
            ddlNoPatients4.SelectedIndex = 0;
            ddlNoPatients5.SelectedIndex = 0;
            ddlNoPatients6.SelectedIndex = 0;
            ddlNoPatients7.SelectedIndex = 0;
            ddlLine1.SelectedIndex = 0;
            ddlLine2.SelectedIndex = 0;
            ddlLine3.SelectedIndex = 0;
            ddlLine4.SelectedIndex = 0;
            ddlLine5.SelectedIndex = 0;
            ddlLine6.SelectedIndex = 0;
            ddlLine7.SelectedIndex = 0;
            ddlWT1.SelectedIndex = 0;
            ddlWT2.SelectedIndex = 0;
            ddlWT3.SelectedIndex = 0;
            ddlWT4.SelectedIndex = 0;
            ddlWT5.SelectedIndex = 0;
            ddlWT6.SelectedIndex = 0;
            ddlWT7.SelectedIndex = 0;

            btnUpdate.Visible = false;
            btnSave.Visible = true;


        }

        private void PhValueUpdate(PhysiciansValueTempDBContext db, int ID, int i, double PHabit, double NoOfPat, int rec, bool deleted, double WT)
        {
            //PhysicianValueByLine updatePhVal = (from PhVal_tbl in db.PhysicianValueByLines where PhVal_tbl.Deleted == null && PhVal_tbl.AffiliationID == ID && PhVal_tbl.LineID == i select PhVal_tbl).FirstOrDefault();
            PhysicianValueByLineTemp updatePhVal = new PhysicianValueByLineTemp();
            updatePhVal.AffiliationID = ID;
            updatePhVal.PrescriptionHappit = PHabit;
            updatePhVal.NoOfPatients = NoOfPat;
            updatePhVal.RecID = rec;
            updatePhVal.LineID = i;
            updatePhVal.Deleted = deleted;
            updatePhVal.WaitingTime = WT;
            using (SpecialtyPriorityDBContext SVdb = new SpecialtyPriorityDBContext())
            {
                int spcode = int.Parse(txtSpCode.Text);
                var SVData = (from SV_tbl in SVdb.SpecPriorityByLines where SV_tbl.LineID == i && SV_tbl.SpecialtyID == spcode select SV_tbl).FirstOrDefault();
                updatePhVal.SpecialtyValue = SVData.SpecValue / 10;
            }
            updatePhVal.TotalValue = updatePhVal.SpecialtyValue + updatePhVal.PrescriptionHappit + updatePhVal.NoOfPatients;

            if (updatePhVal.TotalValue >= 8)
            {
                updatePhVal.PhysicianClass = "A+";
            }
            if (updatePhVal.TotalValue < 8)
            {
                if (updatePhVal.TotalValue >= 4.5)
                {
                    updatePhVal.PhysicianClass = "A";
                }
                if (updatePhVal.TotalValue < 4.5)
                {
                    updatePhVal.PhysicianClass = "C";
                }
            }
            updatePhVal.LastModifierID = int.Parse(Session["EmployeeHRCodeFromAdmin"].ToString());
            updatePhVal.LastModificationDate = DateTime.Now;
            updatePhVal.Status = false;
            updatePhVal.New = false;
            db.PhysicianValueByLineTemps.Add(updatePhVal);
            int roweffected = db.SaveChanges();

            affiliationslblSaveStatus.Text = "Updated";


        }

        protected void gvAffiliations_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnDelete.Visible = true;

            btnUpdate.Visible = true;
            btnSave.Visible = false;
            phyRow = gvAffiliations.SelectedRow;
            txtAffiliationName.Text = phyRow.Cells[2].Text.Replace("&nbsp;", "");
            txtAffID.Text = phyRow.Cells[1].Text.Replace("&nbsp;", "");
            txtBestTimeFrom.Text = phyRow.Cells[13].Text.Replace("&nbsp;", "");
            txtBestTimeTo.Text = phyRow.Cells[14].Text.Replace("&nbsp;", "");
            txtNotes.Text = phyRow.Cells[15].Text.Replace("&nbsp;", "");
            txtAffClinicCode.Text = phyRow.Cells[11].Text.Replace("&nbsp;", "");
            txtAffPhyCode.Text = phyRow.Cells[10].Text.Replace("&nbsp;", "");
            txtSpCode.Text = phyRow.Cells[16].Text.Replace("&nbsp;", "");

            using (PhysicianValueDBContext PhValDB = new PhysicianValueDBContext())
            {
                int affID = int.Parse(txtAffID.Text);
                for (int i = 1; i <= 7; i++)
                {
                    if (i == 1)
                    {
                        var PhValdata = (from PhVal_tbl in PhValDB.PhysicianValueByLines where (PhVal_tbl.Deleted == null || PhVal_tbl.Deleted == false) && PhVal_tbl.AffiliationID == affID && PhVal_tbl.LineID == i select PhVal_tbl).FirstOrDefault();
                        ddlLine1.SelectedValue = PhValdata.PrescriptionHappit.ToString();
                        ddlNoPatients1.SelectedValue = PhValdata.NoOfPatients.ToString();
                        if (PhValdata.WaitingTime.ToString() != "0")
                        {
                            ddlWT1.SelectedValue = PhValdata.WaitingTime.ToString();

                        }
                        txtRecID1.Text = PhValdata.RecID.ToString();
                    }
                    if (i == 2)
                    {
                        var PhValdata = (from PhVal_tbl in PhValDB.PhysicianValueByLines where (PhVal_tbl.Deleted == null || PhVal_tbl.Deleted == false) && PhVal_tbl.AffiliationID == affID && PhVal_tbl.LineID == i select PhVal_tbl).FirstOrDefault();
                        ddlLine2.SelectedValue = PhValdata.PrescriptionHappit.ToString();
                        ddlNoPatients2.SelectedValue = PhValdata.NoOfPatients.ToString();
                        if (PhValdata.WaitingTime.ToString() != "0")
                        {
                            ddlWT2.SelectedValue = PhValdata.WaitingTime.ToString();
                        }
                        txtRecID2.Text = PhValdata.RecID.ToString();

                    }
                    if (i == 3)
                    {
                        var PhValdata = (from PhVal_tbl in PhValDB.PhysicianValueByLines where (PhVal_tbl.Deleted == null || PhVal_tbl.Deleted == false) && PhVal_tbl.AffiliationID == affID && PhVal_tbl.LineID == i select PhVal_tbl).FirstOrDefault();
                        ddlLine3.SelectedValue = PhValdata.PrescriptionHappit.ToString();
                        ddlNoPatients3.SelectedValue = PhValdata.NoOfPatients.ToString();
                        if (PhValdata.WaitingTime.ToString() != "0")
                        {
                            ddlWT3.SelectedValue = PhValdata.WaitingTime.ToString();
                        }
                        txtRecID3.Text = PhValdata.RecID.ToString();
                    }
                    if (i == 4)
                    {
                        var PhValdata = (from PhVal_tbl in PhValDB.PhysicianValueByLines where (PhVal_tbl.Deleted == null || PhVal_tbl.Deleted == false) && PhVal_tbl.AffiliationID == affID && PhVal_tbl.LineID == i select PhVal_tbl).FirstOrDefault();
                        ddlLine4.SelectedValue = PhValdata.PrescriptionHappit.ToString();
                        ddlNoPatients4.SelectedValue = PhValdata.NoOfPatients.ToString();
                        if (PhValdata.WaitingTime.ToString() != "0")
                        {
                            ddlWT4.SelectedValue = PhValdata.WaitingTime.ToString();

                        }
                        txtRecID4.Text = PhValdata.RecID.ToString();
                    }
                    if (i == 5)
                    {
                        var PhValdata = (from PhVal_tbl in PhValDB.PhysicianValueByLines where (PhVal_tbl.Deleted == null || PhVal_tbl.Deleted == false) && PhVal_tbl.AffiliationID == affID && PhVal_tbl.LineID == i select PhVal_tbl).FirstOrDefault();
                        ddlLine5.SelectedValue = PhValdata.PrescriptionHappit.ToString();
                        ddlNoPatients5.SelectedValue = PhValdata.NoOfPatients.ToString();
                        if (PhValdata.WaitingTime.ToString() != "0")
                        {
                            ddlWT5.SelectedValue = PhValdata.WaitingTime.ToString();

                        }
                        txtRecID5.Text = PhValdata.RecID.ToString();
                    }
                    if (i == 6)
                    {
                        var PhValdata = (from PhVal_tbl in PhValDB.PhysicianValueByLines where (PhVal_tbl.Deleted == null || PhVal_tbl.Deleted == false) && PhVal_tbl.AffiliationID == affID && PhVal_tbl.LineID == i select PhVal_tbl).FirstOrDefault();
                        ddlLine6.SelectedValue = PhValdata.PrescriptionHappit.ToString();
                        ddlNoPatients6.SelectedValue = PhValdata.NoOfPatients.ToString();
                        if (PhValdata.WaitingTime.ToString() != "0")
                        {
                            ddlWT6.SelectedValue = PhValdata.WaitingTime.ToString();

                        }
                        txtRecID6.Text = PhValdata.RecID.ToString();
                    }
                    if (i == 7)
                    {
                        var PhValdata = (from PhVal_tbl in PhValDB.PhysicianValueByLines where (PhVal_tbl.Deleted == null || PhVal_tbl.Deleted == false) && PhVal_tbl.AffiliationID == affID && PhVal_tbl.LineID == i select PhVal_tbl).FirstOrDefault();
                        ddlLine7.SelectedValue = PhValdata.PrescriptionHappit.ToString();
                        ddlNoPatients7.SelectedValue = PhValdata.NoOfPatients.ToString();
                        if (PhValdata.WaitingTime.ToString() != "0")
                        {
                            ddlWT7.SelectedValue = PhValdata.WaitingTime.ToString();

                        }
                        txtRecID7.Text = PhValdata.RecID.ToString();
                    }
                }
            }
        }








        protected void Button1_Click(object sender, EventArgs e)
        {
            using (PhysicianBDContext PHdb = new PhysicianBDContext())
            {

                if (txtPhusicianSe.Text != "" & rbPhyName.Checked == true)
                {
                    var PhysicianData = (from physicion_tbl in PHdb.Physicians where physicion_tbl.PhysicianName.Contains(txtPhusicianSe.Text) select physicion_tbl).ToList();
                    ddlPhysicianIDSe.DataValueField = "PhysicianID";
                    ddlPhysicianIDSe.DataTextField = "PhysicianName";
                    ddlPhysicianIDSe.DataSource = PhysicianData;
                    ddlPhysicianIDSe.DataBind();

                }
                else if (txtPhusicianSe.Text != "" & rbPhyCode.Checked == true)
                {
                    int PhyCode = int.Parse(txtPhusicianSe.Text);
                    var PhysicianData = (from physicion_tbl in PHdb.Physicians where physicion_tbl.PhysicianID == PhyCode select physicion_tbl).ToList();
                    ddlPhysicianIDSe.DataValueField = "PhysicianID";
                    ddlPhysicianIDSe.DataTextField = "PhysicianName";
                    ddlPhysicianIDSe.DataSource = PhysicianData;
                    ddlPhysicianIDSe.DataBind();
                }
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {

            {
                using (ClinicDBContext Entdb = new ClinicDBContext())
                {

                    if (txtEntityNameSe.Text != "" & rbEntityName.Checked == true)
                    {
                        var clinicdata = (from clinic_tbl in Entdb.Entities where clinic_tbl.EntityName.Contains(txtEntityNameSe.Text) select clinic_tbl).ToList();
                        ddlEntityIDSe.DataValueField = "EntityID";
                        ddlEntityIDSe.DataTextField = "EntityName";
                        ddlEntityIDSe.DataSource = clinicdata;
                        ddlEntityIDSe.DataBind();




                    }
                    else if (txtEntityNameSe.Text != "" & rbEntityCode.Checked == true)
                    {
                        int EntityCode = int.Parse(txtEntityNameSe.Text);
                        var clinicdata = (from clinic_tbl in Entdb.Entities where clinic_tbl.EntityID == EntityCode select clinic_tbl).ToList();
                        ddlEntityIDSe.DataValueField = "EntityID";
                        ddlEntityIDSe.DataTextField = "EntityName";
                        ddlEntityIDSe.DataSource = clinicdata;
                        ddlEntityIDSe.DataBind();

                    }
                }
            }

        }








        protected void PhysicianDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }

        protected void ddlEntityIDSe_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtClinicCode.Text = ddlEntityIDSe.SelectedValue;
        }

        protected void ddlPhysicianIDSe_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtPhysicianCode.Text = ddlPhysicianIDSe.SelectedValue;
        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        protected void txtAffPhyCode_TextChanged(object sender, EventArgs e)
        {
            using (PhysicianBDContext PHdb = new PhysicianBDContext())
            {
                int PhyCode = int.Parse(txtAffPhyCode.Text);
                var PhysicianData = (from physicion_tbl in PHdb.Physicians where physicion_tbl.PhysicianID == PhyCode select physicion_tbl).FirstOrDefault();
                txtAffiliationName.Text = PhysicianData.PhysicianName;
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            using (AffiliationTempDBContext db = new AffiliationTempDBContext())
            {
                AffiliationsTemp updateAff = new AffiliationsTemp();
                int ID = int.Parse(txtAffID.Text);
                //Affiliation updateAff = (from Aff_tbl in db.Affiliations where Aff_tbl.Deleted == null && Aff_tbl.AffiliationID == ID select Aff_tbl).FirstOrDefault();
                updateAff.AffiliationID = ID;
                updateAff.AffiliationName = txtAffiliationName.Text;
                updateAff.PhysicianID = int.Parse(txtAffPhyCode.Text);
                updateAff.EntityID = int.Parse(txtAffClinicCode.Text);
                updateAff.BestTimeFrom = txtBestTimeFrom.Text;
                updateAff.BestTimeTo = txtBestTimeTo.Text;
                updateAff.Notes = txtNotes.Text;
                updateAff.Deleted = true;
                updateAff.EntryDate = DateTime.Now;
                updateAff.Status = false;
                updateAff.New = false;
                updateAff.EntryEmployeeID = int.Parse(Session["EmployeeHRCodeFromAdmin"].ToString());
                db.AffiliationsTemps.Add(updateAff);
                int roweffected = db.SaveChanges();

                affiliationslblSaveStatus.Text = "deleted";

            }

            using (PhysiciansValueTempDBContext db = new PhysiciansValueTempDBContext())
            {
                int ID = int.Parse(txtAffID.Text);

                for (int i = 1; i <= 7; i++)
                {

                    if (i == 1)
                    {
                        PhValueUpdate(db, ID, i, double.Parse(ddlLine1.SelectedValue), double.Parse(ddlNoPatients1.SelectedValue), int.Parse(txtRecID1.Text), true, double.Parse(ddlWT1.SelectedValue));
                    }
                    if (i == 2)
                    {
                        PhValueUpdate(db, ID, i, double.Parse(ddlLine2.SelectedValue), double.Parse(ddlNoPatients2.SelectedValue), int.Parse(txtRecID2.Text), true, double.Parse(ddlWT2.SelectedValue));
                    }
                    if (i == 3)
                    {
                        PhValueUpdate(db, ID, i, double.Parse(ddlLine3.SelectedValue), double.Parse(ddlNoPatients3.SelectedValue), int.Parse(txtRecID3.Text), true, double.Parse(ddlWT3.SelectedValue));
                    }
                    if (i == 4)
                    {
                        PhValueUpdate(db, ID, i, double.Parse(ddlLine4.SelectedValue), double.Parse(ddlNoPatients4.SelectedValue), int.Parse(txtRecID4.Text), true, double.Parse(ddlWT4.SelectedValue));
                    }
                    if (i == 5)
                    {
                        PhValueUpdate(db, ID, i, double.Parse(ddlLine5.SelectedValue), double.Parse(ddlNoPatients5.SelectedValue), int.Parse(txtRecID5.Text), true, double.Parse(ddlWT5.SelectedValue));
                    }
                    if (i == 6)
                    {
                        PhValueUpdate(db, ID, i, double.Parse(ddlLine6.SelectedValue), double.Parse(ddlNoPatients6.SelectedValue), int.Parse(txtRecID6.Text), true, double.Parse(ddlWT6.SelectedValue));
                    }
                    if (i == 7)
                    {
                        PhValueUpdate(db, ID, i, double.Parse(ddlLine7.SelectedValue), double.Parse(ddlNoPatients7.SelectedValue), int.Parse(txtRecID7.Text), true, double.Parse(ddlWT7.SelectedValue));
                    }
                }
            }

            txtAffID.Text = "";
            txtAffiliationName.Text = "";
            txtBestTimeFrom.Text = "";
            txtBestTimeTo.Text = "";
            txtNotes.Text = "";
            txtAffClinicCode.Text = "";
            txtAffPhyCode.Text = "";
            txtSpCode.Text = "";
            ddlNoPatients1.SelectedIndex = 0;
            ddlNoPatients2.SelectedIndex = 0;
            ddlNoPatients3.SelectedIndex = 0;
            ddlNoPatients4.SelectedIndex = 0;
            ddlNoPatients5.SelectedIndex = 0;
            ddlNoPatients6.SelectedIndex = 0;
            ddlNoPatients7.SelectedIndex = 0;
            ddlLine1.SelectedIndex = 0;
            ddlLine2.SelectedIndex = 0;
            ddlLine3.SelectedIndex = 0;
            ddlLine4.SelectedIndex = 0;
            ddlLine5.SelectedIndex = 0;
            ddlLine6.SelectedIndex = 0;
            ddlLine7.SelectedIndex = 0;
            ddlWT1.SelectedIndex = 0;
            ddlWT2.SelectedIndex = 0;
            ddlWT3.SelectedIndex = 0;
            ddlWT4.SelectedIndex = 0;
            ddlWT5.SelectedIndex = 0;
            ddlWT6.SelectedIndex = 0;
            ddlWT7.SelectedIndex = 0;

            btnUpdate.Visible = false;
            btnSave.Visible = true;
            affiliationslblSaveStatus.Text = "Deleted";

            //int ID = int.Parse(txtAffID.Text);

            //conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ToString());
            //conn.Open();
            //cmd = new SqlCommand("update Affiliations set Deleted=1 where AffiliationID=" + ID, conn);
            //int Affrows = cmd.ExecuteNonQuery();
            //cmd = new SqlCommand("update PhysicianValueByLine set Deleted=1 where AffiliationID=" + ID, conn);
            //int PhValrows = cmd.ExecuteNonQuery();
            //conn.Close();



            //txtAffID.Text = "";
            //txtAffiliationName.Text = "";
            //txtBestTimeFrom.Text = "";
            //txtBestTimeTo.Text = "";
            //txtNotes.Text = "";
            //txtAffClinicCode.Text = "";
            //txtAffPhyCode.Text = "";
            //txtSpCode.Text = "";
            //ddlNoPatients1.SelectedIndex = 0;
            //ddlNoPatients2.SelectedIndex = 0;
            //ddlNoPatients3.SelectedIndex = 0;
            //ddlNoPatients4.SelectedIndex = 0;
            //ddlNoPatients5.SelectedIndex = 0;
            //ddlNoPatients6.SelectedIndex = 0;
            //ddlNoPatients7.SelectedIndex = 0;
            //ddlLine1.SelectedIndex = 0;
            //ddlLine2.SelectedIndex = 0;
            //ddlLine3.SelectedIndex = 0;
            //ddlLine4.SelectedIndex = 0;
            //ddlLine5.SelectedIndex = 0;
            //ddlLine6.SelectedIndex = 0;
            //ddlLine7.SelectedIndex = 0;
            //btnUpdate.Visible = false;
            //btnSave.Visible = true;
            //btnDelete.Visible = false;
            //affiliationslblSaveStatus.Text = "Deleted";

        }

        protected void txtRecID1_TextChanged(object sender, EventArgs e)
        {

        }

        protected void btnAllUpdates_Click(object sender, EventArgs e)
        {
            //SqlCommand AffTempcmd = new SqlCommand("Select * from AffiliationsTemp where Status =0", con);
            //SqlDataAdapter AffTempsda = new SqlDataAdapter(AffTempcmd);
            //DataTable AffTempdt = new DataTable();
            //AffTempsda.Fill(AffTempdt);


            //SqlCommand PhValTempcmd = new SqlCommand("Select * from PhysicianValueByLineTemp where Status =0", con);
            //SqlDataAdapter PhValTempsda = new SqlDataAdapter(PhValTempcmd);
            //DataTable PhValTempdt = new DataTable();
            //PhValTempsda.Fill(PhValTempdt);

            //foreach (DataRow AffTemprow in AffTempdt.Rows)
            //{
            //    if (bool.Parse(AffTemprow["New"].ToString()) == false)
            //    {
            //        con.Open();
            //        SqlCommand cmd = new SqlCommand(@"Update Affiliations set AffiliationName=N'" + AffTemprow["AffiliationName"].ToString() + "',PhysicianID=" + AffTemprow["PhysicianID"] +
            //            ",EntityID=" + AffTemprow["EntityID"] + ",BestTimeFrom='" + AffTemprow["BestTimeFrom"] + "' ,BestTimeTo='" + AffTemprow["BestTimeTo"] + "',Notes='" + AffTemprow["Notes"] +
            //            "',EntryEmployeeID=" + AffTemprow["EntryEmployeeID"] + ",Deleted='" + AffTemprow["Deleted"] + "',EntryDate='" + AffTemprow["EntryDate"] +
            //            "' where AffiliationID=" + AffTemprow["AffiliationID"].ToString(), con);
            //        cmd.ExecuteNonQuery();
            //        con.Close();

            //        con.Open();
            //        SqlCommand cmd2 = new SqlCommand("Update AffiliationsTemp set Status=1 where AffiliationID=" + AffTemprow["AffiliationID"].ToString(), con);
            //        cmd2.ExecuteNonQuery();
            //        con.Close();
            //    }
            //    if (bool.Parse(AffTemprow["New"].ToString()) == true)
            //    {
            //        con.Open();
            //        SqlCommand cmd = new SqlCommand("insert into Affiliations (AffiliationName,PhysicianID,EntityID,BestTimeFrom,BestTimeTo,Notes,EntryEmployeeID,EntryDate) values (N'" + AffTemprow["AffiliationName"].ToString() + "'," + AffTemprow["PhysicianID"] + "," + AffTemprow["EntityID"] + ",N'" + AffTemprow["BestTimeFrom"] + "',N'" + AffTemprow["BestTimeTo"] + "',N'" + AffTemprow["Notes"] + "'," + AffTemprow["EntryEmployeeID"] + ",'" + AffTemprow["EntryDate"] + "')", con);
            //        cmd.ExecuteNonQuery();
            //        con.Close();

            //        con.Open();
            //        SqlCommand cmd5 = new SqlCommand("Update AffiliationsTemp set Status=1 where AffiliationID=" + AffTemprow["AffiliationID"].ToString(), con);
            //        cmd5.ExecuteNonQuery();
            //        con.Close();

            //        SqlCommand cmd2 = new SqlCommand("select max(AffiliationID) from Affiliations");
            //        cmd2.CommandType = CommandType.Text;
            //        con.Open();
            //        cmd2.Connection = con;
            //        int AffID = (int)cmd2.ExecuteScalar();
            //        con.Close();
            //        foreach (DataRow PhValTemprow in PhValTempdt.Rows)
            //        {
            //            if (int.Parse(PhValTemprow["AffiliationID"].ToString()) == int.Parse(AffTemprow["ID"].ToString()))
            //            {
            //                con.Open();
            //                SqlCommand cmd3 = new SqlCommand("insert into PhysicianValueByLine (AffiliationID,LineID,NoOfPatients,SpecialtyValue,TotalValue,PhysicianClass,PrescriptionHappit,CreateDate,LastModificationDate,CreatorID,LastModifierID) values (" + AffID + "," + PhValTemprow["LineID"] + "," + PhValTemprow["NoOfPatients"] + "," + PhValTemprow["SpecialtyValue"] + "," + PhValTemprow["TotalValue"] + ",'" + PhValTemprow["PhysicianClass"] + "'," + PhValTemprow["PrescriptionHappit"] + ",'" + PhValTemprow["CreateDate"] + "','" + PhValTemprow["LastModificationDate"] + "'," + PhValTemprow["CreatorID"] + "," + PhValTemprow["LastModifierID"] + ")", con);
            //                cmd3.ExecuteNonQuery();
            //                con.Close();

            //                con.Open();
            //                SqlCommand cmd4 = new SqlCommand("Update PhysicianValueByLineTemp set Status=1 where AffiliationID=" + AffTemprow["ID"].ToString(), con);
            //                cmd4.ExecuteNonQuery();
            //                con.Close();

            //            }

            //        }
            //    }
            //}

            //foreach (DataRow PhValTemprow in PhValTempdt.Rows)
            //{
            //    if (bool.Parse(PhValTemprow["New"].ToString()) == false)
            //    {
            //        con.Open();
            //        SqlCommand cmd = new SqlCommand(@"Update PhysicianValueByLine set PhysicianClass=N'" + PhValTemprow["PhysicianClass"].ToString() + "',NoOfPatients=" +
            //            PhValTemprow["NoOfPatients"] + ",SpecialtyValue=" + PhValTemprow["SpecialtyValue"] + ",TotalValue=" + PhValTemprow["TotalValue"] + ",PrescriptionHappit=" +
            //            PhValTemprow["PrescriptionHappit"] + " ,Deleted='" + PhValTemprow["Deleted"] + "' ,LastModifierID=" + PhValTemprow["LastModifierID"] + ", LastModificationDate='" +
            //            PhValTemprow["LastModificationDate"] + "' where RecID=" + PhValTemprow["RecID"].ToString(), con);
            //        cmd.ExecuteNonQuery();
            //        con.Close();

            //        con.Open();
            //        SqlCommand cmd2 = new SqlCommand("Update PhysicianValueByLineTemp set Status=1 where AffiliationID=" + PhValTemprow["AffiliationID"].ToString(), con);
            //        cmd2.ExecuteNonQuery();
            //        con.Close();
            //    }
            //}
        }

        protected void gvAffiliations_RowCreated(object sender, GridViewRowEventArgs e)
        {
            GridViewRow gvr = e.Row;
            if (gvr.RowType == DataControlRowType.Header)
            {

            }
            e.Row.Cells[12].Visible = false;
            e.Row.Cells[13].Visible = false;
            e.Row.Cells[14].Visible = false;
            e.Row.Cells[15].Visible = false;
            e.Row.Cells[16].Visible = false;



        }
    }
}