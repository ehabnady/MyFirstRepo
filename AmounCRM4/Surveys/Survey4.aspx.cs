using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace AmounCRM4.Surveys
{
    public partial class Survey4 : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataTable dt;

        SqlCommand cmdIndications;
        SqlDataAdapter daIndications;
        DataTable dtIndications;

        private void FillTable()
        {
            clearTable();

            HtmlTableRow row = new HtmlTableRow();
            HtmlTableCell cell = new HtmlTableCell();
            
            string cmdStr = "Select * From Prods Where LineID >= 1";
            if (ddlBrandName.SelectedIndex >= 1)
            {
                cmdStr += " AND ProductName = '" + ddlBrandName.SelectedText + "'";
            }
            if (ddlMarketName.SelectedIndex >= 1)
            {
                cmdStr += " AND MarketName = '" + ddlMarketName.SelectedText + "'";
            }

            if (chklCompetitors.SelectedIndex >= 0)
            {
                cmdStr += " AND MainCompetitor IN (''";
                foreach (ListItem chk in chklCompetitors.Items)
                {
                    if (chk.Selected == true)
                    {
                        cmdStr += ", '" + (chk.Text) + "'";
                    }
                }
                cmdStr += ")";
            }

            createTableHeader(cell, row);

            con = new SqlConnection(ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ConnectionString);
            cmd = new SqlCommand(cmdStr, con);
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            con.Open();
            da.Fill(dt);

            createTableRows(tableContent);
            tableContent.EnableViewState = true;

            Session["myTable"] = tableContent;
        }

        private void clearTable()
        {
            tableContent.Rows.Clear();
            foreach (HtmlTableRow r in tableContent.Rows)
            {
                tableContent.Rows.Remove(r);
            }
        }

        private void createTableHeader(HtmlTableCell c, HtmlTableRow r)
        {
            //HtmlTableCell c1 = new HtmlTableCell();
            HtmlTableCell c2 = new HtmlTableCell();
            HtmlTableCell c3 = new HtmlTableCell();
            HtmlTableCell c4 = new HtmlTableCell();
            HtmlTableCell c5 = new HtmlTableCell();
            HtmlTableCell c6 = new HtmlTableCell();
            //createCell(c1, r, "Selection");
            createCell(c2, r, "Competitors");
            createCell(c3, r, "Indications");
            createCell(c6, r, "% of Packs from Total Market");
            createCell(c4, r, "Activity");
            createCell(c5, r, "General Activity");

            r.BgColor = "#aeaaaa";
            r.Style.Add("color", "white");
            tableContent.Rows.Add(r);
        }
        
        private void createCell(HtmlTableCell c, HtmlTableRow r, string innerText)
        {
            c.InnerText = innerText;
            r.Cells.Add(c);
        }
        
        private void createTableRows(HtmlTable tbl)
        {
            int iR = 0;
            int iC = 0;
            //int iChk = 0;
            string preComp = "";

            foreach (DataRow dr in dt.Rows)
            {
                HtmlTableRow r = new HtmlTableRow();
                r.ID = "r" + iR;
                r.EnableViewState = true;
                iR++;

                //HtmlTableCell c = new HtmlTableCell();
                //c.ID = "c" + iC;
                //c.EnableViewState = true;
                //iC++;

                //CheckBox chk = new CheckBox();
                //chk.ID = "chk" + iChk;
                //chk.AutoPostBack = true;
                //chk.EnableViewState = true;
                //chk.CheckedChanged += new EventHandler(Chk_CheckedChanged);
                //c.Controls.Add(chk);
                //r.Cells.Add(c);
                //iC++;
                //iChk++;

                HtmlTableCell c1 = new HtmlTableCell();
                c1.ID = "c" + iC;
                c1.EnableViewState = true;
                c1.InnerText = dr[3].ToString();
                c1.Visible = true;
                c1.BgColor = "#2f75b5";
                c1.Style.Add("color", "white");
                c1.Style.Add("border-style", "none");
                r.Cells.Add(c1);
                iC++;

                HtmlTableCell c2 = new HtmlTableCell();
                c2.ID = "c" + iC;
                c2.EnableViewState = true;
                c2.InnerText = dr[4].ToString();
                c2.Visible = true;
                c2.BgColor = "#2f75b5";
                c2.Style.Add("color", "white");
                c2.Style.Add("border-style", "none");
                r.Cells.Add(c2);
                iC++;

                HtmlTableCell c5 = new HtmlTableCell();
                c5.ID = "c" + iC;
                c5.EnableViewState = true;
                DropDownList ddlSales = new DropDownList();
                ddlSales.AppendDataBoundItems = true;
                ddlSales.Items.Add("None");
                for (int i = 0; i <= 100; i += 5)
                {
                    ddlSales.Items.Add(i.ToString());
                }
                ddlSales.EnableViewState = true;

                c5.Controls.Add(ddlSales);
                c5.Visible = true;
                c5.BgColor = "#ffc000";
                c5.Style.Add("border-style", "none");
                r.Cells.Add(c5);
                iC++;

                HtmlTableCell c3 = new HtmlTableCell();
                c3.ID = "c" + iC;
                c3.EnableViewState = true;
                DropDownList ddlActivity = new DropDownList();
                ddlActivity.AppendDataBoundItems = true;
                ddlActivity.Items.Add("None");

                ddlActivity.DataSourceID = "dsActivities";
                ddlActivity.DataTextField = "ActivityName";
                ddlActivity.DataValueField = "ActivityID";
                ddlActivity.EnableViewState = true;
                //ddlActivity.AutoPostBack = true;
                //ddlActivity.SelectedIndexChanged += ddlActivity_SelectedIndexChanged;

                c3.Controls.Add(ddlActivity);
                c3.Visible = true;
                c3.BgColor = "#ffc000";
                c3.Style.Add("border-style", "none");
                r.Cells.Add(c3);
                iC++;

                HtmlTableCell c4 = new HtmlTableCell();
                c4.ID = "c" + iC;
                c4.EnableViewState = true;
                DropDownList ddlGeneralActivity = new DropDownList();
                ddlGeneralActivity.AppendDataBoundItems = true;
                ddlGeneralActivity.Items.Add("None");

                ddlGeneralActivity.DataSourceID = "dsGeneralActivities";
                ddlGeneralActivity.DataTextField = "ActivityName";
                ddlGeneralActivity.DataValueField = "ActivityID";
                ddlGeneralActivity.EnableViewState = true;

                c4.Controls.Add(ddlGeneralActivity);
                c4.Visible = true;
                c4.BgColor = "#ffc000";
                c4.Style.Add("border-style", "none");
                r.Cells.Add(c4);
                iC++;

                if (preComp != c1.InnerText)
                {
                    HtmlTableCell cEmpty = new HtmlTableCell();
                    cEmpty.ColSpan = 5;
                    cEmpty.Style.Add("border", "0");
                    cEmpty.Height = "15px";
                    cEmpty.EnableViewState = true;
                    HtmlTableRow rEmpty = new HtmlTableRow();
                    rEmpty.Cells.Add(cEmpty);
                    r.EnableViewState = true;
                    tbl.Rows.Add(rEmpty);
                }
                preComp = c1.InnerText;
                r.EnableViewState = true;
                tbl.Rows.Add(r);
            }
        }

        private void ddlActivity_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["ActID"] = tableContent.Rows[2].Cells[2].InnerText;
        }

        private void Chk_CheckedChanged(object sender, EventArgs e)
        {
            if (((CheckBox)sender).Checked == true)
            {
                foreach (Control c in ((CheckBox)sender).Parent.Controls)
                {
                    txtPharmacy.Text += "1";
                    //c.Visible = true;
                }
            }
            else
            {
                foreach (Control c in ((CheckBox)sender).Parent.Controls)
                {
                    txtPharmacy.Text += "0";
                    //c.Visible = false;
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            this.PreInit += Survey4_PreInit;
        }

        private void Survey4_PreInit(object sender, EventArgs e)
        {
            Session["ActID"] = tableContent.Rows[2].Cells[2].InnerText;
        }

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
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            tableContent = (HtmlTable)Session["myTable"];

            con = new SqlConnection(ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ConnectionString);
            cmdIndications = new SqlCommand("Select IndicationID, IndicationName From Survey_Indications", con);
            daIndications = new SqlDataAdapter(cmdIndications);
            dtIndications = new DataTable();
            con.Open();
            daIndications.Fill(dtIndications);

            foreach (HtmlTableRow r in tableContent.Rows)
            {
                if (r.Cells[0].InnerText != "" && r.Cells[0].InnerText != "Competitors")
                {
                    int indComp = (chklCompetitors.Items.IndexOf(chklCompetitors.Items.FindByText(r.Cells[0].InnerText)));
                    string valComp = chklCompetitors.Items[indComp].Value;
                    string searchIndication = "IndicationName = '" + r.Cells[1].InnerText + "'";

                    dsSurveySave.InsertParameters[0].DefaultValue = txtPharmacy.Text;
                    dsSurveySave.InsertParameters[1].DefaultValue = ddlBrandName.SelectedValue;
                    dsSurveySave.InsertParameters[2].DefaultValue = ddlMarketName.SelectedValue;
                    dsSurveySave.InsertParameters[3].DefaultValue = valComp;
                    dsSurveySave.InsertParameters[4].DefaultValue = dtIndications.Select(searchIndication)[0][0].ToString();
                    dsSurveySave.InsertParameters[5].DefaultValue = ((DropDownList)r.Cells[3].Controls[0]).SelectedValue == "None" ? "0" : ((DropDownList)r.Cells[3].Controls[0]).SelectedValue;
                    dsSurveySave.InsertParameters[6].DefaultValue = ((DropDownList)r.Cells[4].Controls[0]).SelectedValue == "None" ? "0" : ((DropDownList)r.Cells[4].Controls[0]).SelectedValue;
                    dsSurveySave.InsertParameters[7].DefaultValue = ((DropDownList)r.Cells[5].Controls[0]).SelectedValue == "None" ? "0" : ((DropDownList)r.Cells[5].Controls[0]).SelectedValue;

                    dsSurveySave.Insert();
                }
            }

            txtPharmacy.Text = "";
            ddlBrandName.SelectedIndex = -1;
            ddlMarketName.SelectedIndex = -1;
            chklCompetitors.Items.Clear();

            clearTable();
            Session["myTable"] = "";
        }

        protected void chklCompetitors_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (chklCompetitors.SelectedIndex > -1)
            {
                FillTable();
            }
        }
    }
}