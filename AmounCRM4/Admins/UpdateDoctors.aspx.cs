using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;                  // FOR "DataTable"
using System.Data.SqlClient;
using System.Configuration;


namespace AmounCRM4.Admins
{
    public partial class UpdateDoctors : System.Web.UI.Page
    {
        
        SqlConnection myConn = default(SqlConnection);
        SqlCommand sqComm = default(SqlCommand);

        System.Data.DataSet ds = new System.Data.DataSet();
        System.Data.SqlClient.SqlDataAdapter SqlAdapter;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["EmployeeType"].ToString() == "Rep")
                {
                    int EmpID = int.Parse(Session["EmployeeID"].ToString());
                }
            }
            if (setConn())
            {
                PopulateDS();       // FILL DATASET WITH MASTER DATA.
                ShowEmpDetails();   // SHOW EMPLOYEE DETAILS IN THE GRIDVIEW.
            }


        }
        private bool setConn()
        {
            // SET DATABASE CONNECTION.
            try
            {
                myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ConnectionString);
                myConn.Open();

                sqComm = new SqlCommand();
                sqComm.Connection = myConn;
            }
            catch (Exception ex) { return false; }
            return true;
        }

        protected void GridView1_RowCancelingEdit(object sender,System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            ShowEmpDetails();
        }

        protected void GridView1_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
        {


            if ((e.Row.RowState & DataControlRowState.Edit) > 0)
            {

                DropDownList ddlbr = new DropDownList();
                ddlbr = (DropDownList)e.Row.FindControl("ddlBrick");

                if (ddlbr != null)
                {
                    ddlbr.DataSource = ds.Tables["Bricks"];
                    ddlbr.DataTextField = ds.Tables["Bricks"].Columns["AmounBrickName"].ColumnName.ToString();
                    ddlbr.DataValueField = ds.Tables["Bricks"].Columns["AmounBrickID"].ColumnName.ToString();
                    ddlbr.DataBind();

                    ((DropDownList)e.Row.FindControl("ddlBrick")).SelectedValue =
                        DataBinder.Eval(e.Row.DataItem, "UBrick").ToString();
                }



                DropDownList ddlNo = new DropDownList();
                ddlNo = (DropDownList)e.Row.FindControl("ddlNoOfPatients");

                if (ddlNo != null)
                {
                    ddlNo.DataSource = ds.Tables["NoOfPatients"];
                    ddlNo.DataTextField = ds.Tables["NoOfPatients"].Columns["RangeName"].ColumnName.ToString();
                    ddlNo.DataValueField = ds.Tables["NoOfPatients"].Columns["RangeValue"].ColumnName.ToString();
                    ddlNo.DataBind();


                    ((DropDownList)e.Row.FindControl("ddlNoOfPatients")).SelectedValue =
                        DataBinder.Eval(e.Row.DataItem, "UNoOfPatients").ToString();
                }

                DropDownList ddlPH = new DropDownList();
                ddlPH = (DropDownList)e.Row.FindControl("ddlPHabit");

                if (ddlPH != null)
                {
                    ddlPH.DataSource = ds.Tables["PHabit"];
                    ddlPH.DataTextField = ds.Tables["PHabit"].Columns["ShortName"].ColumnName.ToString();
                    ddlPH.DataValueField = ds.Tables["PHabit"].Columns["RangeValue"].ColumnName.ToString();
                    ddlPH.DataBind();


                    ((DropDownList)e.Row.FindControl("ddlPHabit")).SelectedValue =
                        DataBinder.Eval(e.Row.DataItem, "UPHabit").ToString();
                }
                
            }

           
        }
        protected void GridView1_RowEditing(object sender,System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            ShowEmpDetails();
        }

        private void PopulateDS()
        {
           
            ds.Clear();
            SqlAdapter = new System.Data.SqlClient.SqlDataAdapter
                ("SELECT AmounBrickID,AmounBrickName FROM View_EmployeesBricks WHERE Deleted IS NULL AND EmployeeID = "+ Session["EmployeeID"], myConn);
            SqlAdapter.Fill(ds, "Bricks");
            SqlAdapter = new System.Data.SqlClient.SqlDataAdapter
               ("SELECT RangeValue,RangeName FROM [AmounCRM2].[dbo].[NoOfPatients]", myConn);
            SqlAdapter.Fill(ds, "NoOfPatients");
            SqlAdapter = new System.Data.SqlClient.SqlDataAdapter
              ("SELECT ShortName,[RangeValue] FROM [AmounCRM2].[dbo].[PrescriptionHappit]", myConn);
            SqlAdapter.Fill(ds, "PHabit");
            SqlAdapter.Dispose();
        }


        private void ShowEmpDetails()
        {
            string sQuery = "SELECT Uname,Uaddress,UBrick,UNoOfPatients,UPHabit,txtbrick,txtNoOfPatients,txtPHabit,ID  FROM [AmounCRM2].[dbo].[DoctorsUpdate] where SpecialtyValue > 0 and LineID=" + Session["LineID"] +" and EmployeeID="+ Session["EmployeeID"]+" ORDER BY Uname";

            SqlDataReader sdrEmp = GetDataReader(sQuery);
            try
            {
                if (sdrEmp.HasRows)
                {
                    DataTable dt = new DataTable();
                    dt.Load(sdrEmp);

                    GridView1.DataSource = dt;
                    GridView1.DataBind();        // BIND DATABASE TABLE WITH THE GRIDVIEW.
                }
            }
            catch (Exception ex) { }
            finally
            {
                sdrEmp.Close();
                sdrEmp = null;
            }
        }

        private SqlDataReader GetDataReader(string sQuery)
        {
            SqlDataReader functionReturnValue = default(SqlDataReader);
            sqComm.CommandText = sQuery;
            sqComm.ExecuteNonQuery();
            functionReturnValue = sqComm.ExecuteReader();
            sqComm.Dispose();
            return functionReturnValue;
        }
        protected void GridView1_RowUpdating(object sender, System.Web.UI.WebControls.GridViewUpdateEventArgs e)
        {
            //Finding the controls from Gridview for the row which is going to update
            Label id = GridView1.Rows[e.RowIndex].FindControl("lbl_ID") as Label;
            TextBox name = GridView1.Rows[e.RowIndex].FindControl("txt_Name") as TextBox;
            TextBox Address = GridView1.Rows[e.RowIndex].FindControl("txt_Address") as TextBox;
            DropDownList Brick = GridView1.Rows[e.RowIndex].FindControl("ddlBrick") as DropDownList;
            //string Brick = (GridView1.Rows[e.RowIndex].FindControl("ddlBrick") as DropDownList).SelectedItem.Value;
            DropDownList NoOfPatients = GridView1.Rows[e.RowIndex].FindControl("ddlNoOfPatients") as DropDownList;
            DropDownList PHabit = GridView1.Rows[e.RowIndex].FindControl("ddlPHabit") as DropDownList;

            myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ConnectionString);
            myConn.Open();
            //updating the record  
            SqlCommand cmd = new SqlCommand("Update DoctorsUpdate set Name=N'" + name.Text + "',EntityAddress=N'" + Address.Text + "',Ubrick=" + Brick.SelectedItem.Value + " ,UNoOfPatients=" + NoOfPatients.SelectedValue + " ,UPHabit=" + PHabit.SelectedValue + " ,txtbrick='" + Brick.SelectedItem + "' ,txtNoOfPatients='" + NoOfPatients.SelectedItem + "' ,txtPHabit='" + PHabit.SelectedItem + "' where ID=" + Convert.ToInt32(id.Text), myConn);
            //SqlCommand cmd = new SqlCommand("Update DoctorsUpdate set Name=N'" + name.Text + "' where ID=" + Convert.ToInt32(id.Text), myConn);

            cmd.ExecuteNonQuery();
            myConn.Close();
            //Setting the EditIndex property to -1 to cancel the Edit mode in Gridview  
            GridView1.EditIndex = -1;
            //Call ShowData method for displaying updated data  
            ShowEmpDetails();
        }

    }
}