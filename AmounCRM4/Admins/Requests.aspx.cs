using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace AmounCRM4.Admins
{
    public partial class Requests : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["EmployeeIDFromAdmin"].ToString() == "")
                {
                    Response.Redirect("~/Login2.aspx");
                }
            }
        }

        protected void grdReqs_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {

        }

        protected void grdReqs_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }

        protected void grdReqs_EditCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }

        protected void grdReqs_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }

        protected void grdReqs_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {

        }

        protected void btnExecute_Click(object sender, EventArgs e)
        {
            try
            {
                Reps.RequestsManipulations.openConnection();

                foreach (GridDataItem item in grdReqs.Items)
                {
                    if (item is GridDataItem)
                    {
                        RadDropDownList ddlActions = (RadDropDownList)(item["RequiredAction"].FindControl("ddlActions"));
                        if (ddlActions.SelectedValue == "1")
                        {
                            Reps.RequestsManipulations.CreateTemp(int.Parse(item["RecID"].Text), int.Parse(Session["EmployeeHRCodeFromAdmin"].ToString()));
                        }
                        if (ddlActions.SelectedValue == "2")
                        {
                            Reps.RequestsManipulations.UpdateOneLine(int.Parse(item["RecID"].Text), int.Parse(Session["EmployeeHRCodeFromAdmin"].ToString()));
                        }
                        if (ddlActions.SelectedValue == "3")
                        {
                            Reps.RequestsManipulations.UpdateAllLines(int.Parse(item["RecID"].Text), int.Parse(Session["EmployeeHRCodeFromAdmin"].ToString()));
                        }
                        if (ddlActions.SelectedValue == "4")
                        {
                            Reps.RequestsManipulations.DeleteOneLine(int.Parse(item["RecID"].Text), int.Parse(Session["EmployeeHRCodeFromAdmin"].ToString()));
                        }
                        if (ddlActions.SelectedValue == "5")
                        {
                            Reps.RequestsManipulations.DeleteAllLines(int.Parse(item["RecID"].Text), int.Parse(Session["EmployeeHRCodeFromAdmin"].ToString()));
                        }
                        if (ddlActions.SelectedValue == "6")
                        {
                            Reps.RequestsManipulations.RejectCommercial(int.Parse(item["RecID"].Text), int.Parse(Session["EmployeeHRCodeFromAdmin"].ToString()));
                        }
                        if (ddlActions.SelectedValue == "7")
                        {
                            Reps.RequestsManipulations.RejectCairo(int.Parse(item["RecID"].Text), int.Parse(Session["EmployeeHRCodeFromAdmin"].ToString()));
                        }
                        if (ddlActions.SelectedValue == "8")
                        {
                            Reps.RequestsManipulations.RejectUpper(int.Parse(item["RecID"].Text), int.Parse(Session["EmployeeHRCodeFromAdmin"].ToString()));
                        }
                        if (ddlActions.SelectedValue == "9")
                        {
                            Reps.RequestsManipulations.RejectAdmin(int.Parse(item["RecID"].Text), int.Parse(Session["EmployeeHRCodeFromAdmin"].ToString()));
                        }
                        if (ddlActions.SelectedValue == "10")
                        {
                            Reps.RequestsManipulations.Exist(int.Parse(item["RecID"].Text), int.Parse(Session["EmployeeHRCodeFromAdmin"].ToString()));
                        }

                        
                    }
                }
                grdReqs.DataSourceID = null;
                grdReqs.DataSourceID = "dsRequestsView";
                grdReqs.DataBind();
            }
            catch (Exception ex)
            {
                LblMessages.Text = "Results: " + " " + ex.Message;
            }
            finally
            {
                Reps.RequestsManipulations.closeConnection();
            }
        }

        protected void dsRequestsView_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }

        protected void btnCheckAll_Click(object sender, EventArgs e)
        {
            foreach (GridDataItem item in grdReqs.Items)
            {
                if (item is GridDataItem)
                {
                    RadDropDownList ddl1 = (RadDropDownList)(item["RequiredAction"].FindControl("ddlActions"));
                    ddl1.SelectedIndex = int.Parse(ddlActionsforall.SelectedValue);
                }
            }
        }
    }
}