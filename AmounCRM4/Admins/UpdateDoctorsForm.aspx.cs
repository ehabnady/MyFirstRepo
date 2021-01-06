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
    public partial class UpdateDoctorsForm : System.Web.UI.Page
    {
        //Connection String from web.config File  
        string cs = ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ConnectionString;
        DataTable dt;
        SqlConnection myConn = default(SqlConnection);
        SqlCommand sqComm = default(SqlCommand);

        DataSet ds = new DataSet();
        SqlDataAdapter SqlAdapter;
       


        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                if (Session["EmployeeType"].ToString() == "Rep")
                {
                    int EmpID = int.Parse(Session["EmployeeID"].ToString());
                    AreaDataSource.SelectCommand = "SELECT AmounBrickID, AmounBrickName FROM View_EmployeesBricks WHERE(Deleted IS NULL) AND(EmployeeID = @EmployeeId)";
                    AreaDataSource.SelectParameters.Add("EmployeeId", Session["EmployeeID"].ToString());
                }
                //ShowData();
                GridView1.DataSource = GetData("SELECT Uname,Uaddress,UBrick,UNoOfPatients,UPHabit  FROM [AmounCRM2].[dbo].[DoctorsUpdate] where LineID=1 and EmployeeHRCode=101181 ORDER BY Uname");
                GridView1.DataBind();


            }
        }

      

        protected void GridView1_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            //Setting the EditIndex property to -1 to cancel the Edit mode in Gridview  
            GridView1.EditIndex = -1;
            ShowData();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                DropDownList ddlBrick = (e.Row.FindControl("ddlBrick") as DropDownList);
                if (ddlBrick != null)
                {
                    ddlBrick.DataSource = GetData("SELECT AmounBrickID, AmounBrickName FROM View_EmployeesBricks WHERE Deleted IS NULL AND EmployeeID = 101181");
                    ddlBrick.DataTextField = "AmounBrickID";
                    ddlBrick.DataValueField = "AmounBrickID";
                    ddlBrick.DataBind();

                    //ddlBrick.Items.Insert(0, new ListItem("Please select"));

                    string Brick = (e.Row.FindControl("lbl_Brick") as Label).Text;
                    ddlBrick.Items.FindByValue(Brick).Selected = true;
                }
            }
        }

        protected void GridView1_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            //NewEditIndex property used to determine the index of the row being edited.  

            GridView1.EditIndex = e.NewEditIndex;
            ShowData();
        }

      
        protected void ShowData()
        {
            dt = new DataTable();
            myConn = new SqlConnection(cs);
            myConn.Open();
            SqlAdapter = new SqlDataAdapter("SELECT Uname,Uaddress,UBrick,UNoOfPatients,UPHabit  FROM [AmounCRM2].[dbo].[DoctorsUpdate] where LineID=1 and EmployeeHRCode=101181 ORDER BY Uname", myConn);
            SqlAdapter.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            myConn.Close();
        }

       

      

   


        protected void GridView1_RowUpdating(object sender, System.Web.UI.WebControls.GridViewUpdateEventArgs e)
        {
            //Finding the controls from Gridview for the row which is going to update  
            Label id = GridView1.Rows[e.RowIndex].FindControl("lbl_ID") as Label;
            TextBox name = GridView1.Rows[e.RowIndex].FindControl("txt_Name") as TextBox;
            TextBox city = GridView1.Rows[e.RowIndex].FindControl("txt_City") as TextBox;
            myConn = new SqlConnection("");
            myConn.Open();
            //updating the record  
            SqlCommand cmd = new SqlCommand("Update tbl_Employee set Name='" + name.Text + "',City='" + city.Text + "' where ID=" + Convert.ToInt32(id.Text), myConn);
            cmd.ExecuteNonQuery();
            myConn.Close();
            //Setting the EditIndex property to -1 to cancel the Edit mode in Gridview  
            GridView1.EditIndex = -1;
            //Call ShowData method for displaying updated data  
            ShowData();
        }
        private DataSet GetData(string query)
        {
            string conString = ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ConnectionString;
            SqlCommand cmd = new SqlCommand(query);
            using (SqlConnection con = new SqlConnection(conString))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (DataSet ds = new DataSet())
                    {
                        sda.Fill(ds);
                        return ds;
                    }
                }
            }
        }
    }

   
}