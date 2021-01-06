using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Data;
namespace AmounCRM4.Admins
{
    public partial class EmployeeFormTempUpdates : System.Web.UI.Page
    {
        GridViewRow EmpRow;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //ddlAreaForRep.Visible = true;
                //ddlAreaForDM.Visible = true;
                //ddlAreaForMan.Visible = true;
                //ddlDMNames.Visible = true;
                //ddlManNames.Visible = true;

                ddlAreaForRep.AppendDataBoundItems = true;
                ddlAreaForDM.AppendDataBoundItems = true;
                ddlAreaForMan.AppendDataBoundItems = true;
                ddlDMNames.AppendDataBoundItems = true;
                ddlManNames.AppendDataBoundItems = true;




            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (txtName.Text != "" && txtHRCode.Text != "" && ddlPosition.SelectedIndex != 0)
            {
                if (ddlPosition.SelectedValue == "Rep" && ddlAreaForRep.SelectedIndex != 0 && ddlDMNames.SelectedIndex != 0 && ddlLine.SelectedIndex != 0)
                {
                    Save();
                }

                else if (ddlPosition.SelectedValue == "DM" && ddlAreaForDM.SelectedIndex != 0 && ddlManNames.SelectedIndex != 0 && ddlLine.SelectedIndex != 0)
                {
                    Save();
                }
                else if (true)
                {

                }
                else
                {
                    lblEmployeeSaveStatus.Text = "All Fields is mandatory";
                }
            }
            else
            {
                lblEmployeeSaveStatus.Text = "All Fields is mandatory";

            }
        }


        private void Save()
        {
            //string Pass;
            //using (AmounCRM2Entities newEmployeMD = new AmounCRM2Entities())
            //{
            //    EmployeesMasterDataTemp EmpMD = new EmployeesMasterDataTemp();
            //    EmpMD.EmployeeFullName = txtName.Text;
            //    EmpMD.EmployeeHRCode = int.Parse(txtHRCode.Text);
            //    EmpMD.EmployeeUserName = txtHRCode.Text;
            //    EmpMD.MustChangePassword = true;
            //    EmpMD.NoOfVisitsPerDay = int.Parse(txtVisitsPreDay.Text);
            //    EmpMD.EmployeePassword = RandomPassword.Generate(8, 10);
            //    Pass = EmpMD.EmployeePassword;
            //    newEmployeMD.EmployeesMasterDataTemps.Add(EmpMD);
            //    int roweffected = newEmployeMD.SaveChanges();
            //    if (roweffected > 0)
            //    {
            //        lblEmployeeSaveStatus.Text = "Saved";

            //    }
            //    else
            //    {
            //        lblEmployeeSaveStatus.Text = "Error";
            //        return;
            //    }
            //}

            //using (EmployeeHDBContext newHistory = new EmployeeHDBContext())
            //{
            //    EmployeesHistory History = new EmployeesHistory();
            //    History.EmployeeHRCode = int.Parse(txtHRCode.Text);
            //    History.LineID = int.Parse(ddlLine.SelectedValue);

            //    if (ddlPosition.SelectedValue == "Rep")
            //    {
            //        History.RepAreaID = int.Parse(ddlAreaForRep.SelectedValue);
            //        History.EmployeeType = "Rep";
            //        History.ReportsTo = int.Parse(ddlDMNames.SelectedValue);
            //    }
            //    if (ddlPosition.SelectedValue == "DM")
            //    {
            //        History.RepAreaID = int.Parse(ddlAreaForDM.SelectedValue);
            //        History.EmployeeType = "DM";
            //        History.ReportsTo = int.Parse(ddlManNames.SelectedValue);
            //    }
            //    if (ddlPosition.SelectedValue == "SM")
            //    {
            //        History.RepAreaID = int.Parse(ddlAreaForDM.SelectedValue);
            //        History.EmployeeType = "Sales Manager";
            //        History.ReportsTo = int.Parse(ddlManNames.SelectedValue);
            //    }

            //    newHistory.EmployeesHistories.Add(History);
            //    int roweffected = newHistory.SaveChanges();
            //    if (roweffected > 0)
            //    {
            //        using (EmployeesViewDBContext refreshdb = new EmployeesViewDBContext())
            //        {
            //            int empid = int.Parse(txtHRCode.Text);
            //            var Employeedata = from Employee_tbl in refreshdb.View_Employees where Employee_tbl.EmployeeHRCode == empid select Employee_tbl;
            //            gvEmployee.DataSource = Employeedata.ToList();
            //            gvEmployee.DataBind();

            //        }
            //        Clear();
            //        lblEmployeeSaveStatus.Text = "Saved, Password is: " + Pass;
            //    }
            //    else
            //    {
            //        lblEmployeeSaveStatus.Text = "Error";
            //        return;

            //    }
            //}
            ////UploadPic();
        }
        private void Clear()
        {
            txtHRCode.Text = "";
            txtName.Text = "";
            txtVisitsPreDay.Text = "";
            ddlPosition.SelectedIndex = 0;
            ddlLine.SelectedIndex = 0;
            ddlAreaForRep.SelectedIndex = 0;
            DMDataSource.DataBind();
            //ddlAreaForDM.Items.Clear();
            //ddlAreaForDM.DataSource = DMDataSource;
            ddlAreaForDM.SelectedIndex = 0;
            ddlAreaForMan.SelectedIndex = 0;
            ddlDMNames.SelectedIndex = 0;
            ddlManNames.SelectedIndex = 0;
            ddlAreaForRep.Visible = false;
            ddlAreaForDM.Visible = false;
            ddlAreaForMan.Visible = false;
            ddlDMNames.Visible = false;
            ddlManNames.Visible = false;
            lblEmployeeSaveStatus.Text = "";
            btnDelete.Visible = false;
            btnUpdate.Visible = false;
            txtHRCode.Enabled = true;
            //ddlAreaForDM.Items.Clear();
            //ddlAreaForDM.DataSource = DMDataSource;


        }

        protected void ddlPosition_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlPosition.SelectedValue == "Rep")
            {
                ddlAreaForRep.Visible = true;
                ddlAreaForDM.Visible = false;
                ddlDMNames.Visible = true;
                ddlManNames.Visible = false;

            }
            if (ddlPosition.SelectedValue == "DM")
            {
                ddlAreaForDM.Visible = true;
                ddlAreaForRep.Visible = false;
                ddlDMNames.Visible = false;
                ddlManNames.Visible = true;
            }
            if (ddlPosition.SelectedValue != "DM" && ddlPosition.SelectedValue != "Rep")
            {
                ddlAreaForDM.Visible = false;
                ddlAreaForRep.Visible = true;
                ddlDMNames.Visible = false;
                ddlManNames.Visible = false;
                ddlLine.Visible = true;
            }
        }

        public class RandomPassword
        {
            // Define default min and max password lengths.
            private static int DEFAULT_MIN_PASSWORD_LENGTH = 8;
            private static int DEFAULT_MAX_PASSWORD_LENGTH = 10;

            // Define supported password characters divided into groups.
            // You can add (or remove) characters to (from) these groups.
            private static string PASSWORD_CHARS_LCASE = "abcdefgijkmnopqrstwxyz";
            private static string PASSWORD_CHARS_UCASE = "ABCDEFGHJKLMNPQRSTWXYZ";
            private static string PASSWORD_CHARS_NUMERIC = "1234567890";
            private static string PASSWORD_CHARS_SPECIAL = "*$-+?_&=!%{}/";

            /// <summary>
            /// Generates a random password.
            /// </summary>
            /// <returns>
            /// Randomly generated password.
            /// </returns>
            /// <remarks>
            /// The length of the generated password will be determined at
            /// random. It will be no shorter than the minimum default and
            /// no longer than maximum default.
            /// </remarks>
            public static string Generate()
            {
                return Generate(DEFAULT_MIN_PASSWORD_LENGTH,
                                DEFAULT_MAX_PASSWORD_LENGTH);
            }

            /// <summary>
            /// Generates a random password of the exact length.
            /// </summary>
            /// <param name="length">
            /// Exact password length.
            /// </param>
            /// <returns>
            /// Randomly generated password.
            /// </returns>
            public static string Generate(int length)
            {
                return Generate(length, length);
            }

            /// <summary>
            /// Generates a random password.
            /// </summary>
            /// <param name="minLength">
            /// Minimum password length.
            /// </param>
            /// <param name="maxLength">
            /// Maximum password length.
            /// </param>
            /// <returns>
            /// Randomly generated password.
            /// </returns>
            /// <remarks>
            /// The length of the generated password will be determined at
            /// random and it will fall with the range determined by the
            /// function parameters.
            /// </remarks>
            public static string Generate(int minLength,
                                          int maxLength)
            {
                // Make sure that input parameters are valid.
                if (minLength <= 0 || maxLength <= 0 || minLength > maxLength)
                    return null;

                // Create a local array containing supported password characters
                // grouped by types. You can remove character groups from this
                // array, but doing so will weaken the password strength.
                char[][] charGroups = new char[][]
                {
            PASSWORD_CHARS_LCASE.ToCharArray(),
            PASSWORD_CHARS_UCASE.ToCharArray(),
            PASSWORD_CHARS_NUMERIC.ToCharArray(),
            PASSWORD_CHARS_SPECIAL.ToCharArray()
                };

                // Use this array to track the number of unused characters in each
                // character group.
                int[] charsLeftInGroup = new int[charGroups.Length];

                // Initially, all characters in each group are not used.
                for (int i = 0; i < charsLeftInGroup.Length; i++)
                    charsLeftInGroup[i] = charGroups[i].Length;

                // Use this array to track (iterate through) unused character groups.
                int[] leftGroupsOrder = new int[charGroups.Length];

                // Initially, all character groups are not used.
                for (int i = 0; i < leftGroupsOrder.Length; i++)
                    leftGroupsOrder[i] = i;

                // Because we cannot use the default randomizer, which is based on the
                // current time (it will produce the same "random" number within a
                // second), we will use a random number generator to seed the
                // randomizer.

                // Use a 4-byte array to fill it with random bytes and convert it then
                // to an integer value.
                byte[] randomBytes = new byte[4];

                // Generate 4 random bytes.
                RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
                rng.GetBytes(randomBytes);

                // Convert 4 bytes into a 32-bit integer value.
                int seed = BitConverter.ToInt32(randomBytes, 0);

                // Now, this is real randomization.
                Random random = new Random(seed);

                // This array will hold password characters.
                char[] password = null;

                // Allocate appropriate memory for the password.
                if (minLength < maxLength)
                    password = new char[random.Next(minLength, maxLength + 1)];
                else
                    password = new char[minLength];

                // Index of the next character to be added to password.
                int nextCharIdx;

                // Index of the next character group to be processed.
                int nextGroupIdx;

                // Index which will be used to track not processed character groups.
                int nextLeftGroupsOrderIdx;

                // Index of the last non-processed character in a group.
                int lastCharIdx;

                // Index of the last non-processed group.
                int lastLeftGroupsOrderIdx = leftGroupsOrder.Length - 1;

                // Generate password characters one at a time.
                for (int i = 0; i < password.Length; i++)
                {
                    // If only one character group remained unprocessed, process it;
                    // otherwise, pick a random character group from the unprocessed
                    // group list. To allow a special character to appear in the
                    // first position, increment the second parameter of the Next
                    // function call by one, i.e. lastLeftGroupsOrderIdx + 1.
                    if (lastLeftGroupsOrderIdx == 0)
                        nextLeftGroupsOrderIdx = 0;
                    else
                        nextLeftGroupsOrderIdx = random.Next(0,
                                                             lastLeftGroupsOrderIdx);

                    // Get the actual index of the character group, from which we will
                    // pick the next character.
                    nextGroupIdx = leftGroupsOrder[nextLeftGroupsOrderIdx];

                    // Get the index of the last unprocessed characters in this group.
                    lastCharIdx = charsLeftInGroup[nextGroupIdx] - 1;

                    // If only one unprocessed character is left, pick it; otherwise,
                    // get a random character from the unused character list.
                    if (lastCharIdx == 0)
                        nextCharIdx = 0;
                    else
                        nextCharIdx = random.Next(0, lastCharIdx + 1);

                    // Add this character to the password.
                    password[i] = charGroups[nextGroupIdx][nextCharIdx];

                    // If we processed the last character in this group, start over.
                    if (lastCharIdx == 0)
                        charsLeftInGroup[nextGroupIdx] =
                                                  charGroups[nextGroupIdx].Length;
                    // There are more unprocessed characters left.
                    else
                    {
                        // Swap processed character with the last unprocessed character
                        // so that we don't pick it until we process all characters in
                        // this group.
                        if (lastCharIdx != nextCharIdx)
                        {
                            char temp = charGroups[nextGroupIdx][lastCharIdx];
                            charGroups[nextGroupIdx][lastCharIdx] =
                                        charGroups[nextGroupIdx][nextCharIdx];
                            charGroups[nextGroupIdx][nextCharIdx] = temp;
                        }
                        // Decrement the number of unprocessed characters in
                        // this group.
                        charsLeftInGroup[nextGroupIdx]--;
                    }

                    // If we processed the last group, start all over.
                    if (lastLeftGroupsOrderIdx == 0)
                        lastLeftGroupsOrderIdx = leftGroupsOrder.Length - 1;
                    // There are more unprocessed groups left.
                    else
                    {
                        // Swap processed group with the last unprocessed group
                        // so that we don't pick it until we process all groups.
                        if (lastLeftGroupsOrderIdx != nextLeftGroupsOrderIdx)
                        {
                            int temp = leftGroupsOrder[lastLeftGroupsOrderIdx];
                            leftGroupsOrder[lastLeftGroupsOrderIdx] =
                                        leftGroupsOrder[nextLeftGroupsOrderIdx];
                            leftGroupsOrder[nextLeftGroupsOrderIdx] = temp;
                        }
                        // Decrement the number of unprocessed groups.
                        lastLeftGroupsOrderIdx--;
                    }
                }

                // Convert password characters into a string and return the result.
                return new string(password);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Clear();
            using (EmployeesViewDBContext db = new EmployeesViewDBContext())
            {
                if (txtCodeSe.Text != "" && txtNameSe.Text == "")
                {
                    int Code = int.Parse(txtCodeSe.Text);
                    var Employeedata = from Employee_tbl in db.View_Employees where (Employee_tbl.DeletedEmployee == null || Employee_tbl.DeletedEmployee == false) && Employee_tbl.EmployeeHRCode == Code select Employee_tbl;
                    gvEmployee.DataSource = Employeedata.ToList();
                }

                if (txtCodeSe.Text == "" && txtNameSe.Text != "")
                {
                    string Name = txtNameSe.Text;
                    var Employeedata = from Employee_tbl in db.View_Employees where (Employee_tbl.DeletedEmployee == null || Employee_tbl.DeletedEmployee == false) && Employee_tbl.EmployeeFullName.Contains(Name) select Employee_tbl;
                    gvEmployee.DataSource = Employeedata.ToList();
                }

                if (txtCodeSe.Text != "" && txtNameSe.Text != "")
                {
                    int Code = int.Parse(txtCodeSe.Text);
                    string Name = txtNameSe.Text;
                    var Employeedata = from Employee_tbl in db.View_Employees where (Employee_tbl.DeletedEmployee == null || Employee_tbl.DeletedEmployee == false) && Employee_tbl.EmployeeHRCode == Code && Employee_tbl.EmployeeFullName.Contains(Name) select Employee_tbl;
                    gvEmployee.DataSource = Employeedata.ToList();
                }
                gvEmployee.DataBind();
            }
        }
        protected void gvEmployee_RowCreated(object sender, GridViewRowEventArgs e)
        {
            GridViewRow gvr = e.Row;
            if (gvr.RowType == DataControlRowType.Header)
            {
                gvr.Cells[3].Text = "Code";
                gvr.Cells[4].Text = "Name";
                gvr.Cells[7].Text = "Line";
                gvr.Cells[8].Text = "Position";
                gvr.Cells[18].Text = "Direct MGR";
            }
            e.Row.Cells[1].Visible = false;
            e.Row.Cells[2].Visible = false;
            e.Row.Cells[5].Visible = false;
            e.Row.Cells[6].Visible = false;
            e.Row.Cells[9].Visible = false;
            e.Row.Cells[10].Visible = false;
            e.Row.Cells[11].Visible = false;
            e.Row.Cells[12].Visible = false;
            e.Row.Cells[13].Visible = false;
            e.Row.Cells[14].Visible = false;
            e.Row.Cells[15].Visible = false;
            e.Row.Cells[16].Visible = false;
            e.Row.Cells[17].Visible = false;
            e.Row.Cells[19].Visible = false;
            e.Row.Cells[20].Visible = false;
            e.Row.Cells[21].Visible = false;
            e.Row.Cells[22].Visible = false;
            e.Row.Cells[23].Visible = false;
            e.Row.Cells[24].Visible = false;
            e.Row.Cells[25].Visible = false;
            e.Row.Cells[26].Visible = false;
            e.Row.Cells[27].Visible = false;
            e.Row.Cells[28].Visible = false;
            e.Row.Cells[29].Visible = false;
            e.Row.Cells[30].Visible = false;
            e.Row.Cells[31].Visible = false;
            e.Row.Cells[32].Visible = false;
            e.Row.Cells[33].Visible = false;
            e.Row.Cells[34].Visible = false;
            e.Row.Cells[35].Visible = false;
            e.Row.Cells[36].Visible = false;
            e.Row.Cells[37].Visible = false;
            e.Row.Cells[38].Visible = false;
            e.Row.Cells[39].Visible = false;
            e.Row.Cells[40].Visible = false;
            e.Row.Cells[41].Visible = false;
            e.Row.Cells[42].Visible = false;
            e.Row.Cells[43].Visible = false;
            e.Row.Cells[44].Visible = false;
            e.Row.Cells[45].Visible = false;
            e.Row.Cells[46].Visible = false;
            e.Row.Cells[47].Visible = false;
            e.Row.Cells[48].Visible = false;
            e.Row.Cells[49].Visible = false;
            e.Row.Cells[50].Visible = false;
            e.Row.Cells[51].Visible = false;
            e.Row.Cells[52].Visible = false;
            e.Row.Cells[53].Visible = false;
            e.Row.Cells[54].Visible = false;



        }

        protected void gvEmployee_SelectedIndexChanged(object sender, EventArgs e)
        {
            Clear();
            txtHRCode.Enabled = false;
            btnUpdate.Visible = true;
            btnDelete.Visible = true;
            ddlAreaForRep.DataBind();
            ddlDMNames.DataBind();
            ddlManNames.DataBind();
            ddlAreaForDM.DataBind();


            EmpRow = gvEmployee.SelectedRow;
            txtEmpID.Text = EmpRow.Cells[6].Text;
            txtHRCode.Text = EmpRow.Cells[3].Text;
            txtName.Text = EmpRow.Cells[4].Text;
            txtVisitsPreDay.Text = EmpRow.Cells[54].Text;
            ddlPosition.SelectedValue = EmpRow.Cells[8].Text;
            if (EmpRow.Cells[7].Text != "14")
            {
                ddlLine.SelectedValue = EmpRow.Cells[7].Text;

            }
            if (ddlPosition.SelectedValue == "Rep")
            {
                ddlAreaForRep.SelectedValue = EmpRow.Cells[9].Text;
                ddlDMNames.SelectedValue = EmpRow.Cells[14].Text;
                ddlManNames.Text = EmpRow.Cells[24].Text;
                ddlAreaForRep.Visible = true;
                ddlDMNames.Visible = true;

            }
            if (ddlPosition.SelectedValue == "DM")
            {
                ddlAreaForDM.SelectedValue = EmpRow.Cells[9].Text;
                ddlManNames.SelectedValue = EmpRow.Cells[14].Text;
                ddlAreaForDM.Visible = true;
                ddlManNames.Visible = true;

            }
            if (ddlPosition.SelectedValue == "Sales Manager")
            {
                //ddlAreaForMan.SelectedValue = EmpRow.Cells[9].Text;
            }
            //LoadPic();


        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (txtName.Text != "" && txtHRCode.Text != "" && ddlLine.SelectedIndex != 0 && ddlPosition.SelectedIndex != 0)
            {
                if (ddlPosition.SelectedValue == "Rep" && ddlAreaForRep.SelectedIndex != 0 && ddlDMNames.SelectedIndex != 0)
                {
                    Update();
                }

                else if (ddlPosition.SelectedValue == "DM" && ddlAreaForDM.SelectedIndex != 0 && ddlManNames.SelectedIndex != 0)
                {
                    Update();
                }
                else
                {
                    lblEmployeeSaveStatus.Text = "All Fields is mandatory";
                }
            }
            else
            {
                lblEmployeeSaveStatus.Text = "All Fields is mandatory";

            }
        }
        private void Update()
        {
            //string Pass;
            using (AmounCRM2Entities newEmployeMD = new AmounCRM2Entities())
            {
                EmployeesMasterDataTemp EmpMD = new EmployeesMasterDataTemp();
                EmpMD.EmployeeFullName = txtName.Text;
                EmpMD.EmployeeHRCode = int.Parse(txtHRCode.Text);
                EmpMD.EmployeeUserName = txtHRCode.Text;
                //EmpMD.MustChangePassword = true;
                EmpMD.NoOfVisitsPerDay = int.Parse(txtVisitsPreDay.Text);
                //EmpMD.EmployeePassword = RandomPassword.Generate(8, 10);
                //Pass = EmpMD.EmployeePassword;
                newEmployeMD.EmployeesMasterDataTemps.Add(EmpMD);
                int roweffected = newEmployeMD.SaveChanges();
                if (roweffected > 0)
                {
                    lblEmployeeSaveStatus.Text = "Saved";

                }
                else
                {
                    lblEmployeeSaveStatus.Text = "Error";
                    return;
                }
            }

            using (EmpHistoryTempEntities newHistory = new EmpHistoryTempEntities())
            {
                EmployeesHistoryTemp History = new EmployeesHistoryTemp();
                History.EmployeeHRCode = int.Parse(txtHRCode.Text);
                History.LineID = int.Parse(ddlLine.SelectedValue);
                History.EmployeeID = int.Parse(txtEmpID.Text);
                if (ddlPosition.SelectedValue == "Rep")
                {
                    History.RepAreaID = int.Parse(ddlAreaForRep.SelectedValue);
                    History.EmployeeType = "Rep";
                    History.ReportsTo = int.Parse(ddlDMNames.SelectedValue);
                }
                if (ddlPosition.SelectedValue == "DM")
                {
                    History.RepAreaID = int.Parse(ddlAreaForDM.SelectedValue);
                    History.EmployeeType = "DM";
                    History.ReportsTo = int.Parse(ddlManNames.SelectedValue);
                }
                if (ddlPosition.SelectedValue == "SM")
                {
                    History.RepAreaID = int.Parse(ddlAreaForDM.SelectedValue);
                    History.EmployeeType = "Sales Manager";
                    History.ReportsTo = int.Parse(ddlManNames.SelectedValue);
                }

                newHistory.EmployeesHistoryTemps.Add(History);
                int roweffected = newHistory.SaveChanges();
                if (roweffected > 0)
                {
                    using (EmployeesViewDBContext refreshdb = new EmployeesViewDBContext())
                    {
                        int empid = int.Parse(txtHRCode.Text);
                        var Employeedata = from Employee_tbl in refreshdb.View_Employees where Employee_tbl.EmployeeHRCode == empid select Employee_tbl;
                        gvEmployee.DataSource = Employeedata.ToList();
                        gvEmployee.DataBind();

                    }
                    Clear();
                    //lblEmployeeSaveStatus.Text = "Saved, Password is: " + Pass;
                }
                else
                {
                    lblEmployeeSaveStatus.Text = "Error";
                    return;

                }
            }

        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            int Code = int.Parse(txtHRCode.Text);
            using (EmployeeDBContext db = new EmployeeDBContext())
            {
                EmployeesMasterData ResetEmployeeMD = (from Employee_tbl in db.EmployeesMasterDatas where Employee_tbl.EmployeeHRCode == Code select Employee_tbl).FirstOrDefault();
                ResetEmployeeMD.EmployeePassword = RandomPassword.Generate(6, 8);
                ResetEmployeeMD.MustChangePassword = true;
                int roweffected = db.SaveChanges();
                if (roweffected > 0)
                {
                    Clear();
                    lblEmployeeSaveStatus.Text = "The New Password is " + ResetEmployeeMD.EmployeePassword;
                }
                else
                {
                    lblEmployeeSaveStatus.Text = "Error";
                    return;
                }

            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string Pass;
            using (AmounCRM2Entities newEmployeMD = new AmounCRM2Entities())
            {
                EmployeesMasterDataTemp EmpMD = new EmployeesMasterDataTemp();
                EmpMD.EmployeeFullName = txtName.Text;

                EmpMD.EmployeeHRCode = int.Parse(txtHRCode.Text);
                EmpMD.EmployeeUserName = txtHRCode.Text;
                EmpMD.MustChangePassword = true;
                EmpMD.NoOfVisitsPerDay = int.Parse(txtVisitsPreDay.Text);
                EmpMD.Deleted = true;
                EmpMD.EmployeePassword = RandomPassword.Generate(8, 10);
                Pass = EmpMD.EmployeePassword;
                newEmployeMD.EmployeesMasterDataTemps.Add(EmpMD);
                int roweffected = newEmployeMD.SaveChanges();
                if (roweffected > 0)
                {
                    lblEmployeeSaveStatus.Text = "Saved";

                }
                else
                {
                    lblEmployeeSaveStatus.Text = "Error";
                    return;
                }
            }

            using (EmpHistoryTempEntities newHistory = new EmpHistoryTempEntities())
            {
                EmployeesHistoryTemp History = new EmployeesHistoryTemp();
                History.EmployeeHRCode = int.Parse(txtHRCode.Text);
                History.LineID = int.Parse(ddlLine.SelectedValue);
                History.EmployeeID = int.Parse(txtEmpID.Text);

                History.Deleted = true;
                if (ddlPosition.SelectedValue == "Rep")
                {
                    History.RepAreaID = int.Parse(ddlAreaForRep.SelectedValue);
                    History.EmployeeType = "Rep";
                    History.ReportsTo = int.Parse(ddlDMNames.SelectedValue);
                }
                if (ddlPosition.SelectedValue == "DM")
                {
                    History.RepAreaID = int.Parse(ddlAreaForDM.SelectedValue);
                    History.EmployeeType = "DM";
                    History.ReportsTo = int.Parse(ddlManNames.SelectedValue);
                }
                if (ddlPosition.SelectedValue == "SM")
                {
                    History.RepAreaID = int.Parse(ddlAreaForDM.SelectedValue);
                    History.EmployeeType = "Sales Manager";
                    History.ReportsTo = int.Parse(ddlManNames.SelectedValue);
                }

                newHistory.EmployeesHistoryTemps.Add(History);
                int roweffected = newHistory.SaveChanges();
                if (roweffected > 0)
                {
                    using (EmployeesViewDBContext refreshdb = new EmployeesViewDBContext())
                    {
                        int empid = int.Parse(txtHRCode.Text);
                        var Employeedata = from Employee_tbl in refreshdb.View_Employees where Employee_tbl.EmployeeHRCode == empid select Employee_tbl;
                        gvEmployee.DataSource = Employeedata.ToList();
                        gvEmployee.DataBind();

                    }
                    Clear();
                    //lblEmployeeSaveStatus.Text = "Saved, Password is: " + Pass;
                }
                else
                {
                    lblEmployeeSaveStatus.Text = "Error";
                    return;

                }
            }
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            UploadPic();
        }

        private void UploadPic()
        {

            HttpPostedFile postedFile = PicUpload.PostedFile;
            string filename = Path.GetFileName(postedFile.FileName);
            if (filename != "")
            {
                string fileExtension = Path.GetExtension(filename);
                int fileSize = postedFile.ContentLength;

                if (fileExtension.ToLower() == ".jpg" || fileExtension.ToLower() == ".gif"
                 || fileExtension.ToLower() == ".png" || fileExtension.ToLower() == ".bmp")
                {
                    Stream stream = postedFile.InputStream;
                    BinaryReader binaryReader = new BinaryReader(stream);
                    Byte[] bytes = binaryReader.ReadBytes((int)stream.Length);


                    string cs = ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ConnectionString;
                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        SqlCommand cmd = new SqlCommand("spUploadImage", con);
                        cmd.CommandType = CommandType.StoredProcedure;

                        SqlParameter paramName = new SqlParameter()
                        {
                            ParameterName = @"Name",
                            Value = filename
                        };
                        cmd.Parameters.Add(paramName);

                        SqlParameter paramSize = new SqlParameter()
                        {
                            ParameterName = "@Size",
                            Value = fileSize
                        };
                        cmd.Parameters.Add(paramSize);

                        SqlParameter paramImageData = new SqlParameter()
                        {
                            ParameterName = "@ImageData",
                            Value = bytes
                        };
                        cmd.Parameters.Add(paramImageData);

                        SqlParameter paramNewId = new SqlParameter()
                        {
                            ParameterName = "@NewId",
                            Value = int.Parse(txtHRCode.Text)
                        };
                        cmd.Parameters.Add(paramNewId);

                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();

                        //lblMessage.Visible = true;
                        //lblMessage.ForeColor = System.Drawing.Color.Green;
                        lblEmployeeSaveStatus.Text = "Upload Successful";
                        //hyperlink.Visible = true;
                        //hyperlink.NavigateUrl = "~/WebForm2.aspx?Id=" +
                        //    cmd.Parameters["@NewId"].Value.ToString();
                    }
                }
                else
                {
                    //lblMessage.Visible = true;
                    lblEmployeeSaveStatus.ForeColor = System.Drawing.Color.Red;
                    lblEmployeeSaveStatus.Text = "Only images (.jpg, .png, .gif and .bmp) can be uploaded";
                    //hyperlink.Visible = false;
                }
            }
            lblEmployeeSaveStatus.Text = "no Picture added";

        }

        protected void btnLoad_Click(object sender, EventArgs e)
        {
            LoadPic();
        }

        private void LoadPic()
        {
            string cs = ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("spGetImageById", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter paramId = new SqlParameter()
                {
                    ParameterName = "@Id",
                    Value = int.Parse(txtHRCode.Text)
                };
                cmd.Parameters.Add(paramId);

                con.Open();
                byte[] bytes = (byte[])cmd.ExecuteScalar();
                //string strBase64 = Convert.ToBase64String(bytes);
                //Image1.ImageUrl = "data:Image/png;base64," + strBase64;
            }
        }
    }
}