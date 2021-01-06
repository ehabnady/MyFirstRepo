using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace AmounCRM4.Admins
{
    public partial class Bausch : System.Web.UI.Page
    {
        int hrCode = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeIDFromDM"].ToString() != "")
            {
                hrCode = int.Parse(Session["EmployeeHRCodeFromDM"].ToString());
                lblName.Text = Session["EmployeeNameFromDM"].ToString();
            }
            if (Session["EmployeeID"].ToString() != "")
            {
                hrCode = int.Parse(Session["EmployeeHRCode"].ToString());
                lblName.Text = Session["EmployeeName"].ToString();
            }
            if (Session["EmployeeHRCode"].ToString() == "101481")
            {
                hrCode = 101484;
            }
            string cmdText = @"SELECT [RecID], [EmployeeHRCode], [EmployeeUserName], [EmployeePassword], [Deleted], [EmployeeUN], [EmployeePWD] FROM [EmployeesBauschCredential] 
                                WHERE(([Deleted] IS NULL) AND([EmployeeHRCode] = " + hrCode + "))";
            SqlCommand cmd = new SqlCommand(cmdText, new SqlConnection(sqlDS_Bausch.ConnectionString));
            cmd.Connection.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                lblHRCode_Val.Text = dr[1].ToString();
                lblUserName_Val.Text = dr[2].ToString();
                lblPassword_Val.Text = dr[3].ToString();
                Label5.Text = dr[5].ToString();
                Label7.Text = dr[6].ToString();
            }
            cmd.Connection.Close();
        }
    }
}