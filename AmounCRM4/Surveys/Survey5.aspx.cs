using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Drawing;

namespace AmounCRM4.Surveys
{
    public partial class Survey5 : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataTable dt;

        SqlCommand cmdIndications;
        SqlDataAdapter daIndications;
        DataTable dtIndications;        

        protected void ddlBrandName_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
        {
            if (ddlBrandName.SelectedIndex >= 1)
            {
                string cmdStr = "Select MarketID, MarketName, AmounProductID From View_Survey_AmounProducts_Market Where AmounProductID = " + ddlBrandName.SelectedValue.ToString();

                con = new SqlConnection(ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ConnectionString);
                cmd = new SqlCommand(cmdStr, con);
                da = new SqlDataAdapter(cmd);
                dt = new DataTable();
                con.Open();
                da.Fill(dt);

                ddlMarketName.Items.Clear();
                ddlMarketName.AppendDataBoundItems = true;
                ddlMarketName.Items.Add("Select");
                ddlMarketName.DataSource = dt;
                ddlMarketName.DataTextField = "MarketName";
                ddlMarketName.DataValueField = "MarketID";
                ddlMarketName.DataBind();
                ddlMarketName.SelectedIndex = 0;

                chklCompetitors.Items.Clear();
                tableContent2.Visible = false;
            }
        }

        protected void ddlMarketName_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
        {
            if (ddlMarketName.SelectedIndex >= 1)
            {
                string cmdStr = "Select CompetitorName, CompetitorID, MarketID From View_Survey_Market_Competitors Where MarketID = " + ddlMarketName.SelectedValue.ToString();

                con = new SqlConnection(ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ConnectionString);
                cmd = new SqlCommand(cmdStr, con);
                da = new SqlDataAdapter(cmd);
                dt = new DataTable();
                con.Open();
                da.Fill(dt);

                chklCompetitors.Items.Clear();
                chklCompetitors.DataSource = dt;
                chklCompetitors.DataTextField = "CompetitorName";
                chklCompetitors.DataValueField = "CompetitorID";
                chklCompetitors.DataBind();
                tableContent2.Visible = false;
            }
        }
        
        protected void btnSave_Click(object sender, EventArgs e)
        {
            if ((txtPharmacy.Text == "") || (txtPacksPerWeek.Text == "") || (txtWeeklyRatio.Text == "") || (ddlBrandName.SelectedIndex == -1) || (ddlMarketName.SelectedIndex == -1) || (chklCompetitors.SelectedIndex == -1))
            {
                lblStatus.Text = "Fill All of The Above Data";
                return;
            }
            con = new SqlConnection(ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ConnectionString);
            cmdIndications = new SqlCommand("Select IndicationID, IndicationName From Survey_Indications", con);
            daIndications = new SqlDataAdapter(cmdIndications);
            dtIndications = new DataTable();
            con.Open();
            daIndications.Fill(dtIndications);

            foreach (GridViewRow r in tableContent2.Rows)
            {
                if (r.Cells[0].Text != "" && r.Cells[0].Text != "Competitors")
                {
                    string selectedSales = ((DropDownList)r.Cells[2].FindControl("ddlSales")).SelectedItem.Text;
                    string selectedActivity = ((DropDownList)r.Cells[3].FindControl("ddlActivity")).SelectedItem.Text;
                    string selectedGeneralActivity = ((DropDownList)r.Cells[3].FindControl("ddlGeneralActivity")).SelectedItem.Text;

                    if (selectedSales == "None" && selectedActivity == "None" && selectedGeneralActivity == "None")
                    {

                    }
                    else
                    {
                        int indComp = (chklCompetitors.Items.IndexOf(chklCompetitors.Items.FindByText(r.Cells[0].Text)));
                        string valComp = chklCompetitors.Items[indComp].Value;
                        string searchIndication = "IndicationName = '" + r.Cells[1].Text + "'";

                        dsSurveySave.InsertParameters[0].DefaultValue = txtPharmacy.Text;
                        dsSurveySave.InsertParameters[1].DefaultValue = ddlBrandName.SelectedValue;
                        dsSurveySave.InsertParameters[2].DefaultValue = ddlMarketName.SelectedValue;
                        dsSurveySave.InsertParameters[3].DefaultValue = valComp;
                        dsSurveySave.InsertParameters[4].DefaultValue = dtIndications.Select(searchIndication)[0][0].ToString();
                        dsSurveySave.InsertParameters[5].DefaultValue = selectedSales == "None" ? "0" : ((DropDownList)r.Cells[2].FindControl("ddlSales")).SelectedValue;
                        dsSurveySave.InsertParameters[6].DefaultValue = selectedActivity == "None" ? "22" : ((DropDownList)r.Cells[3].FindControl("ddlActivity")).SelectedValue;
                        dsSurveySave.InsertParameters[7].DefaultValue = selectedGeneralActivity == "None" ? "23" : ((DropDownList)r.Cells[4].FindControl("ddlGeneralActivity")).SelectedValue;
                        dsSurveySave.InsertParameters[8].DefaultValue = txtWeeklyRatio.Text;
                        dsSurveySave.InsertParameters[9].DefaultValue = txtPacksPerWeek.Text;
                        dsSurveySave.InsertParameters[10].DefaultValue = Session["LineID"].ToString();
                        dsSurveySave.InsertParameters[11].DefaultValue = Session["EmployeeID"].ToString();
                        dsSurveySave.InsertParameters[12].DefaultValue = DateTime.Now.ToShortDateString();

                        dsSurveySave.Insert();
                    }
                }
            }

            //txtPharmacy.Text = "";
            txtPacksPerWeek.Text = "";
            txtWeeklyRatio.Text = "";
            //ddlBrandName.SelectedIndex = -1;
            ddlMarketName.SelectedIndex = -1;
            chklCompetitors.Items.Clear();
            tableContent2.Visible = false;
            lblStatus.Text = "Ready...";
        }

        protected void chklCompetitors_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (chklCompetitors.SelectedIndex > -1)
            {
                //FillTable();
                string strCompetitorsID = "0";
                foreach (ListItem item in chklCompetitors.Items)
                {
                    if (item.Selected == true)
                    {
                        strCompetitorsID += "," + int.Parse(item.Value.ToString());
                    }
                }
                dsProds.DataBind();
                dsProds.FilterExpression = @"AmounProductID = " + int.Parse(ddlBrandName.SelectedValue) + 
                    " AND MarketID = " + int.Parse(ddlMarketName.SelectedValue) + " AND CompetitorID IN (" + strCompetitorsID  + ")";
                dsProds.DataBind();

                /*
                DataTable t = ((DataView)(dsProds.Select(new DataSourceSelectArguments()))).ToTable("t");
                DataTable t2 = t.Clone();
                string firstRowFirstCell = t.Rows[0][3].ToString();
                foreach (DataRow rT in t.Rows)
                {
                    if (rT[3].ToString() != firstRowFirstCell)
                    {
                        DataRow rEmpty = t2.NewRow();
                        rEmpty[0] = string.Empty;
                        rEmpty[1] = DBNull.Value;
                        rEmpty[2] = null;
                        rEmpty[3] = null;
                        rEmpty[4] = null;
                        rEmpty[5] = DBNull.Value;
                        rEmpty[6] = DBNull.Value;
                        rEmpty[7] = DBNull.Value;
                        rEmpty[8] = DBNull.Value;
                        t2.Rows.Add(rEmpty);
                        firstRowFirstCell = rT[3].ToString();
                    }

                    DataRow rData = t2.NewRow();
                    rData[0] = rT[0];
                    rData[1] = rT[1];
                    rData[2] = rT[2];
                    rData[3] = rT[3];
                    rData[4] = rT[4];
                    rData[5] = rT[5];
                    rData[6] = rT[6];
                    rData[7] = rT[7];
                    rData[8] = rT[8];
                    t2.Rows.Add(rData);
                }
                t = t2;
                tableContent2.DataSourceID = "";
                tableContent2.DataSource = t;
                */

                tableContent2.DataBind();

                /*
                foreach (GridViewRow rTableContent in tableContent2.Rows)
                {
                    if (rTableContent.Cells[0].Text == "" || (rTableContent.Cells[0].Text == "&nbsp;"))
                    {
                        rTableContent.BackColor = Color.White;
                        rTableContent.Cells[3].Visible = false;
                    }
                }
                */

                tableContent2.Visible = true;
            }
            else
            {
                tableContent2.Visible = false;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if ((Session["EmployeeID"].ToString() == ""))
            {
                Response.Redirect("~/Login2.aspx");
            }
            if (!Page.IsPostBack)
            {
                tableContent2.DataSourceID = "dsProds";
                tableContent2.Visible = false;
            }
        }
    }
}