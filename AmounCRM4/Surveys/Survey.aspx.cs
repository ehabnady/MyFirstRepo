using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using System.Data.SqlClient;

namespace AmounCRM4.Surveys
{
    public partial class Survey : System.Web.UI.Page
    {
        //Session["SpecValUpdate"] --> 1 = New & 0 = Update
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Session["SurveyUpdate"] = "1";
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

        }

        protected void grdSurvey_InsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem insertedItem = e.Item as GridEditableItem;

                string s = "Select COUNT(*) From SpecPriorityByLineTemp Where (Deleted IS NULL OR Deleted = 0) AND LineID = " + ((RadDropDownList)(insertedItem["LineName"].Controls[1])).SelectedValue;
                s += " AND SpecialtyID = " + ((RadDropDownList)(insertedItem["SpecialityCode"].Controls[1])).SelectedValue;

                SqlCommand cmd = new SqlCommand(s, new SqlConnection(dsSaving.ConnectionString));
                cmd.Connection.Open();
                int i = int.Parse(cmd.ExecuteScalar().ToString());
                if (i > 0)
                {
                    lblStatus.Text = "This transaction is already exist";
                    return;
                }

                dsSaving.InsertParameters[0].DefaultValue = ((RadDropDownList)(insertedItem["LineName"].Controls[1])).SelectedValue;
                dsSaving.InsertParameters[1].DefaultValue = ((RadDropDownList)(insertedItem["SpecialityCode"].Controls[1])).SelectedValue;
                dsSaving.InsertParameters[2].DefaultValue = ((TextBox)(insertedItem["SpecValue"].Controls[1])).Text;

                if (int.Parse(((TextBox)(insertedItem["SpecValue"].Controls[1])).Text) > 40)
                {
                    lblStatus.Text = "Specialty Value Must be Less Than or Equal to 40";
                    return;
                }

                dsSaving.Insert();
                lblStatus.Text = "Inserted Successfully";
            }
            catch (Exception ex)
            {
                lblStatus.Text = "Insertion Failed: " + ex.Message;
            }
        }

        protected void grdSurvey_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem editedItem = e.Item as GridEditableItem;

                string s = "Select COUNT(*) From SpecPriorityByLineTemp Where (Deleted IS NULL OR Deleted = 0) AND LineID = " + ((RadDropDownList)(editedItem["LineName"].Controls[1])).SelectedValue;
                s += " AND SpecialtyID = " + ((RadDropDownList)(editedItem["SpecialityCode"].Controls[1])).SelectedValue;

                SqlCommand cmd = new SqlCommand(s, new SqlConnection(dsSaving.ConnectionString));
                cmd.Connection.Open();
                int i = int.Parse(cmd.ExecuteScalar().ToString());
                if (i > 1)
                {
                    lblStatus.Text = "This transaction is already exist";
                    return;
                }

                dsSaving.UpdateParameters[0].DefaultValue = ((Label)(editedItem["RecID"].Controls[1])).Text;
                dsSaving.UpdateParameters[1].DefaultValue = ((RadDropDownList)(editedItem["LineName"].Controls[1])).SelectedValue;
                dsSaving.UpdateParameters[2].DefaultValue = ((RadDropDownList)(editedItem["SpecialityCode"].Controls[1])).SelectedValue;
                dsSaving.UpdateParameters[3].DefaultValue = ((TextBox)(editedItem["SpecValue"].Controls[1])).Text;
                if ((((CheckBox)(editedItem["Deleted"].Controls[1])).Checked).ToString() == "True")
                {
                    dsSaving.UpdateParameters[4].DefaultValue = Boolean.TrueString;
                }
                else
                {
                    dsSaving.UpdateParameters[4].DefaultValue = Boolean.FalseString;
                }

                dsSaving.Update();
                lblStatus.Text = "Updated Successfully";
            }
            catch (Exception ex)
            {
                lblStatus.Text = "Update Failed: " + ex.Message;
            }
        }

        protected void grdSurvey_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "RowClick")
            {
                string strTxt = string.Empty;
                if (e.Item is GridDataItem && e.Item.Selected)
                {
                    GridDataItem dataItem = (GridDataItem)e.Item;
                    Session["SurveyUpdate"] = "0";
                }
                else
                {
                    Session["SurveyUpdate"] = "1";
                }
            }
        }

        protected void grdSurvey_EditCommand(object sender, GridCommandEventArgs e)
        {
            GridEditableItem insertedItem = e.Item as GridEditableItem;
        }

        protected void RadComboBox1_ItemChecked(object sender, RadComboBoxItemEventArgs e)
        {
            TextBox myTextBox = new TextBox();
            myTextBox.Text = "Content here";
            this.PlaceHolder1.Controls.Add(myTextBox);
        }
    }
}