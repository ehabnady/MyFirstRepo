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
    public partial class SalesRepPharmaReq : System.Web.UI.Page
    {
        GridViewRow phyRow;
        DataTable dtAffsOut;

        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)

            {

                if (Session["EmployeeTypeFromSales"].ToString() == "SalesRep")
                {
                    //int EmpID = int.Parse(Session["EmployeeIDFromSales"].ToString());

                    //AreaDataSource.SelectCommand = "SELECT AmounBrickID, AmounBrickName FROM View_EmployeesBricks WHERE(Deleted IS NULL or Deleted=0) AND(EmployeeID = @EmployeeId)";

                    //AreaDataSource.SelectParameters.Add("EmployeeId", Session["EmployeeID"].ToString());



                    ddlAreaRecIDOld.DataBind();
                    ddlPharma.DataBind();

                    btnCancel.Visible = true;
                    rbSDReject.Enabled = false;
                    rbSDApprove.Enabled = false;

                    txtSDComments.Enabled = false;

                    if (Session["LineID"].ToString() == "13")
                    {
                    }
                    else
                    {


                    }
                }
                else
                {
                   
                    
                    if (Session["EmployeeType"].ToString() == "Sales Director")
                    {
                        AreaDataSource.SelectCommand = "SELECT [AmounBrickID], [AmounBrickName] FROM [AreaHierarchy]";
                        ddlAreaRecID.DataBind();
                        ddlAreaRecIDOld.DataBind();
                        btnSave.Visible = false;
                        //ddlRepAffiliations.Enabled = false;


                        rbSDReject.Enabled = true;
                        rbSDApprove.Enabled = true;

                        txtSDComments.Enabled = true;
                    }
                    



                    txtAffiliationID.Enabled = false;
                    txtAffiliationName.Enabled = false;
                    txtNewEntityID.Enabled = false;
                    ddlAreaRecID.Enabled = false;
                    txtClinicAddress.Enabled = false;

                    
                    //ddlRepAffiliations.DataBind();
                    Panel1.Visible = false;
                    txtDescription.Enabled = false;

                }
                

                ddlAreaRecIDOld.AppendDataBoundItems = true;
               
                ddlAreaRecID.AppendDataBoundItems = true;
                ddlPharma.AppendDataBoundItems = true;

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
            //ddlRepAffiliations.Enabled = true;
            txtClinicAddress.Enabled = true;
            ddlAreaRecID.Enabled = true;
            
            txtDescription.Enabled = true;
          
            gvAffiliations.DataSource = null;
            gvAffiliations.DataBind();
           
            lblAreaReq.Visible = false;
            lblEntityReq.Visible = false;
            lblAddressReq.Visible = false;
            
            lblDescriptionReq.Visible = false;
            lblRequestTypeReq.Visible = false;
            lblPharmaCode.Visible = false;
            clearFields();
            //ddlRepAffiliations.Visible = false;

            lblCodeSe.Visible = false;
            txtSeCode.Visible = false;
            txtNewEntityID.Enabled = true;
            txtNewEntityID.Visible = true;
           

            txtNewEntityIDOld.Visible = false;
            txtClinicAddressOld.Visible = false;
            lblClinicAddressOld.Visible = false;
            ddlAreaRecIDOld.Visible = false;
            lblOldBrick.Visible = false;

            lblPharma.Visible = false;
            ddlPharma.Visible = false;

            txtSDName.Text = "";
            txtSDDate.Text = "";
            txtSDComments.Text = "";
            
            rbSDApprove.Checked = false;
            rbSDReject.Checked = false;
          
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
           txtPharmaCode.Text="";
            ddlAreaRecID.SelectedIndex = 0;
          
            txtClinicAddress.Text = "";
           
            txtNewEntityID.Text = "";
           

            txtNewEntityIDOld.Text = "";
            txtClinicAddressOld.Text = "";
            ddlAreaRecIDOld.SelectedIndex = 0;
           
            txtSDDate.Text = "";
            
            txtRequestDate.Text = "";
            
            txtAffID.Text = "";



           
        }

        private void Loadaffiliations()
        {

            using (PharmaProposedEntities db = new PharmaProposedEntities())
            {
                //affiliationslblSaveStatus.Text = "";
                //if ((Session["EmployeeType"]).ToString() == "Admin")
                //{
                //    var ProposedAffData = from ProposedAff_tbl in db.View_ChangeRequests where (ProposedAff_tbl.Status == "Administrator Review") && ProposedAff_tbl.Deleted == null select ProposedAff_tbl;
                //    gvAffiliations.DataSource = ProposedAffData.ToList();
                //    gvAffiliations.DataBind();

                //}
                //if ((Session["EmployeeType"]).ToString() == "DM")
                //{
                //    int DMLineId = int.Parse(Session["LineIDFromDM"].ToString());
                //    int DMId = int.Parse(Session["EmployeeIDFromDM"].ToString());


                //    var ProposedAffData = from ProposedAff_tbl in db.View_ChangeRequests where ProposedAff_tbl.Status == "District Manager" && ProposedAff_tbl.DMID == DMId && ProposedAff_tbl.Deleted == null select ProposedAff_tbl;

                //    //var ProposedAffData = from ProposedAff_tbl in db.Affiliations_Proposed where ProposedAff_tbl.Status == "District Manager" && ProposedAff_tbl.LineID == DMLineId && ProposedAff_tbl.DMID == DMId && ProposedAff_tbl.Deleted == null select ProposedAff_tbl;
                //    gvAffiliations.DataSource = ProposedAffData.ToList();
                //    gvAffiliations.DataBind();

                //}
                if ((Session["EmployeeTypeFromSales"]).ToString() == "SalesRep")
                {
                    int RepId = int.Parse(Session["EmployeeIDFromSales"].ToString());
                    int LineId = int.Parse(Session["LineIDFromSales"].ToString());

                    //var ProposedAffData = from ProposedAff_tbl in db.Affiliations_Proposed where (ProposedAff_tbl.Is_Approved == null || ProposedAff_tbl.Is_Approved == false) && ProposedAff_tbl.LineID == LineId && ProposedAff_tbl.EmployeeID == RepId && ProposedAff_tbl.Deleted == null select ProposedAff_tbl;
                    var ProposedAffData = from ProposedAff_tbl in db.PH_Pharmacies_Proposed where  ProposedAff_tbl.EmpId == RepId && ProposedAff_tbl.Deleted == null select ProposedAff_tbl;
                    gvAffiliations.DataSource = ProposedAffData.ToList();
                    gvAffiliations.DataBind();

                }
               

                if ((Session["EmployeeType"]).ToString() == "Sales Director")
                {
                    int SDId = int.Parse(Session["EmployeeIDFromDir"].ToString());
                    //int LineId = int.Parse(Session["LineIDFromDir"].ToString());

                    var ProposedAffData = from ProposedAff_tbl in db.PH_Pharmacies_Proposed where ProposedAff_tbl.Status == "Sales Director"  && ProposedAff_tbl.Deleted == null select ProposedAff_tbl;
                    gvAffiliations.DataSource = ProposedAffData.ToList();
                    gvAffiliations.DataBind();

                }

                
              

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
            if ((Session["EmployeeType"]).ToString() == "SalesRep" && txtAffiliationID.Text != "")
            {
                int EmpID = int.Parse(Session["EmployeeIDFromSales"].ToString());
                int affID = int.Parse(txtAffiliationID.Text);
                //using (PharmaciesProposedEntities db = new PharmaciesProposedEntities())
                //{
                //    PharmaciesProposedEntities PropAffData = (from PropAff_tbl in db.PH_Pharmacies_Proposed where PropAff_tbl.EmployeeID == EmpID && PropAff_tbl.RealAffID == affID && PropAff_tbl.Deleted == null && (PropAff_tbl.Status != "Rejected" && PropAff_tbl.Status != "In Progress" && PropAff_tbl.Status != "Completed") select PropAff_tbl).FirstOrDefault();
                //    if (PropAffData != null)
                //    {
                //        affiliationslblSaveStatus.Text = "This request is already in the approval cycle";
                //        return;
                //    }
                //}

            }
            if ((Session["EmployeeType"].ToString() == "SalesRep") && (DropDownList2.SelectedValue == "0"))
            {
                lblRequestTypeReq.Visible = true;
                affiliationslblSaveStatus.Text = "All Fields with red(*) is mandatory";
                return;
            }
            if ((Session["EmployeeType"].ToString() == "SalesRep") && (DropDownList2.SelectedValue == "Delete") && (txtDescription.Text == ""))
            {
                lblDescriptionReq.Visible = true;
                affiliationslblSaveStatus.Text = "All Fields with red(*) is mandatory";
                return;
            }
            if (DropDownList2.SelectedValue == "Delete")
            {
                using (PharmaProposedEntities newpharma = new PharmaProposedEntities())
                {
                    PH_Pharmacies_Proposed Pharma = new PH_Pharmacies_Proposed();

                    Pharma.EmpId = int.Parse(Session["EmployeeIDFromSales"].ToString());
                    Pharma.RequestType = DropDownList2.SelectedValue;
                    Pharma.PharmacyName = txtNewEntityID.Text;
                    Pharma.PharmacyAddress = txtClinicAddress.Text;
                    Pharma.BrickID = int.Parse(ddlAreaRecID.SelectedValue);
                    Pharma.AreaRecID = int.Parse(ddlAreaRecID.SelectedValue);
                    Pharma.Description = txtDescription.Text;
                    Pharma.PharmacyID = int.Parse(txtPharmaCode.Text);
                    Pharma.PharmacyAddressOld = txtClinicAddressOld.Text;
                    Pharma.AreaRecIDOld = int.Parse(ddlAreaRecIDOld.SelectedValue);
                    Pharma.RequestDate = DateTime.Parse(txtRequestDate.Text);
                    Pharma.EmpName = Session["EmployeeNameFromSales"].ToString();
                    Pharma.EmpHRCode= int.Parse(Session["EmployeeHRCodeFromSales"].ToString());

                    if (rbSDApprove.Checked == true)
                    {
                        Pharma.SD_Approved = true;
                        Pharma.Status = "Approved";
                    }
                    
                    if (rbSDApprove.Checked == false)
                    {
                        Pharma.Status = "Rejected";
                    }
                    

                    if ((Session["EmployeeType"]).ToString() == "SalesRep")
                    {
                        int EmpID = int.Parse(Session["EmployeeIDFromSales"].ToString());
                        using (EmployeesViewDBContext db = new EmployeesViewDBContext())
                        {
                            View_Employees EmpData = (from Emp_tbl in db.View_Employees where Emp_tbl.EmployeeID == EmpID select Emp_tbl).FirstOrDefault();
                           
                            Pharma.SDID = EmpData.DirectorID;
                            Pharma.Status = "Sales Director";
                        }

                    }

                    newpharma.PH_Pharmacies_Proposed.Add(Pharma);
                    int roweffected = newpharma.SaveChanges();
                    if (roweffected > 0)
                    {
                        
                        affiliationslblSaveStatus.Text = "Saved";
                        //ECMS_Mailing("jezzat@amoun.com", "jezzat@amoun.com", "delete DM", "delete DM");

                        DropDownList2.SelectedIndex = -1;

                        gvAffiliations.DataSource = null;
                        gvAffiliations.DataBind();
                        lblAreaReq.Visible = false;
                        lblEntityReq.Visible = false;
                        lblAddressReq.Visible = false;
                       
                      
                        lblDescriptionReq.Visible = false;
                        lblRequestTypeReq.Visible = false;
                        lblPharmaCode.Visible = false;

                        clearFields();
                        //ddlRepAffiliations.Visible = false;
                       

                        txtNewEntityID.Enabled = true;
                       
                        txtNewEntityIDOld.Visible = false;
                        txtClinicAddressOld.Visible = false;
                        lblClinicAddressOld.Visible = false;

                        ddlAreaRecIDOld.Visible = false;
                        lblOldBrick.Visible = false;
                        ddlPharma.Visible = false;
                        lblCodeSe.Visible = false;
                        txtSeCode.Visible = false;
                        lblPharma.Visible = false;
                       
                        RefreshScreen();

                    }
                    else
                    {
                        affiliationslblSaveStatus.Text = "Error";

                    }
                }
                
                Loadaffiliations();
            }

            else if ( txtNewEntityID.Text != "" && txtClinicAddress.Text != "" && ddlAreaRecID.SelectedIndex != 0 && txtPharmaCode.Text!="")
            {

                using (PharmaProposedEntities newpharma = new PharmaProposedEntities())
                {
                    PH_Pharmacies_Proposed Pharma = new PH_Pharmacies_Proposed();
                  
                    if (DropDownList2.SelectedValue != "New")
                    {
                        //aff.RealAffID = int.Parse(txtAffID.Text);


                    }
                    Pharma.PharmacyName = txtNewEntityID.Text;
                    Pharma.AreaRecID = int.Parse(ddlAreaRecID.SelectedValue);
                    Pharma.PharmacyAddress = txtClinicAddress.Text;

                    Pharma.EmpId = int.Parse(Session["EmployeeIDFromSales"].ToString());
                    Pharma.BrickID = int.Parse(ddlAreaRecID.SelectedValue);
                    Pharma.EmpName = Session["EmployeeNameFromSales"].ToString();
                    Pharma.Description = txtDescription.Text;
                    Pharma.RequestType = DropDownList2.SelectedValue;
                    Pharma.PharmacyID = int.Parse(txtPharmaCode.Text);
                    Pharma.PharmacyAddressOld = txtClinicAddressOld.Text;
                    Pharma.AreaRecIDOld = int.Parse(ddlAreaRecIDOld.SelectedValue);
                    Pharma.RequestDate = DateTime.Parse(txtRequestDate.Text);
                    Pharma.EmpHRCode = int.Parse(Session["EmployeeHRCodeFromSales"].ToString());

                    if (rbSDApprove.Checked == true)
                    {
                        Pharma.SD_Approved = true;
                        Pharma.Status = "Approved";
                    }
                    
                    if (rbSDApprove.Checked == false)
                    {
                        Pharma.Status = "Rejected";
                    }
                    
                    if ((Session["EmployeeType"]).ToString() == "SalesRep")
                    {
                        int EmpID = int.Parse(Session["EmployeeIDFromSales"].ToString());
                        using (EmployeesViewDBContext db = new EmployeesViewDBContext())
                        {
                            View_Employees EmpData = (from Emp_tbl in db.View_Employees where Emp_tbl.EmployeeID == EmpID select Emp_tbl).FirstOrDefault();
                            Pharma.SDID = EmpData.DirectorID;
                            Pharma.Status = "Sales Director";

                        }

                    }
                    
                    newpharma.PH_Pharmacies_Proposed.Add(Pharma);

                    int roweffected = newpharma.SaveChanges();
                    

                    if (roweffected > 0)
                    {
                        affiliationslblSaveStatus.Text = "Saved";
                        //ECMS_Mailing("jezzat@amoun.com", "jezzat@amoun.com", "Update DM", "Update DM");
                        DropDownList2.SelectedIndex = -1;

                        gvAffiliations.DataSource = null;
                        gvAffiliations.DataBind();
                        lblAreaReq.Visible = false;
                        
                        lblEntityReq.Visible = false;
                        lblAddressReq.Visible = false;
                       
                        lblDescriptionReq.Visible = false;
                        lblRequestTypeReq.Visible = false;
                        lblPharmaCode.Visible = false;

                        clearFields();
                        //ddlRepAffiliations.Visible = false;
                       

                        txtNewEntityID.Enabled = true;
                        

                        txtNewEntityIDOld.Visible = false;
                        txtClinicAddressOld.Visible = false;
                        lblClinicAddressOld.Visible = false;

                        ddlAreaRecIDOld.Visible = false;
                        lblOldBrick.Visible = false;

                        


                        


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
                
                if (ddlAreaRecID.SelectedIndex == 0)
                {
                    lblAreaReq.Visible = true;
                }
                
                if (txtNewEntityID.Text == "")
                {
                    lblEntityReq.Visible = true;
                }
                

                if (txtClinicAddress.Text == "")
                {
                    lblAddressReq.Visible = true;
                }
                if (txtPharmaCode.Text == "")
                {
                    lblPharmaCode.Visible = true;
                }
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

            


            if ((Session["EmployeeType"].ToString() != "SalesRep"))
            {
                DropDownList2.Enabled = false;
                btnDelete.Visible = false;
                //ddlRepAffiliations.Enabled = false;
            }
           
            Panel1.Visible = true;

            affiliationslblSaveStatus.Text = "";
            btnUpdate.Visible = true;

            btnSave.Visible = false;
            saveorupdate();
            phyRow = gvAffiliations.SelectedRow;
            if (Session["EmployeeType"].ToString() == "Admin" && phyRow.Cells[19].Text.Replace("&nbsp;", "") == "Approved")
            {
               
            }
            else if (Session["EmployeeType"].ToString() == "Admin" && phyRow.Cells[19].Text.Replace("&nbsp;", "") != "Approved")
            {
                

            }
            if ((Session["EmployeeType"].ToString() == "SalesRep") && phyRow.Cells[19].Text.Replace("&nbsp;", "") != "Sales Director")
            {
                btnUpdate.Visible = false;
                btnDelete.Visible = false;
                txtAffiliationID.Enabled = false;
                txtAffiliationName.Enabled = false;
                
                txtNewEntityID.Enabled = false;
               
                ddlAreaRecID.Enabled = false;
                txtClinicAddress.Enabled = false;
                
                txtDescription.Enabled = false;
                //ddlRepAffiliations.Enabled = false;
                DropDownList2.Enabled = false;
            }
            else if ((Session["EmployeeType"].ToString() == "SalesRep") && phyRow.Cells[19].Text.Replace("&nbsp;", "") == "Sales Director")
            {
                btnUpdate.Visible = true;
                btnDelete.Visible = true;
                txtAffiliationID.Enabled = true;
                txtAffiliationName.Enabled = true;
               
                txtNewEntityID.Enabled = true;
                txtPharmaCode.Enabled = true;
                ddlAreaRecID.Enabled = true;
                txtClinicAddress.Enabled = true;
               

                
                txtDescription.Enabled = true;
                //ddlRepAffiliations.Enabled = false;

                DropDownList2.Enabled = false;

            }
            txtPharmaCode.Text=phyRow.Cells[1].Text.Replace("&nbsp;", "");
            txtAffiliationID.Text = phyRow.Cells[7].Text.Replace("&nbsp;", "");
            txtAffiliationName.Text = phyRow.Cells[2].Text.Replace("&nbsp;", "");
            txtNewEntityID.Text = phyRow.Cells[2].Text.Replace("&nbsp;", "");
            ddlAreaRecID.SelectedValue = phyRow.Cells[14].Text.Replace("&nbsp;", "");
            txtBrickID.Text = phyRow.Cells[3].Text.Replace("&nbsp;", "");
            txtClinicAddress.Text = phyRow.Cells[16].Text.Replace("&nbsp;", "");
            DropDownList2.SelectedValue = phyRow.Cells[12].Text.Replace("&nbsp;", "");
            txtDescription.Text = phyRow.Cells[8].Text.Replace("&nbsp;", "");
            txtNewEntityIDOld.Text = phyRow.Cells[2].Text.Replace("&nbsp;", "");
            txtClinicAddressOld.Text = phyRow.Cells[17].Text.Replace("&nbsp;", "");
            ddlAreaRecIDOld.SelectedValue = phyRow.Cells[15].Text.Replace("&nbsp;", "");
            txtRequestDate.Text = (phyRow.Cells[13].Text.Replace("&nbsp;", "")).ToString();
            txtSDName.Text = (phyRow.Cells[21].Text.Replace("&nbsp;", "")).ToString();
            txtSDComments.Text = (phyRow.Cells[10].Text.Replace("&nbsp;", "")).ToString();
            txtSDDate.Text = (phyRow.Cells[11].Text.Replace("&nbsp;", "")).ToString();
            txtEmpID.Text= (phyRow.Cells[23].Text.Replace("&nbsp;", "")).ToString();





            if (DropDownList2.SelectedValue == "Delete")
            {
                txtNewEntityID.Visible = false;
                //ddlRepAffiliations.Visible = false;
                txtNewEntityIDOld.Visible = true;
                txtClinicAddressOld.Visible = false;
                lblClinicAddressOld.Visible = false;
                ddlAreaRecIDOld.Visible = false;
                lblOldBrick.Visible = false;

            }
            if (DropDownList2.SelectedValue == "New" || DropDownList2.SelectedValue == "Select")
            {
                //ddlRepAffiliations.Visible = false;
                txtNewEntityID.Visible = true;
                txtNewEntityIDOld.Visible = false;
                txtClinicAddressOld.Visible = false;
                lblClinicAddressOld.Visible = false;
                ddlAreaRecIDOld.Visible = false;
                lblOldBrick.Visible = false;
            }
            if (DropDownList2.SelectedValue == "Update" || DropDownList2.SelectedValue == "Update Added Doctor")
            {
                //ddlRepAffiliations.Visible = false;

                txtNewEntityIDOld.Visible = true;
                txtClinicAddressOld.Visible = true;
                lblClinicAddressOld.Visible = true;
                ddlAreaRecIDOld.Visible = true;
                lblOldBrick.Visible = true;
                txtNewEntityID.Enabled = false;
                txtNewEntityID.Visible = false;


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
                
                rbSDApprove.Checked = false;
                rbSDReject.Checked = false;
               
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
                gvr.Cells[1].Text = "Pharmacy Code";
                gvr.Cells[2].Text = "Pharmacy Name";
                gvr.Cells[12].Text = "Request Type";
                gvr.Cells[22].Text = "Requester";
                gvr.Cells[13].Text = "Request Date";
                gvr.Cells[19].Text = "Request Status";
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
            e.Row.Cells[14].Visible = false;
            e.Row.Cells[15].Visible = false;
            e.Row.Cells[16].Visible = false;
            e.Row.Cells[17].Visible = false;
            e.Row.Cells[18].Visible = false;
            e.Row.Cells[20].Visible = false;
            e.Row.Cells[21].Visible = false;
            e.Row.Cells[23].Visible = false;

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if ((Session["EmployeeType"].ToString() == "Admin") )
            {
                affiliationslblSaveStatus.Text = "All Fields with red(*) is mandatory";
                return;
            }
            if ((Session["EmployeeType"].ToString() == "DM") )
            {
                affiliationslblSaveStatus.Text = "All Fields with red(*) is mandatory";
                return;
            }
            if (txtNewEntityID.Text != ""  && txtClinicAddress.Text != ""&& txtPharmaCode.Text!="")
            {
                using (PharmaProposedEntities db = new PharmaProposedEntities())
                {

                    int ID = int.Parse(txtAffiliationID.Text);
                    PH_Pharmacies_Proposed updateProAff = (from ProAff_tbl in db.PH_Pharmacies_Proposed where ProAff_tbl.RecID == ID && ProAff_tbl.Deleted == null select ProAff_tbl).FirstOrDefault();
                    if ((Session["EmployeeType"]).ToString() == "SalesRep")
                    {
                        updateProAff.Description = txtDescription.Text;
                        updateProAff.PharmacyID = int.Parse(txtPharmaCode.Text);
                        updateProAff.PharmacyName = txtNewEntityID.Text;
                        updateProAff.AreaRecID = int.Parse(ddlAreaRecID.SelectedValue);
                        //updateProAff.LineID = int.Parse(Session["LineID"].ToString());
                        updateProAff.EmpId = int.Parse(Session["EmployeeIDFromSales"].ToString());
                        //updateProAff.RepName = Session["EmployeeNameFromSales"].ToString();
                        updateProAff.PharmacyAddress = txtClinicAddress.Text;
                       
                        updateProAff.BrickID = int.Parse(ddlAreaRecID.SelectedValue);
                        updateProAff.EmpName = Session["EmployeeNameFromSales"].ToString();


                        //updateProAff.PharmacyName = txtNewEntityIDOld.Text;

                        updateProAff.PharmacyAddressOld = txtClinicAddressOld.Text;
                        updateProAff.AreaRecIDOld = int.Parse(ddlAreaRecIDOld.SelectedValue);
                        
                        int EmpID = int.Parse(Session["EmployeeIDFromSales"].ToString());
                        //using (EmployeesViewDBContext Empdb = new EmployeesViewDBContext())
                        //{
                        //    View_Employees EmpData = (from Emp_tbl in Empdb.View_Employees where Emp_tbl.EmployeeID == EmpID select Emp_tbl).FirstOrDefault();
                        //    updateProAff.DMID = EmpData.DirectManagerID;
                        //}
                    }





                    if (rbSDApprove.Checked == true)
                    {
                        updateProAff.SD_Approved = true;
                        updateProAff.Status = txtStatus.Text;
                        updateProAff.SDSign = txtSDName.Text;
                        updateProAff.SDDate = DateTime.Parse(txtSDDate.Text);
                        if (DropDownList2.SelectedValue == "New")
                        {


                            using (PharmaEntities db2 = new PharmaEntities())
                            {
                                PH_Pharmacies newPharma = new PH_Pharmacies();
                                newPharma.Address = txtClinicAddress.Text;
                                newPharma.BrickID = int.Parse(ddlAreaRecID.SelectedValue);
                                newPharma.PharmacyID = int.Parse(txtPharmaCode.Text);
                                newPharma.PharmacyName = txtNewEntityID.Text;

                                db2.PH_Pharmacies.Add(newPharma);
                                int roweffected1 = db2.SaveChanges();


                                if (roweffected1 > 0)
                                {
                                    using (PharmacyEmployeesEntities newPhEmp = new PharmacyEmployeesEntities())
                                    {
                                        PharmacyEmployee PhEmp = new PharmacyEmployee();
                                        PhEmp.EmployeeID = int.Parse(txtEmpID.Text);
                                        PhEmp.PharmacyID = int.Parse(txtPharmaCode.Text);

                                        newPhEmp.PharmacyEmployees.Add(PhEmp);
                                        int roweffected2 = newPhEmp.SaveChanges();
                                        if (roweffected2 > 0)
                                        {
                                            affiliationslblSaveStatus.Text = "Saved";

                                        }
                                        else
                                        {
                                            affiliationslblSaveStatus.Text = "Error";
                                            return;

                                        }

                                    }
                                    affiliationslblSaveStatus.Text = "Saved";
                                }
                                else
                                {
                                    affiliationslblSaveStatus.Text = "Error";
                                    return;
                                }

                            }
                        }
                        else
                        {

                            using (PharmaEntities db3 = new PharmaEntities())
                            {
                                int Phid = int.Parse(txtPharmaCode.Text);
                                PH_Pharmacies updatePharma = (from pharma_tbl in db3.PH_Pharmacies where pharma_tbl.PharmacyID == Phid && pharma_tbl.Deleted == null select pharma_tbl).FirstOrDefault();
                                if (DropDownList2.SelectedValue == "Delete")
                                {
                                    updatePharma.Deleted = true;


                                    using (PharmacyEmployeesEntities PhEmpDB = new PharmacyEmployeesEntities())
                                    {
                                        int EmpId= int.Parse(txtEmpID.Text);
                                        PharmacyEmployee UpdatePhEmp = (from phemp_tbl in PhEmpDB.PharmacyEmployees where phemp_tbl.EmployeeID==EmpId && phemp_tbl.Deleted==null select phemp_tbl).FirstOrDefault();
                                        UpdatePhEmp.Deleted = true;
                                        int roweffected3 = 0;
                                        
                                        if (roweffected3 > 0)
                                        {
                                            PhEmpDB.SaveChanges();
                                        }
                                        else
                                        {
                                            affiliationslblSaveStatus.Text = "Error";
                                            return;
                                        }

                                    }
                                }
                                else if (DropDownList2.SelectedValue == "Update")
                                {
                                    updatePharma.Address = txtClinicAddress.Text;
                                    updatePharma.BrickID = int.Parse(ddlAreaRecID.SelectedValue);
                                    updatePharma.PharmacyID = int.Parse(txtPharmaCode.Text);
                                    updatePharma.PharmacyName = txtNewEntityID.Text;
                                    using (PharmacyEmployeesEntities PhEmpDB = new PharmacyEmployeesEntities())
                                    {
                                        int EmpId = int.Parse(txtEmpID.Text);
                                        PharmacyEmployee UpdatePhEmp = (from phemp_tbl in PhEmpDB.PharmacyEmployees where phemp_tbl.EmployeeID == EmpId && phemp_tbl.Deleted == null select phemp_tbl).FirstOrDefault();
                                        UpdatePhEmp.PharmacyID = int.Parse(txtPharmaCode.Text);
                                        int roweffected3 = 0;

                                        if (roweffected3 > 0)
                                        {
                                            PhEmpDB.SaveChanges();
                                        }
                                        else
                                        {
                                            affiliationslblSaveStatus.Text = "Error";
                                            return;
                                        }

                                    }
                                }
                                int roweffected2 = db3.SaveChanges();
                                if (roweffected2>0)
                                {
                                    affiliationslblSaveStatus.Text = "Updated";

                                }
                                else
                                {
                                    affiliationslblSaveStatus.Text = "error";
                                    return;
                                }
                            }
                            
                        }

                    }
                    if (rbSDReject.Checked == true)
                    {
                        updateProAff.Status = txtStatus.Text;
                        updateProAff.SDSign = txtSDName.Text;
                        updateProAff.SDDate = DateTime.Parse(txtSDDate.Text);
                    }


                    int roweffected = 0;
                    try
                    {
                        roweffected = db.SaveChanges();
                    }
                    catch (Exception exc)
                    {
                        affiliationslblSaveStatus.Text = exc.Message + " - " + exc.Source;
                    }



                    if (roweffected > 0)
                    {
                        //------------
                        
                        //------------
                        affiliationslblSaveStatus.Text = "Updated";
                        lblEntityReq.Visible = false;
                        gvAffiliations.DataSource = null;
                        gvAffiliations.DataBind();
                        DropDownList2.SelectedIndex = -1;
                        if ((Session["EmployeeTypeFromSales"]).ToString() == "SalesRep")
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



                
                if (txtNewEntityID.Text == "")
                {
                    lblEntityReq.Visible = true;
                }
                

                if (txtClinicAddress.Text == "")
                {
                    lblAddressReq.Visible = true;
                }
                if (txtPharmaCode.Text == "")
                {
                    lblPharmaCode.Visible = true;
                }
                affiliationslblSaveStatus.Text = "All Fields with red(*) is mandatory";


            }
        }


        protected void cbIsApproved_CheckedChanged(object sender, EventArgs e)
        {
           
        }

        protected void cbRejected_CheckedChanged(object sender, EventArgs e)
        {
           
        }

        protected void RadioButton1_CheckedChanged(object sender, EventArgs e)
        {
            

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

        protected void RadioButton1_CheckedChanged1(object sender, EventArgs e)
        {
           


            txtStatus.Text = "Approved";


        }

        protected void cbNotImplement_CheckedChanged(object sender, EventArgs e)
        {
           
            txtStatus.Text = "Rejected";
        }

        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownList2.SelectedValue == "Update" || DropDownList2.SelectedValue == "Update Added Doctor")
            {
                txtNewEntityID.Enabled = false;
                txtNewEntityID.Visible = true;
                txtClinicAddressOld.Visible = true;
                lblClinicAddressOld.Visible = true;
                ddlAreaRecIDOld.Visible = true;
                lblOldBrick.Visible = true;
                lblPharma.Visible = true;
                ddlPharma.Visible = true;
                btnUpdate.Visible = false;
                lblCodeSe.Visible = true;
                txtSeCode.Visible = true;
                txtSeCode.Text = "";
                txtPharmaCode.Enabled = true;
            }

            if (DropDownList2.SelectedValue == "Delete")
            {
                txtNewEntityID.Enabled = false;
                txtNewEntityID.Visible = true;
                txtNewEntityIDOld.Visible = false;
                txtClinicAddressOld.Visible = false;
                lblClinicAddressOld.Visible = false;
                ddlAreaRecIDOld.Visible = false;
                lblPharma.Visible = true;
                ddlPharma.Visible = true;
                btnUpdate.Visible = false;
                lblCodeSe.Visible = true;
                txtSeCode.Visible = true;
                txtSeCode.Text = "";
                txtPharmaCode.Enabled = false;


            }
            if (DropDownList2.SelectedValue == "New" || DropDownList2.SelectedValue == "Select")
            {
                txtNewEntityID.Enabled = true;
                txtNewEntityID.Visible = true;
                txtNewEntityIDOld.Visible = false;
                txtClinicAddressOld.Visible = false;
                lblClinicAddressOld.Visible = false;
                ddlAreaRecIDOld.Visible = false;
                lblOldBrick.Visible = false;
                lblPharma.Visible = false;
                ddlPharma.Visible = false;
                lblCodeSe.Visible = false;
                txtSeCode.Visible = false;
                txtPharmaCode.Enabled = true;

            }

            clearFields();
            txtRequestDate.Text = DateTime.Today.ToString();
        }


        protected void ddlRepAffiliations_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (AffiliationsAdminViewDBContext db = new AffiliationsAdminViewDBContext())
            {
                //int ID = int.Parse(ddlRepAffiliations.SelectedValue);
                int LineId = int.Parse(Session["LineID"].ToString());
                int EmpID = int.Parse(Session["EmployeeID"].ToString());
                var affiliationdata = (from affiliation_tbl in db.View_Affiliations_Admin where (affiliation_tbl.Deleted == null || affiliation_tbl.Deleted == false) && affiliation_tbl.EmployeeID == EmpID && affiliation_tbl.LineID == LineId && affiliation_tbl.SpecialtyValue > 0 select affiliation_tbl).FirstOrDefault();

                txtAffiliationID.Text = affiliationdata.AffiliationID.ToString();
                txtAffiliationName.Text = affiliationdata.AffiliationName;

                txtNewEntityID.Text = affiliationdata.Entity_Name;
                txtNewEntityIDOld.Text = affiliationdata.Entity_Name;

                if (affiliationdata.Entity_Name == null)
                {
                    txtNewEntityID.Text = txtAffiliationName.Text;
                    txtNewEntityIDOld.Text = txtAffiliationName.Text;
                }

                ddlAreaRecID.SelectedValue = affiliationdata.BrickID.ToString();
                ddlAreaRecIDOld.SelectedValue = affiliationdata.BrickID.ToString();
                txtClinicAddress.Text = affiliationdata.EntityAddress;
                txtClinicAddressOld.Text = affiliationdata.EntityAddress;

                if (affiliationdata.PrescriptionHappit != 0)
                {

                }


                if (DropDownList2.SelectedValue != "Delete")
                {

                }
                //txtAffID.Text = ddlRepAffiliations.SelectedValue;
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {

            string confirmValue = Request.Form["confirm_value"];
            if (confirmValue == "Yes")
            {
                using (PharmaProposedEntities db = new PharmaProposedEntities())
                {

                    int ID = int.Parse(txtAffiliationID.Text);
                    PH_Pharmacies_Proposed DelProAff = (from ProAff_tbl in db.PH_Pharmacies_Proposed where ProAff_tbl.RecID == ID && ProAff_tbl.Deleted == null select ProAff_tbl).FirstOrDefault();
                    if ((Session["EmployeeType"]).ToString() == "SalesRep")
                    {
                        DelProAff.Deleted = true;


                        int roweffected = db.SaveChanges();
                        if (roweffected > 0)
                        {
                            affiliationslblSaveStatus.Text = "Deleted";
                            lblEntityReq.Visible = false;
                            gvAffiliations.DataSource = null;
                            gvAffiliations.DataBind();
                            RefreshScreen();

                            if ((Session["EmployeeType"]).ToString() == "SalesRep")
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
            txtStatus.Text = "Rejected";

        }

        protected void rbSMApprove_CheckedChanged(object sender, EventArgs e)
        {
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
            txtStatus.Text = "Rejected";
        }

        protected void rbSDApprove_CheckedChanged(object sender, EventArgs e)
        {
            txtSDName.Text = Session["EmployeeNameFromDir"].ToString();
            txtSDDate.Text = DateTime.Today.ToString();


            txtStatus.Text = "Approved";



        }

        protected void rbSDReject_CheckedChanged(object sender, EventArgs e)
        {
            txtSDName.Text = Session["EmployeeNameFromDir"].ToString();
            txtSDDate.Text = DateTime.Today.ToString();
            txtStatus.Text = "Rejected";
        }

        protected void rbCOApprove_CheckedChanged(object sender, EventArgs e)
        {
            txtStatus.Text = "Administrator Review";

        }

        protected void rbCOReject_CheckedChanged(object sender, EventArgs e)
        {
            txtStatus.Text = "Rejected";
        }

        protected void cbProccedBy_CheckedChanged(object sender, EventArgs e)
        {
            txtStatus.Text = "In Progress";
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            RefreshScreen();
        }

        protected void cbBricks_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            
        }

        protected void cbAffs_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            using (AffiliationsAdminViewDBContext db = new AffiliationsAdminViewDBContext())
            {
                int LineId = int.Parse(Session["LineID"].ToString());
                int EmpID = int.Parse(Session["EmployeeID"].ToString());
                var affiliationdata = (from affiliation_tbl in db.View_Affiliations_Admin where (affiliation_tbl.Deleted == null || affiliation_tbl.Deleted == false) && affiliation_tbl.EmployeeID == EmpID && affiliation_tbl.LineID == LineId && affiliation_tbl.SpecialtyValue > 0 select affiliation_tbl).FirstOrDefault();
                txtAffiliationID.Text = affiliationdata.AffiliationID.ToString();
                txtAffiliationName.Text = affiliationdata.AffiliationName;
                txtNewEntityID.Text = affiliationdata.Entity_Name;
                txtNewEntityIDOld.Text = affiliationdata.Entity_Name;
                if (affiliationdata.Entity_Name == null)
                {
                    txtNewEntityID.Text = txtAffiliationName.Text;
                    txtNewEntityIDOld.Text = txtAffiliationName.Text;
                }
                //ddlLineID.SelectedValue = affiliationdata.LineName;
                ddlAreaRecID.SelectedValue = affiliationdata.BrickID.ToString();
                ddlAreaRecIDOld.SelectedValue = affiliationdata.BrickID.ToString();
                txtClinicAddress.Text = affiliationdata.EntityAddress;
                txtClinicAddressOld.Text = affiliationdata.EntityAddress;

                if (affiliationdata.PrescriptionHappit != 0)
                {
                }
                
                if (DropDownList2.SelectedValue != "Delete")
                {
                }
            }
        }

        protected void txtNewEntityIDOld_TextChanged(object sender, EventArgs e)
        {

        }

        protected void ddlPharma_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (PharmaEntities db = new PharmaEntities())
            {
                int ID = int.Parse(ddlPharma.SelectedValue);
                //int LineId = int.Parse(Session["LineID"].ToString());
                //int EmpID = int.Parse(Session["EmployeeID"].ToString());
                var affiliationdata = (from affiliation_tbl in db.PH_Pharmacies where (affiliation_tbl.Deleted == null || affiliation_tbl.Deleted == false) && affiliation_tbl.PharmacyID==ID select affiliation_tbl).FirstOrDefault();

                //txtAffiliationID.Text = affiliationdata.AffiliationID.ToString();
                txtAffiliationName.Text = affiliationdata.PharmacyName;
                txtNewEntityID.Text = affiliationdata.PharmacyName;
                txtNewEntityIDOld.Text = affiliationdata.PharmacyName;
                txtPharmaCode.Text = affiliationdata.PharmacyID.ToString();
                ddlAreaRecID.SelectedValue = affiliationdata.BrickID.ToString();
                ddlAreaRecIDOld.SelectedValue = affiliationdata.BrickID.ToString();
                txtClinicAddress.Text = affiliationdata.Address;
                txtClinicAddressOld.Text = affiliationdata.Address;
                
                if (DropDownList2.SelectedValue != "Delete")
                {
                }
                //txtAffID.Text = ddlRepAffiliations.SelectedValue;
            }
        }

        protected void txtSeCode_TextChanged(object sender, EventArgs e)
        {
            clearFields();
            affiliationslblSaveStatus.Text = "";
            ddlPharma.Items.Clear();

            string selectstatment;
            selectstatment = "SELECT PharmacyID, PharmacyName FROM PH_Pharmacies WHERE((Deleted IS NULL) OR(Deleted = 0)) and PharmacyID ="+ txtSeCode.Text+" ORDER BY PharmacyName";
            //PharmaDataSource.SelectParameters.Add("PharmaID", txtSeCode.Text);

            PharmaDataSource.SelectCommand = selectstatment;
            PharmaDataSource.DataBind();
            ddlPharma.DataSource = PharmaDataSource;
            ddlPharma.DataTextField = "PharmacyName";
            ddlPharma.DataValueField = "PharmacyID";
            ddlPharma.Items.Add("Select");
            ddlPharma.SelectedIndex = 0;
            ddlPharma.DataBind();
            //ddlPharma.DataBind();
            if (ddlPharma.Items.Count==1)
            {
                affiliationslblSaveStatus.Text = "Code not found";
            }
            txtRequestDate.Text = DateTime.Today.ToString();
        }

        protected void txtPharmaCode_TextChanged(object sender, EventArgs e)
        {
            if (DropDownList2.SelectedValue == "New")
            {
                using (PharmaEntities db3 = new PharmaEntities())
                {
                    int Phid = int.Parse(txtPharmaCode.Text);
                    PH_Pharmacies updatePharma = (from pharma_tbl in db3.PH_Pharmacies where pharma_tbl.PharmacyID == Phid && pharma_tbl.Deleted == null select pharma_tbl).FirstOrDefault();
                    if (updatePharma!=null)
                    {
                        affiliationslblSaveStatus.Text = "this code is already exist";
                        txtPharmaCode.Text = "";
                        return;
                    }
                }
            }
        }
    }
}
