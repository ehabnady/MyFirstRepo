using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace AmounCRM4.CommercialDirector
{
    public partial class DetailingPriority : System.Web.UI.Page
    {
        //Session["DetailingPriorityUpdate"] --> 1 = New & 0 = Update
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Session["DetailingPriorityUpdate"] = "1";
            }
        }

        //protected void RadGrid1_ItemCommand(object source, GridCommandEventArgs e)
        //{
        //    if (e.CommandName == "RowClick")
        //    {
        //        string strTxt = string.Empty;
        //        if (e.Item is GridDataItem && e.Item.Selected)
        //        {
        //            //Response.Write(e.Item.Cells[2].Text);

        //            //GridDataItem dataItem = (GridDataItem)e.Item;
        //            //foreach (GridColumn col in grdDetailing.MasterTableView.RenderColumns)
        //            //{
        //            //    if (col.UniqueName != "ExpandColumn" && col.UniqueName != "RowIndicator")
        //            //    {
        //            //        strTxt += (dataItem[col.UniqueName].Text) + ",";
        //            //    }
        //            //}
        //            //ListItem item = new ListItem();
        //            //item.Text = strTxt.Substring(0, strTxt.Length - 1);
        //            //ListBox1.Items.Add(item);
        //        }
        //    }
        //}

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if ((ddlLine_Det.SelectedIndex > 0) && (ddlBrands_Det.SelectedIndex > 0) && (ddlSpec_Det.SelectedIndex > 0) && ( ddlPriority_Det.SelectedIndex > 0))
            {
                if (Session["DetailingPriorityUpdate"].ToString() == "1")
                {
                    dsTempSaving.InsertParameters[0].DefaultValue = ddlLine_Det.SelectedValue;
                    dsTempSaving.InsertParameters[1].DefaultValue = ddlBrands_Det.SelectedValue;
                    dsTempSaving.InsertParameters[2].DefaultValue = ddlSpec_Det.SelectedValue;
                    dsTempSaving.InsertParameters[3].DefaultValue = ddlPriority_Det.SelectedValue;
                    dsTempSaving.InsertParameters[4].DefaultValue = "False";

                    dsTempSaving.Insert();
                }
                else
                {
                    dsTempSaving.UpdateParameters[0].DefaultValue = lblRecID_Det.Text;
                    dsTempSaving.UpdateParameters[1].DefaultValue = ddlLine_Det.SelectedValue;
                    dsTempSaving.UpdateParameters[2].DefaultValue = ddlBrands_Det.SelectedValue;
                    dsTempSaving.UpdateParameters[3].DefaultValue = ddlSpec_Det.SelectedValue;
                    dsTempSaving.UpdateParameters[4].DefaultValue = ddlPriority_Det.SelectedValue;
                    dsTempSaving.UpdateParameters[5].DefaultValue = chkDel_Det.Checked.ToString();

                    dsTempSaving.Update();
                }

                lblRecID_Det.Text = "";
                ddlLine_Det.SelectedIndex = 0;
                ddlBrands_Det.SelectedIndex = 0;
                ddlSpec_Det.SelectedIndex = 0;
                ddlPriority_Det.SelectedIndex = 0;
                chkDel_Det.Checked = false;

                lblStatus.Text = "Status: Saved";

                Session["DetailingPriorityUpdate"] = "1";
                grdDetailingTemp.DataBind();
            }
            else
            {
                lblStatus.Text = "Status: All Data Must Be Provided";
            }
        }

        protected void grdDetailingTemp_ItemCommand(object source, GridCommandEventArgs e)
        {
            if (e.CommandName == "RowClick")
            {
                string strTxt = string.Empty;
                if (e.Item is GridDataItem && e.Item.Selected)
                {
                    GridDataItem dataItem = (GridDataItem)e.Item;

                    lblRecID_Det.Text = dataItem["RecID"].Text;
                    ddlLine_Det.SelectedValue = dataItem["LineID"].Text;
                    ddlBrands_Det.SelectedValue = dataItem["BrandID"].Text;
                    ddlSpec_Det.SelectedValue = dataItem["SpecialtyID"].Text;
                    ddlPriority_Det.SelectedValue = dataItem["BrandPriority"].Text;

                    if (dataItem["Deleted"].Text == "True")
                    {
                        chkDel_Det.Checked = true;
                    }
                    else
                    {
                        chkDel_Det.Checked = false;
                    }

                    Session["DetailingPriorityUpdate"] = "0";

                    //foreach (GridColumn col in grdDetailingTemp.MasterTableView.RenderColumns)
                    //{
                    //    if (col.UniqueName != "ExpandColumn" && col.UniqueName != "RowIndicator")
                    //    {
                    //        strTxt += (dataItem[col.UniqueName].Text) + ",";
                    //    }
                    //}
                    //ListItem item = new ListItem();
                    //item.Text = strTxt.Substring(0, strTxt.Length - 1);
                    //ListBox1.Items.Add(item);
                }
                else
                {
                    lblRecID_Det.Text = "0";
                    ddlLine_Det.SelectedIndex = 0;
                    ddlBrands_Det.SelectedIndex = 0;
                    ddlSpec_Det.SelectedIndex = 0;
                    ddlPriority_Det.SelectedIndex = 0;
                    chkDel_Det.Checked = false;

                    Session["DetailingPriorityUpdate"] = "1";
                }
            }
        }

    }
}