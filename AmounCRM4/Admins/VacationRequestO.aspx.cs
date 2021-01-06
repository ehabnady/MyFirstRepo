using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AmounCRM4.Admins
{
    public partial class VacationRequestO : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ConnectionString);

        SqlCommand cmd;
        SqlConnection conn;
        GridViewRow vacRow;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["EmployeeType"].ToString() == "Rep")
                {
                    //rbApproved.Visible = false;
                    //rbRejected.Visible = false;
                }
                if (Session["EmployeeType"].ToString() == "DM")
                {
                    btnSave.Visible = false;

                }
                LoadVacations();
            }
        }

        public int GetWorkingDays(DateTime from, DateTime to)
        {
            int totalDays;
            if (from.DayOfWeek == DayOfWeek.Thursday || from.DayOfWeek == DayOfWeek.Friday)
            {
                totalDays = 0;
            }
            else
            {
                totalDays = 1;
            }
            for (var date = from.AddDays(1); date <= to; date = date.AddDays(1))
            {
                if (date.DayOfWeek != DayOfWeek.Thursday
                    && date.DayOfWeek != DayOfWeek.Friday)
                    totalDays++;
            }

            return totalDays;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Session["EmployeeType"].ToString() == "Rep")
            {
                DateTime first_date = new DateTime(DateTime.Today.Year, DateTime.Today.Month, 1);
                DateTime last_date = new DateTime(DateTime.Today.Year, DateTime.Today.Month, DateTime.DaysInMonth(DateTime.Today.Year, DateTime.Today.Month));
                var today = DateTime.Now;
                var tomorrow = today.AddDays(1);
                var yesterday = today.AddDays(-1);
                var month = DateTime.Now.Month.ToString();



                con = new SqlConnection(ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ConnectionString);
                SqlCommand cmd2 = new SqlCommand("select CycleID from Cycles where IsCurrent=1");
                cmd2.CommandType = CommandType.Text;
                con.Open();
                cmd2.Connection = con;
                int cycleid = (int)cmd2.ExecuteScalar();
                con.Close();


                con = new SqlConnection(ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ConnectionString);
                SqlCommand cmd22 = new SqlCommand("select MonthID from Cycles where IsCurrent=1");
                cmd22.CommandType = CommandType.Text;
                con.Open();
                cmd22.Connection = con;
                int cyclemonth = (int)cmd22.ExecuteScalar();
                con.Close();



                if (month != cyclemonth.ToString())
                {
                    VacationslblSaveStatus.Text = "You can't register a vacation beyond the current cycle";
                    return;
                }

                if (Session["CycleID"].ToString() != cycleid.ToString())
                {
                    VacationslblSaveStatus.Text = "You can't register a vacation beyond the current cycle";
                    return;
                }


                if (dpStartDate.SelectedDate.Value.Date < yesterday.Date)//Modified to take a Date Part in a consideration, Ehab(4-Mar-2018) Reviewe before publishing
                {
                    VacationslblSaveStatus.Text = "Invalid Start Date,it must be within 24 hour by maximum";
                    return;
                }
                if (dpStartDate.SelectedDate > last_date || dpStartDate.SelectedDate < first_date)
                {
                    VacationslblSaveStatus.Text = "Invalid Start Date,it must be within this month";
                    return;
                }

                if (dpEndDate.SelectedDate > last_date || dpEndDate.SelectedDate < first_date)
                {
                    VacationslblSaveStatus.Text = "Invalid End Date,it must be within this month";
                    return;
                }




                if (dpStartDate.SelectedDate == null || dpEndDate.SelectedDate == null || txtNoOfDays.Text == "" || ddlVacationType.SelectedValue == "0")
                {
                    VacationslblSaveStatus.Text = "All fields are mandatory";
                    return;
                }

                if (dpEndDate.SelectedDate < dpStartDate.SelectedDate)
                {
                    VacationslblSaveStatus.Text = "Invalid End Date";
                    return;
                }
                if (int.Parse(ddlVacationType.SelectedValue) == 2 && dpStartDate.SelectedDate > today)
                {
                    VacationslblSaveStatus.Text = "Invalid Vacation type, Emergency Vaction must be within 24 hour by maximum";
                    return;
                }

                int EmpID = int.Parse(Session["EmployeeID"].ToString());
                using (VacationDBContext db = new VacationDBContext())
                {
                    Vacation VacationData = (from Vacation_tbl in db.Vacations where Vacation_tbl.EmpID == EmpID && Vacation_tbl.StartDate >= first_date && Vacation_tbl.EndDate <= last_date && ((Vacation_tbl.StartDate <= dpStartDate.SelectedDate && Vacation_tbl.EndDate >= dpEndDate.SelectedDate) || (Vacation_tbl.StartDate <= dpStartDate.SelectedDate && Vacation_tbl.EndDate >= dpStartDate.SelectedDate) || (Vacation_tbl.StartDate <= dpEndDate.SelectedDate && Vacation_tbl.EndDate >= dpEndDate.SelectedDate) || (Vacation_tbl.StartDate > dpStartDate.SelectedDate && Vacation_tbl.EndDate < dpEndDate.SelectedDate)) && Vacation_tbl.Deleted == false select Vacation_tbl).FirstOrDefault();
                    if (VacationData != null)
                    {
                        VacationslblSaveStatus.Text = "You have a vacation in this date range.";
                        //gvVacations.DataSource = VacationData.;
                        //gvVacations.DataBind();
                        return;
                    }
                }
                using (NationalEntities db = new NationalEntities())
                {

                    NationalVaccation nationalData = (from nationalVac_tbl in db.NationalVaccations where nationalVac_tbl.Deleted == null && nationalVac_tbl.VaccationDate >= dpStartDate.SelectedDate && nationalVac_tbl.VaccationDate <= dpEndDate.SelectedDate select nationalVac_tbl).FirstOrDefault();
                    if (nationalData != null)
                    {
                        VacationslblSaveStatus.Text = "You have a National vacation in this date range.";
                        return;
                    }
                }




                using (VacationDBContext newvac = new VacationDBContext())
                {
                    Vacation vac = new Vacation();
                    vac.EmpID = int.Parse(Session["EmployeeID"].ToString());
                    vac.EmpHRCode = int.Parse(Session["EmployeeHRCode"].ToString());
                    vac.EmpName = Session["EmployeeName"].ToString();
                    vac.StartDate = dpStartDate.SelectedDate;
                    string start = dpStartDate.SelectedDate.ToString();

                    vac.EndDate = dpEndDate.SelectedDate;
                    vac.RequestDate = DateTime.Today;

                    vac.Deleted = false;
                    vac.NoOfDayes = int.Parse(txtNoOfDays.Text);
                    vac.CycleID = int.Parse(Session["CycleID"].ToString());
                    vac.VacationTypeID = int.Parse(ddlVacationType.SelectedValue);
                    vac.VacationType = ddlVacationType.SelectedItem.ToString();

                    using (EmployeesViewDBContext Empdb = new EmployeesViewDBContext())
                    {
                        View_Employees EmpData = (from Emp_tbl in Empdb.View_Employees where Emp_tbl.EmployeeID == vac.EmpID select Emp_tbl).FirstOrDefault();
                        vac.DMID = EmpData.DirectManagerID;
                    }
                    newvac.Vacations.Add(vac);
                    int roweffected = newvac.SaveChanges();
                    if (roweffected > 0)
                    {
                        VacationslblSaveStatus.Text = "Saved";
                        Clear();
                        LoadVacations();
                    }
                    else
                    {
                        VacationslblSaveStatus.Text = "Error";
                    }

                }
            }
        }

        private void Clear()
        {
            txtNoOfDays.Text = "";
            txtVacID.Text = "";
            ddlVacationType.SelectedValue = "0";
            dpEndDate.Clear();
            dpStartDate.Clear();
            btnSave.Visible = true;
            btnUpdate.Visible = false;
            btnDelete.Visible = false;
            dpStartDate.Enabled = true;
            dpEndDate.Enabled = true;

        }
        private void LoadVacations()
        {
            using (VacationDBContext db = new VacationDBContext())
            {
                if ((Session["EmployeeType"]).ToString() == "DM")
                {
                    int DMId = int.Parse(Session["EmployeeIDFromDM"].ToString());

                    var VacationsData = from Vacations_tbl in db.Vacations where Vacations_tbl.ApprovalStatus == null && Vacations_tbl.DMID == DMId && Vacations_tbl.Deleted == false select Vacations_tbl;
                    gvVacations.DataSource = VacationsData.ToList();
                    gvVacations.DataBind();

                }
                if ((Session["EmployeeType"]).ToString() == "Rep")
                {
                    int RepId = int.Parse(Session["EmployeeID"].ToString());

                    var VacationsData = from Vacations_tbl in db.Vacations where Vacations_tbl.EmpID == RepId && Vacations_tbl.Deleted == false && Vacations_tbl.CycleID >= 51 select Vacations_tbl;
                    gvVacations.DataSource = VacationsData.ToList();
                    gvVacations.DataBind();

                }
                if (gvVacations.Rows.Count == 0)
                {
                    VacationslblSaveStatus.Text = "No Requests found";
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {


            using (VacationDBContext db = new VacationDBContext())
            {
                DateTime first_date = new DateTime(DateTime.Today.Year, DateTime.Today.Month, 1);
                DateTime last_date = new DateTime(DateTime.Today.Year, DateTime.Today.Month, DateTime.DaysInMonth(DateTime.Today.Year, DateTime.Today.Month));
                var today = DateTime.Today;
                var tomorrow = today.AddDays(1);
                var yesterday = today.AddDays(-1);

                if (dpStartDate.SelectedDate.Value.Date < yesterday.Date && dpEndDate.SelectedDate.Value.Date < yesterday)
                {
                    VacationslblSaveStatus.Text = "Invalid Date,it must be within 24 hour by maximum";
                    return;
                }

                if (dpStartDate.SelectedDate > last_date || dpStartDate.SelectedDate < first_date)
                {
                    VacationslblSaveStatus.Text = "Invalid Start Date,it must be within this month";
                    return;
                }

                if (dpEndDate.SelectedDate > last_date || dpEndDate.SelectedDate < first_date)
                {
                    VacationslblSaveStatus.Text = "Invalid End Date,it must be within this month";
                    return;
                }

                if (dpStartDate.SelectedDate == null || dpEndDate.SelectedDate == null || txtNoOfDays.Text == "" || ddlVacationType.SelectedValue == "0")
                {
                    VacationslblSaveStatus.Text = "All fields is mandatory";
                    return;
                }

                if (dpEndDate.SelectedDate < dpStartDate.SelectedDate)
                {
                    VacationslblSaveStatus.Text = "Invalid End Date";
                    return;
                }
                int ID = int.Parse(txtVacID.Text);
                Vacation updateVac = (from Vac_tbl in db.Vacations where Vac_tbl.VacationID == ID && Vac_tbl.Deleted == false select Vac_tbl).FirstOrDefault();
                if (Session["EmployeeType"].ToString() == "Rep")
                {

                    updateVac.StartDate = dpStartDate.SelectedDate;
                    updateVac.EndDate = dpEndDate.SelectedDate;
                    updateVac.NoOfDayes = int.Parse(txtNoOfDays.Text);
                    updateVac.VacationTypeID = int.Parse(ddlVacationType.SelectedValue);
                    updateVac.VacationType = ddlVacationType.SelectedItem.ToString();

                    //updateVac.RequestDate = DateTime.Today;
                }



                int roweffected = db.SaveChanges();
                if (roweffected > 0)
                {
                    VacationslblSaveStatus.Text = "Updated";

                    gvVacations.DataSource = null;
                    gvVacations.DataBind();
                    LoadVacations();
                    Clear();

                }
                else
                {
                    VacationslblSaveStatus.Text = "Error";
                }
            }
        }



        protected void rbApproved_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void gvVacations_SelectedIndexChanged(object sender, EventArgs e)
        {

            var today = DateTime.Today;
            var tomorrow = today.AddDays(1);
            var yesterday = today.AddDays(-1);
            VacationslblSaveStatus.Text = "";
            btnUpdate.Visible = true;
            btnDelete.Visible = true;
            btnSave.Visible = false;

            vacRow = gvVacations.SelectedRow;
            dpStartDate.SelectedDate = DateTime.Parse(vacRow.Cells[5].Text);
            dpEndDate.SelectedDate = DateTime.Parse(vacRow.Cells[6].Text);
            if (dpStartDate.SelectedDate.Value.Date < yesterday.Date)
            {
                dpStartDate.Enabled = false;
            }
            else
            {
                dpStartDate.Enabled = true;

            }
            if (dpEndDate.SelectedDate.Value.Date < yesterday.Date)
            {
                dpEndDate.Enabled = false;
            }
            else
            {
                dpEndDate.Enabled = true;

            }
            txtVacID.Text = vacRow.Cells[1].Text;
            txtNoOfDays.Text = vacRow.Cells[14].Text;
            ddlVacationType.SelectedValue = vacRow.Cells[16].Text;

        }
        protected void gvVacations_RowCreated(object sender, GridViewRowEventArgs e)
        {
            GridViewRow gvr = e.Row;
            if (gvr.RowType == DataControlRowType.Header)
            {
                gvr.Cells[3].Text = "Rep. Name";
                gvr.Cells[5].Text = "From Date";
                gvr.Cells[6].Text = "To Date";
                //gvr.Cells[10].Text = "Status";
                gvr.Cells[11].Text = "Request Date";
                gvr.Cells[14].Text = "Duration";

            }
            e.Row.Cells[1].Visible = false;
            e.Row.Cells[2].Visible = false;
            e.Row.Cells[4].Visible = false;
            e.Row.Cells[7].Visible = false;
            e.Row.Cells[8].Visible = false;
            e.Row.Cells[9].Visible = false;
            e.Row.Cells[10].Visible = false;

            e.Row.Cells[12].Visible = false;
            e.Row.Cells[13].Visible = false;

            //e.Row.Cells[14].Visible = false;
            e.Row.Cells[15].Visible = false;
            e.Row.Cells[16].Visible = false;


        }
        protected void gvVacations_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[5].Text = Convert.ToDateTime(e.Row.Cells[5].Text).ToString("dd/MM/yyyy");
                e.Row.Cells[6].Text = Convert.ToDateTime(e.Row.Cells[6].Text).ToString("dd/MM/yyyy");
                e.Row.Cells[11].Text = Convert.ToDateTime(e.Row.Cells[11].Text).ToString("dd/MM/yyyy");
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            using (VacationDBContext db = new VacationDBContext())
            {
                DateTime first_date = new DateTime(DateTime.Today.Year, DateTime.Today.Month, 1);
                DateTime last_date = new DateTime(DateTime.Today.Year, DateTime.Today.Month, DateTime.DaysInMonth(DateTime.Today.Year, DateTime.Today.Month));
                var today = DateTime.Today;
                var tomorrow = today.AddDays(1);
                var yesterday = today.AddDays(-1);

                if (dpStartDate.SelectedDate.Value.Date < yesterday.Date)
                {
                    VacationslblSaveStatus.Text = "You can't delete this vacation,it must be within 24 hour by maximum";
                    Clear();
                    return;
                }

                if (dpStartDate.SelectedDate > last_date || dpStartDate.SelectedDate < first_date)
                {
                    VacationslblSaveStatus.Text = "Invalid Start Date,it must be within this month";
                    return;
                }

                if (dpEndDate.SelectedDate > last_date || dpEndDate.SelectedDate < first_date)
                {
                    VacationslblSaveStatus.Text = "Invalid End Date,it must be within this month";
                    return;
                }

                if (dpStartDate.SelectedDate == null || dpEndDate.SelectedDate == null || txtNoOfDays.Text == "" || ddlVacationType.SelectedValue == "0")
                {
                    VacationslblSaveStatus.Text = "All fields is mandatory";
                    return;
                }

                if (dpEndDate.SelectedDate < dpStartDate.SelectedDate)
                {
                    VacationslblSaveStatus.Text = "Invalid End Date";
                    return;
                }
                int ID = int.Parse(txtVacID.Text);
                Vacation updateVac = (from Vac_tbl in db.Vacations where Vac_tbl.VacationID == ID && Vac_tbl.Deleted == false select Vac_tbl).FirstOrDefault();
                if (Session["EmployeeType"].ToString() == "Rep")
                {

                    updateVac.StartDate = dpStartDate.SelectedDate;
                    updateVac.EndDate = dpEndDate.SelectedDate;
                    updateVac.NoOfDayes = int.Parse(txtNoOfDays.Text);
                    updateVac.VacationTypeID = int.Parse(ddlVacationType.SelectedValue);
                    updateVac.Deleted = true;
                    //updateVac.RequestDate = DateTime.Today;
                }



                int roweffected = db.SaveChanges();
                if (roweffected > 0)
                {
                    VacationslblSaveStatus.Text = "Deleted";

                    gvVacations.DataSource = null;
                    gvVacations.DataBind();
                    LoadVacations();
                    Clear();

                }
                else
                {
                    VacationslblSaveStatus.Text = "Error";
                }
            }
        }

        protected void dpEndDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            if (ddlVacationType.SelectedItem.ToString() == "Office Meeting")
            {
                txtNoOfDays.Text = "0";
            }
            else if (dpEndDate.SelectedDate != null && dpStartDate != null)
            {
                txtNoOfDays.Text = GetWorkingDays(DateTime.Parse(dpStartDate.SelectedDate.ToString()), DateTime.Parse(dpEndDate.SelectedDate.ToString())).ToString();

            }

        }



        protected void dpStartDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            if (ddlVacationType.SelectedItem.ToString() == "Office Meeting")
            {
                txtNoOfDays.Text = "0";
            }
            else if (dpEndDate.SelectedDate != null && dpStartDate != null)
            {
                txtNoOfDays.Text = GetWorkingDays(DateTime.Parse(dpStartDate.SelectedDate.ToString()), DateTime.Parse(dpEndDate.SelectedDate.ToString())).ToString();

            }
        }

        protected void ddlVacationType_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (ddlVacationType.SelectedItem.ToString() == "Office Meeting")
            {
                txtNoOfDays.Text = "0";
            }
            else if (dpEndDate.SelectedDate != null && dpStartDate != null)
            {
                txtNoOfDays.Text = GetWorkingDays(DateTime.Parse(dpStartDate.SelectedDate.ToString()), DateTime.Parse(dpEndDate.SelectedDate.ToString())).ToString();

            }

        }
    }
}