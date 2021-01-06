using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AmounCRM4.Surveys
{
    public partial class Feedbacks : System.Web.UI.Page
    {
        int isUpdate = 0;
        private void refreshAfterSave()
        {
            ddlPhName.SelectedIndex = -1;
            ddlMarket.SelectedIndex = -1;
            txtMarketSalesUnit.Text = "0";
            grdProducts.Visible = false;
            grdIndications.Visible = false;

            dsSearch.DataBind();
            grdFeedbacks.DataBind();

            grdProducts.DataBind();
            grdIndications.DataBind();

            ddlPhName.Enabled = true;
            ddlMarket.Enabled = true;

            isUpdate = 0;

            lblStatus.Text = "Ready...";
            lblStatus2.Text = "Ready...";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if ((Session["EmployeeIDFromSales"].ToString() == ""))
            {
                Response.Redirect("~/Login2.aspx");

                if (int.Parse(Session["LineIDFromSales"].ToString()) != 14)
                {
                    Response.Redirect("~/Reps/Repreport_Dashboard.aspx");
                }
            }
            if (!Page.IsPostBack)
            {
                grdProducts.DataSourceID = "dsProducts";
                grdProducts.Visible = false;
                grdIndications.Visible = false;

                isUpdate = 0;
            }

            //dtpFeedbackDate.MaxDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month+1, 1);
            //dtpFeedbackDate.MinDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            dtpFeedbackDate.Calendar.FirstDayOfWeek = FirstDayOfWeek.Saturday;
            dtpFeedbackDate.ShowAnimation.Type = Telerik.Web.UI.CalendarAnimationType.Slide;
            //ddlPhName.Enabled = false;
            //ddlMarket.Enabled = false;
        }

        protected void grdFeedbacks_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlPhName.Enabled = false;
            ddlPhName.SelectedIndex = ddlPhName.FindItemByText(grdFeedbacks.SelectedItems[0].Cells[5].Text).Index;
            
            //dtpFeedbackDate.DateInput.DateFormat = "MM/dd/yyyy";
            //dtpFeedbackDate.DateInput.DisplayDateFormat = "MM/dd/yyyy";
            dtpFeedbackDate.SelectedDate = DateTime.ParseExact(grdFeedbacks.SelectedItems[0].Cells[4].Text, "MM/dd/yyyy", null);

            ddlMarket.ClearSelection();
            ddlMarket.SelectedIndex = ddlMarket.FindItemByText(grdFeedbacks.SelectedItems[0].Cells[6].Text).Index;
            ddlMarket.Enabled = false;
            txtMarketSalesUnit.Text = grdFeedbacks.SelectedItems[0].Cells[7].Text;

            chkDelete.Checked = false;
            lblStatus.Text = "Ready...";
            lblStatus2.Text = "Ready...";

            grdProducts.DataSourceID = "dsProducts";
            grdProducts.DataBind();
            grdProducts.Visible = true;

            grdIndications.DataSourceID = "dsMarketIndications";
            grdIndications.DataBind();
            grdIndications.Visible = true;

            DataView dv = (DataView)dsFeedbackMarketProductsSave.Select(new DataSourceSelectArguments());
            dv.RowFilter = "FeedbackID = " + grdFeedbacks.SelectedItems[0].Cells[3].Text;
            int intIndex = 0;
            foreach (DataRowView rView in dv)
            {
                ((DropDownList)grdProducts.Rows[intIndex].Cells[0].FindControl("ddlProducts")).SelectedValue = rView[2].ToString();
                ((DropDownList)grdProducts.Rows[intIndex].Cells[1].FindControl("ddlSales")).SelectedValue = rView[3].ToString();
                ((DropDownList)grdProducts.Rows[intIndex].Cells[2].FindControl("ddlActivity")).SelectedValue = rView[4].ToString();
                ((DropDownList)grdProducts.Rows[intIndex].Cells[3].FindControl("ddlGeneralActivity")).SelectedValue = rView[5].ToString();
                intIndex += 1;
            }

            DataView dv2 = (DataView)dsFeedbackMarketIndicationsSave.Select(new DataSourceSelectArguments());
            dv2.RowFilter = "FeedbackID = " + grdFeedbacks.SelectedItems[0].Cells[3].Text;
            int intIndex2 = 0;
            foreach (DataRowView rView in dv2)
            {
                ((DropDownList)grdIndications.Rows[intIndex2].Cells[0].FindControl("ddlIndication")).SelectedValue = rView[2].ToString();
                ((DropDownList)grdIndications.Rows[intIndex2].Cells[1].FindControl("ddlSales")).SelectedValue = rView[3].ToString();
                intIndex2 += 1;
            }

            isUpdate = 1;
        }

        protected void ddlMarket_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
        {
            grdProducts.DataSourceID = "dsProducts";
            grdProducts.Visible = true;

            grdIndications.DataSourceID = "dsMarketIndications";
            grdIndications.Visible = true;

            if (grdFeedbacks.SelectedItems.Count == 0)
            {
                isUpdate = 0;
            }
            else
            {
                isUpdate = 1;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (dtpFeedbackDate.SelectedDate.Value.Month != DateTime.Now.Date.Month)
            {
                lblStatus.Text = "You cannot add visits for the previous month, please review the selected date.";
                lblStatus2.Text = "You cannot add visits for the previous month, please review the selected date.";
                return;
            }

            if (dtpFeedbackDate.SelectedDate.Value.Date.AddDays(1) < DateTime.Now.Date || dtpFeedbackDate.SelectedDate.Value.Date > DateTime.Now.Date)
            {
                lblStatus.Text = "You can add visits for today or yesterday only, please review the selected date.";
                lblStatus2.Text = "You can add visits for today or yesterday only, please review the selected date.";
                return;
            }

            if ((ddlPhName.SelectedIndex == -1) || (txtMarketSalesUnit.Text == "") || (ddlMarket.SelectedIndex == -1))
            {
                lblStatus.Text = "Please Fill Pharmacy, Market, and Sales.";
                lblStatus2.Text = "Please Fill Pharmacy, Market, and Sales.";
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

                    if (selectedSales != "None")// && selectedActivity != "None" && selectedGeneralActivity != "None")
                    {
                        savedRecs += 1;
                    }
                }
            }

            if (savedRecs == 0)
            {
                lblStatus.Text = "No Products Saved, Please Select at Least One Product";
                lblStatus2.Text = "No Products Saved, Please Select at Least One Product";
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
                lblStatus2.Text = "Select at Least One Indication";
                return;
            }

            if (isUpdate == 1 || grdFeedbacks.SelectedItems.Count > 0)
            {
                dsFeedbackHeadSave.DeleteParameters[0].DefaultValue = grdFeedbacks.SelectedItems[0].Cells[3].Text;
                dsFeedbackHeadSave.Delete();

                dsFeedbackMarketsSave.DeleteParameters[0].DefaultValue = grdFeedbacks.SelectedItems[0].Cells[3].Text;
                dsFeedbackMarketsSave.DeleteParameters[1].DefaultValue = ddlMarket.SelectedValue;
                dsFeedbackMarketsSave.Delete();
            }

            if (chkDelete.Checked == true)
            {
                refreshAfterSave();
                return;
            }

            dsFeedbackHeadSave.InsertParameters[0].DefaultValue = Session["CycleID"].ToString();
            dsFeedbackHeadSave.InsertParameters[1].DefaultValue = dtpFeedbackDate.SelectedDate.Value.ToShortDateString();
            dsFeedbackHeadSave.InsertParameters[2].DefaultValue = ddlPhName.SelectedValue;
            dsFeedbackHeadSave.InsertParameters[3].DefaultValue = Session["EmployeeIDFromSales"].ToString();
            dsFeedbackHeadSave.InsertParameters[4].DefaultValue = Session["LineIDFromSales"].ToString();
            dsFeedbackHeadSave.InsertParameters[5].DefaultValue = chkDelete.Checked.ToString();
            
            SqlCommand cmd = new SqlCommand(dsFeedbackHeadSave.InsertCommand, new SqlConnection(dsFeedbackHeadSave.ConnectionString));
            cmd.Parameters.Add(dsFeedbackHeadSave.InsertParameters[0].Name, SqlDbType.Int, dsFeedbackHeadSave.InsertParameters[0].Size, dsFeedbackHeadSave.InsertParameters[0].Name);
            cmd.Parameters.Add(dsFeedbackHeadSave.InsertParameters[1].Name, SqlDbType.SmallDateTime, dsFeedbackHeadSave.InsertParameters[1].Size, dsFeedbackHeadSave.InsertParameters[1].Name);
            cmd.Parameters.Add(dsFeedbackHeadSave.InsertParameters[2].Name, SqlDbType.Int, dsFeedbackHeadSave.InsertParameters[2].Size, dsFeedbackHeadSave.InsertParameters[2].Name);
            cmd.Parameters.Add(dsFeedbackHeadSave.InsertParameters[3].Name, SqlDbType.Int, dsFeedbackHeadSave.InsertParameters[3].Size, dsFeedbackHeadSave.InsertParameters[3].Name);
            cmd.Parameters.Add(dsFeedbackHeadSave.InsertParameters[4].Name, SqlDbType.Int, dsFeedbackHeadSave.InsertParameters[4].Size, dsFeedbackHeadSave.InsertParameters[4].Name);
            cmd.Parameters.Add(dsFeedbackHeadSave.InsertParameters[5].Name, SqlDbType.Bit, dsFeedbackHeadSave.InsertParameters[5].Size, dsFeedbackHeadSave.InsertParameters[5].Name);

            cmd.Parameters[0].Value = dsFeedbackHeadSave.InsertParameters[0].DefaultValue;
            cmd.Parameters[1].Value = dsFeedbackHeadSave.InsertParameters[1].DefaultValue;
            cmd.Parameters[2].Value = dsFeedbackHeadSave.InsertParameters[2].DefaultValue;
            cmd.Parameters[3].Value = dsFeedbackHeadSave.InsertParameters[3].DefaultValue;
            cmd.Parameters[4].Value = dsFeedbackHeadSave.InsertParameters[4].DefaultValue;
            cmd.Parameters[5].Value = dsFeedbackHeadSave.InsertParameters[5].DefaultValue;

            cmd.Connection.Open();
            int feedBackID = Convert.ToInt32(cmd.ExecuteScalar().ToString());

            dsFeedbackMarketsSave.InsertParameters[0].DefaultValue = feedBackID.ToString();
            dsFeedbackMarketsSave.InsertParameters[1].DefaultValue = ddlMarket.SelectedValue;
            dsFeedbackMarketsSave.InsertParameters[2].DefaultValue = txtMarketSalesUnit.Text;
            dsFeedbackMarketsSave.InsertParameters[3].DefaultValue = chkDelete.Checked.ToString();
            
            SqlCommand cmd2 = new SqlCommand(dsFeedbackMarketsSave.InsertCommand, new SqlConnection(dsFeedbackMarketsSave.ConnectionString));
            cmd2.Parameters.Add(dsFeedbackMarketsSave.InsertParameters[0].Name, SqlDbType.Int, dsFeedbackMarketsSave.InsertParameters[0].Size, dsFeedbackMarketsSave.InsertParameters[0].Name);
            cmd2.Parameters.Add(dsFeedbackMarketsSave.InsertParameters[1].Name, SqlDbType.Int, dsFeedbackMarketsSave.InsertParameters[1].Size, dsFeedbackMarketsSave.InsertParameters[1].Name);
            cmd2.Parameters.Add(dsFeedbackMarketsSave.InsertParameters[2].Name, SqlDbType.Int, dsFeedbackMarketsSave.InsertParameters[2].Size, dsFeedbackMarketsSave.InsertParameters[2].Name);
            cmd2.Parameters.Add(dsFeedbackMarketsSave.InsertParameters[3].Name, SqlDbType.Bit, dsFeedbackMarketsSave.InsertParameters[3].Size, dsFeedbackMarketsSave.InsertParameters[3].Name);

            cmd2.Parameters[0].Value = dsFeedbackMarketsSave.InsertParameters[0].DefaultValue;
            cmd2.Parameters[1].Value = dsFeedbackMarketsSave.InsertParameters[1].DefaultValue;
            cmd2.Parameters[2].Value = dsFeedbackMarketsSave.InsertParameters[2].DefaultValue;
            cmd2.Parameters[3].Value = dsFeedbackMarketsSave.InsertParameters[3].DefaultValue;

            cmd2.Connection.Open();
            int feedBackMarketID = Convert.ToInt32(cmd2.ExecuteScalar().ToString());

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
                        dsFeedbackMarketProductsSave.InsertParameters[0].DefaultValue = feedBackMarketID.ToString();
                        dsFeedbackMarketProductsSave.InsertParameters[1].DefaultValue = selectedProduct == "None" ? "0" : ((DropDownList)r.Cells[0].FindControl("ddlProducts")).SelectedValue;
                        dsFeedbackMarketProductsSave.InsertParameters[2].DefaultValue = selectedSales == "None" ? "0" : ((DropDownList)r.Cells[1].FindControl("ddlSales")).SelectedValue;
                        dsFeedbackMarketProductsSave.InsertParameters[3].DefaultValue = selectedActivity == "None" ? "22" : ((DropDownList)r.Cells[2].FindControl("ddlActivity")).SelectedValue;
                        dsFeedbackMarketProductsSave.InsertParameters[4].DefaultValue = selectedGeneralActivity == "None" ? "23" : ((DropDownList)r.Cells[3].FindControl("ddlGeneralActivity")).SelectedValue;
                        dsFeedbackMarketProductsSave.InsertParameters[5].DefaultValue = chkDelete.Checked.ToString();
                        dsFeedbackMarketProductsSave.Insert();
                        //savedRecs += 1;
                    }
                }
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

                    dsFeedbackMarketIndicationsSave.InsertParameters[0].DefaultValue = feedBackMarketID.ToString();
                    dsFeedbackMarketIndicationsSave.InsertParameters[1].DefaultValue = selectedIndication == "None" ? "0" : ((DropDownList)r.Cells[0].FindControl("ddlIndication")).SelectedValue;
                    dsFeedbackMarketIndicationsSave.InsertParameters[2].DefaultValue = selectedSales == "None" ? "0" : ((DropDownList)r.Cells[1].FindControl("ddlSales")).SelectedValue;
                    dsFeedbackMarketIndicationsSave.InsertParameters[3].DefaultValue = chkDelete.Checked.ToString();
                    dsFeedbackMarketIndicationsSave.Insert();
                }
            }

            refreshAfterSave();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            refreshAfterSave();
        }
    }
}