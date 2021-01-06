using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace AmounCRM4.DMs
{
    /*
     * 







*/
    public partial class DMDefault2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
                //RadPanelBar1.Items[0].Expanded = true;
                if (Session["EmployeeIDFromDM"].ToString() == "")
                {
                    Response.Redirect("~/Login2.aspx");                
                }
                else
                {
                    if (Session["EmployeeType"].ToString() == "Admin")
                    {
                        this.Master.FindControl("tblLinksAdmin").Visible = true;
                        this.Master.FindControl("tblLinksReps").Visible = false;
                        this.Master.FindControl("tblLinksDMs").Visible = false;
                    }
                    else if (Session["EmployeeType"].ToString() == "Rep")
                    {
                        this.Master.FindControl("tblLinksAdmin").Visible = false;
                        this.Master.FindControl("tblLinksDMs").Visible = false;
                        this.Master.FindControl("tblLinksReps").Visible = true;
                    }
                    else if (Session["EmployeeType"].ToString() == "DM")
                    {
                        this.Master.FindControl("tblLinksAdmin").Visible = false;
                        this.Master.FindControl("tblLinksReps").Visible = false;
                        this.Master.FindControl("tblLinksDMs").Visible = true;
                    }
                }

                FillAffHeader();
                FillCallsHeader();
                FillAppsHeader();
        }

        protected void gridAffs_ItemCommand(object sender, GridCommandEventArgs e)
        {
            //GridCommandItem cmdItem = (GridCommandItem)gridAffs.MasterTableView.GetItems(GridItemType.CommandItem)[0];
            //Label lT = (Label)cmdItem.FindControl("lblAffsClassTotal");
            //Label lA = (Label)cmdItem.FindControl("lblAffsClassA");
            //Label lB = (Label)cmdItem.FindControl("lblAffsClassB");
            //Label lC = (Label)cmdItem.FindControl("lblAffsClassC");

            //lT.Text = "All Physicians: " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Rows.Count.ToString();
            //lA.Text = "Class A: " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'A'").Length.ToString();
            //lB.Text = "Class B: " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'B'").Length.ToString();
            //lC.Text = "Class C: " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'C'").Length.ToString();
        }

        protected void FillAffHeader()
        {
                RadPanelItem item = RadPanelBar1.Items[1];
                Label lT = (Label)item.Header.FindControl("lblAffsTotal");
                Label lA = (Label)item.Header.FindControl("lblAffsClassA");
                Label lB = (Label)item.Header.FindControl("lblAffsClassB");
                //Label lC = (Label)item.Header.FindControl("lblAffsClassC");

                lT.Text = "All Doctors:          " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Rows.Count.ToString();
                lA.Text = "Class A+: " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'A+'").Length.ToString();
                lB.Text = "Class A: " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'A'").Length.ToString();
                //lC.Text = "Class C: " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'C'").Length.ToString();
        }

        protected void FillCallsHeader()
        {
                RadPanelItem item = RadPanelBar1.Items[2];
                Label lT = (Label)item.Header.FindControl("lblCallsTotal");
                Label lA = (Label)item.Header.FindControl("lblCallsClassA");
                Label lB = (Label)item.Header.FindControl("lblCallsClassB");
                //Label lC = (Label)item.Header.FindControl("lblCallsClassC");

                lT.Text = "All Visits:          " + ((DataView)ListOfCallsDS.Select(DataSourceSelectArguments.Empty)).ToTable().Rows.Count.ToString();
                lA.Text = "Class A+: " + ((DataView)ListOfCallsDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'A+'").Length.ToString();
                lB.Text = "Class A: " + ((DataView)ListOfCallsDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'A'").Length.ToString();
                //lC.Text = "Class C: " + ((DataView)ListOfCallsDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'C'").Length.ToString();
        }

        protected void FillAppsHeader()
        {
                RadPanelItem item = RadPanelBar1.Items[3];
                Label lT = (Label)item.Header.FindControl("lblAppsTotal");
                Label lA = (Label)item.Header.FindControl("lblAppsClassA");
                Label lB = (Label)item.Header.FindControl("lblAppsClassB");
                //Label lC = (Label)item.Header.FindControl("lblAppsClassC");

                lT.Text = "Doctor’s Visits / Planned:            " + ((DataView)ListOfAppointmentsDS.Select(DataSourceSelectArguments.Empty)).ToTable().Rows.Count.ToString();
                lA.Text = "Class A+: " + ((DataView)ListOfAppointmentsDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'A+'").Length.ToString();
                lB.Text = "Class A: " + ((DataView)ListOfAppointmentsDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'A'").Length.ToString();
                //lC.Text = "Class C: " + ((DataView)ListOfAppointmentsDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'C'").Length.ToString();
        }
    }
}