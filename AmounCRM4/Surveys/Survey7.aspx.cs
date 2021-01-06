using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AmounCRM4.Surveys
{
    public partial class Survey7 : System.Web.UI.Page
    {
        protected void btnSave_Click(object sender, EventArgs e)
        {
            if ((txtPharmacy.Text == "") || (txtMarketSalesUnit.Text == "") || (ddlMarketName.SelectedIndex == -1))
            {
                lblStatus.Text = "Fill All of The Above Data";
                return;
            }

            int savedInd2 = 0;
            foreach (GridViewRow r in grdProducts.Rows)
            {
                string selectedProduct = ((DropDownList)r.Cells[0].FindControl("ddlProducts")).SelectedItem.Text;
                if (selectedProduct != "None")
                {
                    savedInd2 += 1;
                }
            }
            if (savedInd2 == 0)
            {
                lblStatus.Text = "Select at Least One Product";
                return;
            }
            
            int savedInd = 0;
            foreach (GridViewRow r in grdIndications.Rows)
            {
                string selectedIndication = ((DropDownList)r.Cells[0].FindControl("ddlIndication")).SelectedItem.Text;
                if (selectedIndication != "None")
                {
                    savedInd += 1;
                }
            }
            if (savedInd == 0)
            {
                lblStatus.Text = "Select at Least One Indication";
                return;
            }

            dsSurveySave.Delete();
            dsIndicationsEntry.Delete();

            if (chkDelete.Checked == true)
            {
                lblStatus.Text = "Ready...";
                return;
            }

            int savedRecs = 0;
            foreach (GridViewRow r in grdProducts.Rows)
            {
                string selectedProduct = ((DropDownList)r.Cells[0].FindControl("ddlProducts")).SelectedItem.Text;
                if (selectedProduct != "" && selectedProduct != "None")
                {
                    string selectedSales = ((DropDownList)r.Cells[1].FindControl("ddlSales")).SelectedItem.Text;
                    string selectedActivity = ((DropDownList)r.Cells[2].FindControl("ddlActivity")).SelectedItem.Text;
                    string selectedGeneralActivity = ((DropDownList)r.Cells[3].FindControl("ddlGeneralActivity")).SelectedItem.Text;

                    if (selectedSales == "None" && selectedActivity == "None" && selectedGeneralActivity == "None")
                    {

                    }
                    else
                    {
                        dsSurveySave.InsertParameters[0].DefaultValue = DateTime.Now.ToShortDateString();
                        dsSurveySave.InsertParameters[1].DefaultValue = txtPharmacy.Text;
                        dsSurveySave.InsertParameters[2].DefaultValue = ddlMarketName.SelectedValue;
                        dsSurveySave.InsertParameters[3].DefaultValue = txtMarketSalesUnit.Text;
                        dsSurveySave.InsertParameters[4].DefaultValue = selectedProduct == "None" ? "0" : ((DropDownList)r.Cells[0].FindControl("ddlProducts")).SelectedValue;
                        dsSurveySave.InsertParameters[5].DefaultValue = selectedSales == "None" ? "0" : ((DropDownList)r.Cells[1].FindControl("ddlSales")).SelectedValue;
                        dsSurveySave.InsertParameters[6].DefaultValue = selectedActivity == "None" ? "22" : ((DropDownList)r.Cells[2].FindControl("ddlActivity")).SelectedValue;
                        dsSurveySave.InsertParameters[7].DefaultValue = selectedGeneralActivity == "None" ? "23" : ((DropDownList)r.Cells[3].FindControl("ddlGeneralActivity")).SelectedValue;
                        dsSurveySave.InsertParameters[8].DefaultValue = Session["EmployeeID"].ToString();
                        dsSurveySave.InsertParameters[9].DefaultValue = txtPharmacyID.Text;

                        dsSurveySave.Insert();
                        savedRecs += 1;
                    }
                }
            }

            if (savedRecs == 0)
            {
                lblStatus.Text = "No Products Saved, Please Select at Least One Product";
                return;
            }

            foreach (GridViewRow r in grdIndications.Rows)
            {
                string selectedIndication = ((DropDownList)r.Cells[0].FindControl("ddlIndication")).SelectedItem.Text;
                if (selectedIndication == "None")
                {

                }
                else
                {
                    string selectedSales = ((DropDownList)r.Cells[1].FindControl("ddlSales")).SelectedItem.Text;

                    dsIndicationsEntry.InsertParameters[0].DefaultValue = ddlMarketName.SelectedValue;
                    dsIndicationsEntry.InsertParameters[1].DefaultValue = DateTime.Now.ToShortDateString();
                    dsIndicationsEntry.InsertParameters[2].DefaultValue = selectedIndication == "None" ? "0" : ((DropDownList)r.Cells[0].FindControl("ddlIndication")).SelectedValue;
                    dsIndicationsEntry.InsertParameters[3].DefaultValue = txtPharmacy.Text;
                    dsIndicationsEntry.InsertParameters[4].DefaultValue = Session["EmployeeID"].ToString();
                    dsIndicationsEntry.InsertParameters[5].DefaultValue = selectedSales == "None" ? "0" : ((DropDownList)r.Cells[1].FindControl("ddlSales")).SelectedValue;
                    dsIndicationsEntry.InsertParameters[6].DefaultValue = txtPharmacyID.Text;

                    dsIndicationsEntry.Insert();
                }
            }

            refreshAfterSave();
        }

        private void refreshAfterSave()
        {
            txtPharmacy.Text = "";
            txtPharmacyID.Text = "0";
            txtMarketSalesUnit.Text = "0";
            ddlMarketName.SelectedIndex = -1;
            grdProducts.Visible = false;
            grdIndications.Visible = false;
            dsSearch.DataBind();
            rg.DataBind();
            rg.SelectedIndex = -1;
            lblStatus.Text = "Ready...";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if ((Session["EmployeeID"].ToString() == ""))
            {
                Response.Redirect("~/Login2.aspx");

                if ((int.Parse(Session["LineID"].ToString()) == 1) || (int.Parse(Session["LineID"].ToString()) == 2) || (int.Parse(Session["LineID"].ToString()) == 5) || (int.Parse(Session["LineID"].ToString()) == 13))
                {
                    Response.Redirect("~/Reps/Repreport_Dashboard.aspx");
                }
            }
            if (!Page.IsPostBack)
            {
                grdProducts.DataSourceID = "dsProducts";
                grdProducts.Visible = false;
                grdIndications.Visible = false;
            }

            txtPharmacy.Enabled = false;
            ddlMarketName.Enabled = false;
        }

        protected void ddlMarketName_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
        {
            grdProducts.DataSourceID = "dsProducts";
            grdProducts.Visible = true;

            grdIndications.DataSourceID = "dsMarketIndications";
            grdIndications.Visible = true;
        }
        
        protected void rg_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtPharmacy.Text = rg.SelectedRow.Cells[1].Text;
            txtPharmacy.Enabled = false;
            txtPharmacyID.Text = rg.SelectedRow.Cells[2].Text;
            ddlMarketName.ClearSelection();
            ddlMarketName.FindItemByText(rg.SelectedRow.Cells[4].Text).Selected = true;
            ddlMarketName.Enabled = false;
            txtMarketSalesUnit.Text = rg.SelectedRow.Cells[5].Text;

            chkDelete.Checked = false;
            lblStatus.Text = "Ready...";

            grdProducts.DataSourceID = "dsProducts";
            grdProducts.DataBind();
            grdProducts.Visible = true;

            grdIndications.DataSourceID = "dsMarketIndications";
            grdIndications.DataBind();
            grdIndications.Visible = true;

            DataView dv = (DataView)dsSurvey2.Select(new DataSourceSelectArguments());
            int intIndex = 0;
            foreach (DataRowView rView in dv)
            {
                ((DropDownList)grdProducts.Rows[intIndex].Cells[0].FindControl("ddlProducts")).SelectedValue = rView[5].ToString();
                ((DropDownList)grdProducts.Rows[intIndex].Cells[1].FindControl("ddlSales")).SelectedValue = rView[8].ToString();
                ((DropDownList)grdProducts.Rows[intIndex].Cells[2].FindControl("ddlActivity")).SelectedValue = rView[9].ToString();
                ((DropDownList)grdProducts.Rows[intIndex].Cells[3].FindControl("ddlGeneralActivity")).SelectedValue = rView[11].ToString();
                intIndex += 1;
            }

            DataView dv2 = (DataView)dsIndicationsEntry.Select(new DataSourceSelectArguments());
            int intIndex2 = 0;
            foreach (DataRowView rView in dv2)
            {
                ((DropDownList)grdIndications.Rows[intIndex2].Cells[0].FindControl("ddlIndication")).SelectedValue = rView[2].ToString();
                ((DropDownList)grdIndications.Rows[intIndex2].Cells[1].FindControl("ddlSales")).SelectedValue = rView[6].ToString();
                intIndex2 += 1;
            }
        }
    }
}