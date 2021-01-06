using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace AmounCRM4.SalesDirector
{
    public partial class SDDefault2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeIDFromDir"].ToString() == "0")
            {
                Response.Redirect("~/Login2.aspx");
            }

            FillAffHeader();
            //FillCallsHeader();
            //FillAppsHeader();
        }

        protected void gridAffs_ItemCommand(object sender, GridCommandEventArgs e)
        {
            GridCommandItem cmdItem = (GridCommandItem)gridAffs.MasterTableView.GetItems(GridItemType.CommandItem)[0];
            Label lT = (Label)cmdItem.FindControl("lblAffsClassTotal");
            Label lA = (Label)cmdItem.FindControl("lblAffsClassA");
            Label lB = (Label)cmdItem.FindControl("lblAffsClassB");
            //Label lC = (Label)cmdItem.FindControl("lblAffsClassC");

            lT.Text = "All Physicians: " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Rows.Count.ToString();
            lA.Text = "Class A: " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'A'").Length.ToString();
            lB.Text = "Class A+: " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'A+'").Length.ToString();
            //lC.Text = "Class C: " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'C'").Length.ToString();
        }

        protected void FillAffHeader()
        {
            RadPanelItem item = RadPanelBar1.Items[1];
            Label lT = (Label)item.Header.FindControl("lblAffsTotal");
            Label lA = (Label)item.Header.FindControl("lblAffsClassA");
            Label lB = (Label)item.Header.FindControl("lblAffsClassB");
            //Label lC = (Label)item.Header.FindControl("lblAffsClassC");

            lT.Text = "Doctors List ( All Doctors For All Lines):          " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Rows.Count.ToString();
            lA.Text = "Class A: " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'A'").Length.ToString();
            lB.Text = "Class A+: " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'A+'").Length.ToString();
            //lC.Text = "Class C: " + ((DataView)ListOfAffDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'C'").Length.ToString();
        }

        protected void FillCallsHeader()
        {
            //RadPanelItem item = RadPanelBar1.Items[2];//true is 5
            //Label lT = (Label)item.Header.FindControl("lblCallsTotal");
            //Label lA = (Label)item.Header.FindControl("lblCallsClassA");
            //Label lB = (Label)item.Header.FindControl("lblCallsClassB");
            ////Label lC = (Label)item.Header.FindControl("lblCallsClassC");

            //lT.Text = "All Visits:          " + ((DataView)ListOfCallsDS.Select(DataSourceSelectArguments.Empty)).ToTable().Rows.Count.ToString();
            //lA.Text = "Class A: " + ((DataView)ListOfCallsDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'A'").Length.ToString();
            //lB.Text = "Class A+: " + ((DataView)ListOfCallsDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'A+'").Length.ToString();
            ////lC.Text = "Class C: " + ((DataView)ListOfCallsDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'C'").Length.ToString();
        }

        protected void FillAppsHeader()
        {
            //RadPanelItem item = RadPanelBar1.Items[2];
            //Label lT = (Label)item.Header.FindControl("lblAppsTotal");
            //Label lA = (Label)item.Header.FindControl("lblAppsClassA");
            //Label lB = (Label)item.Header.FindControl("lblAppsClassB");
            ////Label lC = (Label)item.Header.FindControl("lblAppsClassC");

            ////Comment until finishing Sales Director Partt in Dataset
            //lT.Text = "All Appointments:            " + ((DataView)ListOfAppointmentsDS.Select(DataSourceSelectArguments.Empty)).ToTable().Rows.Count.ToString();
            //lA.Text = "Class A: " + ((DataView)ListOfAppointmentsDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'A'").Length.ToString();
            //lB.Text = "Class A+: " + ((DataView)ListOfAppointmentsDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'A+'").Length.ToString();
            ////lC.Text = "Class C: " + ((DataView)ListOfAppointmentsDS.Select(DataSourceSelectArguments.Empty)).ToTable().Select("PhysicianClass = 'C'").Length.ToString();
        }
    }
}