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
    public partial class Calls2 : System.Web.UI.Page
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
        //private DataTable VisitClosing;

        private DataTable VisitParticipantsSave;
        private DataTable VisitMessagesSave;
        //private DataTable VisitClosingSave;

        private DataTable VisitParticipants2;
        private DataTable VisitMessages2;
        //private DataTable VisitClosing2;
        private DataTable VisitPostCall2;
        private DataTable VisitNextCallObjectives2;
        private DataTable VisitSamples2;
        int visitIDForEdit = 0;

        private DataTable VisitPostCall;
        private DataTable VisitNextCallObjectives;
        private DataTable VisitSamples;

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
                if (Session["IsDoubleVisit"] == null)
                {
                    dsDoubleVisitManagers.DataBind();
                    ddlWho.DataBind();
                    ddlWho.AppendDataBoundItems = true;
                    ddlWho.SelectedIndex = int.Parse(Session["IsDoubleVisit"].ToString());
                    ddlWho.SelectedValue = null;
                    ddlWho.ClearSelection();
                }

                SamplesDS1.DataBind();
                rep1Pro1Samples1.DataBind();

                SamplesDS2.DataBind();
                rep2Pro2Samples2.DataBind();

                SamplesDS3.DataBind();
                rep3Pro3Samples3.DataBind();

                AffDS.DataBind();
                txtAffName.Text = ((DataView)AffDS.Select(DataSourceSelectArguments.Empty))[0][1].ToString();

                if (int.Parse(Session["IsEditCall"].ToString()) > 0) // == 1 because of Display Menu Item
                {
                    CreateDT();
                    SqlCommand cmdForEdit = new SqlCommand();
                    cmdForEdit.CommandType = CommandType.Text;
                    cmdForEdit.Connection = con;
                    SqlDataAdapter visitAda1;
                    //SqlDataAdapter visitAda2;
                    //SqlDataAdapter visitAda3;

                    visitIDForEdit = int.Parse(Session["PlannedVisitID"].ToString());
                    hidVisitID.Value = Session["PlannedVisitID"].ToString();

                    //Visit Message Edit Preparation
                    VisitMessages2 = new DataTable("VisitMessages2");
                    VisitMessages2.Columns.Add("ProductID", Type.GetType("System.String"));
                    VisitMessages2.Columns.Add("ProductName", Type.GetType("System.String"));
                    VisitMessages2.Columns.Add("AdoptionLadderStepID", Type.GetType("System.String"));
                    VisitMessages2.Columns.Add("AdoptionLadderStepName", Type.GetType("System.String"));

                    cmdForEdit.CommandText = "SELECT ProductID, ProductName, AdoptionLadderStepID, AdoptionLadderStepName FROM View_VisitMessages2 WHERE AppointmentID = " + visitIDForEdit + " Order By VisitMessageID ASC";
                    visitAda1 = new SqlDataAdapter(cmdForEdit.CommandText, con);
                    visitAda1.Fill(VisitMessages2);

                    /*
                    //Visit Participant Edit Preparation
                    VisitParticipants2 = new DataTable("VisitParticipants2");
                    VisitParticipants2.Columns.Add("AffiliationID", Type.GetType("System.String"));
                    VisitParticipants2.Columns.Add("AffiliationName", Type.GetType("System.String"));

                    cmdForEdit.CommandText = "SELECT AffiliationID, AffiliationName FROM View_VisitParticipants WHERE AppointmentID = " + visitIDForEdit;
                    visitAda1 = new SqlDataAdapter(cmdForEdit.CommandText, con);
                    visitAda1.Fill(VisitParticipants2);
                    //End Of Visit Participant Edit Preparation
                    */

                    ddlProduct1.DataBind();
                    ddlAdoptionLadderStep1.DataBind();
                    ddlProduct1.SelectedIndex = ddlProduct1.Items.IndexOf(ddlProduct1.Items.FindByValue(VisitMessages2.Rows[0][0].ToString()));
                    ddlAdoptionLadderStep1.SelectedIndex = ddlAdoptionLadderStep1.Items.IndexOf(ddlAdoptionLadderStep1.Items.FindByValue(VisitMessages2.Rows[0][2].ToString()));

                    pnlProd1.Visible = true;
                    //ddlProduct2.Visible = false;
                    pnlProd2.Visible = false;
                    //ddlProduct3.Visible = false;
                    pnlProd3.Visible = false;

                    if (VisitMessages2.Rows.Count == 2)
                    {
                        ddlProduct2.DataBind();
                        ddlAdoptionLadderStep2.DataBind();
                        ddlProduct2.SelectedIndex = ddlProduct2.Items.IndexOf(ddlProduct2.Items.FindByValue(VisitMessages2.Rows[1][0].ToString()));
                        ddlAdoptionLadderStep2.SelectedIndex = ddlAdoptionLadderStep2.Items.IndexOf(ddlAdoptionLadderStep1.Items.FindByValue(VisitMessages2.Rows[1][2].ToString()));

                        pnlProd2.Visible = true;
                        //ddlProduct2.Visible = true;
                        pnlProd3.Visible = false;
                        //ddlProduct3.Visible = false;
                    }
                    if (VisitMessages2.Rows.Count == 3)
                    {
                        ddlProduct2.DataBind();
                        ddlAdoptionLadderStep2.DataBind();
                        //ddlProduct2.SelectedIndex = ddlProduct2.Items.IndexOf((ListItem)VisitMessages2.Rows[1][0]);
                        //ddlAdoptionLadderStep2.SelectedIndex = ddlAdoptionLadderStep2.Items.IndexOf((ListItem)VisitMessages2.Rows[1][2]);
                        ddlProduct2.SelectedIndex = ddlProduct2.Items.IndexOf(ddlProduct2.Items.FindByValue(VisitMessages2.Rows[1][0].ToString()));
                        ddlAdoptionLadderStep2.SelectedIndex = ddlAdoptionLadderStep2.Items.IndexOf(ddlAdoptionLadderStep2.Items.FindByValue(VisitMessages2.Rows[1][2].ToString()));

                        ddlProduct3.DataBind();
                        ddlAdoptionLadderStep3.DataBind();
                        //ddlProduct3.SelectedIndex = ddlProduct3.Items.IndexOf((ListItem)VisitMessages2.Rows[2][0]);
                        //ddlAdoptionLadderStep3.SelectedIndex = ddlAdoptionLadderStep3.Items.IndexOf((ListItem)VisitMessages2.Rows[2][2]);
                        ddlProduct3.SelectedIndex = ddlProduct3.Items.IndexOf(ddlProduct3.Items.FindByValue(VisitMessages2.Rows[2][0].ToString()));
                        ddlAdoptionLadderStep3.SelectedIndex = ddlAdoptionLadderStep3.Items.IndexOf(ddlAdoptionLadderStep3.Items.FindByValue(VisitMessages2.Rows[2][2].ToString()));

                        pnlProd2.Visible = true;
                        //ddlProduct2.Visible = true;
                        pnlProd3.Visible = true;
                        //ddlProduct3.Visible = true;
                    }
                    //End Of Visit Message Edit Preparation

                    if (int.Parse(Session["IsDoubleVisit"].ToString()) == 0)
                    {
                        ddlWho.SelectedIndex = 0;
                    }
                    else
                    {
                        ddlWho.DataBind();
                        ddlWho.SelectedIndex = -1;
                        ddlWho.Items.FindByValue(Session["IsDoubleVisit"].ToString()).Selected = true;
                    }

                    postCallEditPrep();
                    nextCallEditPrep();
                    samplesEditPrep();
                }

                hidVisitID.Value = Session["PlannedVisitID"].ToString();
                //radDate1.DbSelectedDate = DateTime.Now;
                //participantsFirstGridViewRow();
                //messagesFirstGridViewRow();
                //closingFirstGridViewRow();

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

        protected void ddlProduct1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlProduct1.SelectedIndex == 0)
            {
                pnlProd1.Visible = false;
            }
            else
            {
                if ((ddlProduct1.SelectedIndex == ddlProduct2.SelectedIndex) || (ddlProduct1.SelectedIndex == ddlProduct3.SelectedIndex))
                {
                    RadWindowManager1.RadAlert("Choose Different Product", 400, 200, "Alert!", null, "");
                    ddlProduct1.SelectedIndex = 0;
                    return;
                }
                pnlProd1.Visible = true;
            }
        }

        protected void ddlProduct2_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlProduct2.SelectedIndex == 0)
            {
                pnlProd2.Visible = false;
            }
            else
            {
                if ((ddlProduct2.SelectedIndex == ddlProduct1.SelectedIndex) || (ddlProduct2.SelectedIndex == ddlProduct3.SelectedIndex))
                {
                    RadWindowManager1.RadAlert("Choose Different Product", 400, 200, "Alert!", null, "");
                    ddlProduct2.SelectedIndex = 0;
                    return;
                }
                pnlProd2.Visible = true;
            }
        }

        protected void ddlProduct3_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlProduct3.SelectedIndex == 0)
            {
                pnlProd3.Visible = false;
            }
            else
            {
                if ((ddlProduct3.SelectedIndex == ddlProduct1.SelectedIndex) || (ddlProduct3.SelectedIndex == ddlProduct2.SelectedIndex))
                {
                    RadWindowManager1.RadAlert("Choose Different Product", 400, 200, "Alert!", null, "");
                    ddlProduct3.SelectedIndex = 0;
                    return;
                }
                pnlProd3.Visible = true;
            }
        }

        private void CreateDT()
        {
            //	Name is important this will be used in the stored proc
            VisitParticipantsSave = new DataTable("VisitParticipantsSave");
            VisitMessagesSave = new DataTable("VisitMessagesSave");
            VisitPostCall = new DataTable("VisitPostCall");
            VisitNextCallObjectives = new DataTable("VisitNextCallObjectives");
            VisitSamples = new DataTable("VisitSamples");
            //VisitClosingSave = new DataTable("VisitClosingSave");

            //	Create the table structure Of Participants
            VisitParticipantsSave.Columns.Add("AffiliationID", Type.GetType("System.Int32"));//.DefaultValue = "";

            //	Create the table structure Of Messages
            VisitMessagesSave.Columns.Add("ProductID", Type.GetType("System.Int32"));//.DefaultValue = 0;
            VisitMessagesSave.Columns.Add("AdoptionLadderStepID", Type.GetType("System.Int32"));//.DefaultValue = 0;
            VisitMessagesSave.Columns.Add("PhysicianComment", Type.GetType("System.String"));//.DefaultValue = "";//, "Rate * Quantity"//.ReadOnly = true

            //	DatasetName Important it will be used in the stored proc 
            VisitsDataSet = new DataSet("VisitsDataSet");

            //	Create the table structure Of Post Calls
            VisitPostCall.Columns.Add("ProductID", Type.GetType("System.Int32"));//.DefaultValue = 0;
            VisitPostCall.Columns.Add("PostCallAnalysisID", Type.GetType("System.Int32"));

            //	Create the table structure Of Next Call Objectives
            VisitNextCallObjectives.Columns.Add("ProductID", Type.GetType("System.Int32"));//.DefaultValue = 0;
            VisitNextCallObjectives.Columns.Add("NextCallObjectiveID", Type.GetType("System.Int32"));

            //	Create the table structure Of Samples
            VisitSamples.Columns.Add("ProductID", Type.GetType("System.Int32"));
            VisitSamples.Columns.Add("SampleID", Type.GetType("System.Int32"));
            VisitSamples.Columns.Add("Qty", Type.GetType("System.Double"));

            //	Set the name of the dataset this will be used in the store proc
            VisitsDataSet.Tables.Add(VisitParticipantsSave);
            VisitsDataSet.Tables.Add(VisitMessagesSave);
            VisitsDataSet.Tables.Add(VisitPostCall);
            VisitsDataSet.Tables.Add(VisitNextCallObjectives);
            VisitsDataSet.Tables.Add(VisitSamples);
            //VisitsDataSet.Tables.Add(VisitClosingSave);

            //Create Parameter Collection For SQL Command
            visitMasterDataParams = new SqlParameter[7];

            con = new SqlConnection("Data Source=10.10.14.20;Initial Catalog=AmounCRM2;Integrated Security=True");
            cmd = new SqlCommand();
            cmd.Connection = con; ;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "InsertCalls2";
        }

        protected void radSave_Click(object sender, EventArgs e)
        {
            if (ddlWho.SelectedIndex == 0)
            {
                RadWindowManager1.RadAlert("Please Choose One of a Double Visit Options", 400, 200, "Alert!", null, "");
                return;
            }


            if (radDate11.SelectedDate >= DateTime.Now.AddDays(-1000))
            {
                try
                {
                    if ((ddlProduct1.SelectedIndex == ddlProduct2.SelectedIndex && ddlProduct1.SelectedIndex != 0) || (ddlProduct1.SelectedIndex == ddlProduct3.SelectedIndex && ddlProduct1.SelectedIndex != 0) || (ddlProduct2.SelectedIndex == ddlProduct3.SelectedIndex && ddlProduct2.SelectedIndex != 0))
                    {
                        RadWindowManager1.RadAlert("You Have Chosen Similar Products, Please Choose Different Products", 400, 200, "Alert!", null, "");
                        return;
                    }

                    CreateDT();
                    //prepareToSave();

                    fillingDT();
                    //Insert Into DataTables

                    //Begin of Validation
                    if (VisitsDataSet.Tables["VisitMessagesSave"].Rows.Count == 0)
                    {
                        RadWindowManager1.RadAlert("Please select at least one Product", 400, 200, "Alert!", null, "");
                        return;
                    }

                    string errMes = "";
                    if (ddlProduct1.SelectedIndex > 0)
                    {
                        errMes = "";
                        if ((VisitsDataSet.Tables["VisitPostCall"].Select(String.Concat("ProductID = ", ddlProduct1.SelectedValue))).Length == 0)
                        {
                            errMes = "Please select at least one Post Call Choice for " + ddlProduct1.SelectedItem.Text;
                            RadWindowManager1.RadAlert(errMes, 400, 200, "Alert!", null, "");
                            return;
                        }
                        if ((VisitsDataSet.Tables["VisitNextCallObjectives"].Select(String.Concat("ProductID = ", ddlProduct1.SelectedValue))).Length == 0)
                        {
                            errMes = "Please select at least one Next Call Objective Choice for " + ddlProduct1.SelectedItem.Text;
                            RadWindowManager1.RadAlert(errMes, 400, 200, "Alert!", null, "");
                            return;
                        }
                        if (int.Parse(VisitsDataSet.Tables["VisitMessagesSave"].Rows[0][1].ToString()) == 0)
                        {
                            errMes = "Please select an Adoption Ladder Step for " + ddlProduct1.SelectedItem.Text;
                            RadWindowManager1.RadAlert(errMes, 400, 200, "Alert!", null, "");
                            return;
                        }
                    }
                    if (ddlProduct2.SelectedIndex > 0)
                    {
                        if ((VisitsDataSet.Tables["VisitPostCall"].Select(String.Concat("ProductID = ", ddlProduct2.SelectedValue))).Length == 0)
                        {
                            errMes = "Please select at least one Post Call Choice for " + ddlProduct2.SelectedItem.Text;
                            RadWindowManager1.RadAlert(errMes, 400, 200, "Alert!", null, "");
                            return;
                        }
                        if ((VisitsDataSet.Tables["VisitNextCallObjectives"].Select(String.Concat("ProductID = ", ddlProduct2.SelectedValue))).Length == 0)
                        {
                            errMes = "Please select at least one Next Call Objective Choice for " + ddlProduct2.SelectedItem.Text;
                            RadWindowManager1.RadAlert(errMes, 400, 200, "Alert!", null, "");
                            return;
                        }
                        if (int.Parse(VisitsDataSet.Tables["VisitMessagesSave"].Rows[1][1].ToString()) == 0)
                        {
                            errMes = "Please select an Adoption Ladder Step for " + ddlProduct2.SelectedItem.Text;
                            RadWindowManager1.RadAlert(errMes, 400, 200, "Alert!", null, "");
                            return;
                        }
                    }
                    if (ddlProduct3.SelectedIndex > 0)
                    {
                        if ((VisitsDataSet.Tables["VisitPostCall"].Select(String.Concat("ProductID = ", ddlProduct3.SelectedValue))).Length == 0)
                        {
                            errMes = "Please select at least one Post Call Choice for " + ddlProduct3.SelectedItem.Text;
                            RadWindowManager1.RadAlert(errMes, 400, 200, "Alert!", null, "");
                            return;
                        }
                        if ((VisitsDataSet.Tables["VisitNextCallObjectives"].Select(String.Concat("ProductID = ", ddlProduct3.SelectedValue))).Length == 0)
                        {
                            errMes = "Please select at least one Next Call Objective Choice for" + ddlProduct3.SelectedItem.Text;
                            RadWindowManager1.RadAlert(errMes, 400, 200, "Alert!", null, "");
                            return;
                        }
                        if (int.Parse(VisitsDataSet.Tables["VisitMessagesSave"].Rows[2][1].ToString()) == 0)
                        {
                            errMes = "Please select an Adoption Ladder Step for " + ddlProduct3.SelectedItem.Text;
                            RadWindowManager1.RadAlert(errMes, 400, 200, "Alert!", null, "");
                            return;
                        }
                    }
                    //End of Validation

                    //	Create the XML
                    detailsXML = VisitsDataSet.GetXml();

                    //Fill SQL Parameter Collection
                    visitMasterDataParams[0] = new SqlParameter("@VisitTypeID", SqlDbType.Int);
                    visitMasterDataParams[0].Value = 1;

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

                    cmd.Parameters.AddRange(visitMasterDataParams);
                    con.Open();
                    object o = cmd.ExecuteScalar();
                    //txtResult.Text = detailsXML;****commented for testing

                    //Each Time Remove All Old Parameters From a SQL Command
                    cmd.Parameters.Clear();

                    VisitParticipantsSave.Rows.Clear();
                    VisitMessagesSave.Rows.Clear();
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
                    return;
                }
            }
            else
            {
                lblError.Text = "This is too late entry, we're sorry you can not insert it";
                RadWindowManager1.RadAlert("This is too late entry, we're sorry you can not insert it", 400, 200, "Alert!", null, "");
                return;
            }
        }

        private void clearAfterSave()
        {
            Session["PlannedVisitID"] = 0;
            plannedVisitID = 0;

            ViewState["CurrentTable"] = null;
            ViewState["CurrentTable2"] = null;
            ViewState["CurrentTableClosing"] = null;

            //Response.Redirect("~/Reps/CallsScheduler.aspx");
            string jScript = "<script>window.close();</script>";
            ClientScript.RegisterClientScriptBlock(this.GetType(), "keyClientBlock", jScript);
        }

        //private void fillingDT(DropDownList ddlProduct)
        //{
        //    if (ddlProduct.SelectedIndex != 0)
        //    {
        //        foreach (ListItem chk in chklPro1NextCallObjective1.Items)
        //        {
        //            if (chk.Selected == true)
        //            {
        //                DataRow nr = VisitNextCallObjectives.NewRow();
        //                nr["ProductID"] = ddlProduct1.SelectedValue;
        //                nr["NextCallObjectiveID"] = chk.Value;
        //                VisitNextCallObjectives.Rows.Add(nr);
        //            }
        //        }
        //        foreach (ListItem chk in chklPro1PhysicianRequest1.Items)
        //        {
        //            if (chk.Selected == true)
        //            {
        //                DataRow nr = VisitRequests.NewRow();
        //                nr["ProductID"] = ddlProduct1.SelectedValue;
        //                nr["PhysicianRequestID"] = chk.Value;
        //                nr["Qty"] = 1;
        //                VisitRequests.Rows.Add(nr);
        //            }
        //        }
        //        foreach (ListItem chk in chklPro1PostCalls1.Items)
        //        {
        //            if (chk.Selected == true)
        //            {
        //                DataRow nr = VisitPostCall.NewRow();
        //                nr["ProductID"] = ddlProduct1.SelectedValue;
        //                nr["PostCallAnalysisID"] = chk.Value;
        //                VisitPostCall.Rows.Add(nr);
        //            }
        //        }
        //        foreach (ListItem chk in rep1Pro1Samples1.Items)
        //        {
        //            if (chk.Selected == true)
        //            {
        //                DataRow nr = VisitSamples.NewRow();
        //                nr["ProductID"] = ddlProduct1.SelectedValue;
        //                nr["SampleID"] = chk.Value;
        //                nr["Qty"] = 1;
        //                VisitSamples.Rows.Add(nr);
        //            }
        //        }
        //    }
        //}

        private void fillingDT()
        {
            //Start Filling Data Tables For Save - Product 1
            if (ddlProduct1.SelectedIndex > 0)
            {
                DataRow drProd1Messages = VisitMessagesSave.NewRow();
                drProd1Messages[0] = int.Parse(ddlProduct1.SelectedValue);
                drProd1Messages[1] = int.Parse(ddlAdoptionLadderStep1.SelectedValue);
                VisitMessagesSave.Rows.Add(drProd1Messages);

                foreach (RepeaterItem item in this.rep1Pro1Samples1.Items)
                {
                    CheckBox chk = item.FindControl("chkPro1Samples1") as CheckBox;
                    TextBox txt = item.FindControl("txtPro1Samples1Qty") as TextBox;
                    if (chk.Checked)
                    {
                        DataRow drProd1Samples = VisitSamples.NewRow();
                        drProd1Samples[0] = int.Parse(ddlProduct1.SelectedValue);//Product ID
                        drProd1Samples[1] = int.Parse(chk.ToolTip);//SampleID
                        if (txt.Text == "")
                        {
                            txt.Text = "1";
                        }
                        drProd1Samples[2] = int.Parse(txt.Text);//Qty
                        VisitSamples.Rows.Add(drProd1Samples);
                    }
                }

                foreach (ListItem item in chklPro1PostCalls1.Items)
                {
                    if (item.Selected == true)
                    {
                        DataRow drProd1PostCall = VisitPostCall.NewRow();
                        drProd1PostCall[0] = int.Parse(ddlProduct1.SelectedValue);//Product ID
                        drProd1PostCall[1] = int.Parse(item.Value);//Post Call ID
                        VisitPostCall.Rows.Add(drProd1PostCall);
                    }
                }

                foreach (ListItem item in chklPro1NextCallObjective1.Items)
                {
                    if (item.Selected == true)
                    {
                        DataRow drProd1NextCallObjectives = VisitNextCallObjectives.NewRow();
                        drProd1NextCallObjectives[0] = int.Parse(ddlProduct1.SelectedValue);//Product ID
                        drProd1NextCallObjectives[1] = int.Parse(item.Value);//Next Call Objective ID
                        VisitNextCallObjectives.Rows.Add(drProd1NextCallObjectives);
                    }
                }
            }
            //End Filling Data Tables For Save - Product 1


            //Start Filling Data Tables For Save - Product 2
            if (ddlProduct2.SelectedIndex > 0)
            {
                DataRow drProd2Messages = VisitMessagesSave.NewRow();
                drProd2Messages[0] = int.Parse(ddlProduct2.SelectedValue);
                drProd2Messages[1] = int.Parse(ddlAdoptionLadderStep2.SelectedValue);
                VisitMessagesSave.Rows.Add(drProd2Messages);

                foreach (RepeaterItem item in rep2Pro2Samples2.Items)
                {
                    CheckBox chk = item.FindControl("chkPro2Samples2") as CheckBox;
                    TextBox txt = item.FindControl("txtPro2Samples2Qty") as TextBox;
                    if (chk.Checked)
                    {
                        DataRow drProd2Samples = VisitSamples.NewRow();
                        drProd2Samples[0] = int.Parse(ddlProduct2.SelectedValue);//Product ID
                        drProd2Samples[1] = int.Parse(chk.ToolTip);//SampleID
                        if (txt.Text == "")
                        {
                            txt.Text = "1";
                        }
                        drProd2Samples[2] = int.Parse(txt.Text);//Qty
                        VisitSamples.Rows.Add(drProd2Samples);
                    }
                }

                foreach (ListItem item in chklPro2PostCalls2.Items)
                {
                    if (item.Selected == true)
                    {
                        DataRow drProd2PostCall = VisitPostCall.NewRow();
                        drProd2PostCall[0] = int.Parse(ddlProduct2.SelectedValue);//Product ID
                        drProd2PostCall[1] = int.Parse(item.Value);//Post Call ID
                        VisitPostCall.Rows.Add(drProd2PostCall);
                    }
                }

                foreach (ListItem item in chklPro2NextCallObjective2.Items)
                {
                    if (item.Selected == true)
                    {
                        DataRow drProd2NextCallObjectives = VisitNextCallObjectives.NewRow();
                        drProd2NextCallObjectives[0] = int.Parse(ddlProduct2.SelectedValue);//Product ID
                        drProd2NextCallObjectives[1] = int.Parse(item.Value);//Next Call Objective ID
                        VisitNextCallObjectives.Rows.Add(drProd2NextCallObjectives);
                    }
                }
            }
            //End Filling Data Tables For Save - Product 2


            //Start Filling Data Tables For Save - Product 3
            if (ddlProduct3.SelectedIndex > 0)
            {
                DataRow drProd3Messages = VisitMessagesSave.NewRow();
                drProd3Messages[0] = int.Parse(ddlProduct3.SelectedValue);
                drProd3Messages[1] = int.Parse(ddlAdoptionLadderStep3.SelectedValue);
                VisitMessagesSave.Rows.Add(drProd3Messages);

                foreach (RepeaterItem item in rep3Pro3Samples3.Items)
                {
                    CheckBox chk = item.FindControl("chkPro3Samples3") as CheckBox;
                    TextBox txt = item.FindControl("txtPro3Samples3Qty") as TextBox;
                    if (chk.Checked)
                    {
                        DataRow drProd3Samples = VisitSamples.NewRow();
                        drProd3Samples[0] = int.Parse(ddlProduct3.SelectedValue);//Product ID
                        drProd3Samples[1] = int.Parse(chk.ToolTip);//SampleID
                        if (txt.Text == "")
                        {
                            txt.Text = "1";
                        }
                        drProd3Samples[2] = int.Parse(txt.Text);//Qty
                        VisitSamples.Rows.Add(drProd3Samples);
                    }
                }

                foreach (ListItem item in chklPro3PostCalls3.Items)
                {
                    if (item.Selected == true)
                    {
                        DataRow drProd3PostCall = VisitPostCall.NewRow();
                        drProd3PostCall[0] = int.Parse(ddlProduct3.SelectedValue);//Product ID
                        drProd3PostCall[1] = int.Parse(item.Value);//Post Call ID
                        VisitPostCall.Rows.Add(drProd3PostCall);
                    }
                }

                foreach (ListItem item in chklPro3NextCallObjective3.Items)
                {
                    if (item.Selected == true)
                    {
                        DataRow drProd3NextCallObjectives = VisitNextCallObjectives.NewRow();
                        drProd3NextCallObjectives[0] = int.Parse(ddlProduct3.SelectedValue);//Product ID
                        drProd3NextCallObjectives[1] = int.Parse(item.Value);//Next Call Objective ID
                        VisitNextCallObjectives.Rows.Add(drProd3NextCallObjectives);
                    }
                }
            }
            //End Filling Data Tables For Save - Product 3
        }

        private void postCallEditPrep()
        {
            SqlCommand cmdForEdit = new SqlCommand();
            cmdForEdit.CommandType = CommandType.Text;
            cmdForEdit.Connection = con;
            SqlDataAdapter visitAda2;

            //Visit Post Call Edit Preparation
            VisitPostCall2 = new DataTable("VisitPostCall2");
            VisitPostCall2.Columns.Add("VisitMessageID", Type.GetType("System.String"));//Added to collect all post calls for all products
            VisitPostCall2.Columns.Add("ProductID", Type.GetType("System.String"));//Added to collect all post calls for all products
            VisitPostCall2.Columns.Add("PostCallAnalysisID", Type.GetType("System.String"));
            VisitPostCall2.Columns.Add("PostCallAnalysisName", Type.GetType("System.String"));

            //cmdForEdit.CommandText = "SELECT DISTINCT PostCallAnalysisID, PostCallAnalysisName FROM View_VisitPostCallAnalysis WHERE AppointmentID = " + visitIDForEdit + " AND ProductID = " + int.Parse(ddlProduct1.SelectedValue) + " Orde By VisitMessageID ASC";
            cmdForEdit.CommandText = "SELECT DISTINCT VisitMessageID, ProductID, PostCallAnalysisID, PostCallAnalysisName FROM View_VisitPostCallAnalysis WHERE AppointmentID = " + visitIDForEdit + " Order By VisitMessageID ASC";
            visitAda2 = new SqlDataAdapter(cmdForEdit.CommandText, con);
            visitAda2.Fill(VisitPostCall2);

            chklPro1PostCalls1.DataBind();
            chklPro1NextCallObjective1.DataBind();

            chklPro2PostCalls2.DataBind();
            chklPro2NextCallObjective2.DataBind();

            chklPro3PostCalls3.DataBind();
            chklPro3NextCallObjective3.DataBind();

            for (int ii = 0; ii < VisitPostCall2.Rows.Count; ii++)
            {
                if (int.Parse(ddlProduct1.SelectedValue) == int.Parse(VisitPostCall2.Rows[ii][1].ToString()))
                {
                    foreach (ListItem item in chklPro1PostCalls1.Items)
                    {
                        if (item.Value == VisitPostCall2.Rows[ii][2].ToString())
                        {
                            item.Selected = true;
                        }
                    }
                }

                if (int.Parse(ddlProduct2.SelectedValue) == int.Parse(VisitPostCall2.Rows[ii][1].ToString()))
                {
                    foreach (ListItem item in chklPro2PostCalls2.Items)
                    {
                        if (item.Value == VisitPostCall2.Rows[ii][2].ToString())
                        {
                            item.Selected = true;
                        }
                    }
                }

                if (int.Parse(ddlProduct3.SelectedValue) == int.Parse(VisitPostCall2.Rows[ii][1].ToString()))
                {
                    foreach (ListItem item in chklPro3PostCalls3.Items)
                    {
                        if (item.Value == VisitPostCall2.Rows[ii][2].ToString())
                        {
                            item.Selected = true;
                        }
                    }
                }
            }

            //End Of Visit Post Call Edit Preparation
        }

        private void nextCallEditPrep()
        {
            SqlCommand cmdForEdit = new SqlCommand();
            cmdForEdit.CommandType = CommandType.Text;
            cmdForEdit.Connection = con;
            SqlDataAdapter visitAda2;

            //Next Call Edit Preparation
            //Visit Next Call Edit Preparation
            VisitNextCallObjectives2 = new DataTable("VisitNextCallObjectives2");
            VisitNextCallObjectives2.Columns.Add("VisitMessageID", Type.GetType("System.String"));//Added to collect all post calls for all products
            VisitNextCallObjectives2.Columns.Add("ProductID", Type.GetType("System.String"));//Added to collect all post calls for all products
            VisitNextCallObjectives2.Columns.Add("NextCallObjectiveID", Type.GetType("System.String"));
            VisitNextCallObjectives2.Columns.Add("NextCallObjectiveName", Type.GetType("System.String"));
            VisitNextCallObjectives2.Columns.Add("VisitNextCallObjRecID", Type.GetType("System.String"));

            //cmdForEdit.CommandText = "SELECT DISTINCT PostCallAnalysisID, PostCallAnalysisName FROM View_VisitPostCallAnalysis WHERE AppointmentID = " + visitIDForEdit + " AND ProductID = " + int.Parse(ddlProduct1.SelectedValue) + " Orde By VisitMessageID ASC";
            cmdForEdit.CommandText = "SELECT DISTINCT VisitMessageID, ProductID, NextCallObjectiveID, NextCallObjectiveName, VisitNextCallObjRecID FROM View_VisitNextCallObjectives WHERE AppointmentID = " + visitIDForEdit + " Order By VisitmessageID ASC, VisitNextCallObjRecID ASC";
            visitAda2 = new SqlDataAdapter(cmdForEdit.CommandText, con);
            visitAda2.Fill(VisitNextCallObjectives2);

            for (int ii = 0; ii < VisitNextCallObjectives2.Rows.Count; ii++)
            {
                if (int.Parse(ddlProduct1.SelectedValue) == int.Parse(VisitNextCallObjectives2.Rows[ii][1].ToString()))
                {
                    foreach (ListItem item in chklPro1NextCallObjective1.Items)
                    {
                        if (item.Value == VisitNextCallObjectives2.Rows[ii][2].ToString())
                        {
                            item.Selected = true;
                        }
                    }
                }

                if (int.Parse(ddlProduct2.SelectedValue) == int.Parse(VisitNextCallObjectives2.Rows[ii][1].ToString()))
                {
                    foreach (ListItem item in chklPro2NextCallObjective2.Items)
                    {
                        if (item.Value == VisitNextCallObjectives2.Rows[ii][2].ToString())
                        {
                            item.Selected = true;
                        }
                    }
                }

                if (int.Parse(ddlProduct3.SelectedValue) == int.Parse(VisitNextCallObjectives2.Rows[ii][1].ToString()))
                {
                    foreach (ListItem item in chklPro3NextCallObjective3.Items)
                    {
                        if (item.Value == VisitNextCallObjectives2.Rows[ii][2].ToString())
                        {
                            item.Selected = true;
                        }
                    }
                }
            }

            //End Of Visit Post Call Edit Preparation
        }

        private void samplesEditPrep()
        {
            SqlCommand cmdForEdit = new SqlCommand();
            cmdForEdit.CommandType = CommandType.Text;
            cmdForEdit.Connection = con;
            SqlDataAdapter visitAda2;

            //Visit Samples Edit Preparation
            VisitSamples2 = new DataTable("VisitSamples2");
            VisitSamples2.Columns.Add("VisitMessageID", Type.GetType("System.String"));//Added to collect all post calls for all products
            VisitSamples2.Columns.Add("ProductID", Type.GetType("System.String"));//Added to collect all post calls for all products
            VisitSamples2.Columns.Add("SampleID", Type.GetType("System.String"));
            VisitSamples2.Columns.Add("SampleName", Type.GetType("System.String"));
            VisitSamples2.Columns.Add("Qty", Type.GetType("System.Double"));
            VisitSamples2.Columns.Add("VisitSamplesRecID", Type.GetType("System.String"));//Added to collect all post calls for all products
            //End Of Visit Samples Edit Preparation

            //cmdForEdit.CommandText = "SELECT DISTINCT PostCallAnalysisID, PostCallAnalysisName FROM View_VisitPostCallAnalysis WHERE AppointmentID = " + visitIDForEdit + " AND ProductID = " + int.Parse(ddlProduct1.SelectedValue) + " Orde By VisitMessageID ASC";
            cmdForEdit.CommandText = "SELECT DISTINCT VisitMessageID, ProductID, SampleID, SampleName, Qty, VisitSamplesRecID FROM View_VisitSamples WHERE AppointmentID = " + visitIDForEdit + " Order By VisitmessageID ASC, VisitSamplesRecID ASC";
            visitAda2 = new SqlDataAdapter(cmdForEdit.CommandText, con);
            visitAda2.Fill(VisitSamples2);

            for (int ii = 0; ii < VisitSamples2.Rows.Count; ii++)
            {
                if (int.Parse(ddlProduct1.SelectedValue) == int.Parse(VisitSamples2.Rows[ii][1].ToString()))
                {
                    foreach (RepeaterItem item in this.rep1Pro1Samples1.Items)
                    {
                        CheckBox chk = item.FindControl("chkPro1Samples1") as CheckBox;
                        TextBox txt = item.FindControl("txtPro1Samples1Qty") as TextBox;

                        if (chk.ToolTip == VisitSamples2.Rows[ii][2].ToString())
                        {
                            //string collageName = (item.FindControl("txtCollageName") as TextBox).Text;
                            //string degree = chk.Text;
                            chk.Checked = true;
                            txt.Text = VisitSamples2.Rows[ii][4].ToString();
                        }
                    }
                }

                if (int.Parse(ddlProduct2.SelectedValue) == int.Parse(VisitSamples2.Rows[ii][1].ToString()))
                {
                    foreach (RepeaterItem item in this.rep2Pro2Samples2.Items)
                    {
                        CheckBox chk = item.FindControl("chkPro2Samples2") as CheckBox;
                        TextBox txt = item.FindControl("txtPro2Samples2Qty") as TextBox;

                        if (chk.ToolTip == VisitSamples2.Rows[ii][2].ToString())
                        {
                            //string collageName = (item.FindControl("txtCollageName") as TextBox).Text;
                            //string degree = chk.Text;
                            chk.Checked = true;
                            txt.Text = VisitSamples2.Rows[ii][4].ToString();
                        }
                    }
                }

                if (int.Parse(ddlProduct3.SelectedValue) == int.Parse(VisitSamples2.Rows[ii][1].ToString()))
                {
                    foreach (RepeaterItem item in this.rep3Pro3Samples3.Items)
                    {
                        CheckBox chk = item.FindControl("chkPro3Samples3") as CheckBox;
                        TextBox txt = item.FindControl("txtPro3Samples3Qty") as TextBox;

                        if (chk.ToolTip == VisitSamples2.Rows[ii][2].ToString())
                        {
                            //string collageName = (item.FindControl("txtCollageName") as TextBox).Text;
                            //string degree = chk.Text;
                            chk.Checked = true;
                            txt.Text = VisitSamples2.Rows[ii][4].ToString();
                        }
                    }
                }
            }

            //End Of Visit Post Call Edit Preparation
        }

        protected void ddlProduct1_PreRender(object sender, EventArgs e)
        {
            if (ddlProduct1.Items.Count == 2)//Select & First Product
            {
                tbl1.Rows[1].Visible = false;
                tbl1.Rows[2].Visible = false;
                tbl1.Rows[3].Visible = false;
                tbl1.Rows[4].Visible = false;
            }
            else if (ddlProduct1.Items.Count == 3)//Select & First Product & Second Product
            {
                tbl1.Rows[3].Visible = false;
                tbl1.Rows[4].Visible = false;
            }
            else
            {
                tbl1.Rows[1].Visible = true;
                tbl1.Rows[2].Visible = true;
                tbl1.Rows[3].Visible = true;
                tbl1.Rows[4].Visible = true;
            }
        }

        protected void chkPro1Samples1_CheckedChanged(object sender, EventArgs e)
        {
            foreach (RepeaterItem item in this.rep1Pro1Samples1.Items)
            {
                CheckBox chk = item.FindControl("chkPro1Samples1") as CheckBox;
                TextBox txt = item.FindControl("txtPro1Samples1Qty") as TextBox;

                if ((chk.Checked == true) && (txt.Text == "0"))
                {
                    txt.Text = "1";
                }
                if ((chk.Checked == true) && (int.Parse(txt.Text) != 0))
                {
                    //
                }
                if ((chk.Checked == false) && (int.Parse(txt.Text) != 0))
                {
                    txt.Text = "0";
                }
                if ((chk.Checked == false) && (int.Parse(txt.Text) == 0))
                {
                    //
                }
            }
        }

        protected void chkPro2Samples2_CheckedChanged(object sender, EventArgs e)
        {
            foreach (RepeaterItem item in this.rep2Pro2Samples2.Items)
            {
                CheckBox chk = item.FindControl("chkPro2Samples2") as CheckBox;
                TextBox txt = item.FindControl("txtPro2Samples2Qty") as TextBox;

                if ((chk.Checked == true) && (txt.Text == "0"))
                {
                    txt.Text = "1";
                }
                if ((chk.Checked == true) && (int.Parse(txt.Text) != 0))
                {
                    //
                }
                if ((chk.Checked == false) && (int.Parse(txt.Text) != 0))
                {
                    txt.Text = "0";
                }
                if ((chk.Checked == false) && (int.Parse(txt.Text) == 0))
                {
                    //
                }
            }
        }

        protected void chkPro3Samples3_CheckedChanged(object sender, EventArgs e)
        {
            foreach (RepeaterItem item in this.rep3Pro3Samples3.Items)
            {
                CheckBox chk = item.FindControl("chkPro3Samples3") as CheckBox;
                TextBox txt = item.FindControl("txtPro3Samples3Qty") as TextBox;

                if ((chk.Checked == true) && (txt.Text == "0"))
                {
                    txt.Text = "1";
                }
                if ((chk.Checked == true) && (int.Parse(txt.Text) != 0))
                {
                    //
                }
                if ((chk.Checked == false) && (int.Parse(txt.Text) != 0))
                {
                    txt.Text = "0";
                }
                if ((chk.Checked == false) && (int.Parse(txt.Text) == 0))
                {
                    //
                }
            }
        }
    }
}