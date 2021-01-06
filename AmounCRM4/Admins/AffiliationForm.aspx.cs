using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AmounCRM4.Admins
{
    public partial class AffiliationForm : System.Web.UI.Page
    {

        GridViewRow phyRow;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlBrickSe.AppendDataBoundItems = true;
                ddlSpecialtySe.AppendDataBoundItems = true;
                ddlNoOfPatients.AppendDataBoundItems = true;
                ddlWaitingTime.AppendDataBoundItems = true;
                ddlPHappit.AppendDataBoundItems = true;
                Loadaffiliations();
                Panel1.Visible = false;
                btnUpdate.Visible = false;
                saveorupdate();
            }
        }
        private void clearFields()
        {
            affiliationslblSaveStatus.Text = "";
            txtAffiliationID.Text = "";
            txtAffiliationName.Text = "";
            txtBestTimeFrom.Text = "";
            txtBestTimeTo.Text = "";
            ddlBrickSe.SelectedIndex = 0;
            ddlSpecialtySe.SelectedIndex = 0;
            ddlNoOfPatients.SelectedIndex = -1;
            ddlWaitingTime.SelectedIndex = -1;
            ddlPHappit.SelectedIndex = -1;
            txtNotes.Text = "";
            lblPHappitReq.Visible = false;
        }

        private void Loadaffiliations()
        {
            affiliationslblSaveStatus.Text = "";
            using (AffiliationsAdminViewDBContext db = new AffiliationsAdminViewDBContext())
            {
                int EmpID = int.Parse(Session["EmployeeID"].ToString());
                int linID = int.Parse(Session["LineID"].ToString());
                int AreaId = int.Parse(Session["AreaID"].ToString());
                //var affiliationdata = from affiliation_tbl in db.View_Affiliations_Admin where affiliation_tbl.Deleted == null && affiliation_tbl.LineID == linID && affiliation_tbl.EmployeeID == EmpID && affiliation_tbl.SpecialtyValue>0 && affiliation_tbl.TotalValue!=affiliation_tbl.PrescriptionHappit+affiliation_tbl.NoOfPatients+affiliation_tbl.SpecialtyValue select affiliation_tbl;
                var affiliationdata = from affiliation_tbl in db.View_Affiliations_Admin where affiliation_tbl.Deleted == null && affiliation_tbl.LineID == linID && affiliation_tbl.EmployeeID == EmpID && affiliation_tbl.SpecialtyValue > 0 && affiliation_tbl.LastModifierID == null select affiliation_tbl;

                gvAffiliations.DataSource = affiliationdata.ToList();
                gvAffiliations.DataBind();

            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            //clearFields();
            affiliationslblSaveStatus.Text = "";
            gvAffiliations.DataSource = null;
            gvAffiliations.DataBind();
            saveorupdate();
            SearchQuery();
            Panel1.Visible = false;
        }

        private void SearchQuery()
        {
            Panel1.Visible = false;
            int EmpID = int.Parse(Session["EmployeeID"].ToString());

            int LineID = int.Parse(Session["LineID"].ToString());
            int AreaId = int.Parse(Session["AreaID"].ToString());
            int BrickId = int.Parse(ddlBrickSe.SelectedValue);
            int SpecialtyID = int.Parse(ddlSpecialtySe.SelectedValue);
            using (AffiliationsAdminViewDBContext db = new AffiliationsAdminViewDBContext())
            {
                if (ddlBrickSe.SelectedIndex > 0 && ddlSpecialtySe.SelectedIndex == 0)
                {
                    var affiliationdata = from affiliation_tbl in db.View_Affiliations_Admin where affiliation_tbl.Deleted == null && affiliation_tbl.BrickID == BrickId && affiliation_tbl.LineID == LineID && affiliation_tbl.EmployeeID == EmpID && affiliation_tbl.SpecialtyValue > 0 && affiliation_tbl.LastModifierID == null select affiliation_tbl;
                    gvAffiliations.DataSource = affiliationdata.ToList();
                }
                if (ddlBrickSe.SelectedIndex == 0 && ddlSpecialtySe.SelectedIndex > 0)
                {
                    var affiliationdata = from affiliation_tbl in db.View_Affiliations_Admin where affiliation_tbl.Deleted == null && affiliation_tbl.SpecialtyID == SpecialtyID && affiliation_tbl.LineID == LineID && affiliation_tbl.EmployeeID == EmpID && affiliation_tbl.SpecialtyValue > 0 && affiliation_tbl.LastModifierID == null select affiliation_tbl;
                    gvAffiliations.DataSource = affiliationdata.ToList();
                }
                if (ddlBrickSe.SelectedIndex == 0 && ddlSpecialtySe.SelectedIndex == 0)
                {
                    var affiliationdata = from affiliation_tbl in db.View_Affiliations_Admin where affiliation_tbl.Deleted == null && affiliation_tbl.LineID == LineID && affiliation_tbl.EmployeeID == EmpID && affiliation_tbl.SpecialtyValue > 0 && affiliation_tbl.LastModifierID == null select affiliation_tbl;
                    gvAffiliations.DataSource = affiliationdata.ToList();
                }
                if (ddlBrickSe.SelectedIndex > 0 && ddlSpecialtySe.SelectedIndex > 0)
                {
                    var affiliationdata = from affiliation_tbl in db.View_Affiliations_Admin where affiliation_tbl.Deleted == null && affiliation_tbl.BrickID == BrickId && affiliation_tbl.SpecialtyID == SpecialtyID && affiliation_tbl.LineID == LineID && affiliation_tbl.EmployeeID == EmpID && affiliation_tbl.SpecialtyValue > 0 && affiliation_tbl.LastModifierID == null select affiliation_tbl;
                    gvAffiliations.DataSource = affiliationdata.ToList();
                }
                gvAffiliations.DataBind();
                if (gvAffiliations.Rows.Count == 0)
                {
                    affiliationslblSaveStatus.Text = "No doctors found";
                }
            }
        }





        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (ddlPHappit.SelectedIndex != -1)
            {
                int AffID = int.Parse(txtAffiliationID.Text);
                //using (AppointmentDBContext appdb = new AppointmentDBContext())
                //{
                //    int AffID = int.Parse(txtAffiliationID.Text);
                //    int cycleID = int.Parse(Session["CycleIDFromAdmin"].ToString());
                //    Appointment checkapp = (from Appointment_tbl in appdb.Appointments where Appointment_tbl.AffiliationID == AffID && Appointment_tbl.CycleID == cycleID  select Appointment_tbl).FirstOrDefault();
                //    if (checkapp == null)
                //    {
                using (AffiliationsDBContext db = new AffiliationsDBContext())
                {
                    
                    Affiliation updateAff = (from Affiliation_tbl in db.Affiliations where Affiliation_tbl.Deleted == null && Affiliation_tbl.AffiliationID == AffID select Affiliation_tbl).FirstOrDefault();
                    updateAff.BestTimeFrom = txtBestTimeFrom.Text;
                    updateAff.BestTimeTo = txtBestTimeTo.Text;
                    updateAff.Notes = txtNotes.Text;
                    int roweffected = db.SaveChanges();
                    if (roweffected > 0)
                    {
                        affiliationslblSaveStatus.Text = "Updated";
                    }
                    else
                    {
                        affiliationslblSaveStatus.Text = "Error";
                    }
                }
                int LineID = int.Parse(Session["LineID"].ToString());

                using (PhysicianValueDBContext db = new PhysicianValueDBContext())
                {
                    
                    PhysicianValueByLine updatePhByLine = (from PhyByLine_tbl in db.PhysicianValueByLines where PhyByLine_tbl.Deleted == null && PhyByLine_tbl.AffiliationID == AffID && PhyByLine_tbl.LineID == LineID select PhyByLine_tbl).FirstOrDefault();
                    updatePhByLine.NoOfPatients = Math.Round(float.Parse(ddlNoOfPatients.SelectedValue), 3, MidpointRounding.AwayFromZero);
                    updatePhByLine.WaitingTime = Math.Round(float.Parse(ddlWaitingTime.SelectedValue), 3, MidpointRounding.AwayFromZero);
                    updatePhByLine.PrescriptionHappit = Math.Round(float.Parse(ddlPHappit.SelectedValue), 3, MidpointRounding.AwayFromZero);
                    //updatePhByLine.PrescriptionHappit = Math.Round(float.Parse(ddlPHappit.SelectedValue), 3, MidpointRounding.AwayFromZero);

                    updatePhByLine.TotalValue = updatePhByLine.NoOfPatients + updatePhByLine.PrescriptionHappit + Math.Round(float.Parse(txtSpecValue.Text), 3, MidpointRounding.AwayFromZero);
                    updatePhByLine.LastModifierID = int.Parse(Session["EmployeeHRCode"].ToString());
                    updatePhByLine.LastModificationDate = DateTime.Today;
                    if (updatePhByLine.TotalValue >= 7)
                    {
                        updatePhByLine.PhysicianClass = "A";
                    }
                    if (updatePhByLine.TotalValue < 7)
                    {
                        if (updatePhByLine.TotalValue >= 5)
                        {
                            updatePhByLine.PhysicianClass = "B";
                        }
                        if (updatePhByLine.TotalValue < 5)
                        {
                            updatePhByLine.PhysicianClass = "C";
                        }
                    }

                    int roweffected = db.SaveChanges();
                    if (roweffected > 0)
                    {
                        affiliationslblSaveStatus.Text = "Updated";
                        btnUpdate.Visible = false;
                        saveorupdate();
                        clearFields();
                        Panel1.Visible = false;
                    }
                    else
                    {
                        affiliationslblSaveStatus.Text = "Error";
                    }
                }
                using (AffiliationsAdminViewDBContext db = new AffiliationsAdminViewDBContext())
                {
                   
                    var affiliationdata = from affiliation_tbl in db.View_Affiliations_Admin where affiliation_tbl.Deleted == null && affiliation_tbl.AffiliationID == AffID && affiliation_tbl.LineID == LineID select affiliation_tbl;
                    gvAffiliations.DataSource = affiliationdata.ToList();
                    gvAffiliations.DataBind();

                }
            }


            //    else if (checkapp != null)
            //    {
            //        affiliationslblSaveStatus.Text = "Cannot update this affiliation.It has appointments";
            //}

            //}
        //}
            else
            {
                if (ddlPHappit.SelectedIndex == -1)
                {
                    lblPHappitReq.Visible = true;
                }
               
                affiliationslblSaveStatus.Text = "All Fields with red(*) is mandatory";
            }
        }






        protected void gvAffiliations_SelectedIndexChanged(object sender, EventArgs e)
        {
            affiliationslblSaveStatus.Text = "";
            Panel1.Visible = true;
            btnUpdate.Visible = true;
            saveorupdate();
            phyRow = gvAffiliations.SelectedRow;
            ddlNoOfPatients.SelectedValue = phyRow.Cells[35].Text;
            ddlWaitingTime.SelectedValue = phyRow.Cells[36].Text;
            ddlPHappit.SelectedValue = phyRow.Cells[40].Text;
            txtAffiliationID.Text = phyRow.Cells[1].Text;
            txtAffiliationName.Text = phyRow.Cells[2].Text;
            txtBestTimeFrom.Text = phyRow.Cells[33].Text.Replace("&nbsp;", "");
            txtBestTimeTo.Text = phyRow.Cells[34].Text.Replace("&nbsp;", "");
            txtNotes.Text = phyRow.Cells[31].Text.Replace("&nbsp;", "");
            txtSpecValue.Text = phyRow.Cells[37].Text.Replace("&nbsp;", "");
        }
        protected void ddlLineID_SelectedIndexChanged(object sender, EventArgs e)
        {

        }


        private void saveorupdate()
        {

        }


        protected void LineDataSource_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {

        }

        protected void PhysicianDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }


        protected void gvAffiliations_RowCreated(object sender, GridViewRowEventArgs e)
        {
            GridViewRow gvr = e.Row;
            if (gvr.RowType == DataControlRowType.Header)
            {
                gvr.Cells[1].Text = "ID";
                gvr.Cells[2].Text = "Name";
                gvr.Cells[23].Text = "Address";
                gvr.Cells[24].Text = "Speciality";
                gvr.Cells[30].Text = "Brick";
            }




            e.Row.Cells[3].Visible = false;
            e.Row.Cells[4].Visible = false;
            e.Row.Cells[5].Visible = false;
            e.Row.Cells[8].Visible = false;
            e.Row.Cells[9].Visible = false;
            e.Row.Cells[10].Visible = false;
            e.Row.Cells[12].Visible = false;
            e.Row.Cells[13].Visible = false;
            e.Row.Cells[14].Visible = false;
            e.Row.Cells[15].Visible = false;
            e.Row.Cells[16].Visible = false;
            e.Row.Cells[17].Visible = false;
            e.Row.Cells[18].Visible = false;
            e.Row.Cells[19].Visible = false;
            e.Row.Cells[20].Visible = false;
            e.Row.Cells[21].Visible = false;
            e.Row.Cells[22].Visible = false;
            e.Row.Cells[11].Visible = false;
            e.Row.Cells[6].Visible = false;
            e.Row.Cells[25].Visible = false;
            e.Row.Cells[26].Visible = false;
            e.Row.Cells[27].Visible = false;
            e.Row.Cells[28].Visible = false;
            e.Row.Cells[29].Visible = false;
            e.Row.Cells[31].Visible = false;
            e.Row.Cells[32].Visible = false;
            e.Row.Cells[33].Visible = false;
            e.Row.Cells[34].Visible = false;
            e.Row.Cells[39].Visible = false;
            e.Row.Cells[7].Visible = false;
            e.Row.Cells[37].Visible = false;
            e.Row.Cells[38].Visible = false;
            e.Row.Cells[36].Visible = false;
            e.Row.Cells[35].Visible = false;
            e.Row.Cells[39].Visible = false;
            e.Row.Cells[40].Visible = false;
            e.Row.Cells[41].Visible = false;
            e.Row.Cells[42].Visible = false;
            e.Row.Cells[43].Visible = false;
            e.Row.Cells[44].Visible = false;
            e.Row.Cells[45].Visible = false;
            e.Row.Cells[46].Visible = false;
            e.Row.Cells[47].Visible = false;
            e.Row.Cells[48].Visible = false;
            e.Row.Cells[49].Visible = false;
            e.Row.Cells[50].Visible = false;
            e.Row.Cells[51].Visible = false;
            e.Row.Cells[52].Visible = false;
            e.Row.Cells[53].Visible = false;


        }

        protected void AreaDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }

        protected void txtAffiliationID_TextChanged(object sender, EventArgs e)
        {

        }
    }
}