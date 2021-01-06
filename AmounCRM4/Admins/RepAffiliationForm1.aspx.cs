using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Net;
using System.Security.Cryptography.X509Certificates;
using System.Net.Security;

namespace AmounCRM4.Admins
{
    public partial class RepAffiliationForm1 : System.Web.UI.Page
    {
        GridViewRow phyRow;
        DataTable dtAffsOut;

        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)

            {
                if (Session["EmployeeType"].ToString() == "Rep")
                {
                    int EmpID = int.Parse(Session["EmployeeID"].ToString());

                    AreaDataSource.SelectCommand = "SELECT AmounBrickID, AmounBrickName FROM View_EmployeesBricks WHERE(Deleted IS NULL or Deleted=0) AND(EmployeeID = @EmployeeId)";

                    AreaDataSource.SelectParameters.Add("EmployeeId", Session["EmployeeID"].ToString());

                    LineDataSource.SelectCommand = "SELECT [LineID], [LineName], [OldLineName], [Deleted] FROM [PromotionalLines] WHERE (Deleted IS NULL or Deleted=0) and ([LineID]= @LineID)";
                    LineDataSource.SelectParameters.Add("LineID", Session["LineID"].ToString());

                    SpecialityDataSource.SelectCommand = "SELECT DISTINCT BrandPriorityBySpecLine.SpecialtyID, Specialities.Specialitycode FROM BrandPriorityBySpecLine INNER JOIN Specialities ON BrandPriorityBySpecLine.SpecialtyID = Specialities.SpecialityID WHERE(BrandPriorityBySpecLine.LineID = @LineID) AND(BrandPriorityBySpecLine.BrandPriority < 5)";
                    SpecialityDataSource.SelectParameters.Add("LineID", Session["LineID"].ToString());

                    AffDataSource1.SelectCommand = "SELECT [AffiliationID], [AffiliationName] from [View_Affiliations_Admin] WHERE (SpecialtyValue > 0) AND (Deleted IS NULL or Deleted=0) AND (EmployeeID = @EmpID) order by AffiliationName";
                    AffDataSource1.SelectParameters.Add("EmpID", Session["EmployeeID"].ToString());

                    ddlAreaRecIDOld.DataBind();
                    ddlSpecialityIDOld.DataBind();
                    DropDownList1Old.DataBind();

                    lblAdminCommentReq.Visible = false;
                    lblDmCommentReq.Visible = false;

                    btnCancel.Visible = true;
                    cbIsApproved.Enabled = false;
                    cbRejected.Enabled = false;
                    cbimplemented.Enabled = false;
                    cbNotImplement.Enabled = false;
                    rpSMReject.Enabled = false;
                    rbSMApprove.Enabled = false;
                    rbSDReject.Enabled = false;
                    rbSDApprove.Enabled = false;
                    rbCOReject.Enabled = false;
                    rbCOApprove.Enabled = false;
                    cbProccedBy.Enabled = false;

                    txtDMComments.Enabled = false;
                    txtAdminComments.Enabled = false;
                    txtCOComments.Enabled = false;
                    txtDMComments.Enabled = false;
                    txtSDComments.Enabled = false;
                    txtSMComments.Enabled = false;


                }
                else
                {
                    if (Session["EmployeeType"].ToString() == "DM")
                    {
                        LineDataSource.SelectCommand = "SELECT [LineID], [LineName], [OldLineName], [Deleted] FROM [PromotionalLines] WHERE ([Deleted] IS NULL)";
                        LineDataSource.SelectParameters.Add("LineID", Session["LineIDFromDM"].ToString());
                        AreaDataSource.SelectCommand = "SELECT [AmounBrickID], [AmounBrickName] FROM [AreaHierarchy] where ([SupervisionAreaID] = " + int.Parse(Session["AreaIDFromDM"].ToString()) + ")";
                        AreaDataSource.SelectParameters.Add("AreaIDFromDM", Session["AreaIDFromDM"].ToString());

                        SpecialityDataSource.SelectCommand = "SELECT DISTINCT BrandPriorityBySpecLine.SpecialtyID, Specialities.Specialitycode FROM BrandPriorityBySpecLine INNER JOIN Specialities ON BrandPriorityBySpecLine.SpecialtyID = Specialities.SpecialityID";
                        SpecialityDataSource.SelectParameters.Add("LineID", Session["LineIDFromDM"].ToString());

                        ddlAreaRecID.DataBind();
                        ddlSpecialityID.DataBind();
                        DropDownList1.DataBind();
                        ddlAreaRecIDOld.DataBind();
                        ddlSpecialityIDOld.DataBind();
                        DropDownList1Old.DataBind();
                        cbimplemented.Enabled = false;
                        cbNotImplement.Enabled = false;
                        txtAdminComments.Enabled = false;
                        btnSave.Visible = false;
                        lblAdminCommentReq.Visible = false;
                        lblDmCommentReq.Visible = false;
                        ddlRepAffiliations.Enabled = false;



                        cbIsApproved.Enabled = true;
                        cbRejected.Enabled = true;
                        cbimplemented.Enabled = false;
                        cbNotImplement.Enabled = false;
                        rpSMReject.Enabled = false;
                        rbSMApprove.Enabled = false;
                        rbSDReject.Enabled = false;
                        rbSDApprove.Enabled = false;
                        rbCOReject.Enabled = false;
                        rbCOApprove.Enabled = false;
                        cbProccedBy.Enabled = false;


                        txtDMComments.Enabled = true;
                        txtAdminComments.Enabled = false;
                        txtCOComments.Enabled = false;
                        txtSDComments.Enabled = false;
                        txtSMComments.Enabled = false;

                    }
                    if (Session["EmployeeType"].ToString() == "Sales Manager")
                    {
                        LineDataSource.SelectCommand = "SELECT [LineID], [LineName], [OldLineName], [Deleted] FROM [PromotionalLines] WHERE ([Deleted] IS NULL)";
                        AreaDataSource.SelectCommand = "SELECT [AmounBrickID], [AmounBrickName] FROM [AreaHierarchy]";
                        SpecialityDataSource.SelectCommand = "SELECT DISTINCT BrandPriorityBySpecLine.SpecialtyID, Specialities.Specialitycode FROM BrandPriorityBySpecLine INNER JOIN Specialities ON BrandPriorityBySpecLine.SpecialtyID = Specialities.SpecialityID";
                        ddlAreaRecID.DataBind();
                        ddlSpecialityID.DataBind();
                        DropDownList1.DataBind();
                        ddlAreaRecIDOld.DataBind();
                        ddlSpecialityIDOld.DataBind();
                        DropDownList1Old.DataBind();
                        cbIsApproved.Visible = false;
                        cbRejected.Visible = false;
                        txtDMComments.Enabled = false;
                        lblAdminCommentReq.Visible = false;
                        lblDmCommentReq.Visible = false;
                        btnSave.Visible = false;
                        ddlRepAffiliations.Enabled = false;

                        cbProccedBy.Enabled = false;

                        cbIsApproved.Enabled = false;
                        cbRejected.Enabled = false;
                        cbimplemented.Enabled = false;
                        cbNotImplement.Enabled = false;
                        rpSMReject.Enabled = true;
                        rbSMApprove.Enabled = true;
                        rbSDReject.Enabled = false;
                        rbSDApprove.Enabled = false;
                        rbCOReject.Enabled = false;
                        rbCOApprove.Enabled = false;

                        txtDMComments.Enabled = false;
                        txtAdminComments.Enabled = false;
                        txtCOComments.Enabled = false;
                        txtDMComments.Enabled = false;
                        txtSDComments.Enabled = false;
                        txtSMComments.Enabled = true;
                    }
                    if (Session["EmployeeType"].ToString() == "Sales Director")
                    {
                        LineDataSource.SelectCommand = "SELECT [LineID], [LineName], [OldLineName], [Deleted] FROM [PromotionalLines] WHERE ([Deleted] IS NULL)";
                        AreaDataSource.SelectCommand = "SELECT [AmounBrickID], [AmounBrickName] FROM [AreaHierarchy]";
                        SpecialityDataSource.SelectCommand = "SELECT DISTINCT BrandPriorityBySpecLine.SpecialtyID, Specialities.Specialitycode FROM BrandPriorityBySpecLine INNER JOIN Specialities ON BrandPriorityBySpecLine.SpecialtyID = Specialities.SpecialityID";
                        ddlAreaRecID.DataBind();
                        ddlSpecialityID.DataBind();
                        DropDownList1.DataBind();
                        ddlAreaRecIDOld.DataBind();
                        ddlSpecialityIDOld.DataBind();
                        DropDownList1Old.DataBind();
                        cbIsApproved.Visible = false;
                        cbRejected.Visible = false;
                        txtDMComments.Enabled = false;
                        lblAdminCommentReq.Visible = false;
                        lblDmCommentReq.Visible = false;
                        btnSave.Visible = false;
                        ddlRepAffiliations.Enabled = false;

                        cbProccedBy.Enabled = false;

                        cbIsApproved.Enabled = false;
                        cbRejected.Enabled = false;
                        cbimplemented.Enabled = false;
                        cbNotImplement.Enabled = false;
                        rpSMReject.Enabled = false;
                        rbSMApprove.Enabled = false;
                        rbSDReject.Enabled = true;
                        rbSDApprove.Enabled = true;
                        rbCOReject.Enabled = false;
                        rbCOApprove.Enabled = false;

                        txtDMComments.Enabled = false;
                        txtAdminComments.Enabled = false;
                        txtCOComments.Enabled = false;
                        txtDMComments.Enabled = false;
                        txtSDComments.Enabled = true;
                        txtSMComments.Enabled = false;
                    }
                    if (Session["EmployeeType"].ToString() == "Commercial Director")
                    {
                        LineDataSource.SelectCommand = "SELECT [LineID], [LineName], [OldLineName], [Deleted] FROM [PromotionalLines] WHERE ([Deleted] IS NULL)";
                        AreaDataSource.SelectCommand = "SELECT [AmounBrickID], [AmounBrickName] FROM [AreaHierarchy]";
                        SpecialityDataSource.SelectCommand = "SELECT DISTINCT BrandPriorityBySpecLine.SpecialtyID, Specialities.Specialitycode FROM BrandPriorityBySpecLine INNER JOIN Specialities ON BrandPriorityBySpecLine.SpecialtyID = Specialities.SpecialityID";
                        ddlAreaRecID.DataBind();
                        ddlSpecialityID.DataBind();
                        DropDownList1.DataBind();
                        ddlAreaRecIDOld.DataBind();
                        ddlSpecialityIDOld.DataBind();
                        DropDownList1Old.DataBind();
                        cbIsApproved.Visible = false;
                        cbRejected.Visible = false;
                        txtDMComments.Enabled = false;
                        lblAdminCommentReq.Visible = false;
                        lblDmCommentReq.Visible = false;
                        btnSave.Visible = false;
                        ddlRepAffiliations.Enabled = false;

                        cbProccedBy.Enabled = false;

                        cbIsApproved.Enabled = false;
                        cbRejected.Enabled = false;
                        cbimplemented.Enabled = false;
                        cbNotImplement.Enabled = false;
                        rpSMReject.Enabled = false;
                        rbSMApprove.Enabled = false;
                        rbSDReject.Enabled = false;
                        rbSDApprove.Enabled = false;
                        rbCOReject.Enabled = true;
                        rbCOApprove.Enabled = true;

                        txtDMComments.Enabled = false;
                        txtAdminComments.Enabled = false;
                        txtCOComments.Enabled = true;
                        txtDMComments.Enabled = false;
                        txtSDComments.Enabled = false;
                        txtSMComments.Enabled = false;
                    }
                    if (Session["EmployeeType"].ToString() == "Admin")
                    {
                        LineDataSource.SelectCommand = "SELECT [LineID], [LineName], [OldLineName], [Deleted] FROM [PromotionalLines] WHERE ([Deleted] IS NULL)";
                        AreaDataSource.SelectCommand = "SELECT [AmounBrickID], [AmounBrickName] FROM [AreaHierarchy]";
                        SpecialityDataSource.SelectCommand = "SELECT DISTINCT BrandPriorityBySpecLine.SpecialtyID, Specialities.Specialitycode FROM BrandPriorityBySpecLine INNER JOIN Specialities ON BrandPriorityBySpecLine.SpecialtyID = Specialities.SpecialityID";
                        ddlAreaRecID.DataBind();
                        ddlSpecialityID.DataBind();
                        DropDownList1.DataBind();
                        ddlAreaRecIDOld.DataBind();
                        ddlSpecialityIDOld.DataBind();
                        DropDownList1Old.DataBind();
                        cbIsApproved.Visible = false;
                        cbRejected.Visible = false;
                        txtDMComments.Enabled = false;
                        lblAdminCommentReq.Visible = false;
                        lblDmCommentReq.Visible = false;
                        btnSave.Visible = false;

                        txtBrickID.Visible = true;
                        cbIsApproved.Enabled = false;
                        cbRejected.Enabled = false;

                        cbimplemented.Enabled = true;
                        cbNotImplement.Enabled = true;


                        rpSMReject.Enabled = false;
                        rbSMApprove.Enabled = false;
                        rbSDReject.Enabled = false;
                        rbSDApprove.Enabled = false;
                        rbCOReject.Enabled = false;
                        rbCOApprove.Enabled = false;

                        txtDMComments.Enabled = false;
                        txtAdminComments.Enabled = true;
                        txtCOComments.Enabled = false;
                        txtDMComments.Enabled = false;
                        txtSDComments.Enabled = false;
                        txtSMComments.Enabled = false;
                    }



                    txtAffiliationID.Enabled = false;
                    txtAffiliationName.Enabled = false;
                    txtBestTimeFrom.Enabled = false;
                    txtBestTimeTo.Enabled = false;
                    txtNotes.Enabled = false;
                    ddlSpecialityID.Enabled = false;
                    txtNewEntityID.Enabled = false;
                    txtNewPhysicianID.Enabled = false;
                    ddlLineID.Enabled = false;
                    ddlAreaRecID.Enabled = false;
                    txtClinicAddress.Enabled = false;
                    DropDownList1.Enabled = false;
                    ddlNoOfPatients.Enabled = false;
                    ddlPrescriptionHappit.Enabled = false;
                    ddlWatingTime.Enabled = false;
                    txtTel1.Enabled = false;
                    txtTel2.Enabled = false;
                    txtTel3.Enabled = false;
                    txtFax.Enabled = false;
                    txtEmailAddress.Enabled = false;
                    txtWebSite.Enabled = false;
                    ddlLineID.Enabled = false;
                    ddlRepAffiliations.DataBind();
                    Panel1.Visible = false;
                    txtDescription.Enabled = false;

                }
                //ddlAreaRecID.DataBind();
                //ddlSpecialityID.DataBind();
                //DropDownList1.DataBind();



                ddlAreaRecIDOld.AppendDataBoundItems = true;
                ddlSpecialityIDOld.AppendDataBoundItems = true;
                DropDownList1Old.AppendDataBoundItems = true;

                //ddlNoOfPatientsOld.AppendDataBoundItems = true;
                //ddlWatingTimeOld.AppendDataBoundItems = true;
                //ddlPrescriptionHappitOld.AppendDataBoundItems = true;
                //ddlRepAffiliations.DataBind();
                //ddlNoOfPatientsOld.DataBind();
                //ddlWatingTimeOld.DataBind();
                //ddlPrescriptionHappitOld.DataBind();
                //ddlPrescriptionHappit.DataBind();
                //ddlWatingTime.DataBind();
                //ddlNoOfPatients.DataBind();
                //ddlPrescriptionHappit.AppendDataBoundItems = true;
                //ddlWatingTime.AppendDataBoundItems = true;
                //ddlNoOfPatients.AppendDataBoundItems = true;

                ddlLineID.Enabled = false;
                ddlAreaRecID.AppendDataBoundItems = true;
                ddlLineID.DataBind();


                ddlLineID.AppendDataBoundItems = true;
                ddlSpecialityID.AppendDataBoundItems = true;
                DropDownList1.AppendDataBoundItems = true;

                btnUpdate.Visible = false;
                btnDelete.Visible = false;
                saveorupdate();
                //ddlAreaRecID.SelectedItem = -1;
                Loadaffiliations();

            }
        }

        private void RefreshScreen()
        {
            DropDownList2.SelectedIndex = -1;
            DropDownList2.Enabled = true;
            ddlRepAffiliations.Enabled = true;
            txtClinicAddress.Enabled = true;
            ddlAreaRecID.Enabled = true;
            ddlNoOfPatients.Enabled = true;
            ddlWatingTime.Enabled = true;
            txtEmailAddress.Enabled = true;
            txtTel1.Enabled = true;
            txtTel2.Enabled = true;
            txtTel3.Enabled = true;
            txtWebSite.Enabled = true;
            txtNotes.Enabled = true;
            txtBestTimeFrom.Enabled = true;
            txtBestTimeTo.Enabled = true;
            txtDescription.Enabled = true;
            ddlPrescriptionHappit.Enabled = true;
            txtFax.Enabled = true;
            gvAffiliations.DataSource = null;
            gvAffiliations.DataBind();
            lblSpecialityReq.Visible = false;
            lblAreaReq.Visible = false;
            lblTelReq.Visible = false;
            lblPhysicianReq.Visible = false;
            lblEntityReq.Visible = false;
            lblAddressReq.Visible = false;
            lblClincTypeReq.Visible = false;
            lblNoOfPatients.Visible = false;
            lblPrescriptionHappit.Visible = false;
            lblWatingTime.Visible = false;
            lblDescriptionReq.Visible = false;
            lblRequestTypeReq.Visible = false;

            clearFields();
            ddlRepAffiliations.Visible = false;
            lblSelectAffiliation.Visible = false;

            txtNewEntityID.Enabled = true;
            txtNewPhysicianID.Enabled = true;
            txtNewEntityID.Visible = true;
            txtNewPhysicianID.Visible = true;
            DropDownList1.Enabled = true;
            ddlSpecialityID.Enabled = true;

            txtNewEntityIDOld.Visible = false;
            txtNewPhysicianIDOld.Visible = false;
            txtClinicAddressOld.Visible = false;
            lblClinicAddressOld.Visible = false;
            ddlAreaRecIDOld.Visible = false;
            lblOldBrick.Visible = false;
            ddlSpecialityIDOld.Visible = false;
            DropDownList1Old.Visible = false;
            lblOldEntityType.Visible = false;
            ddlNoOfPatientsOld.Visible = false;
            lblNoOfPatientsOld.Visible = false;

            ddlWatingTimeOld.Visible = false;
            lblWatingTimeOld.Visible = false;

            ddlPrescriptionHappitOld.Visible = false;
            lblPrescriptionHabitOld.Visible = false;

            txtDMName.Text = "";
            txtDMDate.Text = "";
            txtDMComments.Text = "";
            txtAdminName.Text = "";
            txtAdminDate.Text = "";
            txtAdminComments.Text = "";
            txtSDName.Text = "";
            txtSDDate.Text = "";
            txtSDComments.Text = "";
            txtSMName.Text = "";
            txtSMDate.Text = "";
            txtSMComments.Text = "";
            txtCOComments.Text = "";
            txtCOMangerDate.Text = "";
            txtCOMangerName.Text = "";
            txtProccedByName.Text = "";
            txtProccedByDate.Text = "";
            cbimplemented.Checked = false;
            cbNotImplement.Checked = false;
            cbIsApproved.Checked = false;
            cbRejected.Checked = false;
            rbSMApprove.Checked = false;
            rpSMReject.Checked = false;
            rbSDApprove.Checked = false;
            rbSDReject.Checked = false;
            rbCOApprove.Checked = false;
            rbCOReject.Checked = false;
            cbProccedBy.Checked = false;
            btnSave.Visible = true;
            btnDelete.Visible = false;
            Loadaffiliations();
        }
        private void clearFields()
        {

            txtDescription.Text = "";
            lblDescriptionReq.Visible = false;
            txtAffiliationID.Text = "";
            txtAffiliationName.Text = "";
            txtBestTimeFrom.Text = "";
            txtBestTimeTo.Text = "";
            ddlAreaRecID.SelectedIndex = 0;
            ddlSpecialityID.SelectedIndex = 0;
            txtNotes.Text = "";
            txtClinicAddress.Text = "";
            DropDownList1.SelectedIndex = 0;
            txtTel1.Text = "";
            txtTel2.Text = "";
            txtTel3.Text = "";
            txtFax.Text = "";
            txtEmailAddress.Text = "";
            txtWebSite.Text = "";
            txtNewPhysicianID.Text = "";
            txtNewEntityID.Text = "";
            //txtEntitySave.Text = "";
            //txtPhySave.Text = "";
            cbIsApproved.Checked = false;
            cbRejected.Checked = false;
            //lblDMApproval.Checked = false;
            cbimplemented.Checked = false;
            cbNotImplement.Checked = false;
            txtAdminComments.Text = "";
            txtDMComments.Text = "";

            txtNewEntityIDOld.Text = "";
            txtNewPhysicianIDOld.Text = "";
            txtClinicAddressOld.Text = "";
            ddlAreaRecIDOld.SelectedIndex = 0;
            ddlSpecialityIDOld.SelectedIndex = 0;
            DropDownList1Old.SelectedIndex = 0;
            ddlNoOfPatientsOld.SelectedIndex = 0;
            ddlWatingTimeOld.SelectedIndex = 0;
            ddlPrescriptionHappitOld.SelectedIndex = 0;
            txtDMDate.Text = "";
            txtSDDate.Text = "";
            txtSMDate.Text = "";
            txtCOMangerDate.Text = "";
            txtProccedByDate.Text = "";
            txtRequestDate.Text = "";
            cbProccedBy.Checked = false;




            //lblAdmin.Visible = false;
            ddlWatingTime.SelectedIndex = 0;
            ddlPrescriptionHappit.SelectedIndex = 0;
            ddlNoOfPatients.SelectedIndex = 0;
            //if (Session["EmployeeType"].ToString() == "Rep")
            //{
            //    AreaDataSource.SelectCommand = "SELECT [AmounBrickID], [AmounBrickName] FROM [AreaHierarchy] where ([RepAreaID] = @AreaID)";
            //    LineDataSource.SelectCommand = "SELECT [LineID], [LineName], [OldLineName], [Deleted] FROM [PromotionalLines] WHERE ([Deleted] IS NULL) and ([LineID]= @LineID)";
            //}
            //if (Session["EmployeeType"].ToString() == "DM")
            //{
            //    AreaDataSource.SelectCommand = "SELECT [AmounBrickID], [AmounBrickName] FROM [AreaHierarchy] where ([SupervisionAreaID] = @AreaIDFromDM)";
            //}
        }

        private void Loadaffiliations()
        {


            using (ProposedAffiliationDBContext db = new ProposedAffiliationDBContext())
            {
                affiliationslblSaveStatus.Text = "";
                if ((Session["EmployeeType"]).ToString() == "Admin")
                {
                    var ProposedAffData = from ProposedAff_tbl in db.Affiliations_Proposed where (ProposedAff_tbl.Status == "Approved") && ProposedAff_tbl.Deleted == null select ProposedAff_tbl;
                    gvAffiliations.DataSource = ProposedAffData.ToList();
                    gvAffiliations.DataBind();

                }
                if ((Session["EmployeeType"]).ToString() == "DM")
                {
                    int DMLineId = int.Parse(Session["LineIDFromDM"].ToString());
                    int DMId = int.Parse(Session["EmployeeIDFromDM"].ToString());

                    var ProposedAffData = from ProposedAff_tbl in db.Affiliations_Proposed where ProposedAff_tbl.Status == "District Manager" && ProposedAff_tbl.LineID == DMLineId && ProposedAff_tbl.DMID == DMId && ProposedAff_tbl.Deleted == null select ProposedAff_tbl;
                    gvAffiliations.DataSource = ProposedAffData.ToList();
                    gvAffiliations.DataBind();

                }
                if ((Session["EmployeeType"]).ToString() == "Rep")
                {
                    int RepId = int.Parse(Session["EmployeeID"].ToString());
                    int LineId = int.Parse(Session["LineID"].ToString());

                    //var ProposedAffData = from ProposedAff_tbl in db.Affiliations_Proposed where (ProposedAff_tbl.Is_Approved == null || ProposedAff_tbl.Is_Approved == false) && ProposedAff_tbl.LineID == LineId && ProposedAff_tbl.EmployeeID == RepId && ProposedAff_tbl.Deleted == null select ProposedAff_tbl;
                    var ProposedAffData = from ProposedAff_tbl in db.Affiliations_Proposed where ProposedAff_tbl.LineID == LineId && ProposedAff_tbl.EmployeeID == RepId && ProposedAff_tbl.Deleted == null select ProposedAff_tbl;
                    gvAffiliations.DataSource = ProposedAffData.ToList();
                    gvAffiliations.DataBind();

                }
                if ((Session["EmployeeType"]).ToString() == "Sales Manager")
                {
                    int SMId = int.Parse(Session["EmployeeIDFromSM"].ToString());
                    int LineId = int.Parse(Session["LineIDFromSM"].ToString());

                    var ProposedAffData = from ProposedAff_tbl in db.Affiliations_Proposed where ProposedAff_tbl.Status == "Sales Manager" && ProposedAff_tbl.SMID == SMId && ProposedAff_tbl.Deleted == null select ProposedAff_tbl;
                    gvAffiliations.DataSource = ProposedAffData.ToList();

                    gvAffiliations.DataBind();

                }

                if ((Session["EmployeeType"]).ToString() == "Sales Director")
                {
                    int SDId = int.Parse(Session["EmployeeIDFromDir"].ToString());
                    //int LineId = int.Parse(Session["LineIDFromDir"].ToString());

                    var ProposedAffData = from ProposedAff_tbl in db.Affiliations_Proposed where ProposedAff_tbl.Status == "Sales Director" && ProposedAff_tbl.SDID == SDId && ProposedAff_tbl.Deleted == null select ProposedAff_tbl;
                    gvAffiliations.DataSource = ProposedAffData.ToList();
                    gvAffiliations.DataBind();

                }

                if ((Session["EmployeeType"]).ToString() == "Commercial Director")
                {
                    int COId = int.Parse(Session["EmployeeIDFromComDir"].ToString());
                    //int LineId = int.Parse(Session["LineIDFromComDir"].ToString());

                    var ProposedAffData = from ProposedAff_tbl in db.Affiliations_Proposed where ProposedAff_tbl.Status == "Commercial Director" && ProposedAff_tbl.COVP_ID == COId && ProposedAff_tbl.Deleted == null select ProposedAff_tbl;
                    gvAffiliations.DataSource = ProposedAffData.ToList();
                    gvAffiliations.DataBind();

                }
                //if ((Session["EmployeeType"]).ToString() == "Admin")
                //{
                //    //int AdminId = int.Parse(Session["EmployeeIDFromComDir"].ToString());
                //    //int LineId = int.Parse(Session["LineIDFromComDir"].ToString());

                //    var ProposedAffData = from ProposedAff_tbl in db.Affiliations_Proposed where ProposedAff_tbl.Status == "Approved" &&  ProposedAff_tbl.Deleted == null select ProposedAff_tbl;
                //    gvAffiliations.DataSource = ProposedAffData.ToList();
                //    gvAffiliations.DataBind();

                //}

                if (gvAffiliations.Rows.Count == 0)
                {
                    affiliationslblSaveStatus.Text = "No Requests found";
                }

            }
        }


        protected void btnSearch_Click(object sender, EventArgs e)
        {
            clearFields();
            gvAffiliations.DataSource = null;
            gvAffiliations.DataBind();
            saveorupdate();
            SearchQuery();
        }

        private void SearchQuery()
        {
            if ((Session["EmployeeType"]).ToString() != "Admin")
            {
                using (PhysicianValueDBContext db = new PhysicianValueDBContext())
                {

                    //var affiliationdata = from affiliation_tbl in db.PhysicianValueByLines where affiliation_tbl.Deleted == null && affiliation_tbl.AffiliationName.Contains(txtNameSe.Text) select affiliation_tbl;
                    //gvAffiliations.DataSource = affiliationdata.ToList();
                    //gvAffiliations.DataBind();
                    ////gvAffiliations.
                    ////gvAffiliations.Columns[2].Visible = false;

                }
            }
            else if ((Session["EmployeeType"]).ToString() == "Admin")
            {
                using (ProposedAffiliationDBContext proAffDB = new ProposedAffiliationDBContext())
                {//Ehab
                    //var ProposedAffData = from ProposedAff_tbl in proAffDB.Affiliations_Proposed where ProposedAff_tbl.Is_Approved == null && ProposedAff_tbl.AffiliationName.Contains(txtNameSe.Text) select ProposedAff_tbl;
                    //gvAffiliations.DataSource = ProposedAffData.ToList();
                    //gvAffiliations.DataBind();
                }
            }

        }


        protected void btnSave_Click(object sender, EventArgs e)
        {
            if ((Session["EmployeeType"]).ToString() == "Rep" && txtAffiliationID.Text != "")
            {
                int EmpID = int.Parse(Session["EmployeeID"].ToString());
                int affID = int.Parse(txtAffiliationID.Text);
                using (ProposedAffiliationDBContext db = new ProposedAffiliationDBContext())
                {
                    Affiliations_Proposed PropAffData = (from PropAff_tbl in db.Affiliations_Proposed where PropAff_tbl.EmployeeID == EmpID && PropAff_tbl.RealAffID == affID && PropAff_tbl.Deleted == null && (PropAff_tbl.Status != "Rejected" && PropAff_tbl.Status != "In Progress") select PropAff_tbl).FirstOrDefault();
                    if (PropAffData != null)
                    {
                        affiliationslblSaveStatus.Text = "This request is already in the approval cycle";
                        return;
                    }
                }

            }
            if ((Session["EmployeeType"].ToString() == "Rep") && (DropDownList2.SelectedValue == "0"))
            {
                lblRequestTypeReq.Visible = true;
                affiliationslblSaveStatus.Text = "All Fields with red(*) is mandatory";
                return;
            }
            //if ((Session["EmployeeType"].ToString() == "Rep") && (DropDownList2.SelectedValue == "Update" || DropDownList2.SelectedValue == "Delete") && (txtDescription.Text == ""))
            //{
            //    lblDescriptionReq.Visible = true;
            //    affiliationslblSaveStatus.Text = "All Fields with red(*) is mandatory";
            //    return;
            //}
            if (DropDownList2.SelectedValue == "Delete")
            {
                using (ProposedAffiliationDBContext newaff = new ProposedAffiliationDBContext())
                {
                    Affiliations_Proposed aff = new Affiliations_Proposed();
                    aff.AffiliationName = txtNewPhysicianID.Text;

                    aff.RealAffID = int.Parse(txtAffID.Text);
                    aff.LineID = int.Parse(Session["LineID"].ToString());
                    aff.EmployeeID = int.Parse(Session["EmployeeID"].ToString());
                    aff.RequestType = DropDownList2.SelectedValue;
                    aff.PhysicianName = txtNewPhysicianID.Text;
                    aff.EntityName = txtNewEntityID.Text;
                    aff.EntityAddress = txtClinicAddress.Text;
                    aff.BrickID = int.Parse(ddlAreaRecID.SelectedValue);

                    if (DropDownList2.SelectedValue != "New")
                    {
                        aff.RealAffID = int.Parse(txtAffID.Text);


                    }
                    aff.PhysicianName = txtNewPhysicianID.Text;
                    aff.EntityName = txtNewEntityID.Text;
                    aff.AreaRecID = int.Parse(Session["AreaID"].ToString());
                    aff.SpecialityID = int.Parse(ddlSpecialityID.SelectedValue);
                    aff.LineID = int.Parse(Session["LineID"].ToString());
                    aff.BestTimeFrom = txtBestTimeFrom.Text;
                    aff.BestTimeTo = txtBestTimeTo.Text;
                    aff.Notes = txtNotes.Text;
                    aff.EntityAddress = txtClinicAddress.Text;
                    aff.EntityTypeID = int.Parse(DropDownList1.SelectedValue);
                    aff.Tel1 = txtTel1.Text;
                    aff.Tel2 = txtTel2.Text;
                    aff.Tel3 = txtTel3.Text;
                    aff.Fax = txtFax.Text;
                    aff.EntityEmailAddress = txtEmailAddress.Text;
                    aff.EntityWebSite = txtWebSite.Text;
                    aff.EmployeeID = int.Parse(Session["EmployeeID"].ToString());
                    aff.RepName = Session["EmployeeName"].ToString();
                    aff.BrickID = int.Parse(ddlAreaRecID.SelectedValue);
                    aff.NoOfPatients = ddlNoOfPatients.SelectedValue;
                    aff.WatingTime = ddlWatingTime.SelectedValue;
                    aff.PrescriptionHappit = ddlPrescriptionHappit.SelectedValue;
                    aff.Description = txtDescription.Text;
                    aff.RequestType = DropDownList2.SelectedValue;
                    aff.EntityNameOld = txtNewEntityIDOld.Text;
                    aff.PhysicianNameOld = txtNewPhysicianIDOld.Text;
                    aff.EntityAddressOld = txtClinicAddressOld.Text;
                    aff.AreaRecIDOld = int.Parse(ddlAreaRecIDOld.SelectedValue);
                    aff.SpecialityIDOld = int.Parse(ddlSpecialityIDOld.SelectedValue);
                    aff.EntityTypeIDOld = int.Parse(DropDownList1Old.SelectedValue);
                    aff.NoOfPatientsOld = ddlNoOfPatientsOld.SelectedValue;
                    aff.WatingTimeOld = ddlWatingTimeOld.SelectedValue;
                    aff.PrescriptionHappitOld = ddlPrescriptionHappitOld.SelectedValue;
                    aff.RequestDate = DateTime.Parse(txtRequestDate.Text);

                    if (rbSMApprove.Checked == true)
                    {
                        aff.SM_Approved = true;
                        aff.Status = "Sales Director";
                    }
                    if (rbSDApprove.Checked == true)
                    {
                        aff.SD_Approved = true;
                        aff.Status = "Commercial Director";
                    }
                    if (rbCOApprove.Checked == true)
                    {
                        aff.COVP_Approved = true;
                        aff.Status = "Approved";
                    }

                    if (rbSMApprove.Checked == false)
                    {
                        aff.Status = "Rejected";
                    }
                    if (rbSDApprove.Checked == false)
                    {
                        aff.Status = "Rejected";
                    }
                    if (rbCOApprove.Checked == false)
                    {
                        aff.Status = "Rejected";
                    }
                    if (cbIsApproved.Checked == true)
                    {
                        aff.Is_Approved = true;
                        aff.Status = "Administrator Review";
                    }
                    if (cbRejected.Checked == true)
                    {
                        aff.Is_Approved = null;
                        aff.Status = "Rejected";
                    }
                    if (cbimplemented.Checked == true)
                    {
                        aff.Is_Implemented = true;
                        aff.Status = "Sales Manager";
                    }
                    if (cbNotImplement.Checked == true)
                    {
                        aff.Is_Implemented = null;
                        aff.Is_Approved = null;
                        aff.Status = "Rejected";
                    }

                    if ((Session["EmployeeType"]).ToString() == "Rep")
                    {
                        int EmpID = int.Parse(Session["EmployeeID"].ToString());
                        using (EmployeesViewDBContext db = new EmployeesViewDBContext())
                        {
                            View_Employees EmpData = (from Emp_tbl in db.View_Employees where Emp_tbl.EmployeeID == EmpID select Emp_tbl).FirstOrDefault();
                            aff.DMID = EmpData.DirectManagerID;
                            aff.SMID = EmpData.TopManagerID;
                            aff.SDID = EmpData.DirectorID;
                            aff.COVP_ID = EmpData.ComDirID;
                            aff.Status = "District Manager";
                        }

                    }

                    newaff.Affiliations_Proposed.Add(aff);
                    int roweffected = newaff.SaveChanges();
                    if (roweffected > 0)
                    {
                        affiliationslblSaveStatus.Text = "Saved";
                        //ECMS_Mailing("jezzat@amoun.com", "jezzat@amoun.com", "delete DM", "delete DM");

                        DropDownList2.SelectedIndex = -1;

                        gvAffiliations.DataSource = null;
                        gvAffiliations.DataBind();
                        lblSpecialityReq.Visible = false;
                        lblAreaReq.Visible = false;
                        lblTelReq.Visible = false;
                        lblPhysicianReq.Visible = false;
                        lblEntityReq.Visible = false;
                        lblAddressReq.Visible = false;
                        lblClincTypeReq.Visible = false;
                        lblNoOfPatients.Visible = false;
                        lblPrescriptionHappit.Visible = false;
                        lblWatingTime.Visible = false;
                        lblDescriptionReq.Visible = false;
                        lblRequestTypeReq.Visible = false;

                        clearFields();
                        ddlRepAffiliations.Visible = false;
                        lblSelectAffiliation.Visible = false;

                        txtNewEntityID.Enabled = true;
                        txtNewPhysicianID.Enabled = true;
                        DropDownList1.Enabled = true;
                        ddlSpecialityID.Enabled = true;

                        txtNewEntityIDOld.Visible = false;
                        txtNewPhysicianIDOld.Visible = false;
                        txtClinicAddressOld.Visible = false;
                        lblClinicAddressOld.Visible = false;

                        ddlAreaRecIDOld.Visible = false;
                        lblOldBrick.Visible = false;

                        ddlSpecialityIDOld.Visible = false;
                        DropDownList1Old.Visible = false;
                        lblOldEntityType.Visible = false;

                        ddlNoOfPatientsOld.Visible = false;
                        lblNoOfPatientsOld.Visible = false;
                        ddlWatingTimeOld.Visible = false;
                        lblWatingTimeOld.Visible = false;

                        ddlPrescriptionHappitOld.Visible = false;
                        lblPrescriptionHabitOld.Visible = false;
                        RefreshScreen();

                    }
                    else
                    {
                        affiliationslblSaveStatus.Text = "Error";

                    }
                }
                Loadaffiliations();
            }

            else if (cbNotImplement.Checked == false && cbRejected.Checked == false && txtNewPhysicianID.Text != "" && txtNewEntityID.Text != "" && ddlSpecialityID.SelectedIndex != 0 && txtClinicAddress.Text != "" && ddlAreaRecID.SelectedIndex != 0 && DropDownList1.SelectedIndex != 0 && ddlNoOfPatients.SelectedIndex != 0 && ddlPrescriptionHappit.SelectedIndex != 0 && ddlWatingTime.SelectedIndex != 0)
            {

                using (ProposedAffiliationDBContext newaff = new ProposedAffiliationDBContext())
                {
                    Affiliations_Proposed aff = new Affiliations_Proposed();
                    aff.AffiliationName = txtNewPhysicianID.Text;
                    //if (txtPhySave.Text != "")
                    //{
                    //    aff.PhysicianID = int.Parse(txtPhySave.Text);
                    //}
                    //if (txtEntitySave.Text != "")
                    //{
                    //    aff.EntityID = int.Parse(txtEntitySave.Text);
                    //}
                    if (DropDownList2.SelectedValue != "New")
                    {
                        aff.RealAffID = int.Parse(txtAffID.Text);


                    }
                    aff.PhysicianName = txtNewPhysicianID.Text;
                    aff.EntityName = txtNewEntityID.Text;
                    aff.AreaRecID = int.Parse(Session["AreaID"].ToString());
                    aff.SpecialityID = int.Parse(ddlSpecialityID.SelectedValue);
                    aff.LineID = int.Parse(Session["LineID"].ToString());
                    aff.BestTimeFrom = txtBestTimeFrom.Text;
                    aff.BestTimeTo = txtBestTimeTo.Text;
                    aff.Notes = txtNotes.Text;
                    aff.EntityAddress = txtClinicAddress.Text;
                    aff.EntityTypeID = int.Parse(DropDownList1.SelectedValue);
                    aff.Tel1 = txtTel1.Text;
                    aff.Tel2 = txtTel2.Text;
                    aff.Tel3 = txtTel3.Text;
                    aff.Fax = txtFax.Text;
                    aff.EntityEmailAddress = txtEmailAddress.Text;
                    aff.EntityWebSite = txtWebSite.Text;
                    aff.EmployeeID = int.Parse(Session["EmployeeID"].ToString());
                    aff.RepName = Session["EmployeeName"].ToString();
                    aff.BrickID = int.Parse(ddlAreaRecID.SelectedValue);
                    aff.NoOfPatients = ddlNoOfPatients.SelectedValue;
                    aff.WatingTime = ddlWatingTime.SelectedValue;
                    aff.PrescriptionHappit = ddlPrescriptionHappit.SelectedValue;
                    aff.Description = txtDescription.Text;
                    aff.RequestType = DropDownList2.SelectedValue;
                    aff.EntityNameOld = txtNewEntityIDOld.Text;
                    aff.PhysicianNameOld = txtNewPhysicianIDOld.Text;
                    aff.EntityAddressOld = txtClinicAddressOld.Text;
                    aff.AreaRecIDOld = int.Parse(ddlAreaRecIDOld.SelectedValue);
                    aff.SpecialityIDOld = int.Parse(ddlSpecialityIDOld.SelectedValue);
                    aff.EntityTypeIDOld = int.Parse(DropDownList1Old.SelectedValue);
                    aff.NoOfPatientsOld = ddlNoOfPatientsOld.SelectedValue;
                    aff.WatingTimeOld = ddlWatingTimeOld.SelectedValue;
                    aff.PrescriptionHappitOld = ddlPrescriptionHappitOld.SelectedValue;
                    aff.RequestDate = DateTime.Parse(txtRequestDate.Text);


                    if (rbSMApprove.Checked == true)
                    {
                        aff.SM_Approved = true;
                        aff.Status = "Sales Director";
                    }
                    if (rbSDApprove.Checked == true)
                    {
                        aff.SD_Approved = true;
                        aff.Status = "Commercial Director";
                    }
                    if (rbCOApprove.Checked == true)
                    {
                        aff.COVP_Approved = true;
                        aff.Status = "Approved";
                    }

                    if (rbSMApprove.Checked == false)
                    {
                        aff.Status = "Rejected";
                    }
                    if (rbSDApprove.Checked == false)
                    {
                        aff.Status = "Rejected";
                    }
                    if (rbCOApprove.Checked == false)
                    {
                        aff.Status = "Rejected";
                    }
                    if (cbIsApproved.Checked == true)
                    {
                        aff.Is_Approved = true;
                        aff.Status = "Administrator Review";
                    }
                    if (cbRejected.Checked == true)
                    {
                        aff.Is_Approved = null;
                        aff.Status = "Rejected";
                    }
                    if (cbimplemented.Checked == true)
                    {
                        aff.Is_Implemented = true;
                        aff.Status = "Sales Manager";
                    }
                    if (cbNotImplement.Checked == true)
                    {
                        aff.Is_Implemented = null;
                        aff.Is_Approved = null;
                        aff.Status = "Rejected";
                    }



                    if ((Session["EmployeeType"]).ToString() == "Rep")
                    {
                        int EmpID = int.Parse(Session["EmployeeID"].ToString());
                        using (EmployeesViewDBContext db = new EmployeesViewDBContext())
                        {
                            View_Employees EmpData = (from Emp_tbl in db.View_Employees where Emp_tbl.EmployeeID == EmpID select Emp_tbl).FirstOrDefault();
                            aff.DMID = EmpData.DirectManagerID;
                            aff.SMID = EmpData.TopManagerID;
                            aff.SDID = EmpData.DirectorID;
                            aff.COVP_ID = EmpData.ComDirID;
                            aff.Status = "District Manager";

                        }

                    }

                    newaff.Affiliations_Proposed.Add(aff);
                    int roweffected = newaff.SaveChanges();
                    if (roweffected > 0)
                    {
                        affiliationslblSaveStatus.Text = "Saved";
                        //ECMS_Mailing("jezzat@amoun.com", "jezzat@amoun.com", "Update DM", "Update DM");
                        DropDownList2.SelectedIndex = -1;

                        gvAffiliations.DataSource = null;
                        gvAffiliations.DataBind();
                        lblSpecialityReq.Visible = false;
                        lblAreaReq.Visible = false;
                        lblTelReq.Visible = false;
                        lblPhysicianReq.Visible = false;
                        lblEntityReq.Visible = false;
                        lblAddressReq.Visible = false;
                        lblClincTypeReq.Visible = false;
                        lblNoOfPatients.Visible = false;
                        lblPrescriptionHappit.Visible = false;
                        lblWatingTime.Visible = false;
                        lblDescriptionReq.Visible = false;
                        lblRequestTypeReq.Visible = false;

                        clearFields();
                        ddlRepAffiliations.Visible = false;
                        lblSelectAffiliation.Visible = false;

                        txtNewEntityID.Enabled = true;
                        txtNewPhysicianID.Enabled = true;
                        DropDownList1.Enabled = true;
                        ddlSpecialityID.Enabled = true;

                        txtNewEntityIDOld.Visible = false;
                        txtNewPhysicianIDOld.Visible = false;
                        txtClinicAddressOld.Visible = false;
                        lblClinicAddressOld.Visible = false;

                        ddlAreaRecIDOld.Visible = false;
                        lblOldBrick.Visible = false;

                        ddlSpecialityIDOld.Visible = false;
                        DropDownList1Old.Visible = false;
                        lblOldEntityType.Visible = false;

                        ddlNoOfPatientsOld.Visible = false;
                        lblNoOfPatientsOld.Visible = false;

                        ddlWatingTimeOld.Visible = false;
                        lblWatingTimeOld.Visible = false;

                        ddlPrescriptionHappitOld.Visible = false;
                        lblPrescriptionHabitOld.Visible = false;


                    }
                    else
                    {
                        affiliationslblSaveStatus.Text = "Error";
                    }
                }
                Loadaffiliations();
            }
            else
            {
                if (cbNotImplement.Checked == true)
                {
                    lblAdminCommentReq.Visible = true;
                }
                if (cbRejected.Checked == true)
                {
                    lblDmCommentReq.Visible = true;
                }
                //if (ddlWatingTime.SelectedIndex == 0)
                //{
                //    lblWatingTime.Visible = true;
                //}
                if (ddlPrescriptionHappit.SelectedIndex == 0)
                {
                    lblPrescriptionHappit.Visible = true;
                }
                if (ddlNoOfPatients.SelectedIndex == 0)
                {
                    lblNoOfPatients.Visible = true;
                }
                if (DropDownList1.SelectedIndex == 0)
                {
                    lblClincTypeReq.Visible = true;
                }
                if (ddlAreaRecID.SelectedIndex == 0)
                {
                    lblAreaReq.Visible = true;
                }
                if (txtNewPhysicianID.Text == "")
                {
                    lblPhysicianReq.Visible = true;
                }
                if (txtNewEntityID.Text == "")
                {
                    lblEntityReq.Visible = true;
                }
                if (ddlSpecialityID.SelectedIndex == 0)
                {
                    lblSpecialityReq.Visible = true;
                }

                if (txtClinicAddress.Text == "")
                {
                    lblAddressReq.Visible = true;
                }
                //if (txtTel1.Text == "")
                //{
                //    lblTelReq.Visible = true;
                //}
                affiliationslblSaveStatus.Text = "All Fields with red(*) is mandatory";
            }
        }
        public void ECMS_Mailing(string fromMail, string toMail, string subjectText, string bodyText)
        {
            MailMessage mail = new MailMessage();
            mail.To.Add(toMail);
            mail.From = new MailAddress(fromMail);
            mail.Subject = subjectText;
            mail.Body = bodyText;
            mail.Priority = MailPriority.High;

            SmtpClient smtp = new SmtpClient();
            smtp.Host = "mail.amoun.com"; //Or Your SMTP Server Address
            smtp.Port = 25;
            smtp.UseDefaultCredentials = false;
            //smtp.Credentials = new System.Net.NetworkCredential("jezzat", "P@ssw0rd1");
            smtp.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;

            smtp.EnableSsl = true;
            ServicePointManager.ServerCertificateValidationCallback = delegate (object s, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors) { return true; };
            smtp.Send(mail);
        }


        protected void gvAffiliations_SelectedIndexChanged(object sender, EventArgs e)
        {

            ddlNoOfPatients.AppendDataBoundItems = false;
            ddlPrescriptionHappit.AppendDataBoundItems = false;
            ddlWatingTime.AppendDataBoundItems = false;

            ddlNoOfPatientsOld.DataBind();
            ddlWatingTimeOld.DataBind();
            ddlPrescriptionHappitOld.DataBind();
            ddlNoOfPatients.DataBind();
            ddlWatingTime.DataBind();
            ddlPrescriptionHappit.DataBind();


            if ((Session["EmployeeType"].ToString() != "Rep"))
            {
                DropDownList2.Enabled = false;
                btnDelete.Visible = false;
                ddlRepAffiliations.Enabled = false;
            }
            if ((Session["EmployeeType"].ToString() == "Rep"))
            {
                DropDownList2.Enabled = false;

                btnDelete.Visible = true;
                cbimplemented.Enabled = false;
                cbNotImplement.Enabled = false;

            }
            Panel1.Visible = true;

            affiliationslblSaveStatus.Text = "";
            btnUpdate.Visible = true;

            btnSave.Visible = false;
            saveorupdate();
            phyRow = gvAffiliations.SelectedRow;
            if (Session["EmployeeType"].ToString() == "Admin" && phyRow.Cells[56].Text.Replace("&nbsp;", "") == "Approved")
            {
                cbProccedBy.Enabled = true;
                cbimplemented.Enabled = false;
                cbNotImplement.Enabled = false;
                txtAdminComments.Enabled = false;
            }
            else if (Session["EmployeeType"].ToString() == "Admin" && phyRow.Cells[56].Text.Replace("&nbsp;", "") != "Approved")
            {
                cbProccedBy.Enabled = false;
                cbimplemented.Enabled = true;
                cbNotImplement.Enabled = true;

            }
            if ((Session["EmployeeType"].ToString() == "Rep") && phyRow.Cells[56].Text.Replace("&nbsp;", "") != "District Manager")
            {
                btnUpdate.Visible = false;
                btnDelete.Visible = false;
                txtAffiliationID.Enabled = false;
                txtAffiliationName.Enabled = false;
                txtBestTimeFrom.Enabled = false;
                txtBestTimeTo.Enabled = false;
                txtNotes.Enabled = false;
                ddlSpecialityID.Enabled = false;
                txtNewEntityID.Enabled = false;
                txtNewPhysicianID.Enabled = false;
                ddlLineID.Enabled = false;
                ddlAreaRecID.Enabled = false;
                txtClinicAddress.Enabled = false;
                DropDownList1.Enabled = false;
                ddlNoOfPatients.Enabled = false;
                ddlPrescriptionHappit.Enabled = false;
                ddlWatingTime.Enabled = false;
                txtTel1.Enabled = false;
                txtTel2.Enabled = false;
                txtTel3.Enabled = false;
                txtFax.Enabled = false;
                txtEmailAddress.Enabled = false;
                txtWebSite.Enabled = false;
                ddlLineID.Enabled = false;
                txtDescription.Enabled = false;
                ddlRepAffiliations.Enabled = false;
                lblSelectAffiliation.Visible = false;
                DropDownList2.Enabled = false;
            }
            else if ((Session["EmployeeType"].ToString() == "Rep") && phyRow.Cells[56].Text.Replace("&nbsp;", "") == "District Manager")
            {
                btnUpdate.Visible = true;
                txtAffiliationID.Enabled = true;
                txtAffiliationName.Enabled = true;
                txtBestTimeFrom.Enabled = true;
                txtBestTimeTo.Enabled = true;
                txtNotes.Enabled = true;
                ddlSpecialityID.Enabled = true;
                txtNewEntityID.Enabled = true;
                txtNewPhysicianID.Enabled = true;
                ddlLineID.Enabled = false;
                ddlAreaRecID.Enabled = true;
                txtClinicAddress.Enabled = true;
                DropDownList1.Enabled = true;
                ddlNoOfPatients.Enabled = true;
                ddlPrescriptionHappit.Enabled = true;
                ddlWatingTime.Enabled = true;
                txtTel1.Enabled = true;
                txtTel2.Enabled = true;
                txtTel3.Enabled = true;
                txtFax.Enabled = true;
                txtEmailAddress.Enabled = true;
                txtWebSite.Enabled = true;
                txtDescription.Enabled = true;
                ddlRepAffiliations.Enabled = false;
                lblSelectAffiliation.Visible = false;

                DropDownList2.Enabled = false;

            }
            txtAffiliationID.Text = phyRow.Cells[57].Text.Replace("&nbsp;", "");
            txtAffiliationName.Text = phyRow.Cells[2].Text.Replace("&nbsp;", "");
            txtBestTimeFrom.Text = phyRow.Cells[9].Text.Replace("&nbsp;", "");
            txtBestTimeTo.Text = phyRow.Cells[10].Text.Replace("&nbsp;", "");
            txtNotes.Text = phyRow.Cells[11].Text.Replace("&nbsp;", "");
            txtNewEntityID.Text = phyRow.Cells[25].Text.Replace("&nbsp;", "");
            txtNewPhysicianID.Text = phyRow.Cells[24].Text.Replace("&nbsp;", "");
            ddlLineID.SelectedValue = phyRow.Cells[7].Text.Replace("&nbsp;", "");
            ddlAreaRecID.SelectedValue = phyRow.Cells[29].Text.Replace("&nbsp;", "");
            txtBrickID.Text = phyRow.Cells[29].Text.Replace("&nbsp;", "");
            //txtNewEntityID.Enabled = false;
            //txtNewPhysicianID.Enabled = false;
            txtClinicAddress.Text = phyRow.Cells[16].Text.Replace("&nbsp;", "");
            DropDownList1.SelectedValue = (phyRow.Cells[17].Text.Replace("&nbsp;", "")).ToString();
            txtTel1.Text = phyRow.Cells[18].Text.Replace("&nbsp;", "");
            txtTel2.Text = phyRow.Cells[19].Text.Replace("&nbsp;", "");
            txtTel3.Text = phyRow.Cells[20].Text.Replace("&nbsp;", "");
            txtFax.Text = phyRow.Cells[21].Text.Replace("&nbsp;", "");
            txtEmailAddress.Text = phyRow.Cells[22].Text.Replace("&nbsp;", "");
            txtWebSite.Text = phyRow.Cells[23].Text.Replace("&nbsp;", "");
            ddlSpecialityID.SelectedValue = phyRow.Cells[6].Text;
            ddlWatingTime.SelectedValue = phyRow.Cells[31].Text;
            if (phyRow.Cells[30].Text != "0")
            {
                ddlNoOfPatients.SelectedValue = phyRow.Cells[30].Text;

            }
            if (phyRow.Cells[32].Text != "0")
            {
                ddlPrescriptionHappit.SelectedValue = phyRow.Cells[32].Text;

            }
            txtAdminComments.Text = phyRow.Cells[33].Text.Replace("&nbsp;", "");
            txtDMComments.Text = phyRow.Cells[34].Text.Replace("&nbsp;", "");
            DropDownList2.SelectedValue = phyRow.Cells[35].Text.Replace("&nbsp;", "");
            txtDescription.Text = phyRow.Cells[36].Text.Replace("&nbsp;", "");
            txtNewEntityIDOld.Text = phyRow.Cells[37].Text.Replace("&nbsp;", "");
            txtNewPhysicianIDOld.Text = phyRow.Cells[38].Text.Replace("&nbsp;", "");
            txtClinicAddressOld.Text = phyRow.Cells[39].Text.Replace("&nbsp;", "");
            ddlAreaRecIDOld.SelectedValue = phyRow.Cells[40].Text.Replace("&nbsp;", "");
            txtBrickID.Text = phyRow.Cells[29].Text.Replace("&nbsp;", "");

            ddlSpecialityIDOld.SelectedValue = phyRow.Cells[41].Text;
            DropDownList1Old.SelectedValue = (phyRow.Cells[42].Text.Replace("&nbsp;", "")).ToString();
            ddlNoOfPatientsOld.SelectedValue = phyRow.Cells[43].Text;
            ddlWatingTimeOld.SelectedValue = phyRow.Cells[44].Text;
            ddlPrescriptionHappitOld.SelectedValue = phyRow.Cells[45].Text;
            txtRequestDate.Text = (phyRow.Cells[63].Text.Replace("&nbsp;", "")).ToString();


            txtDMName.Text = (phyRow.Cells[58].Text.Replace("&nbsp;", "")).ToString();
            txtDMComments.Text = (phyRow.Cells[34].Text.Replace("&nbsp;", "")).ToString();
            txtDMDate.Text = (phyRow.Cells[64].Text.Replace("&nbsp;", "")).ToString();

            txtAdminName.Text = (phyRow.Cells[62].Text.Replace("&nbsp;", "")).ToString();
            txtAdminComments.Text = (phyRow.Cells[33].Text.Replace("&nbsp;", "")).ToString();
            txtAdminDate.Text = (phyRow.Cells[68].Text.Replace("&nbsp;", "")).ToString();

            txtSMName.Text = (phyRow.Cells[59].Text.Replace("&nbsp;", "")).ToString();
            txtSMComments.Text = (phyRow.Cells[53].Text.Replace("&nbsp;", "")).ToString();
            txtSMDate.Text = (phyRow.Cells[65].Text.Replace("&nbsp;", "")).ToString();

            txtSDName.Text = (phyRow.Cells[60].Text.Replace("&nbsp;", "")).ToString();
            txtSDComments.Text = (phyRow.Cells[54].Text.Replace("&nbsp;", "")).ToString();
            txtSDDate.Text = (phyRow.Cells[66].Text.Replace("&nbsp;", "")).ToString();

            txtCOMangerName.Text = (phyRow.Cells[61].Text.Replace("&nbsp;", "")).ToString();
            txtCOComments.Text = (phyRow.Cells[55].Text.Replace("&nbsp;", "")).ToString();
            txtCOMangerDate.Text = (phyRow.Cells[67].Text.Replace("&nbsp;", "")).ToString();
            txtProccedByName.Text = (phyRow.Cells[69].Text.Replace("&nbsp;", "")).ToString();
            txtProccedByDate.Text = (phyRow.Cells[70].Text.Replace("&nbsp;", "")).ToString();

            if (txtDMName.Text != "" && phyRow.Cells[56].Text != "Rejected" || (phyRow.Cells[56].Text == "Rejected" && txtAdminName.Text != "")) //DM Approved
            {
                cbIsApproved.Checked = true;
            }
            else if (txtDMName.Text != "" && phyRow.Cells[56].Text == "Rejected" && txtAdminName.Text == "")
            {
                cbRejected.Checked = true;
            }

            if (txtAdminName.Text != "" && phyRow.Cells[56].Text != "Rejected" || (phyRow.Cells[56].Text == "Rejected" && txtSMName.Text != ""))//Admin Approved
            {
                cbimplemented.Checked = true;
            }
            else if (txtAdminName.Text != "" && phyRow.Cells[56].Text == "Rejected" && txtSMName.Text == "")
            {
                cbNotImplement.Checked = true;
            }
            if (txtSMName.Text != "" && phyRow.Cells[56].Text != "Rejected" || (phyRow.Cells[56].Text == "Rejected" && txtSDName.Text != ""))//SM Approved
            {
                rbSMApprove.Checked = true;
            }
            else if (txtSMName.Text != "" && phyRow.Cells[56].Text == "Rejected" && txtSDName.Text == "")
            {
                rpSMReject.Checked = true;
            }
            if (txtSDName.Text != "" && phyRow.Cells[56].Text != "Rejected" || (phyRow.Cells[56].Text == "Rejected" && txtCOMangerName.Text != ""))//SD Approved
            {
                rbSDApprove.Checked = true;
            }
            else if (txtSDName.Text != "" && phyRow.Cells[56].Text == "Rejected" && txtCOMangerName.Text == "")
            {
                rbSDReject.Checked = true;
            }
            if (txtCOMangerName.Text != "" && phyRow.Cells[56].Text != "Rejected" || (phyRow.Cells[56].Text == "Rejected" && txtProccedByName.Text != ""))//CO Approved
            {
                rbCOApprove.Checked = true;
            }
            else if (txtCOMangerName.Text != "" && phyRow.Cells[56].Text == "Rejected" && txtProccedByName.Text == "")
            {
                rbCOReject.Checked = true;
            }
            if (txtProccedByName.Text != "" && phyRow.Cells[56].Text == "In Progress")
            {
                cbProccedBy.Checked = true;
            }




            if (DropDownList2.SelectedValue == "Delete")
            {
                txtNewEntityID.Visible = false;
                txtNewPhysicianID.Visible = false;
                ddlRepAffiliations.Visible = false;
                lblSelectAffiliation.Visible = false;
                ddlSpecialityIDOld.Visible = false;
                txtNewEntityIDOld.Visible = true;
                txtNewPhysicianIDOld.Visible = true;
                txtClinicAddressOld.Visible = false;
                lblClinicAddressOld.Visible = false;

                ddlAreaRecIDOld.Visible = false;
                lblOldBrick.Visible = false;

                ddlSpecialityIDOld.Visible = false;
                DropDownList1Old.Visible = false;
                lblOldEntityType.Visible = false;

                ddlNoOfPatientsOld.Visible = false;
                lblNoOfPatientsOld.Visible = false;

                ddlWatingTimeOld.Visible = false;
                lblWatingTimeOld.Visible = false;

                ddlPrescriptionHappitOld.Visible = false;
                lblPrescriptionHabitOld.Visible = false;


            }
            if (DropDownList2.SelectedValue == "New" || DropDownList2.SelectedValue == "Select")
            {
                ddlRepAffiliations.Visible = false;
                lblSelectAffiliation.Visible = false;
                txtNewEntityID.Visible = true;
                txtNewPhysicianID.Visible = true;
                //txtNewEntityID.Enabled = true;
                //txtNewPhysicianID.Enabled = true;
                //DropDownList1.Enabled = true;
                //ddlSpecialityID.Enabled = true;

                txtNewEntityIDOld.Visible = false;
                txtNewPhysicianIDOld.Visible = false;
                txtClinicAddressOld.Visible = false;
                lblClinicAddressOld.Visible = false;

                ddlAreaRecIDOld.Visible = false;
                lblOldBrick.Visible = false;

                ddlSpecialityIDOld.Visible = false;
                DropDownList1Old.Visible = false;
                lblOldEntityType.Visible = false;

                ddlNoOfPatientsOld.Visible = false;
                lblNoOfPatientsOld.Visible = false;

                ddlWatingTimeOld.Visible = false;
                lblWatingTimeOld.Visible = false;

                ddlPrescriptionHappitOld.Visible = false;
                lblPrescriptionHabitOld.Visible = false;

            }
            if (DropDownList2.SelectedValue == "Update")
            {
                ddlRepAffiliations.Visible = false;
                lblSelectAffiliation.Visible = false;

                txtNewEntityIDOld.Visible = true;
                txtNewPhysicianIDOld.Visible = true;
                txtClinicAddressOld.Visible = true;
                lblClinicAddressOld.Visible = true;
                ddlSpecialityIDOld.Visible = false;

                ddlAreaRecIDOld.Visible = true;
                lblOldBrick.Visible = true;

                DropDownList1Old.Visible = true;
                lblOldEntityType.Visible = true;

                ddlNoOfPatientsOld.Visible = true;
                lblNoOfPatientsOld.Visible = true;

                ddlWatingTimeOld.Visible = true;
                lblWatingTimeOld.Visible = true;

                ddlPrescriptionHappitOld.Visible = true;
                lblPrescriptionHabitOld.Visible = true;

                txtNewEntityID.Enabled = false;
                txtNewPhysicianID.Enabled = false;

                txtNewEntityID.Visible = false;
                txtNewPhysicianID.Visible = false;


            }


        }


        protected void ddlLineID_SelectedIndexChanged(object sender, EventArgs e)
        {

        }



        private void saveorupdate()
        {
            if (btnUpdate.Visible == false)
            {

            }
            else if (btnUpdate.Visible == true)
            {
                cbIsApproved.Checked = false;
                cbRejected.Checked = false;
                cbimplemented.Checked = false;
                cbNotImplement.Checked = false;
                rbSMApprove.Checked = false;
                rpSMReject.Checked = false;
                rbSDApprove.Checked = false;
                rbSDReject.Checked = false;
                rbCOApprove.Checked = false;
                rbCOReject.Checked = false;
                cbProccedBy.Checked = false;
            }
        }



        protected void LineDataSource_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
        }

        protected void rbPhyCode_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void EntityTypeDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }

        protected void ddlAreaRecID_SelectedIndexChanged(object sender, EventArgs e)
        {

        }





        protected void gvAffiliations_RowCreated(object sender, GridViewRowEventArgs e)
        {
            GridViewRow gvr = e.Row;
            if (gvr.RowType == DataControlRowType.Header)
            {
                gvr.Cells[2].Text = "Name";
                gvr.Cells[7].Text = "Line";
                //gvr.Cells[16].Text = "Address";
                //gvr.Cells[24].Text = "Doctor Name";
                gvr.Cells[25].Text = "Clinic Name";
                //gvr.Cells[30].Text = "No. of Patients";
                //gvr.Cells[31].Text = "Waiting Time";
                //gvr.Cells[32].Text = "Prescription Habit";
                //gvr.Cells[33].Text = "Admin Comments";
                //gvr.Cells[34].Text = "DM Comments";
                gvr.Cells[35].Text = "Request Type";
                gvr.Cells[63].Text = "Request Date";

            }
            e.Row.Cells[24].Visible = false;
            e.Row.Cells[30].Visible = false;
            e.Row.Cells[31].Visible = false;
            e.Row.Cells[32].Visible = false;
            e.Row.Cells[33].Visible = false;
            e.Row.Cells[34].Visible = false;
            e.Row.Cells[1].Visible = false;
            e.Row.Cells[3].Visible = false;
            e.Row.Cells[4].Visible = false;
            e.Row.Cells[5].Visible = false;
            e.Row.Cells[6].Visible = false;
            e.Row.Cells[8].Visible = false;
            e.Row.Cells[9].Visible = false;
            e.Row.Cells[10].Visible = false;
            e.Row.Cells[11].Visible = false;
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
            e.Row.Cells[23].Visible = false;
            e.Row.Cells[26].Visible = false;
            //e.Row.Cells[27].Visible = false;
            e.Row.Cells[28].Visible = false;
            e.Row.Cells[29].Visible = false;
            e.Row.Cells[36].Visible = false;
            e.Row.Cells[37].Visible = false;
            e.Row.Cells[38].Visible = false;
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
            e.Row.Cells[54].Visible = false;
            e.Row.Cells[55].Visible = false;
            e.Row.Cells[56].Visible = false;
            e.Row.Cells[57].Visible = false;
            e.Row.Cells[58].Visible = false;
            e.Row.Cells[59].Visible = false;
            e.Row.Cells[60].Visible = false;
            e.Row.Cells[61].Visible = false;
            e.Row.Cells[62].Visible = false;
            e.Row.Cells[63].Visible = false;
            e.Row.Cells[64].Visible = false;
            e.Row.Cells[65].Visible = false;
            e.Row.Cells[66].Visible = false;
            e.Row.Cells[67].Visible = false;
            e.Row.Cells[68].Visible = false;
            e.Row.Cells[69].Visible = false;
            e.Row.Cells[70].Visible = false;
            e.Row.Cells[71].Visible = false;




        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if ((Session["EmployeeType"].ToString() == "Admin") && (cbNotImplement.Checked == true) && (txtAdminComments.Text == ""))
            {
                lblAdminCommentReq.Visible = true;
                affiliationslblSaveStatus.Text = "All Fields with red(*) is mandatory";
                return;
            }
            if ((Session["EmployeeType"].ToString() == "DM") && (cbRejected.Checked == true) && (txtDMComments.Text == ""))
            {
                lblDmCommentReq.Visible = true;
                affiliationslblSaveStatus.Text = "All Fields with red(*) is mandatory";
                return;
            }
            if (txtNewPhysicianID.Text != "" && txtNewEntityID.Text != "" && ddlSpecialityID.SelectedIndex != 0 && txtClinicAddress.Text != "")
            {
                using (ProposedAffiliationDBContext db = new ProposedAffiliationDBContext())
                {

                    int ID = int.Parse(txtAffiliationID.Text);
                    Affiliations_Proposed updateProAff = (from ProAff_tbl in db.Affiliations_Proposed where ProAff_tbl.RecID == ID && ProAff_tbl.Deleted == null select ProAff_tbl).FirstOrDefault();
                    if ((Session["EmployeeType"]).ToString() == "Rep")
                    {
                        updateProAff.Description = txtDescription.Text;
                        updateProAff.Is_Approved = null;
                        updateProAff.PhysicianName = txtNewPhysicianID.Text;
                        updateProAff.EntityName = txtNewEntityID.Text;
                        updateProAff.AreaRecID = int.Parse(Session["AreaID"].ToString());
                        updateProAff.LineID = int.Parse(Session["LineID"].ToString());
                        updateProAff.EmployeeID = int.Parse(Session["EmployeeID"].ToString());
                        updateProAff.RepName = Session["EmployeeName"].ToString();
                        updateProAff.SpecialityID = int.Parse(ddlSpecialityID.SelectedValue);
                        updateProAff.BestTimeFrom = txtBestTimeFrom.Text;
                        updateProAff.BestTimeTo = txtBestTimeTo.Text;
                        updateProAff.Notes = txtNotes.Text;
                        updateProAff.EntityAddress = txtClinicAddress.Text;
                        updateProAff.EntityTypeID = int.Parse(DropDownList1.SelectedValue);
                        updateProAff.Tel1 = txtTel1.Text;
                        updateProAff.Tel2 = txtTel2.Text;
                        updateProAff.Tel3 = txtTel3.Text;
                        updateProAff.Fax = txtFax.Text;
                        updateProAff.EntityEmailAddress = txtEmailAddress.Text;
                        updateProAff.EntityWebSite = txtWebSite.Text;
                        updateProAff.BrickID = int.Parse(ddlAreaRecID.SelectedValue);
                        updateProAff.NoOfPatients = ddlNoOfPatients.SelectedValue;
                        updateProAff.WatingTime = ddlWatingTime.SelectedValue;
                        updateProAff.PrescriptionHappit = ddlPrescriptionHappit.SelectedValue;
                        updateProAff.EntityNameOld = txtNewEntityIDOld.Text;
                        updateProAff.PhysicianNameOld = txtNewPhysicianIDOld.Text;
                        updateProAff.EntityAddressOld = txtClinicAddressOld.Text;
                        updateProAff.AreaRecIDOld = int.Parse(ddlAreaRecIDOld.SelectedValue);
                        updateProAff.SpecialityIDOld = int.Parse(ddlSpecialityIDOld.SelectedValue);
                        updateProAff.EntityTypeIDOld = int.Parse(DropDownList1Old.SelectedValue);
                        updateProAff.NoOfPatientsOld = ddlNoOfPatientsOld.SelectedValue;
                        updateProAff.WatingTimeOld = ddlWatingTimeOld.SelectedValue;
                        updateProAff.PrescriptionHappitOld = ddlPrescriptionHappitOld.SelectedValue;
                        int EmpID = int.Parse(Session["EmployeeID"].ToString());
                        using (EmployeesViewDBContext Empdb = new EmployeesViewDBContext())
                        {
                            View_Employees EmpData = (from Emp_tbl in Empdb.View_Employees where Emp_tbl.EmployeeID == EmpID select Emp_tbl).FirstOrDefault();
                            updateProAff.DMID = EmpData.DirectManagerID;
                        }
                    }
                    updateProAff.AdminComments = txtAdminComments.Text;
                    updateProAff.DMComments = txtDMComments.Text;

                    if (cbIsApproved.Checked == true)
                    {
                        updateProAff.Is_Approved = true;
                        updateProAff.Status = txtStatus.Text;
                        updateProAff.DMSignature = txtDMName.Text;
                        updateProAff.DMDate = DateTime.Parse(txtDMDate.Text);

                    }
                    if (cbRejected.Checked == true)
                    {
                        updateProAff.Is_Approved = null;
                        updateProAff.Status = txtStatus.Text;
                        updateProAff.DMSignature = txtDMName.Text;
                        updateProAff.DMDate = DateTime.Parse(txtDMDate.Text);
                    }

                    if (cbimplemented.Checked == true)
                    {
                        updateProAff.Is_Implemented = true;
                        updateProAff.Status = txtStatus.Text;
                        updateProAff.AdminSignature = txtAdminName.Text;
                        updateProAff.AdminDate = DateTime.Parse(txtAdminDate.Text);

                    }
                    if (cbNotImplement.Checked == true)
                    {
                        updateProAff.Is_Implemented = null;
                        updateProAff.Is_Approved = null;
                        updateProAff.Status = txtStatus.Text;
                        updateProAff.AdminSignature = txtAdminName.Text;
                        updateProAff.AdminDate = DateTime.Parse(txtAdminDate.Text);

                    }
                    if (rbSMApprove.Checked == true)
                    {

                        updateProAff.Status = txtStatus.Text;
                        updateProAff.SM_Approved = true;
                        //updateProAff.Status = txtStatus.Text;
                        updateProAff.SMSignature = txtSMName.Text;
                        updateProAff.SMDate = DateTime.Parse(txtSMDate.Text);

                    }
                    if (rpSMReject.Checked == true)
                    {
                        updateProAff.Status = txtStatus.Text;
                        updateProAff.SMSignature = txtSMName.Text;
                        updateProAff.SMDate = DateTime.Parse(txtSMDate.Text);


                    }
                    if (rbSDApprove.Checked == true)
                    {
                        updateProAff.SD_Approved = true;
                        updateProAff.Status = txtStatus.Text;
                        updateProAff.SDSignature = txtSDName.Text;
                        updateProAff.SDDate = DateTime.Parse(txtSDDate.Text);


                    }
                    if (rbSDReject.Checked == true)
                    {
                        updateProAff.Status = txtStatus.Text;
                        updateProAff.SDSignature = txtSDName.Text;
                        updateProAff.SDDate = DateTime.Parse(txtSDDate.Text);
                    }


                    if (rbCOApprove.Checked == true)
                    {
                        updateProAff.COVP_Approved = true;
                        updateProAff.Status = txtStatus.Text;
                        updateProAff.COSignature = txtCOMangerName.Text;
                        updateProAff.CODate = DateTime.Parse(txtCOMangerDate.Text);
                    }


                    if (rbCOReject.Checked == true)
                    {
                        updateProAff.Status = txtStatus.Text;
                        updateProAff.COSignature = txtCOMangerName.Text;
                        updateProAff.CODate = DateTime.Parse(txtCOMangerDate.Text);
                    }
                    if (cbProccedBy.Checked == true)
                    {
                        updateProAff.Status = txtStatus.Text;
                        updateProAff.ProceedBySignature = txtProccedByName.Text;
                        updateProAff.ProceedByDate = DateTime.Parse(txtProccedByDate.Text);
                    }



                    int roweffected = db.SaveChanges();
                    if (roweffected > 0)
                    {
                        affiliationslblSaveStatus.Text = "Updated";
                        lblPhysicianReq.Visible = false;
                        lblEntityReq.Visible = false;
                        gvAffiliations.DataSource = null;
                        gvAffiliations.DataBind();
                        lblSpecialityReq.Visible = false;
                        DropDownList2.SelectedIndex = -1;
                        if ((Session["EmployeeType"]).ToString() == "Rep")
                        {
                            btnSave.Visible = true;
                            btnUpdate.Visible = false;
                            RefreshScreen();
                        }
                        else
                        {
                            Panel1.Visible = false;
                        }

                        clearFields();
                    }
                    else
                    {
                        affiliationslblSaveStatus.Text = "Error";
                    }

                }

                Loadaffiliations();

            }
            else
            {



                if (txtNewPhysicianID.Text == "")
                {
                    lblPhysicianReq.Visible = true;
                }
                if (txtNewEntityID.Text == "")
                {
                    lblEntityReq.Visible = true;
                }
                if (ddlSpecialityID.SelectedIndex == 0)
                {
                    lblSpecialityReq.Visible = true;
                }

                if (txtClinicAddress.Text == "")
                {
                    lblAddressReq.Visible = true;
                }
                //if (txtTel1.Text == "")
                //{
                //    lblTelReq.Visible = true;
                //}
                affiliationslblSaveStatus.Text = "All Fields with red(*) is mandatory";


            }
        }


        protected void cbIsApproved_CheckedChanged(object sender, EventArgs e)
        {
            if (cbIsApproved.Checked == true)
            {
                cbRejected.Checked = false;
            }

        }

        protected void cbRejected_CheckedChanged(object sender, EventArgs e)
        {
            if (cbRejected.Checked == true)
            {
                cbIsApproved.Checked = false;
            }
        }

        protected void RadioButton1_CheckedChanged(object sender, EventArgs e)
        {
            txtDMName.Text = Session["EmployeeNameFromDM"].ToString();
            txtDMDate.Text = DateTime.Today.ToString();

            txtStatus.Text = "Administrator Review";

        }

        protected void RadioButton1_CheckedChanged1(object sender, EventArgs e)
        {
            txtAdminName.Text = Session["EmployeeNameFromAdmin"].ToString();
            txtAdminDate.Text = DateTime.Today.ToString();

            phyRow = gvAffiliations.SelectedRow;

            SqlCommand Repcmd = new SqlCommand("SELECT * FROM [AmounCRM2].[dbo].[View_Employees] where EmployeeID=" + phyRow.Cells[13].Text, con);
            SqlDataAdapter Repsda = new SqlDataAdapter(Repcmd);
            DataTable Empdt = new DataTable();
            Repsda.Fill(Empdt);
            string sdname = Empdt.Rows[0]["TopManagerName"].ToString();
            if (sdname.Contains("Vac") == true)
            {
                txtStatus.Text = "Sales Director";

            }
            else
            {
                txtStatus.Text = "Sales Manager";

            }


        }

        protected void cbNotImplement_CheckedChanged(object sender, EventArgs e)
        {
            txtAdminName.Text = Session["EmployeeNameFromAdmin"].ToString();
            txtAdminDate.Text = DateTime.Today.ToString();
            txtStatus.Text = "Rejected";
        }

        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownList2.SelectedValue == "Update" || DropDownList2.SelectedValue == "Accept")
            {
                //ddlRepAffiliations.Visible = true;
                cbSpec.Visible = true;
                cbAffs.Visible = true;
                cbClass.Visible = true;
                cbBricks.Visible = true;
                lblSelectAffiliation.Visible = true;
                txtNewEntityID.Enabled = false;
                txtNewPhysicianID.Enabled = false;

                txtNewEntityID.Visible = true;
                txtNewPhysicianID.Visible = true;
                DropDownList1.Enabled = false;
                ddlSpecialityID.Enabled = false;
                ddlNoOfPatientsOld.Enabled = false;
                ddlWatingTimeOld.Enabled = false;

                txtClinicAddressOld.Visible = true;
                lblClinicAddressOld.Visible = true;

                ddlAreaRecIDOld.Visible = true;
                lblOldBrick.Visible = true;

                ddlNoOfPatientsOld.Visible = true;
                lblNoOfPatientsOld.Visible = true;

                ddlWatingTimeOld.Visible = true;
                lblWatingTimeOld.Visible = true;

                ddlPrescriptionHappitOld.Visible = true;
                lblPrescriptionHabitOld.Visible = true;

            }

            if (DropDownList2.SelectedValue == "Delete")
            {

                txtNewEntityID.Enabled = false;
                txtNewPhysicianID.Enabled = false;

                txtNewEntityID.Visible = true;
                txtNewPhysicianID.Visible = true;
                ddlRepAffiliations.Visible = true;
                cbSpec.Visible = true;
                cbAffs.Visible = true;
                cbClass.Visible = true;
                cbBricks.Visible = true;
                lblSelectAffiliation.Visible = true;
                txtNewEntityIDOld.Visible = false;
                txtNewPhysicianIDOld.Visible = false;
                txtClinicAddressOld.Visible = false;
                lblClinicAddressOld.Visible = false;

                ddlAreaRecIDOld.Visible = false;
                ddlSpecialityIDOld.Visible = false;
                DropDownList1Old.Visible = false;
                lblOldEntityType.Visible = false;

                ddlNoOfPatientsOld.Visible = false;
                lblNoOfPatientsOld.Visible = false;

                ddlWatingTimeOld.Visible = false;
                lblWatingTimeOld.Visible = false;
                ddlPrescriptionHappitOld.Visible = false;
                lblPrescriptionHabitOld.Visible = false;

            }
            if (DropDownList2.SelectedValue == "New" || DropDownList2.SelectedValue == "Select")
            {
                ddlRepAffiliations.Visible = false;
                cbSpec.Visible = false;
                cbAffs.Visible = false;
                cbClass.Visible = false;
                cbBricks.Visible = false;
                lblSelectAffiliation.Visible = false;
                txtNewEntityID.Enabled = true;
                txtNewPhysicianID.Enabled = true;
                txtNewEntityID.Visible = true;
                txtNewPhysicianID.Visible = true;
                DropDownList1.Enabled = true;
                ddlSpecialityID.Enabled = true;
                txtNewEntityIDOld.Visible = false;
                txtNewPhysicianIDOld.Visible = false;
                txtClinicAddressOld.Visible = false;
                lblClinicAddressOld.Visible = false;

                ddlAreaRecIDOld.Visible = false;
                lblOldBrick.Visible = false;

                ddlSpecialityIDOld.Visible = false;
                DropDownList1Old.Visible = false;
                lblOldEntityType.Visible = false;

                ddlNoOfPatientsOld.Visible = false;
                lblNoOfPatientsOld.Visible = false;

                ddlWatingTimeOld.Visible = false;
                lblWatingTimeOld.Visible = false;

                ddlPrescriptionHappitOld.Visible = false;
                lblPrescriptionHabitOld.Visible = false;

            }

            clearFields();
            txtRequestDate.Text = DateTime.Today.ToString();

        }


        protected void ddlRepAffiliations_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (AffiliationsAdminViewDBContext db = new AffiliationsAdminViewDBContext())
            {
                int ID = int.Parse(ddlRepAffiliations.SelectedValue);
                int LineId = int.Parse(Session["LineID"].ToString());
                int EmpID = int.Parse(Session["EmployeeID"].ToString());
                var affiliationdata = (from affiliation_tbl in db.View_Affiliations_Admin where affiliation_tbl.AffiliationID == ID && (affiliation_tbl.Deleted == null || affiliation_tbl.Deleted == false) && affiliation_tbl.EmployeeID == EmpID && affiliation_tbl.LineID == LineId && affiliation_tbl.SpecialtyValue > 0 select affiliation_tbl).FirstOrDefault();

                txtAffiliationID.Text = affiliationdata.AffiliationID.ToString();
                txtAffiliationName.Text = affiliationdata.AffiliationName;
                txtBestTimeFrom.Text = affiliationdata.BestTimeFrom;
                txtBestTimeTo.Text = affiliationdata.BestTimeTo;
                txtNotes.Text = affiliationdata.Notes;

                txtNewEntityID.Text = affiliationdata.Entity_Name;
                txtNewEntityIDOld.Text = affiliationdata.Entity_Name;

                if (affiliationdata.Entity_Name == null)
                {
                    txtNewEntityID.Text = txtAffiliationName.Text;
                    txtNewEntityIDOld.Text = txtAffiliationName.Text;
                }

                txtNewPhysicianID.Text = affiliationdata.PhysicianName;
                txtNewPhysicianIDOld.Text = affiliationdata.PhysicianName;

                //ddlLineID.SelectedValue = affiliationdata.LineName;
                ddlAreaRecID.SelectedValue = affiliationdata.BrickID.ToString();
                ddlAreaRecIDOld.SelectedValue = affiliationdata.BrickID.ToString();

                //txtNewEntityID.Enabled = false;
                //txtNewPhysicianID.Enabled = false;
                txtClinicAddress.Text = affiliationdata.EntityAddress;
                txtClinicAddressOld.Text = affiliationdata.EntityAddress;

                DropDownList1.SelectedValue = affiliationdata.EntityTypeID.ToString();
                DropDownList1Old.SelectedValue = affiliationdata.EntityTypeID.ToString();

                txtTel1.Text = affiliationdata.Tel1;
                txtTel2.Text = affiliationdata.Tel2;
                txtTel3.Text = affiliationdata.Tel3;
                txtFax.Text = affiliationdata.Fax;
                txtEmailAddress.Text = affiliationdata.EntityEmailAddress;
                txtWebSite.Text = affiliationdata.EntityWebSite;
                ddlSpecialityID.SelectedValue = affiliationdata.SpecialtyID.ToString();
                ddlSpecialityIDOld.SelectedValue = affiliationdata.SpecialtyID.ToString();



                if (affiliationdata.PrescriptionHappit != 0)
                {
                    ddlPrescriptionHappit.SelectedValue = affiliationdata.PrescriptionHappit.ToString();

                }
                ddlPrescriptionHappitOld.DataBind();
                ddlPrescriptionHappitOld.SelectedValue = affiliationdata.PrescriptionHappit.ToString();
                ddlNoOfPatients.SelectedValue = affiliationdata.NoOfPatients.ToString();
                if (DropDownList2.SelectedValue != "Delete")
                {
                    ddlNoOfPatientsOld.SelectedValue = affiliationdata.NoOfPatients.ToString();
                    ddlWatingTimeOld.SelectedValue = affiliationdata.WaitingTime.ToString();

                }
                ddlWatingTime.SelectedValue = affiliationdata.WaitingTime.ToString();
                txtAffID.Text = ddlRepAffiliations.SelectedValue;
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {

            string confirmValue = Request.Form["confirm_value"];
            if (confirmValue == "Yes")
            {
                using (ProposedAffiliationDBContext db = new ProposedAffiliationDBContext())
                {

                    int ID = int.Parse(txtAffiliationID.Text);
                    Affiliations_Proposed DelProAff = (from ProAff_tbl in db.Affiliations_Proposed where ProAff_tbl.RecID == ID && ProAff_tbl.Deleted == null select ProAff_tbl).FirstOrDefault();
                    if ((Session["EmployeeType"]).ToString() == "Rep")
                    {
                        DelProAff.Deleted = true;


                        int roweffected = db.SaveChanges();
                        if (roweffected > 0)
                        {
                            affiliationslblSaveStatus.Text = "Deleted";
                            lblPhysicianReq.Visible = false;
                            lblEntityReq.Visible = false;
                            gvAffiliations.DataSource = null;
                            gvAffiliations.DataBind();
                            lblSpecialityReq.Visible = false;
                            RefreshScreen();

                            if ((Session["EmployeeType"]).ToString() == "Rep")
                            {
                                btnSave.Visible = true;
                                btnUpdate.Visible = false;
                            }
                            else
                            {
                                Panel1.Visible = false;
                            }

                            clearFields();
                        }
                        else
                        {
                            affiliationslblSaveStatus.Text = "Error";
                        }

                    }
                    Loadaffiliations();
                }
            }
            else
            {
                return;
            }

        }

        protected void txtNewPhysicianIDOld_TextChanged(object sender, EventArgs e)
        {

        }

        protected void cbRejected_CheckedChanged1(object sender, EventArgs e)
        {
            txtDMName.Text = Session["EmployeeNameFromDM"].ToString();
            txtStatus.Text = "Rejected";
            txtDMDate.Text = DateTime.Today.ToString();

        }

        protected void rbSMApprove_CheckedChanged(object sender, EventArgs e)
        {
            txtSMName.Text = Session["EmployeeNameFromSM"].ToString();
            txtSMDate.Text = DateTime.Today.ToString();
            phyRow = gvAffiliations.SelectedRow;

            SqlCommand Repcmd = new SqlCommand("SELECT * FROM [AmounCRM2].[dbo].[View_Employees] where EmployeeID=" + phyRow.Cells[13].Text, con);
            SqlDataAdapter Repsda = new SqlDataAdapter(Repcmd);
            DataTable Empdt = new DataTable();
            Repsda.Fill(Empdt);
            string sdname = Empdt.Rows[0]["DirectorName"].ToString();
            if (sdname.Contains("Vac") == true)
            {
                txtStatus.Text = "Commercial Director";

            }
            else
            {
                txtStatus.Text = "Sales Director";

            }




        }

        protected void rpSMReject_CheckedChanged(object sender, EventArgs e)
        {
            txtSMName.Text = Session["EmployeeNameFromSM"].ToString();
            txtSMDate.Text = DateTime.Today.ToString();
            txtStatus.Text = "Rejected";
        }

        protected void rbSDApprove_CheckedChanged(object sender, EventArgs e)
        {
            txtSDName.Text = Session["EmployeeNameFromDir"].ToString();
            txtSDDate.Text = DateTime.Today.ToString();

            phyRow = gvAffiliations.SelectedRow;

            SqlCommand Repcmd = new SqlCommand("SELECT * FROM [AmounCRM2].[dbo].[View_Employees] where EmployeeID=" + phyRow.Cells[13].Text, con);
            SqlDataAdapter Repsda = new SqlDataAdapter(Repcmd);
            DataTable Empdt = new DataTable();
            Repsda.Fill(Empdt);
            string sdname = Empdt.Rows[0]["ComDirName"].ToString();
            if (sdname.Contains("Vac") == true)
            {
                txtStatus.Text = "Approved";

            }
            else
            {
                txtStatus.Text = "Commercial Director";

            }

        }

        protected void rbSDReject_CheckedChanged(object sender, EventArgs e)
        {
            txtSDName.Text = Session["EmployeeNameFromDir"].ToString();
            txtSDDate.Text = DateTime.Today.ToString();
            txtStatus.Text = "Rejected";
        }

        protected void rbCOApprove_CheckedChanged(object sender, EventArgs e)
        {
            txtCOMangerName.Text = Session["EmployeeNameFromComDir"].ToString();
            txtStatus.Text = "Approved";
            txtCOMangerDate.Text = DateTime.Today.ToString(); ;
        }

        protected void rbCOReject_CheckedChanged(object sender, EventArgs e)
        {
            txtCOMangerName.Text = Session["EmployeeNameFromComDir"].ToString();
            txtCOMangerDate.Text = DateTime.Today.ToString();
            txtStatus.Text = "Rejected";
        }

        protected void cbProccedBy_CheckedChanged(object sender, EventArgs e)
        {
            txtProccedByName.Text = txtAdminName.Text = Session["EmployeeNameFromAdmin"].ToString();
            txtStatus.Text = "In Progress";
            txtProccedByDate.Text = DateTime.Today.ToString();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            RefreshScreen();
        }

        protected void cbBricks_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            try
            {
                string selectText = "SELECT Distinct AffiliationID, AffiliationName2, AffiliationName3, PhysicianClass, SpecialtyID, SpecialtyValue, TotalValue, BrickID FROM View_Affiliations_Scheduler WHERE (PhysicianClass IN ('A+', 'A') AND SpecialtyValue > 0 AND LastModifierID IS NOT NULL AND EmployeeID = " + int.Parse(Session["EmployeeID"].ToString()) + " AND LineID = " + int.Parse(Session["LineID"].ToString()) + ")";// + " AND CycleID = " + int.Parse(Session["CycleID"].ToString()) Dimmed to allow planning from not targeted
                //string selectText = "SELECT Distinct AffiliationID, AffiliationName2, PhysicianClass, SpecialtyID FROM View_Affiliations_Scheduler WHERE (RepAreaID = " + int.Parse(Session["AreaID"].ToString()) + " AND LineID = " + int.Parse(Session["LineID"].ToString()) + ")";

                if (DateTime.Now.Day <= int.Parse(Session["AllowedDaysForPlanning"].ToString()))
                {
                    //selectText += " AND [Is Targeted] = 'Targeted' AND (BrickID = @BrickID)";
                }

                if (cbBricks.SelectedIndex > 0)
                {
                    cbAffs.Items.Clear();


                    selectText += " AND (BrickID = @BrickID)";
                    dsAffsOut.SelectCommand = selectText;
                    dsAffsOut.SelectParameters[0].DefaultValue = cbBricks.SelectedValue;
                }

                if (cbClass.SelectedIndex > 0)
                {

                    selectText += " AND (PhysicianClass IN (@PhysicianClass))";
                    dsAffsOut.SelectCommand = selectText;
                    dsAffsOut.SelectParameters[1].DefaultValue = "'" + cbClass.SelectedValue + "'";
                }
                //else
                //{
                //    selectText += " AND (PhysicianClass IN (@PhysicianClass))";
                //    dsAffsOut.SelectCommand = selectText;
                //    dsAffsOut.SelectParameters[1].DefaultValue = "'A', 'B', 'C'";
                //}

                if (cbSpec.SelectedIndex > 0)
                {

                    selectText += " AND (SpecialtyID = @SpecialtyID)";
                    dsAffsOut.SelectCommand = selectText;
                    dsAffsOut.SelectParameters[2].DefaultValue = cbSpec.SelectedValue;
                }
                //else
                //{
                //    selectText += " AND (SpecialtyID >= @SpecialtyID)";
                //    dsAffsOut.SelectCommand = selectText;
                //    dsAffsOut.SelectParameters[2].DefaultValue = "0";
                //}
                //dsAffsOut.SelectCommand = selectText;
                //dsAffsOut.SelectParameters[0].DefaultValue = cbBricks.SelectedValue;

                selectText += " ORDER BY TotalValue Desc, SpecialtyValue DESC";
                dsAffsOut.SelectCommand = selectText;
                dsAffsOut.DataBind();

                dtAffsOut = ((DataView)dsAffsOut.Select(DataSourceSelectArguments.Empty)).ToTable();
                Session["dtAffsOut"] = dtAffsOut;

                cbAffs.SelectedIndex = 0;

                cbAffs.DataSource = dsAffsOut;
                cbAffs.DataTextField = "AffiliationName3";//AffiliationName2
                cbAffs.DataValueField = "AffiliationID";
                cbAffs.Items.Add("Select Doctor");
                cbAffs.DataBind();
                //dsAffsOut.SelectParameters[0].DefaultValue = cbBricks.SelectedValue;
                //selectText += " ORDER BY AffiliationName2 Desc";
            }
            catch (Exception ex)
            {
                return;
            }
        }

        protected void cbAffs_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            using (AffiliationsAdminViewDBContext db = new AffiliationsAdminViewDBContext())
            {
                int ID = int.Parse(cbAffs.SelectedValue);
                int LineId = int.Parse(Session["LineID"].ToString());
                int EmpID = int.Parse(Session["EmployeeID"].ToString());
                var affiliationdata = (from affiliation_tbl in db.View_Affiliations_Admin where affiliation_tbl.AffiliationID == ID && (affiliation_tbl.Deleted == null || affiliation_tbl.Deleted == false) && affiliation_tbl.EmployeeID == EmpID && affiliation_tbl.LineID == LineId && affiliation_tbl.SpecialtyValue > 0 select affiliation_tbl).FirstOrDefault();

                txtAffiliationID.Text = affiliationdata.AffiliationID.ToString();
                txtAffiliationName.Text = affiliationdata.AffiliationName;
                txtBestTimeFrom.Text = affiliationdata.BestTimeFrom;
                txtBestTimeTo.Text = affiliationdata.BestTimeTo;
                txtNotes.Text = affiliationdata.Notes;

                txtNewEntityID.Text = affiliationdata.Entity_Name;
                txtNewEntityIDOld.Text = affiliationdata.Entity_Name;

                if (affiliationdata.Entity_Name == null)
                {
                    txtNewEntityID.Text = txtAffiliationName.Text;
                    txtNewEntityIDOld.Text = txtAffiliationName.Text;
                }

                txtNewPhysicianID.Text = affiliationdata.PhysicianName;
                txtNewPhysicianIDOld.Text = affiliationdata.PhysicianName;

                //ddlLineID.SelectedValue = affiliationdata.LineName;
                ddlAreaRecID.SelectedValue = affiliationdata.BrickID.ToString();
                ddlAreaRecIDOld.SelectedValue = affiliationdata.BrickID.ToString();

                //txtNewEntityID.Enabled = false;
                //txtNewPhysicianID.Enabled = false;
                txtClinicAddress.Text = affiliationdata.EntityAddress;
                txtClinicAddressOld.Text = affiliationdata.EntityAddress;

                DropDownList1.SelectedValue = affiliationdata.EntityTypeID.ToString();
                DropDownList1Old.SelectedValue = affiliationdata.EntityTypeID.ToString();

                txtTel1.Text = affiliationdata.Tel1;
                txtTel2.Text = affiliationdata.Tel2;
                txtTel3.Text = affiliationdata.Tel3;
                txtFax.Text = affiliationdata.Fax;
                txtEmailAddress.Text = affiliationdata.EntityEmailAddress;
                txtWebSite.Text = affiliationdata.EntityWebSite;
                ddlSpecialityID.SelectedValue = affiliationdata.SpecialtyID.ToString();
                ddlSpecialityIDOld.SelectedValue = affiliationdata.SpecialtyID.ToString();



                if (affiliationdata.PrescriptionHappit != 0)
                {
                    ddlPrescriptionHappit.SelectedValue = affiliationdata.PrescriptionHappit.ToString();

                }
                ddlPrescriptionHappitOld.DataBind();
                ddlPrescriptionHappitOld.SelectedValue = affiliationdata.PrescriptionHappit.ToString();
                ddlNoOfPatients.SelectedValue = affiliationdata.NoOfPatients.ToString();
                if (DropDownList2.SelectedValue != "Delete")
                {
                    ddlNoOfPatientsOld.SelectedValue = affiliationdata.NoOfPatients.ToString();
                    ddlWatingTimeOld.SelectedValue = affiliationdata.WaitingTime.ToString();

                }
                ddlWatingTime.SelectedValue = affiliationdata.WaitingTime.ToString();
                txtAffID.Text = ddlRepAffiliations.SelectedValue;
            }
        }
    }
}
