using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Telerik.Web.UI;
using System.Drawing;
using AmounCRM4.App_Data;
using static AmounCRM4.App_Data.ExecSummary3;
using AmounCRM4.App_Data.ExecSummary3TableAdapters;

namespace AmounCRM4.Reps
{
    public partial class RepReport_Dashboard2 : System.Web.UI.Page
    {
        //ExecSummary3 summary;

        Total_CovFreqCallsTableAdapter totalAda;
        Total_CovFreqCallsDataTable totalTable;

        ByClass_CovFreqCallsTableAdapter byClassAda;
        ByClass_CovFreqCallsDataTable byClassTable;

        BySpec_CovFreqCallsTableAdapter bySpecAda;
        BySpec_CovFreqCallsDataTable bySpecTable;

        //ByBrick_CovFreqCallsTableAdapter byBrickAda;
        //ByBrick_CovFreqCallsDataTable byBrickTable;
        
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeID"].ToString() == "")
            {
                Response.Redirect("~/Login2.aspx");
            }

            GetTotal();
            GetByClass();
            GetBySpec();
        }

        private void GetTotal()
        {
            totalTable = new Total_CovFreqCallsDataTable();
            totalAda = new Total_CovFreqCallsTableAdapter();
            totalAda.FillCovFreq(totalTable, int.Parse(Session["EmployeeID"].ToString()), int.Parse(Session["CycleID"].ToString()));

            if (totalTable.Rows.Count == 0)
            {
                txtCovTotal.Text = "No Data Found";
                txtFreqTotal.Text = "No Data Found";
                txtCallsTotal.Text = "No Data Found";
            }
            else
            {
                //tblContainer.Rows[0].Cells[0].Text = "Total Coverage" + System.Environment.NewLine + "<br />" + "<br />";
                //tblContainer.Rows[0].Cells[0].Text += "T: " + Math.Round(float.Parse(totalTable.Rows[0]["TargetDoctors"].ToString()), 0) + System.Environment.NewLine + "<br />";
                //tblContainer.Rows[0].Cells[0].Text += "A: " + Math.Round(float.Parse(totalTable.Rows[0]["VisitedDoctors"].ToString()), 0) + System.Environment.NewLine + "<br />";
                //tblContainer.Rows[0].Cells[0].Text += "R: " + Math.Round((((float.Parse(totalTable.Rows[0]["VisitedDoctors"].ToString())) / (float.Parse(totalTable.Rows[0]["TargetDoctors"].ToString()))) * 100), 0) + "%";
                //tblContainer.Rows[0].Cells[0].Text += "<br />";
                //tblContainer.Rows[0].Cells[0].ForeColor = Color.White;

                //tblContainer.Rows[0].Cells[0].HorizontalAlign = HorizontalAlign.Left;
                //tblContainer.Rows[0].Cells[0].CssClass = "b";

                lblTotalCovLabel.Width = tblContainer.Rows[0].Cells[0].Width;
                txtCovTotal.Text = "T: " + Math.Round(float.Parse(totalTable.Rows[0]["TargetDoctors"].ToString()), 0) + System.Environment.NewLine;
                txtCovTotal.Text += "A: " + Math.Round(float.Parse(totalTable.Rows[0]["VisitedDoctors"].ToString()), 0) + System.Environment.NewLine;
                txtCovTotal.Text += "R: " + Math.Round((((float.Parse(totalTable.Rows[0]["VisitedDoctors"].ToString())) / (float.Parse(totalTable.Rows[0]["TargetDoctors"].ToString()))) * 100), 0) + "%";

                txtFreqTotal.Text = "T: " + Math.Round(float.Parse(totalTable.Rows[0]["TargetVisits"].ToString()), 0) + System.Environment.NewLine;
                txtFreqTotal.Text += "A: " + Math.Round(float.Parse(totalTable.Rows[0]["ActualVisits"].ToString()), 0) + System.Environment.NewLine;
                txtFreqTotal.Text += "R: " + Math.Round((((float.Parse(totalTable.Rows[0]["ActualVisits"].ToString())) / (float.Parse(totalTable.Rows[0]["TargetVisits"].ToString()))) * 100), 0) + "%";

                txtCallsTotal.Text = "T: " + Math.Round(float.Parse(totalTable.Rows[0]["TargetCalls"].ToString()), 0) + System.Environment.NewLine;
                txtCallsTotal.Text += "A: " + Math.Round(float.Parse(totalTable.Rows[0]["ActualCalls"].ToString()), 0) + System.Environment.NewLine;
                txtCallsTotal.Text += "R: " + Math.Round((((float.Parse(totalTable.Rows[0]["ActualCalls"].ToString())) / (float.Parse(totalTable.Rows[0]["TargetCalls"].ToString()))) * 100), 0) + "%";
            }
        }

        private void GetByClass()
        {
            byClassTable = new ByClass_CovFreqCallsDataTable();
            byClassAda = new ByClass_CovFreqCallsTableAdapter();
            byClassAda.FillCovFreq(byClassTable, int.Parse(Session["EmployeeID"].ToString()), int.Parse(Session["CycleID"].ToString()));

            if (byClassTable.Rows.Count == 0)
            {
                txtCovAplus.Text = "No Data Found";
                txtFreqAplus.Text = "No Data Found";
                txtCallsAplus.Text = "No Data Found";

                txtCovA.Text = "No Data Found";
                txtFreqA.Text = "No Data Found";
                txtCallsA.Text = "No Data Found";
            }
            else
            {
                if (byClassTable.Rows.Count == 1)
                {
                    if (byClassTable.Rows[0][8].ToString() == "A")
                    {
                        txtCovAplus.Text = "No Data Found";
                        txtFreqAplus.Text = "No Data Found";
                        txtCallsAplus.Text = "No Data Found";

                        txtCovA.Text = "T: " + Math.Round(float.Parse(byClassTable.Rows[0]["TargetDoctors"].ToString()), 0) + System.Environment.NewLine;
                        txtCovA.Text += "A: " + Math.Round(float.Parse(byClassTable.Rows[0]["VisitedDoctors"].ToString()), 0) + System.Environment.NewLine;
                        txtCovA.Text += "R: " + Math.Round((((float.Parse(byClassTable.Rows[0]["VisitedDoctors"].ToString())) / (float.Parse(totalTable.Rows[0]["TargetDoctors"].ToString()))) * 100), 0) + "%";

                        txtFreqA.Text = "T: " + Math.Round(float.Parse(byClassTable.Rows[0]["TargetVisits"].ToString()), 0) + System.Environment.NewLine;
                        txtFreqA.Text += "A: " + Math.Round(float.Parse(byClassTable.Rows[0]["ActualVisits"].ToString()), 0) + System.Environment.NewLine;
                        txtFreqA.Text += "R: " + Math.Round((((float.Parse(byClassTable.Rows[0]["ActualVisits"].ToString())) / (float.Parse(totalTable.Rows[0]["TargetVisits"].ToString()))) * 100), 0) + "%";

                        txtCallsA.Text = "T: " + Math.Round(float.Parse(byClassTable.Rows[0]["TargetCalls"].ToString()), 0) + System.Environment.NewLine;
                        txtCallsA.Text += "A: " + Math.Round(float.Parse(byClassTable.Rows[0]["ActualCalls"].ToString()), 0) + System.Environment.NewLine;
                        txtCallsA.Text += "R: " + Math.Round((((float.Parse(byClassTable.Rows[0]["ActualCalls"].ToString())) / (float.Parse(byClassTable.Rows[0]["TargetCalls"].ToString()))) * 100), 0) + "%";
                    }
                    if (byClassTable.Rows[0][8].ToString() == "A+")
                    {
                        txtCovA.Text = "No Data Found";
                        txtFreqA.Text = "No Data Found";
                        txtCallsA.Text = "No Data Found";

                        txtCovAplus.Text = "T: " + Math.Round(float.Parse(byClassTable.Rows[0]["TargetDoctors"].ToString()), 0) + System.Environment.NewLine;
                        txtCovAplus.Text += "A: " + Math.Round(float.Parse(byClassTable.Rows[0]["VisitedDoctors"].ToString()), 0) + System.Environment.NewLine;
                        txtCovAplus.Text += "R: " + Math.Round((((float.Parse(byClassTable.Rows[0]["VisitedDoctors"].ToString())) / (float.Parse(totalTable.Rows[0]["TargetDoctors"].ToString()))) * 100), 0) + "%";

                        txtFreqAplus.Text = "T: " + Math.Round(float.Parse(byClassTable.Rows[0]["TargetVisits"].ToString()), 0) + System.Environment.NewLine;
                        txtFreqAplus.Text += "A: " + Math.Round(float.Parse(byClassTable.Rows[0]["ActualVisits"].ToString()), 0) + System.Environment.NewLine;
                        txtFreqAplus.Text += "R: " + Math.Round((((float.Parse(byClassTable.Rows[0]["ActualVisits"].ToString())) / (float.Parse(byClassTable.Rows[0]["TargetVisits"].ToString()))) * 100), 0) + "%";

                        txtCallsAplus.Text = "T: " + Math.Round(float.Parse(byClassTable.Rows[0]["TargetCalls"].ToString()), 0) + System.Environment.NewLine;
                        txtCallsAplus.Text += "A: " + Math.Round(float.Parse(byClassTable.Rows[0]["ActualCalls"].ToString()), 0) + System.Environment.NewLine;
                        txtCallsAplus.Text += "R: " + Math.Round((((float.Parse(byClassTable.Rows[0]["ActualCalls"].ToString())) / (float.Parse(byClassTable.Rows[0]["TargetCalls"].ToString()))) * 100), 0) + "%";
                    }
                }
                if (byClassTable.Rows.Count == 2)
                {
                    txtCovA.Text = "T: " + Math.Round(float.Parse(byClassTable.Rows[0]["TargetDoctors"].ToString()), 0) + System.Environment.NewLine;
                    txtCovA.Text += "A: " + Math.Round(float.Parse(byClassTable.Rows[0]["VisitedDoctors"].ToString()), 0) + System.Environment.NewLine;
                    txtCovA.Text += "R: " + Math.Round((((float.Parse(byClassTable.Rows[0]["VisitedDoctors"].ToString())) / (float.Parse(byClassTable.Rows[0]["TargetDoctors"].ToString()))) * 100), 0) + "%";

                    txtFreqA.Text = "T: " + Math.Round(float.Parse(byClassTable.Rows[0]["TargetVisits"].ToString()), 0) + System.Environment.NewLine;
                    txtFreqA.Text += "A: " + Math.Round(float.Parse(byClassTable.Rows[0]["ActualVisits"].ToString()), 0) + System.Environment.NewLine;
                    txtFreqA.Text += "R: " + Math.Round((((float.Parse(byClassTable.Rows[0]["ActualVisits"].ToString())) / (float.Parse(byClassTable.Rows[0]["TargetVisits"].ToString()))) * 100), 0) + "%";

                    txtCallsA.Text = "T: " + Math.Round(float.Parse(byClassTable.Rows[0]["TargetCalls"].ToString()), 0) + System.Environment.NewLine;
                    txtCallsA.Text += "A: " + Math.Round(float.Parse(byClassTable.Rows[0]["ActualCalls"].ToString()), 0) + System.Environment.NewLine;
                    txtCallsA.Text += "R: " + Math.Round((((float.Parse(byClassTable.Rows[0]["ActualCalls"].ToString())) / (float.Parse(byClassTable.Rows[0]["TargetCalls"].ToString()))) * 100), 0) + "%";

                    txtCovAplus.Text = "T: " + Math.Round(float.Parse(byClassTable.Rows[1]["TargetDoctors"].ToString()), 0) + System.Environment.NewLine;
                    txtCovAplus.Text += "A: " + Math.Round(float.Parse(byClassTable.Rows[1]["VisitedDoctors"].ToString()), 0) + System.Environment.NewLine;
                    txtCovAplus.Text += "R: " + Math.Round((((float.Parse(byClassTable.Rows[1]["VisitedDoctors"].ToString())) / (float.Parse(byClassTable.Rows[1]["TargetDoctors"].ToString()))) * 100), 0) + "%";

                    txtFreqAplus.Text = "T: " + Math.Round(float.Parse(byClassTable.Rows[1]["TargetVisits"].ToString()), 0) + System.Environment.NewLine;
                    txtFreqAplus.Text += "A: " + Math.Round(float.Parse(byClassTable.Rows[1]["ActualVisits"].ToString()), 0) + System.Environment.NewLine;
                    txtFreqAplus.Text += "R: " + Math.Round((((float.Parse(byClassTable.Rows[1]["ActualVisits"].ToString())) / (float.Parse(byClassTable.Rows[1]["TargetVisits"].ToString()))) * 100), 0) + "%";

                    txtCallsAplus.Text = "T: " + Math.Round(float.Parse(byClassTable.Rows[1]["TargetCalls"].ToString()), 0) + System.Environment.NewLine;
                    txtCallsAplus.Text += "A: " + Math.Round(float.Parse(byClassTable.Rows[1]["ActualCalls"].ToString()), 0) + System.Environment.NewLine;
                    txtCallsAplus.Text += "R: " + Math.Round((((float.Parse(byClassTable.Rows[1]["ActualCalls"].ToString())) / (float.Parse(byClassTable.Rows[1]["TargetCalls"].ToString()))) * 100), 0) + "%";
                }
            }
        }        

        private void GetBySpec()
        {
            bySpecTable = new BySpec_CovFreqCallsDataTable();
            bySpecAda = new BySpec_CovFreqCallsTableAdapter();
            bySpecAda.FillCovFreq(bySpecTable, int.Parse(Session["EmployeeID"].ToString()), int.Parse(Session["CycleID"].ToString()));
            pieSpec.DataBind();
        }
    }
}