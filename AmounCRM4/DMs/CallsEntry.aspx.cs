using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Telerik;
using Telerik.Web;
using Telerik.Web.UI;

namespace AmounCRM4.DMs
{
    public partial class CallsEntry : System.Web.UI.Page
    {
        int plannedVisitID;
        string visitDesc = "Desc";
        DataSet VisitsDataSet;
        string detailsXML = "";
        SqlParameter[] visitMasterDataParams;

        SqlCommand cmd;
        SqlConnection con;

        private DataTable VisitParticipants;
        private DataTable VisitMessages;
        private DataTable VisitClosing;

        private DataTable VisitParticipantsSave;
        private DataTable VisitMessagesSave;
        private DataTable VisitClosingSave;

        private DataTable VisitParticipants2;
        private DataTable VisitMessages2;
        private DataTable VisitClosing2;
        int visitIDForEdit = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if ((Session["EmployeeIDFromDM"].ToString() == ""))
            {
                Response.Redirect("~/Login2.aspx");
            }

            int i = 0;
            string s = "";

            if (i == int.Parse(Session["PlannedVisitID"].ToString()))
            {
                plannedVisitID = 0;
                Session["ParticipantID"] = 0;
            }
            else
            {
                plannedVisitID = int.Parse(Session["PlannedVisitID"].ToString());
            }

            if (s == Session["PlannedVisitDate"].ToString())
            {
                radDate11.SelectedDate = DateTime.Now;
            }
            else
            {
                radDate11.SelectedDate = (DateTime.Parse(Session["PlannedVisitDate"].ToString())).Date;
            }

            visitDesc = "My Desc";

            if (!Page.IsPostBack)
            {
                if (int.Parse(Session["IsEditCall"].ToString()) > 0) // == 1 because of Display Menu Item
                {
                    CreateDT();
                    SqlCommand cmdForEdit = new SqlCommand();
                    cmdForEdit.CommandType = CommandType.Text;
                    cmdForEdit.Connection = con;
                    SqlDataAdapter visitAda;

                    visitIDForEdit = int.Parse(Session["PlannedVisitID"].ToString());
                    hidVisitID.Value = Session["PlannedVisitID"].ToString();

                    //Visit Participant Edit Preparation
                    VisitParticipants2 = new DataTable("VisitParticipants2");
                    VisitParticipants2.Columns.Add("AffiliationID", Type.GetType("System.String"));
                    VisitParticipants2.Columns.Add("AffiliationName", Type.GetType("System.String"));

                    cmdForEdit.CommandText = "SELECT AffiliationID, AffiliationName FROM View_VisitParticipants WHERE AppointmentID = " + visitIDForEdit;
                    visitAda = new SqlDataAdapter(cmdForEdit.CommandText, con);
                    visitAda.Fill(VisitParticipants2);
                    //End Of Visit Participant Edit Preparation

                    //Visit Message Edit Preparation
                    VisitMessages2 = new DataTable("VisitMessages2");
                        VisitMessages2.Columns.Add("ProductID", Type.GetType("System.String"));
                        VisitMessages2.Columns.Add("ProductName", Type.GetType("System.String"));
                        VisitMessages2.Columns.Add("AdoptionLadderStepID", Type.GetType("System.String"));
                        VisitMessages2.Columns.Add("AdoptionLadderStepName", Type.GetType("System.String"));

                        //Changed From ProductID, ProductName
                        cmdForEdit.CommandText = "SELECT ProductID, ProductName, AdoptionLadderStepID, AdoptionLadderStepName FROM View_VisitMessages2 WHERE AppointmentID = " + visitIDForEdit;
                        visitAda = new SqlDataAdapter(cmdForEdit.CommandText, con);
                        visitAda.Fill(VisitMessages2);
                        //End Of Visit Message Edit Preparation

                        //Visit Closing Edit Preparation
                        VisitClosing2 = new DataTable("VisitClosing2");
                        VisitClosing2.Columns.Add("PostCallAnalysisID", Type.GetType("System.String"));
                        VisitClosing2.Columns.Add("PostCallAnalysisName", Type.GetType("System.String"));
                        VisitClosing2.Columns.Add("RequestID", Type.GetType("System.String"));
                        VisitClosing2.Columns.Add("RequestName", Type.GetType("System.String"));
                        VisitClosing2.Columns.Add("NextCallObjID", Type.GetType("System.String"));
                        VisitClosing2.Columns.Add("NextCallObjName", Type.GetType("System.String"));
                        VisitClosing2.Columns.Add("SampleID", Type.GetType("System.String"));
                        VisitClosing2.Columns.Add("SampleName", Type.GetType("System.String"));

                        cmdForEdit.CommandText = "SELECT PostCallAnalysisID, PostCallAnalysisName, RequestID, RequestName, NextCallObjID, NextCallObjName, SampleID, SampleName FROM View_VisitClosing WHERE AppointmentID = " + visitIDForEdit;
                        visitAda = new SqlDataAdapter(cmdForEdit.CommandText, con);
                        visitAda.Fill(VisitClosing2);
                        //End Of Visit Closing Edit Preparation
                    
                }

                hidVisitID.Value = Session["PlannedVisitID"].ToString();
                //radDate1.DbSelectedDate = DateTime.Now;
                participantsFirstGridViewRow();
                messagesFirstGridViewRow();
                closingFirstGridViewRow();

                if (2 == int.Parse(Session["IsEditCall"].ToString()))
                {
                    radSave.Enabled = false;
                    if (Session["IsFinal"].ToString() == "Final Save")
                    {
                        chkCompleted.Checked = true;
                        chkCompleted.Enabled = false;
                        chkDelete.Enabled = false;
                    }
                    else
                    {
                        chkCompleted.Checked = false;
                        chkCompleted.Enabled = true;
                        chkDelete.Enabled = true;
                    }
                }
            }
        }

        private void CreateDT()
        {
            //	Name is important this will be used in the stored proc
            VisitParticipantsSave = new DataTable("VisitParticipantsSave");
            VisitMessagesSave = new DataTable("VisitMessagesSave");
            VisitClosingSave = new DataTable("VisitClosingSave");

            //	Create the table structure Of Participants
            VisitParticipantsSave.Columns.Add("AffiliationID", Type.GetType("System.Int32"));//.DefaultValue = "";

            //	Create the table structure Of Messages
            VisitMessagesSave.Columns.Add("ProductID", Type.GetType("System.Int32"));//.DefaultValue = 0;
            VisitMessagesSave.Columns.Add("AdoptionLadderStepID", Type.GetType("System.Int32"));//.DefaultValue = 0;
            VisitMessagesSave.Columns.Add("PhysicianComment", Type.GetType("System.String"));//.DefaultValue = "";//, "Rate * Quantity"//.ReadOnly = true

            //	Create the table structure Of Closing
            VisitClosingSave.Columns.Add("PostCallAnalysisID", Type.GetType("System.Int32"));//.DefaultValue = 0;
            VisitClosingSave.Columns.Add("RequestID", Type.GetType("System.Int32"));//.DefaultValue = 0;
            VisitClosingSave.Columns.Add("NextCallObjID", Type.GetType("System.Int32"));//.DefaultValue = 0;
            VisitClosingSave.Columns.Add("SampleID", Type.GetType("System.Int32"));//.DefaultValue = 0;

            //	DatasetName Important it will be used in the stored proc 
            VisitsDataSet = new DataSet("VisitsDataSet");

            //	Set the name of the dataset this will be used in the store proc
            VisitsDataSet.Tables.Add(VisitParticipantsSave);
            VisitsDataSet.Tables.Add(VisitMessagesSave);
            VisitsDataSet.Tables.Add(VisitClosingSave);

            //Create Parameter Collection For SQL Command
            visitMasterDataParams = new SqlParameter[7];

            con = new SqlConnection("Data Source=10.10.14.20;Initial Catalog=AmounCRM2;Integrated Security=True");
            cmd = new SqlCommand();
            cmd.Connection = con; ;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "InsertCalls";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (radDate11.SelectedDate >= DateTime.Now.AddDays(-1000))
            {
                try
                {
                    CreateDT();
                    int iResult = prepareToSave();
                    if (iResult == 1)
                    {
                        RadWindowManager1.RadAlert("Select Valid Post Call Analysis ", 400, 200, "Alert!", null, "");
                        return;
                    }
                    if (iResult == 2)
                    {
                        RadWindowManager1.RadAlert("Select Valid Next Call Objective", 400, 200, "Alert!", null, "");
                        return;
                    }
                    //	Create the XML
                    detailsXML = VisitsDataSet.GetXml();

                    //Fill SQL Parameter Collection
                    visitMasterDataParams[0] = new SqlParameter("@VisitTypeID", SqlDbType.Int);
                    visitMasterDataParams[0].Value = 1;

                    //visitMasterDataParams[1] = new SqlParameter("@VisitDateTime", SqlDbType.DateTime);
                    //visitMasterDataParams[1].Value = radDate1.SelectedDate;//DateTime.Parse("02/02/2014 16:19:22");//radDateTimePicker1.Value;

                    //visitMasterDataParams[2] = new SqlParameter("@EmployeeID", SqlDbType.Int, 50);
                    //visitMasterDataParams[2].Value = int.Parse(Session["EmployeeID"].ToString());

                    //visitMasterDataParams[3] = new SqlParameter("@AreaID", SqlDbType.Int);
                    //visitMasterDataParams[3].Value = int.Parse(Session["AreaID"].ToString());

                    //visitMasterDataParams[4] = new SqlParameter("@LineID", SqlDbType.Int);
                    //visitMasterDataParams[4].Value = int.Parse(Session["LineID"].ToString());

                    //visitMasterDataParams[5] = new SqlParameter("@CycleID", SqlDbType.Int);
                    //visitMasterDataParams[5].Value = int.Parse(Session["CycleID"].ToString());

                    //visitMasterDataParams[6] = new SqlParameter("@VisitDesc", SqlDbType.NVarChar, 150);
                    //visitMasterDataParams[6].Value = visitDesc;

                    //visitMasterDataParams[7] = new SqlParameter("@EntryDateTime", SqlDbType.DateTime);
                    //visitMasterDataParams[7].Value = DateTime.Now;

                    //visitMasterDataParams[8] = new SqlParameter("@PlannedVisitID", SqlDbType.Int);
                    //visitMasterDataParams[8].Value = plannedVisitID;

                    visitMasterDataParams[1] = new SqlParameter("@DeletedAppointment", SqlDbType.Bit);
                    visitMasterDataParams[1].Value = false;

                    visitMasterDataParams[2] = new SqlParameter("@AppointmentCase", SqlDbType.NVarChar);
                    if (chkCompleted.Checked == true)
                    {
                        visitMasterDataParams[2].Value = "Final Save";
                    }
                    else
                    {
                        visitMasterDataParams[2].Value = "Created";
                    }

                    visitMasterDataParams[3] = new SqlParameter("@VisitRecID", SqlDbType.Int);
                    visitMasterDataParams[3].Value = int.Parse(hidVisitID.Value); //visitIDForEdit;

                    visitMasterDataParams[4] = new SqlParameter("@IsEditCall", SqlDbType.Bit);
                    visitMasterDataParams[4].Value = int.Parse(Session["IsEditCall"].ToString());

                    visitMasterDataParams[5] = new SqlParameter("@IsDeletedVisit", SqlDbType.Bit);
                    if (chkDelete.Checked == true)
                    {
                        visitMasterDataParams[5].Value = 1;
                    }
                    else
                    {
                        visitMasterDataParams[5].Value = 0;
                    }

                    visitMasterDataParams[6] = new SqlParameter("@VisitDetails", SqlDbType.NText);
                    visitMasterDataParams[6].Value = detailsXML;
                    //visitMasterDataParams[7] = new SqlParameter("@VisitParticipants", SqlDbType.NText);
                    //visitMasterDataParams[8] = new SqlParameter("@VisitMessages", SqlDbType.NText);
                    //visitMasterDataParams[9] = new SqlParameter("@VisitClosing", SqlDbType.NText);

                    //SqlHelper.ExecuteScalar(con.ConnectionString, "InsertCalls", visitMasterDataParams);

                    cmd.Parameters.AddRange(visitMasterDataParams);
                    con.Open();
                    object o = cmd.ExecuteScalar();
                    //txtResult.Text = detailsXML;****commented for testing

                    //Each Time Remove All Old Parameters From a SQL Command
                    cmd.Parameters.Clear();

                    VisitParticipantsSave.Rows.Clear();
                    VisitMessagesSave.Rows.Clear();
                    VisitClosingSave.Rows.Clear();
                    /*
                    dgVisitParticipants.DataSource = null;
                    dgVisitMessages.DataSource = null;
                    dgVisitClosing.DataSource = null; 
                    dgVisitParticipants.DataSource = VisitParticipants;
                    dgVisitMessages.DataSource = VisitMessages;
                    dgVisitClosing.DataSource = VisitClosing; 
                    */
                    detailsXML = "";
                    con.Close();

                    clearAfterSave();
                }
                catch (Exception ex)
                {
                    lblError.Text = ex.Source + " - " + ex.Message;
                    //txtResult.Text = ex.Message + ":\n" + Environment.NewLine + ex.Data;****commented for testing
                    RadWindowManager1.RadAlert(ex.Source + "<br />" + ex.Message, 400, 200, "Alert!", null, "");
                }
            }
            else
            {
                lblError.Text = "This is too late entry, we're sorry you can not insert it";
                RadWindowManager1.RadAlert("This is too late entry, we're sorry you can not insert it", 400, 200, "Alert!", null, "");
            }
        }

        private void clearAfterSave()
        {
            Session["PlannedVisitID"] = 0;
            plannedVisitID = 0;

            ViewState["CurrentTable"] = null;
            ViewState["CurrentTable2"] = null;
            ViewState["CurrentTableClosing"] = null;

            gvParticipants.DataSource = null;
            gvParticipants.DataBind();
            gvMessages.DataSource = null;
            gvMessages.DataBind();
            gvClosing.DataSource = null;
            gvClosing.DataBind();

            //Response.Redirect("~/Reps/CallsScheduler.aspx");
            string jScript = "<script>window.close();</script>";
            ClientScript.RegisterClientScriptBlock(this.GetType(), "keyClientBlock", jScript);

            participantsFirstGridViewRow();
            //messagesFirstGridViewRow();
            //closingFirstGridViewRow();
        }

        private void participantsFirstGridViewRow()
        {
            
            VisitParticipants = new DataTable("VisitParticipants");
            DataRow drParticipants = null;
            VisitParticipants.Columns.Add("AffiliationName", Type.GetType("System.String"));
            drParticipants = VisitParticipants.NewRow();
            drParticipants["AffiliationName"] = string.Empty;
            VisitParticipants.Rows.Add(drParticipants);

            if (int.Parse(Session["IsEditCall"].ToString()) == 0)
            {
                ViewState["CurrentTable"] = VisitParticipants;

                gvParticipants.DataSource = VisitParticipants;
                gvParticipants.DataBind();

                DropDownList ddlAff = (DropDownList)gvParticipants.Rows[0].Cells[0].FindControl("ddlAff");
                ddlAff.Focus();

                int ii = 0;
                if (ii < int.Parse(Session["PlannedVisitID"].ToString()))
                {
                    ddlAff.ClearSelection();
                    ddlAff.SelectedIndex = ddlAff.Items.IndexOf(ddlAff.Items.FindByValue(Session["ParticipantID"].ToString()));
                    //ddlAff.Items.FindByValue(Session["ParticipantID"].ToString()).Selected = true;
                    //ddlAff.DataBind();
                    //ddlAff.SelectedValue = Session["ParticipantID"].ToString();
                }
            }
            else
            {
                ViewState["CurrentTable"] = VisitParticipants;
                VisitParticipants.Rows.Clear();

                for (int iii = 0; iii < VisitParticipants2.Rows.Count; iii++)
                {
                    DataRow drVisitParticipant = VisitParticipants.NewRow();
                    drVisitParticipant["AffiliationName"] = string.Empty;
                    VisitParticipants.Rows.Add(drVisitParticipant);
                }
                gvParticipants.DataSource = VisitParticipants;
                gvParticipants.DataBind();

                for (int iii = 0; iii < VisitParticipants2.Rows.Count; iii++)
                {
                    DropDownList ddlAff = (DropDownList)gvParticipants.Rows[iii].Cells[0].FindControl("ddlAff");
                    ddlAff.SelectedIndex = ddlAff.Items.IndexOf(ddlAff.Items.FindByValue(VisitParticipants2.Rows[iii][0].ToString()));

                    //ddlAff.Focus();
                    //ddlAff.ClearSelection();
                }
            }

            System.Web.UI.WebControls.Button btnAdd = (System.Web.UI.WebControls.Button)gvParticipants.FooterRow.Cells[0].FindControl("ButtonAdd");
            Page.Form.DefaultFocus = btnAdd.ClientID;
            
        }

        private void participantsAddNewRow()
        {
            
            int rowIndex = 0;

            if (ViewState["CurrentTable"] != null)
            {
                DropDownList ddlAff;
                VisitParticipants = (DataTable)ViewState["CurrentTable"];
                DataRow drCurrentRowParticipants = null;
                if (VisitParticipants.Rows.Count > 0)
                {
                    for (int i = 1; i <= VisitParticipants.Rows.Count; i++)
                    {
                        ddlAff = (DropDownList)gvParticipants.Rows[rowIndex].Cells[0].FindControl("ddlAff");
                        drCurrentRowParticipants = VisitParticipants.NewRow();
                        drCurrentRowParticipants[0] = i + 1;
                        VisitParticipants.Rows[i - 1]["AffiliationName"] = ddlAff.SelectedValue;
                        rowIndex++;
                    }
                    VisitParticipants.Rows.Add(drCurrentRowParticipants);
                    ViewState["CurrentTable"] = VisitParticipants;

                    gvParticipants.DataSource = VisitParticipants;
                    gvParticipants.DataBind();

                    ddlAff = (DropDownList)gvParticipants.Rows[rowIndex].Cells[0].FindControl("ddlAff");
                    ddlAff.Focus();
                }
            }
            else
            {
                Response.Write("ViewState is null");
            }
            participantsSetPreviousData();
        }

        private void participantsSetPreviousData()
        {
            int rowIndex = 0;
            if (ViewState["CurrentTable"] != null)
            {
                VisitParticipants = (DataTable)ViewState["CurrentTable"];
                if (VisitParticipants.Rows.Count > 0)
                {
                    for (int i = 0; i < VisitParticipants.Rows.Count; i++)
                    {
                        DropDownList ddlAff = (DropDownList)gvParticipants.Rows[rowIndex].Cells[0].FindControl("ddlAff");
                        // drCurrentRow["RowNumber"] = i + 1;

                        ddlAff.SelectedValue = VisitParticipants.Rows[i]["AffiliationName"].ToString();
                        rowIndex++;
                    }
                }
            }
            
        }

        protected void ButtonAdd_Click(object sender, EventArgs e)
        {
            participantsAddNewRow();
        }

        protected void gvParticipants_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            
            participantsSetRowData();
            if (ViewState["CurrentTable"] != null)
            {
                VisitParticipants = (DataTable)ViewState["CurrentTable"];
                DataRow drCurrentRowParticipants = null;
                int rowIndex = Convert.ToInt32(e.RowIndex);
                if (VisitParticipants.Rows.Count > 1)
                {
                    VisitParticipants.Rows.Remove(VisitParticipants.Rows[rowIndex]);
                    drCurrentRowParticipants = VisitParticipants.NewRow();
                    ViewState["CurrentTable"] = VisitParticipants;
                    gvParticipants.DataSource = VisitParticipants;
                    gvParticipants.DataBind();
                    participantsSetPreviousData();
                }
            }
            
        }

        private void participantsSetRowData()
        {
            
            int rowIndex = 0;

            if (ViewState["CurrentTable"] != null)
            {
                VisitParticipants = (DataTable)ViewState["CurrentTable"];
                DataRow drCurrentRowParticipants = null;
                if (VisitParticipants.Rows.Count > 0)
                {
                    for (int i = 1; i <= VisitParticipants.Rows.Count; i++)
                    {
                        DropDownList ddlAff = (DropDownList)gvParticipants.Rows[rowIndex].Cells[0].FindControl("ddlAff");
                        drCurrentRowParticipants = VisitParticipants.NewRow();
                        drCurrentRowParticipants["AffiliationName"] = i + 1;
                        VisitParticipants.Rows[i - 1]["AffiliationName"] = ddlAff.SelectedValue;
                        rowIndex++;
                    }

                    ViewState["CurrentTable"] = VisitParticipants;
                    //grvStudentDetails.DataSource = dtCurrentTable;
                    //grvStudentDetails.DataBind();
                }
            }
            else
            {
                Response.Write("ViewState is null");
            }
            //SetPreviousData();
            
        }

        protected void gvMessages_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            messagesSetRowData();
            if (ViewState["CurrentTable2"] != null)
            {
                VisitMessages = (DataTable)ViewState["CurrentTable2"];
                DataRow drCurrentRowMessages = null;
                int rowIndex = Convert.ToInt32(e.RowIndex);
                if (VisitMessages.Rows.Count > 1)
                {
                    VisitMessages.Rows.Remove(VisitMessages.Rows[rowIndex]);
                    drCurrentRowMessages = VisitMessages.NewRow();
                    ViewState["CurrentTable2"] = VisitMessages;
                    gvMessages.DataSource = VisitMessages;
                    gvMessages.DataBind();
                    messagesSetPreviousData();
                }
            }
        }

        private void messagesSetRowData()
        {
            int rowIndex = 0;

            if (ViewState["CurrentTable2"] != null)
            {
                VisitMessages = (DataTable)ViewState["CurrentTable2"];
                DataRow drCurrentRowMessages = null;
                if (VisitMessages.Rows.Count > 0)
                {
                    for (int i = 1; i <= VisitMessages.Rows.Count; i++)
                    {
                        DropDownList ddlProduct = (DropDownList)gvMessages.Rows[rowIndex].Cells[0].FindControl("ddlProduct");
                        DropDownList ddlAdoptionLadderStep = (DropDownList)gvMessages.Rows[rowIndex].Cells[0].FindControl("ddlAdoptionLadderStep");

                        drCurrentRowMessages = VisitMessages.NewRow();

                        drCurrentRowMessages["ProductName"] = i + 1; //Changed From ProductName
                        VisitMessages.Rows[i - 1]["ProductName"] = ddlProduct.SelectedValue; //Changed From ProductName

                        drCurrentRowMessages["AdoptionLadderStepName"] = i + 1;
                        VisitMessages.Rows[i - 1]["AdoptionLadderStepName"] = ddlAdoptionLadderStep.SelectedValue;

                        rowIndex++;
                    }

                    ViewState["CurrentTable2"] = VisitMessages;
                    //grvStudentDetails.DataSource = dtCurrentTable;
                    //grvStudentDetails.DataBind();
                }
            }
            else
            {
                Response.Write("ViewState is null");
            }
            //SetPreviousData();
        }

        protected void btnAddMessage_Click(object sender, EventArgs e)
        {
            messagesAddNewRow();
        }

        private void messagesFirstGridViewRow()
        {
            VisitMessages = new DataTable("VisitMessages");
            DataRow drMessages = null;

            VisitMessages.Columns.Add("ProductName", Type.GetType("System.String"));
            VisitMessages.Columns.Add("AdoptionLadderStepName", Type.GetType("System.String"));
            drMessages = VisitMessages.NewRow();
            drMessages["ProductName"] = string.Empty;

            //drMessages = VisitMessages.NewRow();
            drMessages["AdoptionLadderStepName"] = string.Empty;

            VisitMessages.Rows.Add(drMessages);
            if (int.Parse(Session["IsEditCall"].ToString()) == 0)
            {
                ViewState["CurrentTable2"] = VisitMessages;

                gvMessages.DataSource = VisitMessages;
                gvMessages.DataBind();

                DropDownList ddlProduct = (DropDownList)gvMessages.Rows[0].Cells[0].FindControl("ddlProduct");
                ddlProduct.Focus();

                DropDownList ddlAdoptionLadderStep = (DropDownList)gvMessages.Rows[0].Cells[1].FindControl("ddlAdoptionLadderStep");
                ddlAdoptionLadderStep.Focus();
            }
            else
            {
                ViewState["CurrentTable2"] = VisitMessages;
                VisitMessages.Rows.Clear();

                for (int iii = 0; iii < VisitMessages2.Rows.Count; iii++)
                {
                    DataRow drVisitMessages = VisitMessages.NewRow();
                    drVisitMessages["ProductName"] = string.Empty; //Changed From ProductName
                    drVisitMessages["AdoptionLadderStepName"] = string.Empty;
                    VisitMessages.Rows.Add(drVisitMessages);
                }
                gvMessages.DataSource = VisitMessages;
                gvMessages.DataBind();

                for (int iii = 0; iii < VisitMessages2.Rows.Count; iii++)
                {
                    DropDownList ddlProduct = (DropDownList)gvMessages.Rows[iii].Cells[0].FindControl("ddlProduct");
                    ddlProduct.SelectedIndex = ddlProduct.Items.IndexOf(ddlProduct.Items.FindByValue(VisitMessages2.Rows[iii][0].ToString()));
                    DropDownList ddlAdoptionLadderStep = (DropDownList)gvMessages.Rows[iii].Cells[1].FindControl("ddlAdoptionLadderStep");
                    ddlAdoptionLadderStep.SelectedIndex = ddlAdoptionLadderStep.Items.IndexOf(ddlAdoptionLadderStep.Items.FindByValue(VisitMessages2.Rows[iii][2].ToString()));
                }
            }

            System.Web.UI.WebControls.Button btnAddMessage = (System.Web.UI.WebControls.Button)gvMessages.FooterRow.Cells[0].FindControl("btnAddMessage");
        }

        private void messagesAddNewRow()
        {
            int rowIndex = 0;

            if (ViewState["CurrentTable2"] != null)
            {
                DropDownList ddlProduct;
                DropDownList ddlAdoptionLadderStep;

                VisitMessages = (DataTable)ViewState["CurrentTable2"];
                DataRow drCurrentRowMessages = null;
                if (VisitMessages.Rows.Count > 0)
                {
                    for (int i = 1; i <= VisitMessages.Rows.Count; i++)
                    {
                        ddlProduct = (DropDownList)gvMessages.Rows[rowIndex].Cells[0].FindControl("ddlProduct");
                        ddlAdoptionLadderStep = (DropDownList)gvMessages.Rows[rowIndex].Cells[0].FindControl("ddlAdoptionLadderStep");

                        drCurrentRowMessages = VisitMessages.NewRow();
                        drCurrentRowMessages[0] = i + 1;

                        VisitMessages.Rows[i - 1]["ProductName"] = ddlProduct.SelectedValue;
                        VisitMessages.Rows[i - 1]["AdoptionLadderStepName"] = ddlAdoptionLadderStep.SelectedValue;

                        rowIndex++;
                    }
                    VisitMessages.Rows.Add(drCurrentRowMessages);
                    ViewState["CurrentTable2"] = VisitMessages;

                    gvMessages.DataSource = VisitMessages;
                    gvMessages.DataBind();

                    ddlProduct = (DropDownList)gvMessages.Rows[rowIndex].Cells[0].FindControl("ddlProduct");
                    ddlProduct.Focus();

                    ddlAdoptionLadderStep = (DropDownList)gvMessages.Rows[rowIndex].Cells[1].FindControl("ddlAdoptionLadderStep");
                    ddlAdoptionLadderStep.Focus();
                }
            }
            else
            {
                Response.Write("ViewState is null");
            }
            messagesSetPreviousData();
        }

        private void messagesSetPreviousData()
        {
            int rowIndex = 0;
            if (ViewState["CurrentTable2"] != null)
            {
                VisitMessages = (DataTable)ViewState["CurrentTable2"];
                if (VisitMessages.Rows.Count > 0)
                {
                    for (int i = 0; i < VisitMessages.Rows.Count; i++)
                    {
                        DropDownList ddlProduct = (DropDownList)gvMessages.Rows[rowIndex].Cells[0].FindControl("ddlProduct");
                        DropDownList ddlAdoptionLadderStep = (DropDownList)gvMessages.Rows[rowIndex].Cells[1].FindControl("ddlAdoptionLadderStep");

                        // drCurrentRow["RowNumber"] = i + 1;

                        ddlProduct.SelectedValue = VisitMessages.Rows[i]["ProductName"].ToString();
                        ddlAdoptionLadderStep.SelectedValue = VisitMessages.Rows[i]["AdoptionLadderStepName"].ToString();

                        rowIndex++;
                    }
                }
            }
        }

        protected void btnAddClosing_Click(object sender, EventArgs e)
        {
            closingAddNewRow();
        }

        protected void gvClosing_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            closingSetRowData();
            if (ViewState["CurrentTableClosing"] != null)
            {
                VisitClosing = (DataTable)ViewState["CurrentTableClosing"];
                DataRow drCurrentRowClosing = null;
                int rowIndex = Convert.ToInt32(e.RowIndex);
                if (VisitClosing.Rows.Count > 1)
                {
                    VisitClosing.Rows.Remove(VisitClosing.Rows[rowIndex]);
                    drCurrentRowClosing = VisitClosing.NewRow();
                    ViewState["CurrentTableClosing"] = VisitClosing;
                    gvClosing.DataSource = VisitClosing;
                    gvClosing.DataBind();
                    closingSetPreviousData();
                }
            }
        }

        private void closingSetPreviousData()
        {
            int rowIndex = 0;
            if (ViewState["CurrentTableClosing"] != null)
            {
                VisitClosing = (DataTable)ViewState["CurrentTableClosing"];
                if (VisitClosing.Rows.Count > 0)
                {
                    for (int i = 0; i < VisitClosing.Rows.Count; i++)
                    {
                        DropDownList ddlPostCallAnalysis = (DropDownList)gvClosing.Rows[rowIndex].Cells[0].FindControl("ddlPostCallAnalysis");
                        DropDownList ddlPhysicianRequest = (DropDownList)gvClosing.Rows[rowIndex].Cells[1].FindControl("ddlPhysicianRequest");
                        DropDownList ddlNextCallObjective = (DropDownList)gvClosing.Rows[rowIndex].Cells[2].FindControl("ddlNextCallObjective");
                        DropDownList ddlSample = (DropDownList)gvClosing.Rows[rowIndex].Cells[3].FindControl("ddlSample");

                        // drCurrentRow["RowNumber"] = i + 1;

                        ddlPostCallAnalysis.SelectedValue = VisitClosing.Rows[i]["PostCallAnalysisName"].ToString();
                        ddlPhysicianRequest.SelectedValue = VisitClosing.Rows[i]["RequestName"].ToString();
                        ddlNextCallObjective.SelectedValue = VisitClosing.Rows[i]["NextCallObjName"].ToString();
                        ddlSample.SelectedValue = VisitClosing.Rows[i]["SampleName"].ToString();

                        rowIndex++;
                    }
                }
            }
        }

        private void closingSetRowData()
        {
            int rowIndex = 0;

            if (ViewState["CurrentTableClosing"] != null)
            {
                VisitClosing = (DataTable)ViewState["CurrentTableClosing"];
                DataRow drCurrentRowClosing = null;
                if (VisitClosing.Rows.Count > 0)
                {
                    for (int i = 1; i <= VisitClosing.Rows.Count; i++)
                    {
                        DropDownList ddlPostCallAnalysis = (DropDownList)gvClosing.Rows[rowIndex].Cells[0].FindControl("ddlPostCallAnalysis");
                        DropDownList ddlPhysicianRequest = (DropDownList)gvClosing.Rows[rowIndex].Cells[1].FindControl("ddlPhysicianRequest");
                        DropDownList ddlNextCallObjective = (DropDownList)gvClosing.Rows[rowIndex].Cells[2].FindControl("ddlNextCallObjective");
                        DropDownList ddlSample = (DropDownList)gvClosing.Rows[rowIndex].Cells[3].FindControl("ddlSample");

                        drCurrentRowClosing = VisitClosing.NewRow();

                        drCurrentRowClosing["PostCallAnalysisName"] = i + 1;
                        VisitClosing.Rows[i - 1]["PostCallAnalysisName"] = ddlPostCallAnalysis.SelectedValue;

                        drCurrentRowClosing["RequestName"] = i + 1;
                        VisitClosing.Rows[i - 1]["RequestName"] = ddlPhysicianRequest.SelectedValue;

                        drCurrentRowClosing["NextCallObjName"] = i + 1;
                        VisitClosing.Rows[i - 1]["NextCallObjName"] = ddlNextCallObjective.SelectedValue;

                        drCurrentRowClosing["SampleName"] = i + 1;
                        VisitClosing.Rows[i - 1]["SampleName"] = ddlSample.SelectedValue;

                        rowIndex++;
                    }

                    ViewState["CurrentTableClosing"] = VisitClosing;
                    //grvStudentDetails.DataSource = dtCurrentTable;
                    //grvStudentDetails.DataBind();
                }
            }
            else
            {
                Response.Write("ViewState is null");
            }
            //SetPreviousData();
        }

        private void closingAddNewRow()
        {
            int rowIndex = 0;

            if (ViewState["CurrentTableClosing"] != null)
            {
                DropDownList ddlPostCallAnalysis;
                DropDownList ddlPhysicianRequest;
                DropDownList ddlNextCallObjective;
                DropDownList ddlSample;

                VisitClosing = (DataTable)ViewState["CurrentTableClosing"];
                DataRow drCurrentRowClosing = null;
                if (VisitClosing.Rows.Count > 0)
                {
                    for (int i = 1; i <= VisitClosing.Rows.Count; i++)
                    {
                        ddlPostCallAnalysis = (DropDownList)gvClosing.Rows[rowIndex].Cells[0].FindControl("ddlPostCallAnalysis");
                        ddlPhysicianRequest = (DropDownList)gvClosing.Rows[rowIndex].Cells[1].FindControl("ddlPhysicianRequest");
                        ddlNextCallObjective = (DropDownList)gvClosing.Rows[rowIndex].Cells[2].FindControl("ddlNextCallObjective");
                        ddlSample = (DropDownList)gvClosing.Rows[rowIndex].Cells[3].FindControl("ddlSample");

                        if (ddlPostCallAnalysis.SelectedValue == "0")
                        {
                            RadWindowManager1.RadAlert("Select Valid Post Call Analysis ", 400, 200, "Alert!", null, "");
                            return;
                        }
                        if (ddlNextCallObjective.SelectedValue == "0")
                        {
                            RadWindowManager1.RadAlert("Select Valid Next Call Objective", 400, 200, "Alert!", null, "");
                            return;
                        }

                        drCurrentRowClosing = VisitClosing.NewRow();
                        drCurrentRowClosing[0] = i + 1;

                        VisitClosing.Rows[i - 1]["PostCallAnalysisName"] = ddlPostCallAnalysis.SelectedValue;
                        VisitClosing.Rows[i - 1]["RequestName"] = ddlPhysicianRequest.SelectedValue;
                        VisitClosing.Rows[i - 1]["NextCallObjName"] = ddlNextCallObjective.SelectedValue;
                        VisitClosing.Rows[i - 1]["SampleName"] = ddlSample.SelectedValue;

                        rowIndex++;
                    }
                    VisitClosing.Rows.Add(drCurrentRowClosing);
                    ViewState["CurrentTableClosing"] = VisitClosing;

                    gvClosing.DataSource = VisitClosing;
                    gvClosing.DataBind();

                    ddlPostCallAnalysis = (DropDownList)gvClosing.Rows[rowIndex].Cells[0].FindControl("ddlPostCallAnalysis");
                    ddlPostCallAnalysis.Focus();

                    ddlPhysicianRequest = (DropDownList)gvClosing.Rows[rowIndex].Cells[1].FindControl("ddlPhysicianRequest");
                    ddlPhysicianRequest.Focus();

                    ddlNextCallObjective = (DropDownList)gvClosing.Rows[rowIndex].Cells[2].FindControl("ddlNextCallObjective");
                    ddlNextCallObjective.Focus();

                    ddlSample = (DropDownList)gvClosing.Rows[rowIndex].Cells[3].FindControl("ddlSample");
                    ddlSample.Focus();
                }
            }
            else
            {
                Response.Write("ViewState is null");
            }
            closingSetPreviousData();
        }

        private void closingFirstGridViewRow()
        {
            VisitClosing = new DataTable("VisitClosing");
            DataRow drClosing = null;

            VisitClosing.Columns.Add("PostCallAnalysisName", Type.GetType("System.String"));
            VisitClosing.Columns.Add("RequestName", Type.GetType("System.String"));
            VisitClosing.Columns.Add("NextCallObjName", Type.GetType("System.String"));
            VisitClosing.Columns.Add("SampleName", Type.GetType("System.String"));

            drClosing = VisitClosing.NewRow();

            drClosing["PostCallAnalysisName"] = string.Empty;

            //drClosing = VisitClosing.NewRow();
            drClosing["RequestName"] = string.Empty;

            //drClosing = VisitClosing.NewRow();
            drClosing["NextCallObjName"] = string.Empty;

            //drClosing = VisitClosing.NewRow();
            drClosing["SampleName"] = string.Empty;

            VisitClosing.Rows.Add(drClosing);

            if (int.Parse(Session["IsEditCall"].ToString()) == 0)
            {
                ViewState["CurrentTableClosing"] = VisitClosing;

                gvClosing.DataSource = VisitClosing;
                gvClosing.DataBind();

                DropDownList ddlPostCallAnalysis = (DropDownList)gvClosing.Rows[0].Cells[0].FindControl("ddlPostCallAnalysis");
                ddlPostCallAnalysis.Focus();

                DropDownList ddlPhysicianRequest = (DropDownList)gvClosing.Rows[0].Cells[1].FindControl("ddlPhysicianRequest");
                ddlPhysicianRequest.Focus();

                DropDownList ddlNextCallObjective = (DropDownList)gvClosing.Rows[0].Cells[2].FindControl("ddlNextCallObjective");
                ddlNextCallObjective.Focus();

                DropDownList ddlSample = (DropDownList)gvClosing.Rows[0].Cells[3].FindControl("ddlSample");
                ddlSample.Focus();
            }
            else
            {
                ViewState["CurrentTableClosing"] = VisitClosing;
                VisitClosing.Rows.Clear();

                for (int iii = 0; iii < VisitClosing2.Rows.Count; iii++)
                {
                    DataRow drVisitClosing = VisitClosing.NewRow();
                    drVisitClosing["PostCallAnalysisName"] = string.Empty;
                    drVisitClosing["RequestName"] = string.Empty;
                    drVisitClosing["NextCallObjName"] = string.Empty;
                    drVisitClosing["SampleName"] = string.Empty;
                    VisitClosing.Rows.Add(drVisitClosing);
                }
                gvClosing.DataSource = VisitClosing;
                gvClosing.DataBind();

                for (int iii = 0; iii < VisitClosing2.Rows.Count; iii++)
                {
                    DropDownList ddlPostCallAnalysis = (DropDownList)gvClosing.Rows[iii].Cells[0].FindControl("ddlPostCallAnalysis");
                    ddlPostCallAnalysis.SelectedIndex = ddlPostCallAnalysis.Items.IndexOf(ddlPostCallAnalysis.Items.FindByValue(VisitClosing2.Rows[iii][0].ToString()));

                    DropDownList ddlPhysicianRequest = (DropDownList)gvClosing.Rows[iii].Cells[1].FindControl("ddlPhysicianRequest");
                    ddlPhysicianRequest.SelectedIndex = ddlPhysicianRequest.Items.IndexOf(ddlPhysicianRequest.Items.FindByValue(VisitClosing2.Rows[iii][2].ToString()));

                    DropDownList ddlNextCallObjective = (DropDownList)gvClosing.Rows[iii].Cells[2].FindControl("ddlNextCallObjective");
                    ddlNextCallObjective.SelectedIndex = ddlNextCallObjective.Items.IndexOf(ddlNextCallObjective.Items.FindByValue(VisitClosing2.Rows[iii][4].ToString()));

                    DropDownList ddlSample = (DropDownList)gvClosing.Rows[iii].Cells[3].FindControl("ddlSample");
                    ddlSample.SelectedIndex = ddlSample.Items.IndexOf(ddlSample.Items.FindByValue(VisitClosing2.Rows[iii][6].ToString()));
                }
            }

            System.Web.UI.WebControls.Button btnAddMessage = (System.Web.UI.WebControls.Button)gvClosing.FooterRow.Cells[0].FindControl("btnAddClosing");
            //Page.Form.DefaultFocus = btnAddMessage.ClientID; for testing purpose
        }

        private int prepareToSave()
        {
            int iResult = 0;
            int i = 0;
            foreach (GridViewRow r in gvParticipants.Rows)
            {
                DropDownList ddlAff = (DropDownList)gvParticipants.Rows[i].Cells[0].FindControl("ddlAff");
                DataRow rP = VisitParticipantsSave.NewRow();
                rP[0] = int.Parse(ddlAff.SelectedValue);
                VisitParticipantsSave.Rows.Add(rP);
                i++;
            }

            int j = 0;
            foreach (GridViewRow r in gvMessages.Rows)
            {
                DropDownList ddlProduct = (DropDownList)gvMessages.Rows[j].Cells[0].FindControl("ddlProduct");
                DropDownList ddlAdoptionLadderStep = (DropDownList)gvMessages.Rows[j].Cells[1].FindControl("ddlAdoptionLadderStep");

                DataRow rM = VisitMessagesSave.NewRow();
                rM[0] = int.Parse(ddlProduct.SelectedValue);
                rM[1] = int.Parse(ddlAdoptionLadderStep.SelectedValue);
                VisitMessagesSave.Rows.Add(rM);
                j++;
            }

            int k = 0;
            foreach (GridViewRow r in gvClosing.Rows)
            {
                DropDownList ddlPostCallAnalysis = (DropDownList)gvClosing.Rows[k].Cells[0].FindControl("ddlPostCallAnalysis");
                DropDownList ddlPhysicianRequest = (DropDownList)gvClosing.Rows[k].Cells[1].FindControl("ddlPhysicianRequest");
                DropDownList ddlNextCallObjective = (DropDownList)gvClosing.Rows[k].Cells[0].FindControl("ddlNextCallObjective");
                DropDownList ddlSample = (DropDownList)gvClosing.Rows[k].Cells[1].FindControl("ddlSample");

                if (ddlPostCallAnalysis.SelectedValue == "0")
                {
                    RadWindowManager1.RadAlert("Select Valid Post Call Analysis ", 400, 200, "Alert!", null, "");
                    iResult = 1;
                }
                if (ddlNextCallObjective.SelectedValue == "0")
                {
                    RadWindowManager1.RadAlert("Select Valid Next Call Objective", 400, 200, "Alert!", null, "");
                    iResult = 2;
                }

                DataRow rC = VisitClosingSave.NewRow();
                rC[0] = int.Parse(ddlPostCallAnalysis.SelectedValue);
                rC[1] = int.Parse(ddlPhysicianRequest.SelectedValue);
                rC[2] = int.Parse(ddlNextCallObjective.SelectedValue);
                rC[3] = int.Parse(ddlSample.SelectedValue);
                VisitClosingSave.Rows.Add(rC);
                k++;
            }
            return iResult;

            //participantsSetRowData();
            //messagesSetRowData();
            //closingSetRowData();

            //DataTable tblParticipant = ViewState["CurrentTable"] as DataTable;
            //DataTable tblMessage = ViewState["CurrentTable2"] as DataTable;
            //DataTable tblClosing = ViewState["CurrentTableClosing"] as DataTable;

            //if(tblParticipant != null)
            //{
            //    foreach(DataRow r in tblParticipant.Rows)
            //    {
            //        DataRow rP = VisitParticipantsSave.NewRow();
            //        rP[0] = 
            //        VisitParticipantsSave.Rows.Add();
            //    }
            //}
        }

        protected void radDate1_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            if (radDate11.SelectedDate > DateTime.Now)
            {
                Response.Write("alert('Error')");
            }
            //lblVisitDateTime.Text = "";
            //lblVisitDateTime.Text = radDate1.SelectedDate.ToShortDateString() + " " + DateTime.Parse(radTimePicker1.Value.ToString()).ToShortTimeString();
        }
    }
}