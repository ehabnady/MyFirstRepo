using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Drawing;

namespace AmounCRM4
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        SqlConnection conNewSave;
        SqlCommand cmdNewSave;
        SqlDataReader drNewSave;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                txtUserName.Text = "";
                txtOldPassword.Text = "";
                txtNewPassword.Text = "";
            }
        }
        private static readonly char[] SpecialChars = "!@#$%^&*()".ToCharArray();
        private static readonly char[] Numbers = "1234567890".ToCharArray();

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                bool oldpassword = false;
                using (EmployeeDBContext empdb = new EmployeeDBContext())
                {                    
                    EmployeesMasterData currentEmp = (from Emp_tbl in empdb.EmployeesMasterDatas where Emp_tbl.EmployeeUserName == txtUserName.Text select Emp_tbl).FirstOrDefault();
                    if (currentEmp.EmployeePassword == txtOldPassword.Text)
                    {
                        oldpassword = true;
                    }
                }

                bool hasUpperCaseLetter = false;
                foreach (char c in txtNewPassword.Text)
                {
                    if (char.IsUpper(c))
                    {
                        hasUpperCaseLetter = true;
                    }
                }
                int indexOf = txtNewPassword.Text.IndexOfAny(SpecialChars);
                int indexOfNo= txtNewPassword.Text.IndexOfAny(Numbers);
                if (txtNewPassword.Text == txtConfirmPassword.Text && txtUserName.Text != String.Empty && txtOldPassword.Text != String.Empty && txtNewPassword.Text!= txtOldPassword.Text && indexOf != -1 && indexOfNo != -1 && txtNewPassword.Text.Length >= 6 && hasUpperCaseLetter == true && oldpassword == true)
                {
                    /*
                    //Begin of Saving an old password
                    conNewSave = new SqlConnection(sqlDsEmp.ConnectionString);
                    string sss = @"Select Count(*) From PasswordHistory Where EmployeeUserName = " + txtUserName.Text + " AND (Pass1 = " + txtNewPassword.Text + 
                                " OR Pass2 = " + txtNewPassword.Text + " OR Pass3 = " + txtNewPassword.Text + ")";
                    cmdNewSave = new SqlCommand(sss, conNewSave);
                    conNewSave.Open();
                    drNewSave = cmdNewSave.ExecuteReader();
                    if (drNewSave.HasRows)
                    {
                        lblError.Text = "Please, write a password that is differrent from the last three passwords";
                        return;
                    }
                    else
                    {
                        sss = "UPDATE PasswordHistory SET Pass3 = Pass2, Pass2 = Pass1, Pass1 = " + txtNewPassword.Text + " WHERE EmployeeUserName = " + txtNewPassword.Text;
                        drNewSave = cmdNewSave.ExecuteReader();
                    }
                    //End of Saving an old password
                    */
                    sqlDsEmp.UpdateParameters["LastChangeDate"].DefaultValue = DateTime.Now.ToShortDateString();
                    sqlDsEmp.UpdateParameters["NextChangeDate"].DefaultValue = DateTime.Now.AddDays(45).ToShortDateString();
                    int i = sqlDsEmp.Update();

                    if (i > 0)
                    {
                        ClientScript.RegisterStartupScript(GetType(), "Alert", "alert('Password Changed Successfully');", true);
                        txtUserName.Text = "";
                        txtOldPassword.Text = "";
                        txtNewPassword.Text = "";
                        txtUserName.Text = "";
                        lblError.Text = "";

                        lblError.Text = "Your password has been changed successfully, click the below link to enter your new password";
                        lblError.BackColor = Color.Green;

                        lnkRedirect.Visible = true;
                        //Response.Redirect("~/Login2.aspx");
                    }
                    else
                    {
                        txtUserName.Text = "";
                        txtOldPassword.Text = "";
                        txtNewPassword.Text = "";
                        txtUserName.Text = "";
                        lblError.Text = "Your username or password is incorrect, please try again";
                    }
                }
                else
                {
                    if (oldpassword == false)
                    {
                        lblError.Text = "Your username or password is incorrect, please try again";
                    }
                    if (hasUpperCaseLetter==false)
                    {
                        lblError.Text = "Password Must contains capital letters, please try again";
                    }
                    if (txtUserName.Text == String.Empty)
                    {
                        lblError.Text = "Please write your username";
                    }
                    if (txtNewPassword.Text != txtConfirmPassword.Text)
                    {
                        lblError.Text = "Password and Confirm password must be identical, please try again";
                    }
                    if (txtNewPassword.Text == txtOldPassword.Text)
                    {
                        lblError.Text = "Old Password must be changed, please try again";
                    }
                    if (indexOf == -1)
                    {
                        lblError.Text = "Password Must contains Special Characters like !@#$%^&*() , please try again";
                    }
                    if (indexOfNo == -1)
                    {
                        lblError.Text = "Password Must contains Number, please try again";
                    }

                    if (txtNewPassword.Text.Length < 6)
                    {
                        lblError.Text = "Password Must be at least 6 Characters, please try again";
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message + " - " + ex.Source;
            }
        }

        protected void sqlDsEmp_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }
    }
}

//private static readonly char[] SpecialChars = "!@#$%^&*()".ToCharArray();

//...

//int indexOf = text.IndexOfAny(SpecialChars);
//if (indexOf == -1)
//{
//    // No special chars
//}