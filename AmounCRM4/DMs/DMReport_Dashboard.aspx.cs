using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using AmounCRM4.App_Data;
using Telerik.Web.UI;
using AmounCRM4.App_Data.ExecSummary2TableAdapters;
using static AmounCRM4.App_Data.ExecSummary2;
using Telerik.Web.UI.PivotGrid.Core;
using Telerik.Web.UI.PivotGrid.Core.Aggregates;

namespace AmounCRM4.DMs
{
    public partial class DMReport_Dashboard : System.Web.UI.Page
    {
        ExecSummary2 summary;
        View_PlannedVsActualTableAdapter ada1;
        View_PlannedVsActualDataTable apps;
        View_PlannedVsActualAffsTableAdapter ada2;
        View_PlannedVsActualAffsDataTable affs;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeID"].ToString() == "" && Session["EmployeeIDFromAdmin"].ToString() == "" && Session["EmployeeIDFromDM"].ToString() == "")
            {
                Response.Redirect("~/Login2.aspx");
            }

            double classA_Cover;
            double classB_Cover;

            summary = new ExecSummary2();

            apps = new View_PlannedVsActualDataTable();
            ada1 = new View_PlannedVsActualTableAdapter();
            ada1.FillBySupervisionAreaID2(apps, int.Parse(Session["CycleIDFromDM"].ToString()), int.Parse(Session["EmployeeIDFromDM"].ToString()));

            if (apps.Rows.Count == 0 || apps[0].AppointmentsCount == 0)
            {
                g1.Pointer.Value = 0;
                g1.Scale.Min = 0;
                g1.Scale.Max = 100;
                g1.ToolTip = "No Plan";
                //scaleDivider(g1, 100);
            }
            else
            {
                g1.Pointer.Value = (decimal.Parse(apps[0].ActualCount.ToString()) / decimal.Parse(apps[0].AppointmentsCount.ToString())*100);
                g1.Scale.Min = 0;
                g1.Scale.Max = 100;// apps[0].AppointmentsCount;
                g1.ToolTip = apps[0].ActualCount + " out of " + apps[0].AppointmentsCount.ToString() + Environment.NewLine + apps[0].AchievmentRatio.ToString() + " % ";
                //scaleDivider(g1, apps[0].AppointmentsCount);
            }

            affs = new View_PlannedVsActualAffsDataTable();
            ada2 = new View_PlannedVsActualAffsTableAdapter();
            ada2.FillBySupervisionAreaID2(affs, int.Parse(Session["EmployeeIDFromDM"].ToString()), int.Parse(Session["CycleIDFromDM"].ToString()));

            if (affs.Rows.Count == 0)//No Appointments or Calls
            {
                classA_Cover = 0;
                classB_Cover = 0;

                g2.Pointer.Value = 0;
                g2.Scale.Min = 0;
                g2.Scale.Max = 100;
                g2.ToolTip = "No Plan";

                g3.Pointer.Value = 0;
                g3.Scale.Min = 0;
                g3.Scale.Max = 100;
                g3.ToolTip = "No Plan";

                //scaleDivider(g2, 100);
                //scaleDivider(g3, 100);
            }
            else if (affs.Rows.Count == 1)//Class "A" Only
            {
                classA_Cover = (Math.Round((double.Parse(affs[0].ActualAffsCount.ToString()) / double.Parse(affs[0].PlannedAffsCount.ToString())) * 100));
                g3.Pointer.Value = decimal.Parse((Math.Round((double.Parse(affs[0].ActualAffsCount.ToString()) / double.Parse(affs[0].PlannedAffsCount.ToString())) * 100)).ToString());//affs[0].ActualAffsCount;
                g3.Scale.Min = 0;
                g3.Scale.Max = 100;// affs[0].PlannedAffsCount;
                double ii = double.Parse(affs[0].ActualAffsCount.ToString());
                g3.ToolTip = affs[0].ActualAffsCount + " out of " + affs[0].PlannedAffsCount.ToString() + Environment.NewLine + classA_Cover.ToString() + " % ";
                //scaleDivider(g3, affs[0].PlannedAffsCount);
            }
            else if (affs.Rows.Count == 2)//Class "A" & Class "B"
            {
                if (double.Parse(affs[0].PlannedAffsCount.ToString()) == 0)
                {
                    classA_Cover = 0;
                    g2.Pointer.Value = 0;
                    g2.Scale.Min = 0;
                    g2.Scale.Max = 100;
                }
                else
                {
                    classA_Cover = (Math.Round((double.Parse(affs[0].ActualAffsCount.ToString()) / double.Parse(affs[0].PlannedAffsCount.ToString())) * 100));
                    g2.Pointer.Value = decimal.Parse((Math.Round((double.Parse(affs[0].ActualAffsCount.ToString()) / double.Parse(affs[0].PlannedAffsCount.ToString())) * 100)).ToString());// affs[0].ActualAffsCount;
                    g2.Scale.Min = 0;
                    g2.Scale.Max = 100;// affs[0].PlannedAffsCount;
                    double ii = double.Parse(affs[0].ActualAffsCount.ToString());
                    g2.ToolTip = affs[0].ActualAffsCount + " out of " + affs[0].PlannedAffsCount.ToString() + Environment.NewLine + classA_Cover.ToString() + " % ";
                    //scaleDivider(g2, affs[0].PlannedAffsCount);
                }

                classB_Cover = (Math.Round((double.Parse(affs[1].ActualAffsCount.ToString()) / double.Parse(affs[1].PlannedAffsCount.ToString())) * 100));
                if (affs[1].PlannedAffsCount == 0)
                {
                    g3.Pointer.Value = 0;
                    g3.Scale.Min = 0;
                    g3.Scale.Max = 100;// affs[1].PlannedAffsCount;
                    double jj = double.Parse(affs[1].ActualAffsCount.ToString());
                    g3.ToolTip = "0 out of 0" + Environment.NewLine + "0 % ";
                    //scaleDivider(g3, affs[1].PlannedAffsCount);
                }
                else
                {
                    g3.Pointer.Value = decimal.Parse((Math.Round((double.Parse(affs[1].ActualAffsCount.ToString()) / double.Parse(affs[1].PlannedAffsCount.ToString())) * 100)).ToString());// affs[1].ActualAffsCount;
                    g3.Scale.Min = 0;
                    g3.Scale.Max = 100;// affs[1].PlannedAffsCount;
                    double jj = double.Parse(affs[1].ActualAffsCount.ToString());
                    g3.ToolTip = affs[1].ActualAffsCount + " out of " + affs[1].PlannedAffsCount.ToString() + Environment.NewLine + classB_Cover.ToString() + " % ";
                    //scaleDivider(g3, affs[1].PlannedAffsCount);
                }
            }
        }

        protected void ObjectDataSource2_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            int i = ((DataTable) e.ReturnValue).Rows.Count;
        }

        private void scaleDivider(RadRadialGauge g, double maxPlan)
        {
            decimal dec = decimal.Parse(maxPlan.ToString());

            //g.Scale.Ranges[0].From = 0;
            //g.Scale.Ranges[0].To = dec / 2;
            //g.Scale.Ranges[1].From = (dec / 2);
            //g.Scale.Ranges[1].To = ((dec * 9) / 10);
            //g.Scale.Ranges[2].From = ((dec * 9) / 10);
            //g.Scale.Ranges[2].To = ((dec * 12) / 10);
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            try
            {
                RadPivotGrid1.ExportSettings.Excel.Format = (PivotGridExcelFormat)Enum.Parse(typeof(PivotGridExcelFormat), "Xlsx");
                RadPivotGrid1.ExportSettings.IgnorePaging = true;
                RadPivotGrid1.ExportSettings.OpenInNewWindow = true;
                RadPivotGrid1.ExportSettings.FileName = "Summary";
                RadPivotGrid1.ExportToExcel();
            }
            catch (Exception ex)
            {
                RadWindowManager1.RadAlert(ex.Source + " - " + ex.Message, 400, 200, "Error!", null, "");
            }
        }

        protected void myID2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            Boolean isEmpty = true;
            for (int j = 0; j < e.Row.Cells.Count; j++)
            {
                if (e.Row.Cells[j].Text.ToString() != "" && e.Row.Cells[j].Text.ToString() != "&nbsp;")
                {
                    isEmpty = false;
                    if (j == 0)
                    {
                        e.Row.Cells[j].HorizontalAlign = HorizontalAlign.Left;
                        e.Row.Cells[j].Font.Bold = false;
                        e.Row.Cells[j].Font.Size = FontUnit.Large;
                    }
                    else
                    {
                        e.Row.Cells[j].HorizontalAlign = HorizontalAlign.Center;
                        e.Row.Cells[j].Font.Bold = true;
                        e.Row.Cells[j].Font.Size = FontUnit.Large;
                    }
                    //break;
                }
            }
            if (isEmpty == true)
            {
                e.Row.Visible = false;
            }
        }
    }
}