using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using System.Data.SqlClient;

namespace AmounCRM4.CommercialDirector
{
    public partial class DetailingPriority2 : System.Web.UI.Page
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
            //if ((ddlLine_Det.SelectedIndex > 0) && (ddlBrands_Det.SelectedIndex > 0) && (ddlSpec_Det.SelectedIndex > 0) && ( ddlPriority_Det.SelectedIndex > 0))
            //{
            //    if (Session["DetailingPriorityUpdate"].ToString() == "1")
            //    {
            //        dsTempSaving.InsertParameters[0].DefaultValue = ddlLine_Det.SelectedValue;
            //        dsTempSaving.InsertParameters[1].DefaultValue = ddlBrands_Det.SelectedValue;
            //        dsTempSaving.InsertParameters[2].DefaultValue = ddlSpec_Det.SelectedValue;
            //        dsTempSaving.InsertParameters[3].DefaultValue = ddlPriority_Det.SelectedValue;
            //        dsTempSaving.InsertParameters[4].DefaultValue = "False";

            //        dsTempSaving.Insert();
            //    }
            //    else
            //    {
            //        //dsTempSaving.UpdateParameters[0].DefaultValue = lblRecID_Det.Text;
            //        //dsTempSaving.UpdateParameters[1].DefaultValue = ddlLine_Det.SelectedValue;
            //        //dsTempSaving.UpdateParameters[2].DefaultValue = ddlBrands_Det.SelectedValue;
            //        //dsTempSaving.UpdateParameters[3].DefaultValue = ddlSpec_Det.SelectedValue;
            //        //dsTempSaving.UpdateParameters[4].DefaultValue = ddlPriority_Det.SelectedValue;
            //        //dsTempSaving.UpdateParameters[5].DefaultValue = chkDel_Det.Checked.ToString();

            //        dsTempSaving.Update();
            //    }

                //lblRecID_Det.Text = "";
                //ddlLine_Det.SelectedIndex = 0;
                //ddlBrands_Det.SelectedIndex = 0;
                //ddlSpec_Det.SelectedIndex = 0;
                //ddlPriority_Det.SelectedIndex = 0;
                //chkDel_Det.Checked = false;

            //    lblStatus.Text = "Status: Saved";

            //    Session["DetailingPriorityUpdate"] = "1";
            //    grdDetailingTemp.DataBind();
            //}
            //else
            //{
            //    lblStatus.Text = "Status: All Data Must Be Provided";
            //}
        }

        protected void grdDetailingTemp_ItemCommand(object source, GridCommandEventArgs e)
        {
            if (e.CommandName == "RowClick")
            {
                string strTxt = string.Empty;
                if (e.Item is GridDataItem && e.Item.Selected)
                {
                    GridDataItem dataItem = (GridDataItem)e.Item;

                    //lblRecID_Det.Text = dataItem["RecID"].Text;
                    //ddlLine_Det.SelectedValue = dataItem["LineID"].Text;
                    //ddlBrands_Det.SelectedValue = dataItem["BrandID"].Text;
                    //ddlSpec_Det.SelectedValue = dataItem["SpecialtyID"].Text;
                    //ddlPriority_Det.SelectedValue = dataItem["BrandPriority"].Text;

                    //if (dataItem["Deleted"].Text == "True")
                    //{
                    //    chkDel_Det.Checked = true;
                    //}
                    //else
                    //{
                    //    chkDel_Det.Checked = false;
                    //}

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
                    //lblRecID_Det.Text = "0";
                    //ddlLine_Det.SelectedIndex = 0;
                    //ddlBrands_Det.SelectedIndex = 0;
                    //ddlSpec_Det.SelectedIndex = 0;
                    //ddlPriority_Det.SelectedIndex = 0;
                    //chkDel_Det.Checked = false;

                    Session["DetailingPriorityUpdate"] = "1";
                }
            }
        }

        protected void grdDetailingTemp_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridEditFormInsertItem || e.Item is GridDataInsertItem)
            {
                // insert item
                //dsTempSaving.Insert();
            }
            else
            {
                // edit item
                //dsTempSaving.Update();
            }
        }

        protected void grdDetailingTemp_InsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem insertedItem = e.Item as GridEditableItem;

                string s = "Select COUNT(*) From BrandPriorityBySpecLineTemp Where (Deleted IS NULL OR Deleted = 0) AND LineID = " + ((RadDropDownList)(insertedItem["LineName"].Controls[1])).SelectedValue;
                s += " AND SpecialtyID = " + ((RadDropDownList)(insertedItem["SpecialityCode"].Controls[1])).SelectedValue;
                s += " AND BrandID = " + ((RadDropDownList)(insertedItem["BrandName"].Controls[1])).SelectedValue;

                SqlCommand cmd = new SqlCommand(s, new SqlConnection(dsTempSaving.ConnectionString));
                cmd.Connection.Open();
                int i = int.Parse(cmd.ExecuteScalar().ToString());
                if (i > 0)
                {
                    lblStatus.Text = "This transaction is already exist";
                    return;
                }

                dsTempSaving.InsertParameters[0].DefaultValue = ((RadDropDownList)(insertedItem["LineName"].Controls[1])).SelectedValue;
                dsTempSaving.InsertParameters[1].DefaultValue = ((RadDropDownList)(insertedItem["BrandName"].Controls[1])).SelectedValue;
                dsTempSaving.InsertParameters[2].DefaultValue = ((RadDropDownList)(insertedItem["SpecialityCode"].Controls[1])).SelectedValue;
                dsTempSaving.InsertParameters[3].DefaultValue = ((RadDropDownList)(insertedItem["BrandPriority"].Controls[1])).SelectedValue;

                dsTempSaving.Insert();
                lblStatus.Text = "Inserted Successfully";
            }
            catch (Exception ex)
            {
                lblStatus.Text = "Insertion Failed: " + ex.Message;
            }
        }

        protected void grdDetailingTemp_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem editedItem = e.Item as GridEditableItem;
                //Get the primary key value using the DataKeyValue.      
                //string EmployeeID = editedItem.OwnerTableView.DataKeyValues[editedItem.ItemIndex]["EmployeeID"].ToString();
                //Access the textbox from the edit form template and store the values in string variables.   
                //string LastName = (editedItem["LastName"].Controls[0] as TextBox).Text;

                string s = "Select COUNT(*) From BrandPriorityBySpecLineTemp Where (Deleted IS NULL OR Deleted = 0) AND LineID = " + ((RadDropDownList)(editedItem["LineName"].Controls[1])).SelectedValue;
                s += " AND SpecialtyID = " + ((RadDropDownList)(editedItem["SpecialityCode"].Controls[1])).SelectedValue;
                s += " AND BrandID = " + ((RadDropDownList)(editedItem["BrandName"].Controls[1])).SelectedValue;
                s += " AND BrandPriority = " + ((RadDropDownList)(editedItem["BrandPriority"].Controls[1])).SelectedValue;

                SqlCommand cmd = new SqlCommand(s, new SqlConnection(dsTempSaving.ConnectionString));
                cmd.Connection.Open();
                int i = int.Parse(cmd.ExecuteScalar().ToString());
                if (i > 1)
                {
                    lblStatus.Text = "This transaction is already exist";
                    return;
                }

                dsTempSaving.UpdateParameters[0].DefaultValue = ((Label)(editedItem["RecID"].Controls[1])).Text;
                dsTempSaving.UpdateParameters[1].DefaultValue = ((RadDropDownList)(editedItem["LineName"].Controls[1])).SelectedValue;
                dsTempSaving.UpdateParameters[2].DefaultValue = ((RadDropDownList)(editedItem["BrandName"].Controls[1])).SelectedValue;
                dsTempSaving.UpdateParameters[3].DefaultValue = ((RadDropDownList)(editedItem["SpecialityCode"].Controls[1])).SelectedValue;
                dsTempSaving.UpdateParameters[4].DefaultValue = ((RadDropDownList)(editedItem["BrandPriority"].Controls[1])).SelectedValue;
                if ((((CheckBox)(editedItem["Deleted"].Controls[1])).Checked).ToString() == "True")
                {
                    dsTempSaving.UpdateParameters[5].DefaultValue = Boolean.TrueString;
                }
                else
                {
                    dsTempSaving.UpdateParameters[5].DefaultValue = Boolean.FalseString;
                }

                dsTempSaving.Update();
                lblStatus.Text = "Updated Successfully";
            }
            catch (Exception ex)
            {
                lblStatus.Text = "Update Failed: " + ex.Message;
            }
        }

        protected void grdDetailingTemp_EditCommand(object sender, GridCommandEventArgs e)
        {
            GridEditableItem insertedItem = e.Item as GridEditableItem;
            //dsTempSaving.InsertParameters[0].DefaultValue = (insertedItem["LineName"].Controls[1] as DropDownList).SelectedValue;// ddlLine_Det.SelectedValue;
        }
    }
}