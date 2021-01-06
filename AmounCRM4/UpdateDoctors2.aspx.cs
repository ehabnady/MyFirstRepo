using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;                  // FOR "DataTable"
using System.Data.SqlClient;
using System.Configuration;

namespace AmounCRM4
{
    public partial class UpdateDoctors2 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ConnectionString);
        SqlCommand cmdLog;
        DropDownList ddlFixed;
        DropDownList ddlBrickFixed;

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("Thanks.html");
            if (Session["EmployeeType"].ToString() == "Rep")
            {
                //this.Unload += new System.EventHandler(this.Page_UnLoad);
               
                int EmpID = int.Parse(Session["EmployeeID"].ToString());

                cmdLog = new SqlCommand("Insert INTO MyLogTable (EmployeeID, EntryDateTime) VALUES (@P1, @P2)", con);
                cmdLog.Parameters.Add(new SqlParameter("@P1", SqlDbType.Int));
                cmdLog.Parameters.Add(new SqlParameter("@P2", SqlDbType.DateTime));
                cmdLog.Parameters[0].Value = EmpID;
                cmdLog.Parameters[1].Value = DateTime.Now;
                con.Open();
                int iRec = cmdLog.ExecuteNonQuery();
                con.Close();

            }
            if (!IsPostBack)
            {
                refreshdata();
                ddlFixed = (DropDownList)GridView1.HeaderRow.FindControl("ddlSpecialitySE");
                ddlBrickFixed = (DropDownList)GridView1.HeaderRow.FindControl("ddlBrickSE");
            }
           
        }
       
        private void Page_UnLoad(object sender, EventArgs e)
        {
            //if (this.Page.IsCallback || this.Page.Title == "")
            //{
            //    return;
            //}
            if (Session["EmployeeID"].ToString() == "")
            {

            }
            else
            {
                int EmpID = int.Parse(Session["EmployeeID"].ToString());

                cmdLog = new SqlCommand("Update MyLogTable Set ClosingDateTime = @P1 Where EmployeeID = @P2 AND ClosingDateTime IS NULL", con);
                cmdLog.Parameters.Add(new SqlParameter("@P1", SqlDbType.DateTime));
                cmdLog.Parameters.Add(new SqlParameter("@P2", SqlDbType.Int));
                cmdLog.Parameters[0].Value = DateTime.Now;
                cmdLog.Parameters[1].Value = EmpID;
                con.Open();
                int iRec = cmdLog.ExecuteNonQuery();
                con.Close();
            }            
        }

        protected void GridView1_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            refreshdata();

            ddlFixed = (DropDownList)GridView1.HeaderRow.FindControl("ddlSpecialitySE");
            ddlFixed.Items.FindByValue(txtSpValue.Text).Selected = true;

            ddlBrickFixed = (DropDownList)GridView1.HeaderRow.FindControl("ddlBrickSE");
            ddlBrickFixed.Items.FindByValue(txtBrickVal.Text).Selected = true;
        }

        

        protected void GridView1_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            int check = 0;
            GridView1.EditIndex = e.NewEditIndex;
            refreshdata(); //commented by Ehab
            DropDownList PHabit = GridView1.Rows[GridView1.EditIndex].FindControl("ddlPHabit") as DropDownList;
            Label ID = GridView1.Rows[GridView1.EditIndex].FindControl("lbl_ID") as Label;

            ddlFixed = (DropDownList)GridView1.HeaderRow.FindControl("ddlSpecialitySE");
            ddlFixed.Items.FindByValue(txtSpValue.Text).Selected = true;

            ddlBrickFixed = (DropDownList)GridView1.HeaderRow.FindControl("ddlBrickSE");
            ddlBrickFixed.Items.FindByValue(txtBrickVal.Text).Selected = true;

            SqlCommand Pilotcmd = new SqlCommand("select * from pilotteam", con);
            SqlDataAdapter Pilotsda = new SqlDataAdapter(Pilotcmd);
            DataTable Pilotdt = new DataTable();
            Pilotsda.Fill(Pilotdt);

            SqlCommand Drcmd = new SqlCommand("select * FROM DoctorsUpdate where ID="+ID.Text, con);
            SqlDataAdapter Drsda = new SqlDataAdapter(Drcmd);
            DataTable Drdt = new DataTable();
            Drsda.Fill(Drdt);

            foreach (DataRow Drrow in Drdt.Rows)
            {
                foreach (DataRow Pilotrow in Pilotdt.Rows)
                {
                    if (Drrow["EmployeeID"].ToString() == Pilotrow["EmpID"].ToString())
                    {
                        check = 1;
                    }
                }
            }
           

            if (check == 1)
            {
                GridView1.Rows[GridView1.EditIndex].FindControl("ddlNoOfPatients").Visible = false;
            }
            else
            {
                GridView1.Rows[GridView1.EditIndex].FindControl("lbl_NoOfPatients").Visible = false;
            }

            //GridView1.DataSource = dt2;
            //GridView1.DataBind();
        }



        public void refreshdata()
        {
            SqlCommand cmd = new SqlCommand(@"SELECT Uname,Uaddress,UBrick,UNoOfPatients,UPHabit,txtbrick,txtNoOfPatients,txtPHabit,ID,
                            UDeleted,SpecialityCode,SpecialtyID FROM [AmounCRM2].[dbo].[DoctorsUpdate] 
                            where SpecialtyValue > 0 and LineID=" + Session["LineID"] + " and EmployeeID=" + Session["EmployeeID"], con);

            if (txtSpValue.Text != ""&& txtSpValue.Text != "0")
            {
                cmd.CommandText += " AND SpecialtyID = " + int.Parse(txtSpValue.Text);
            }
            if (txtBrickVal.Text != ""&& txtBrickVal.Text != "0")
            {
                cmd.CommandText += " AND BrickID = " + int.Parse(txtBrickVal.Text);
            }
            cmd.CommandText += " ORDER BY Uname";
            
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
            lblStatus.Text = "";

            //ddlFixed = (DropDownList)GridView1.HeaderRow.FindControl("ddlSpecialitySE");
            //ddlFixed.Items.FindByValue(txtSpValue.Text).Selected = true;

            //ddlBrickFixed = (DropDownList)GridView1.HeaderRow.FindControl("ddlBrickSE");
            //ddlBrickFixed.Items.FindByValue(txtBrickVal.Text).Selected = true;
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
            DropDownList delete = GridView1.Rows[e.RowIndex].FindControl("ddlDeleted") as DropDownList;

            if ((PHabit.SelectedIndex <= 0) && (String.Equals(delete.SelectedValue,"No")))
            {
                lblStatus.Text = "Plesae Select a Choice From The Prescription Habit List";
                return;
            }

            con = new SqlConnection(ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ConnectionString);
            con.Open();
            //updating the record  
            SqlCommand cmd = new SqlCommand(@"Update DoctorsUpdate set UName=N'" + name.Text + "',Uaddress=N'" + Address.Text
                + "',Ubrick=" + Brick.SelectedItem.Value + " ,UNoOfPatients=" + NoOfPatients.SelectedValue
                + " ,UPHabit=" + PHabit.SelectedValue + " ,UDeleted='" + delete.SelectedItem + "' ,txtbrick='"
                + Brick.SelectedItem + "' ,txtNoOfPatients='" + NoOfPatients.SelectedItem + "' ,txtPHabit='"
                + PHabit.SelectedItem
                + "', LastModifierID = " + int.Parse(Session["EmployeeID"].ToString())
                + " where ID=" + Convert.ToInt32(id.Text)+" and LineID="+ Session["LineID"], con);
            //SqlCommand cmd = new SqlCommand("Update DoctorsUpdate set Name=N'" + name.Text + "' where ID=" + Convert.ToInt32(id.Text), myConn);

            cmd.ExecuteNonQuery();
            con.Close();
            //Setting the EditIndex property to -1 to cancel the Edit mode in Gridview  
            GridView1.EditIndex = -1;
            //Call ShowData method for displaying updated data  
            lblStatus.Text = "Saved Successfully";
            refreshdata();

            ddlFixed = (DropDownList)GridView1.HeaderRow.FindControl("ddlSpecialitySE");
            ddlFixed.Items.FindByValue(txtSpValue.Text).Selected = true;

            ddlBrickFixed = (DropDownList)GridView1.HeaderRow.FindControl("ddlBrickSE");
            ddlBrickFixed.Items.FindByValue(txtBrickVal.Text).Selected = true;
        }

       

        protected void AddNewCustomer(object sender, EventArgs e)
        {

           

             //Label id = GridView1.Rows[e].FindControl("lbl_ID") as Label;
             TextBox name = GridView1.FooterRow.FindControl("txt_Name") as TextBox;
            TextBox Address = GridView1.FooterRow.FindControl("txt_Address") as TextBox;
            DropDownList Brick = GridView1.FooterRow.FindControl("ddlBrick") as DropDownList;
            DropDownList NoOfPatients = GridView1.FooterRow.FindControl("ddlNoOfPatients") as DropDownList;
            DropDownList PHabit = GridView1.FooterRow.FindControl("ddlPHabit") as DropDownList;
            DropDownList Speciality = GridView1.FooterRow.FindControl("ddlSpeciality") as DropDownList;


            if (Brick.SelectedIndex != 0 && NoOfPatients.SelectedIndex != 0 && PHabit.SelectedIndex != 0 && Speciality.SelectedIndex != 0 && name.Text != "0" && Address.Text != "0")
            {

                con = new SqlConnection(ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ConnectionString);
                con.Open();




                //updating the record  
                SqlCommand cmd = new SqlCommand("insert into DoctorsUpdate (UName,Uaddress,Ubrick,UNoOfPatients,UPHabit,LineID,EmployeeID,SpecialtyValue,txtbrick,txtNoOfPatients,txtPHabit,SpecialityCode,SpecialtyID,UDeleted,NewDoctor,EmployeeHRCode) values (N'" + name.Text + "',N'" + Address.Text + "'," + Brick.SelectedItem.Value + "," + NoOfPatients.SelectedItem.Value + "," + PHabit.SelectedItem.Value + "," + Session["LineID"] + "," + Session["EmployeeID"] + ",1000,'" + Brick.SelectedItem.Text + "','" + NoOfPatients.SelectedItem.Text + "','" + PHabit.SelectedItem.Text + "','" + Speciality.SelectedItem.Text + "'," + Speciality.SelectedItem.Value + ",'No',1,"+Session["EmployeeHRCode"]+")", con);
                //SqlCommand cmd = new SqlCommand("Update DoctorsUpdate set Name=N'" + name.Text + "' where ID=" + Convert.ToInt32(id.Text), myConn);

                cmd.ExecuteNonQuery();
                con.Close();
                //Setting the EditIndex property to -1 to cancel the Edit mode in Gridview  
                GridView1.EditIndex = -1;
                //Call ShowData method for displaying updated data  
                refreshdata();
            }
            else
            {
                lblStatus.Text = "All Fields Required";
            }

        }

        protected void OnPaging(object sender, GridViewPageEventArgs e)
        {
            if (txtSpValue.Text != "" && txtSpValue.Text != "0")
            {
                SqlCommand cmd = new SqlCommand("SELECT Uname,Uaddress,UBrick,UNoOfPatients,UPHabit,txtbrick,txtNoOfPatients,txtPHabit,ID,UDeleted,SpecialityCode,SpecialtyID FROM [AmounCRM2].[dbo].[DoctorsUpdate] where SpecialtyValue > 0 and LineID=" + Session["LineID"] + " and EmployeeID=" + Session["EmployeeID"] + " and SpecialtyID=" + int.Parse(txtSpValue.Text) + " ORDER BY Uname", con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            else if (txtBrickVal.Text != "" && txtBrickVal.Text != "0")
            {
                SqlCommand cmd = new SqlCommand("SELECT Uname,Uaddress,UBrick,UNoOfPatients,UPHabit,txtbrick,txtNoOfPatients,txtPHabit,ID,UDeleted,SpecialityCode,SpecialtyID FROM [AmounCRM2].[dbo].[DoctorsUpdate] where SpecialtyValue > 0 and LineID=" + Session["LineID"] + " and EmployeeID=" + Session["EmployeeID"] + " and UBrick=" + int.Parse(txtBrickVal.Text) + " ORDER BY Uname", con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            //else if (txtPHabitVal.Text != "")
            //{
            //    SqlCommand cmd = new SqlCommand("SELECT Uname,Uaddress,UBrick,UNoOfPatients,UPHabit,txtbrick,txtNoOfPatients,txtPHabit,ID,UDeleted,SpecialityCode,SpecialtyID FROM [AmounCRM2].[dbo].[DoctorsUpdate] where SpecialtyValue > 0 and LineID=" + Session["LineID"] + " and EmployeeID=" + Session["EmployeeID"] + " and UPHabit=" + Decimal.Parse(txtPHabitVal.Text) + " ORDER BY Uname", con);
            //    SqlDataAdapter sda = new SqlDataAdapter(cmd);
            //    DataTable dt = new DataTable();
            //    sda.Fill(dt);
            //    GridView1.DataSource = dt;
            //    GridView1.DataBind();


            //}
            else
            {
                refreshdata();
            }
            GridView1.PageIndex = e.NewPageIndex;
            GridView1.DataBind();
        }

        protected void SpecialityChanged(object sender, EventArgs e)
        {
            //txtBrickVal.Text = "";
            //txtPHabitVal.Text = "";

            DropDownList ddlSpecialitySE = (DropDownList)sender;
            ViewState["Filter"] = ddlSpecialitySE.SelectedValue;
            txtSpValue.Text = ddlSpecialitySE.SelectedValue;
            if (int.Parse(txtSpValue.Text) !=0)
            {
                string s = "SELECT Uname,Uaddress,UBrick,UNoOfPatients,UPHabit,txtbrick,txtNoOfPatients,txtPHabit,ID,UDeleted,SpecialityCode,SpecialtyID FROM [AmounCRM2].[dbo].[DoctorsUpdate] where SpecialtyValue > 0 and LineID= " + int.Parse(Session["LineID"].ToString());
                s += " AND EmployeeID= " + int.Parse(Session["EmployeeID"].ToString());
                s += " AND SpecialtyID=" + int.Parse(txtSpValue.Text);
                if (txtBrickVal.Text != "" && txtBrickVal.Text != "0")
                {
                    s += " AND UBrick = " + int.Parse(txtBrickVal.Text);
                }
                s += " ORDER BY Uname";

                SqlCommand cmd = new SqlCommand(s, con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                GridView1.DataSource = dt;
                GridView1.DataBind();

                ddlFixed = (DropDownList)GridView1.HeaderRow.FindControl("ddlSpecialitySE");
                ddlFixed.Items.FindByValue(txtSpValue.Text).Selected = true;

                ddlBrickFixed = (DropDownList)GridView1.HeaderRow.FindControl("ddlBrickSE");
                ddlBrickFixed.Items.FindByValue(txtBrickVal.Text).Selected = true;
            }
            else
            {
                refreshdata();
                
            }
           
        }

        protected void BrickChanged(object sender, EventArgs e)
        {
            //txtSpValue.Text = "";
            //txtPHabitVal.Text = "";
            DropDownList ddlBrickSE = (DropDownList)sender;
            ViewState["Filter"] = ddlBrickSE.SelectedValue;
            txtBrickVal.Text = ddlBrickSE.SelectedValue;
            if (int.Parse(txtBrickVal.Text) != 0)
            {
                string s = "SELECT Uname,Uaddress,UBrick,UNoOfPatients,UPHabit,txtbrick,txtNoOfPatients,txtPHabit,ID,UDeleted,SpecialityCode,SpecialtyID FROM [AmounCRM2].[dbo].[DoctorsUpdate] where SpecialtyValue > 0 and LineID= " + int.Parse(Session["LineID"].ToString());
                s += " AND EmployeeID= " + int.Parse(Session["EmployeeID"].ToString());
                s += " AND UBrick=" + int.Parse(txtBrickVal.Text);
                if (txtSpValue.Text != "" && txtSpValue.Text != "0")
                {
                    s += " AND SpecialtyID = " + int.Parse(txtSpValue.Text);
                }
                s += " ORDER BY Uname";
                SqlCommand cmd = new SqlCommand(s, con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                GridView1.DataSource = dt;
                GridView1.DataBind();

                ddlFixed = (DropDownList)GridView1.HeaderRow.FindControl("ddlSpecialitySE");
                ddlFixed.Items.FindByValue(txtSpValue.Text).Selected = true;

                ddlBrickFixed = (DropDownList)GridView1.HeaderRow.FindControl("ddlBrickSE");
                ddlBrickFixed.Items.FindByValue(txtBrickVal.Text).Selected = true;
            }
            else
            {
                refreshdata();

            }

        }
        //protected void PHabitChanged(object sender, EventArgs e)
        //{
        //    txtSpValue.Text = "";
        //    txtBrickVal.Text = "";
        //    DropDownList ddlPHabitSE = (DropDownList)sender;
        //    ViewState["Filter"] = ddlPHabitSE.SelectedValue;
        //    txtPHabitVal.Text = ddlPHabitSE.SelectedValue;

        //    if (Decimal.Parse(txtPHabitVal.Text) == 0)
        //    {
        //        SqlCommand cmd = new SqlCommand("SELECT Uname,Uaddress,UBrick,UNoOfPatients,UPHabit,txtbrick,txtNoOfPatients,txtPHabit,ID,UDeleted,SpecialityCode,SpecialtyID FROM [AmounCRM2].[dbo].[DoctorsUpdate] where NewDoctor is null and SpecialtyValue > 0 and LineID=" + Session["LineID"] + " and EmployeeID=" + Session["EmployeeID"] + " and UPHabit=" + Decimal.Parse(txtPHabitVal.Text) + " ORDER BY Uname", con);
        //        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        //        DataTable dt = new DataTable();
        //        sda.Fill(dt);
        //        GridView1.DataSource = dt;
        //        GridView1.DataBind();
        //    }


        //    else if (Decimal.Parse(txtPHabitVal.Text) == -10)
        //    {
        //        SqlCommand cmd = new SqlCommand("SELECT Uname,Uaddress,UBrick,UNoOfPatients,UPHabit,txtbrick,txtNoOfPatients,txtPHabit,ID,UDeleted,SpecialityCode,SpecialtyID FROM [AmounCRM2].[dbo].[DoctorsUpdate] where SpecialtyValue > 0 and LineID=" + Session["LineID"] + " and EmployeeID=" + Session["EmployeeID"] + " and UPHabit=" + Decimal.Parse(txtPHabitVal.Text) + " ORDER BY Uname", con);
        //        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        //        DataTable dt = new DataTable();
        //        sda.Fill(dt);
        //        GridView1.DataSource = dt;
        //        GridView1.DataBind();
        //    }
        //    else
        //    {
        //        refreshdata();

        //    }

        //}

        protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
        {
            GridViewRow gvr = e.Row;
            
            //e.Row.Cells[3].Visible = false;
           


        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}