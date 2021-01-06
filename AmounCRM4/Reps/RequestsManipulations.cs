using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;


namespace AmounCRM4.Reps
{
    public static class RequestsManipulations
    {
        private static SqlCommand cmdMan;
        private static SqlConnection conMan;
        private static SqlDataAdapter daMan;
        private static SqlDataReader drMan;
        private static DataSet ds;

        public static void openConnection()
        {
            conMan = new SqlConnection(ConfigurationManager.ConnectionStrings["AmounCrmConnectionString"].ConnectionString);
            conMan.Open();
        }

        public static void closeConnection()
        {
            conMan.Close();
        }
        public static DataTable GetPhyEnt(int affID)
        {
            string strPhCMD = "select PhysicianID,EntityID from Affiliations where AffiliationID="+affID;
            cmdMan = new SqlCommand(strPhCMD, conMan);
            daMan =new SqlDataAdapter(cmdMan);
            ds = new DataSet("ds");
            daMan.Fill(ds);

            return ds.Tables[0];
        }
        public static DataTable GetAffProposed(int recID)
        {
            string strCmd = @"Select RealAffID,AffiliationName,PhysicianID,EntityID,AreaRecID,SpecialityID,LineID
            ,PhysicianClass,BestTimeFrom,BestTimeTo,Notes,Deleted,EmployeeID,EntryDate,Is_Approved,
            EntityAddress,EntityTypeID,Tel1,Tel2,Tel3,Fax,EntityEmailAddress,EntityWebSite,
            PhysicianName,EntityName,Is_Implemented,RepName,DMID,BrickID,NoOfPatients,
            WatingTime,PrescriptionHappit,AdminComments,DMComments,RequestType,Description,
            EntityNameOld,PhysicianNameOld,EntityAddressOld,AreaRecIDOld,SpecialityIDOld,
            EntityTypeIDOld,NoOfPatientsOld,WatingTimeOld,PrescriptionHappitOld,AffiliationID,
            SMID,SM_Approved,SDID,SD_Approved,COVP_ID,COVP_Approved,SM_Comment,SD_Comment,
            CO_Comment,Status,RecID,DMSignature,SMSignature,SDSignature,COSignature,AdminSignature,
            RequestDate,DMDate,SMDate,SDDate,CODate,AdminDate,ProceedBySignature,ProceedByDate,
            ProceedBy,NoOfOperations,NoOfOperationsOld 
            From Affiliations_Proposed
            WHERE RecID = " + recID;
            cmdMan = new SqlCommand(strCmd, conMan);
            daMan = new SqlDataAdapter(cmdMan);
            ds = new DataSet("ds");
            daMan.Fill(ds);

            return ds.Tables[0];
        }

        public static DataTable GetPhyValByLine(int AffID,int LineID)
        {
            string strCmd = @"Select RecID,AffiliationID,LineID,NoOfPatients,WaitingTime,SpecialtyValue,TotalValue
            ,PhysicianClass,Deleted,PrescriptionHappit,NoOfPatientsOld,CreateDate,LastModificationDate,CreatorID,LastModifierID,
            NoOfPatientsOld2,PrescriptionHappitOld2,NoOfOperations
            From PhysicianValueByLine
            WHERE AffiliationID = " + AffID+ " and LineID="+ LineID;
            cmdMan = new SqlCommand(strCmd, conMan);
            daMan = new SqlDataAdapter(cmdMan);
            ds = new DataSet("ds");
            daMan.Fill(ds);

            return ds.Tables[0];
        }
        public static void CreateTemp(int recID, int EmployeeHRCodeFromAdmin)
        {
            DataTable t = GetAffProposed(recID);
            //Create New Entity
            string insertEntity = @"INSERT INTO Entities (EntityName,EntityAddress,EntityTypeID,BrickID
                                 ,Tel1,Tel2,Tel3,Fax,EntityEmailAddress,EntityWebSite,EntryEmployeeID,EntryDate)
                                 VALUES (N'"
                                 + t.Rows[0][24].ToString() + "', N'"
                                 + t.Rows[0][15].ToString() + "', "
                                 + 2 + ", "
                                 + int.Parse(t.Rows[0][28].ToString()) + ", '"
                                 + t.Rows[0][17].ToString() + "', '"
                                 + t.Rows[0][18].ToString() + "', '"
                                 + t.Rows[0][19].ToString() + "', '"
                                 + t.Rows[0][20].ToString() + "', '"
                                 + t.Rows[0][21].ToString() + "', '"
                                 + t.Rows[0][22].ToString() + "', "
                                 + EmployeeHRCodeFromAdmin + ", '"
                                 + DateTime.Now.ToString("MM/dd/yyyy") + "')";
            cmdMan = new SqlCommand(insertEntity, conMan);
            int EntityReq = cmdMan.ExecuteNonQuery();

            
            cmdMan = new SqlCommand("select max(EntityID) from Entities", conMan);
            int EntityID = int.Parse(cmdMan.ExecuteScalar().ToString());

            //Create New Physician

            string insertPhysician = @"INSERT INTO Physicians (PhysicianName,MobileNumber,TelNumber,PhysicianEmailAddress,SpecialtyID
                                    ,EntryEmployeeID,EntryDate) VALUES (N'"
                                    + t.Rows[0][23].ToString() + "', '"
                                    + t.Rows[0][17].ToString() + "', '"
                                    + t.Rows[0][18].ToString() + "', '"
                                    + t.Rows[0][21].ToString() + "', "
                                    + int.Parse(t.Rows[0][5].ToString()) + ", "
                                    + EmployeeHRCodeFromAdmin + ", '"
                                    + DateTime.Now.ToString("MM/dd/yyyy") + "')";
            cmdMan = new SqlCommand(insertPhysician, conMan);
            int PhysicianReq = cmdMan.ExecuteNonQuery();

            cmdMan = new SqlCommand("select max(PhysicianID) from Physicians", conMan);
            int PhysiciansID = int.Parse(cmdMan.ExecuteScalar().ToString());

            //insert into AffiliationsTemp

            int ReqLine = int.Parse(t.Rows[0][6].ToString());
            decimal PrHabbit = 0;
            decimal NoOfPat = 0;
            string strInsert = @"INSERT INTO AffiliationsTemp (AffiliationName, PhysicianID, EntityID, BestTimeFrom, BestTimeTo, Notes,EntryEmployeeID, EntryDate,Deleted , Status, New,RequestID)
                                VALUES (N'"

                                + t.Rows[0][1].ToString() + "', "
                                + PhysiciansID + ", "
                                + EntityID + ", '"
                                + t.Rows[0][8].ToString() + "', '"
                                + t.Rows[0][9].ToString() + "', '"
                                + t.Rows[0][10].ToString() + "', "
                                + EmployeeHRCodeFromAdmin + ", '"
                                + DateTime.Now.ToString("MM/dd/yyyy") + "', "
                                + 0 + ", "
                                + 0 + ", "
                                + 1 + ", "
                                + t.Rows[0][56].ToString() + ") "
                ;
            cmdMan = new SqlCommand(strInsert, conMan);
            int ii = cmdMan.ExecuteNonQuery();

            cmdMan = new SqlCommand("select max(ID) from AffiliationsTemp", conMan);
            int AffID = int.Parse(cmdMan.ExecuteScalar().ToString());

            decimal ReqNoOp = 0;
            if (t.Rows[0][71].ToString() == "") { ReqNoOp = 0; } else { ReqNoOp = decimal.Parse(t.Rows[0][71].ToString()); }
            for (int i = 1; i < 9; i++)
            {
                if (i == 8)
                {
                    if (ReqLine == 13)
                    {
                        PrHabbit = decimal.Parse(t.Rows[0][31].ToString());
                        NoOfPat = 0;

                    }
                    else
                    {
                        PrHabbit = 0;
                    }
                    string strInsertPhysValTemp = @"INSERT INTO [PhysicianValueByLineTemp] ([AffiliationID],[LineID],[NoOfPatients],[WaitingTime]
                                                ,[Deleted],[PrescriptionHappit],[LastModificationDate],[LastModifierID],
                                                [Status],[New],[NoOfOperations])
                                                VALUES("
                                                    + AffID + ", "
                                                    + 13 + ", "
                                                    + NoOfPat + ", "
                                                    + decimal.Parse(t.Rows[0][30].ToString()) + ", "
                                                    + 0 + ", "
                                                    + PrHabbit + ", '"
                                                    + DateTime.Now.ToString("MM/dd/yyyy") + "', "
                                                    + EmployeeHRCodeFromAdmin + ", "
                                                    + 0 + ", "
                                                    + 1 + ", "
                                                    + ReqNoOp + ") ";
                    cmdMan = new SqlCommand(strInsertPhysValTemp, conMan);
                    int exexute = cmdMan.ExecuteNonQuery();
                }
                else
                {
                    //DataTable AffT = GetPhyValByLine(int.Parse(t.Rows[0][0].ToString()), i);
                    if (ReqLine == i)
                    {
                        PrHabbit = decimal.Parse(t.Rows[0][31].ToString());
                        NoOfPat = decimal.Parse(t.Rows[0][29].ToString());

                    }
                    else
                    {
                        PrHabbit = 0;
                        if (t.Rows[0][29].ToString()!="")
                        {
                            NoOfPat = decimal.Parse(t.Rows[0][29].ToString());

                        }
                        else
                        {
                            NoOfPat = 0;
                        }

                        //NoOfPat = decimal.Parse(t.Rows[0][29].ToString());

                    }
                    string strInsertPhysValTemp = @"INSERT INTO [PhysicianValueByLineTemp] ([AffiliationID],[LineID],[NoOfPatients],[WaitingTime]
                                                ,[Deleted],[PrescriptionHappit],[LastModificationDate],[LastModifierID],
                                                [Status],[New],[NoOfOperations])
                                                VALUES("
                                                   + AffID + ", "
                                                   + i + ", "
                                                   + NoOfPat + ", "
                                                   + decimal.Parse(t.Rows[0][30].ToString()) + ", "
                                                   + 0 + ", "
                                                   + PrHabbit + ", '"
                                                   + DateTime.Now.ToString("MM/dd/yyyy") + "', "
                                                   + EmployeeHRCodeFromAdmin + ", "
                                                   + 0 + ", "
                                                   + 1 + ", "
                                                   + ReqNoOp + ") ";
                    cmdMan = new SqlCommand(strInsertPhysValTemp, conMan);
                    int exexute = cmdMan.ExecuteNonQuery();
                }
            }

            string cmdManStr = "update Affiliations_Proposed set [Status] = 'In Progress', COVP_Approved = 1, COSignature = 'Commercial Director', AdminSignature = 'Bassem Gerguis', ProceedBySignature = 'Fady Fawzy', ProceedBy = 1, AdminDate = '" + DateTime.Now.ToString("MM/dd/yyyy") + "',CODate='" + DateTime.Now.ToString("MM/dd/yyyy") + "', ProceedByDate='" + DateTime.Now.ToString("MM/dd/yyyy") + "' where RecID=" + recID;
            cmdMan = new SqlCommand(cmdManStr, conMan);
            int InProgressRecs = cmdMan.ExecuteNonQuery();
        }

        public static void UpdateOneLine(int recID, int EmployeeHRCodeFromAdmin)
        {
            DataTable t = GetAffProposed(recID);
            DataTable PE = GetPhyEnt(int.Parse(t.Rows[0][0].ToString()));
            //insert into AffiliationsTemp
            int RecPhyId = int.Parse(PE.Rows[0][0].ToString());
            int RecEntId = int.Parse(PE.Rows[0][1].ToString());


           

            string strInsert = @"INSERT INTO AffiliationsTemp (AffiliationID, AffiliationName, PhysicianID, EntityID, BestTimeFrom, BestTimeTo, Notes,EntryEmployeeID, EntryDate,Deleted , Status, New,RequestID) 
                                VALUES ("
                                + int.Parse(t.Rows[0][0].ToString()) + ", N'"
                                + t.Rows[0][1].ToString() + "', "
                                + RecPhyId + ", "
                                + RecEntId + ", '"
                                + t.Rows[0][8].ToString() + "', '"
                                + t.Rows[0][9].ToString() + "', '"
                                + t.Rows[0][10].ToString() + "', "
                                + EmployeeHRCodeFromAdmin + ", '"
                                + DateTime.Now.ToString("MM/dd/yyyy") + "', "
                                + 0 + ", "
                                + 0 + ", "
                                + 0 + ", "
                                + int.Parse(t.Rows[0][56].ToString()) + ") "
                ;
            cmdMan = new SqlCommand(strInsert, conMan);
            int ii = cmdMan.ExecuteNonQuery();

            //insert into PhysicianValueByLineTemp
            DataTable AffT = GetPhyValByLine(int.Parse(t.Rows[0][0].ToString()), int.Parse(t.Rows[0][6].ToString()));
            decimal ReqNoOp = 0;
            if (t.Rows[0][71].ToString() == "") { ReqNoOp = 0; } else { ReqNoOp = int.Parse(t.Rows[0][71].ToString()); }
            string strInsertPhysValTemp = @"INSERT INTO [PhysicianValueByLineTemp] ([AffiliationID],[LineID],[NoOfPatients],[WaitingTime]
                                                ,[Deleted],[PrescriptionHappit],[LastModificationDate],[LastModifierID],
                                                [Status],[New],[NoOfOperations])
                                                VALUES("
                                            + int.Parse(t.Rows[0][0].ToString()) + ", "
                                            + int.Parse(t.Rows[0][6].ToString()) + ", "
                                            + decimal.Parse(AffT.Rows[0][3].ToString()) + ", "
                                            + decimal.Parse(AffT.Rows[0][4].ToString()) + ", "
                                            + 0 + ", "
                                            + decimal.Parse(t.Rows[0][31].ToString()) + ", '"
                                            + DateTime.Now.ToString("MM/dd/yyyy") + "', "
                                            + EmployeeHRCodeFromAdmin + ", "
                                            + 0 + ", "
                                            + 0 + ", "
                                            + ReqNoOp + ") ";
            cmdMan = new SqlCommand(strInsertPhysValTemp, conMan);
            int exexute = cmdMan.ExecuteNonQuery();

            string cmdManStr = "update Affiliations_Proposed set [Status] = 'In Progress', COVP_Approved = 1, COSignature = 'Commercial Director', AdminSignature = 'Bassem Gerguis', ProceedBySignature = 'Fady Fawzy', ProceedBy = 1, AdminDate = '" + DateTime.Now.ToString("MM/dd/yyyy") + "',CODate='" + DateTime.Now.ToString("MM/dd/yyyy") + "', ProceedByDate='" + DateTime.Now.ToString("MM/dd/yyyy") + "' where RecID=" + recID;
            cmdMan = new SqlCommand(cmdManStr, conMan);
            int InProgressRecs = cmdMan.ExecuteNonQuery();
        }

        public static void UpdateAllLines(int recID, int EmployeeHRCodeFromAdmin)
        {
                        DataTable t = GetAffProposed(recID);
            int ReqLine = int.Parse(t.Rows[0][6].ToString());
            decimal PrHabbit = 0;
            decimal NoOfPat = 0;
            DataTable PE = GetPhyEnt(int.Parse(t.Rows[0][0].ToString()));
            int RecPhyId = int.Parse(PE.Rows[0][0].ToString());
            int RecEntId = int.Parse(PE.Rows[0][1].ToString());

            string strInsert = @"INSERT INTO AffiliationsTemp (AffiliationID, AffiliationName, PhysicianID, EntityID, BestTimeFrom, BestTimeTo, Notes,EntryEmployeeID, EntryDate,Deleted , Status, New,RequestID)
                                VALUES ("
                                + int.Parse(t.Rows[0][0].ToString()) + ", N'"
                                + t.Rows[0][1].ToString() + "', "
                                + RecPhyId + ", "
                                + RecEntId + ", '"
                                + t.Rows[0][8].ToString() + "', '"
                                + t.Rows[0][9].ToString() + "', '"
                                + t.Rows[0][10].ToString() + "', "
                                + EmployeeHRCodeFromAdmin + ", '"
                                + DateTime.Now.ToString("MM/dd/yyyy") + "', "
                                + 0 + ", "
                                + 0 + ", "
                                + 0 + ", "
                                + int.Parse(t.Rows[0][56].ToString()) + ") "
                ;
            cmdMan = new SqlCommand(strInsert, conMan);
            int ii = cmdMan.ExecuteNonQuery();
            decimal ReqNoOp = 0;
            if (t.Rows[0][71].ToString() == "") { ReqNoOp = 0; } else { ReqNoOp = decimal.Parse(t.Rows[0][71].ToString()); }
            for (int i = 1; i < 9; i++)
            {


                if (i == 8)
                {

                    DataTable AffT = GetPhyValByLine(int.Parse(t.Rows[0][0].ToString()), 13);

                    if (ReqLine == 13)
                    {
                        PrHabbit = decimal.Parse(t.Rows[0][31].ToString());
                        NoOfPat = decimal.Parse(AffT.Rows[0][3].ToString());
                    }
                    else
                    {
                        PrHabbit = decimal.Parse(AffT.Rows[0][9].ToString());
                        NoOfPat = decimal.Parse(AffT.Rows[0][3].ToString());
                    }
                    string strInsertPhysValTemp = @"INSERT INTO [PhysicianValueByLineTemp] ([AffiliationID],[LineID],[NoOfPatients],[WaitingTime]
                                                ,[Deleted],[PrescriptionHappit],[LastModificationDate],[LastModifierID],
                                                [Status],[New],[NoOfOperations])
                                                VALUES("
                                                    + int.Parse(t.Rows[0][0].ToString()) + ", "
                                                    + 13 + ", "
                                                    + NoOfPat + ", "
                                                    + decimal.Parse(t.Rows[0][30].ToString()) + ", "
                                                    + 0 + ", "
                                                    + PrHabbit + ", '"
                                                    + DateTime.Now.ToString("MM/dd/yyyy") + "', "
                                                    + EmployeeHRCodeFromAdmin + ", "
                                                    + 0 + ", "
                                                    + 0 + ", "
                                                    + ReqNoOp + ") ";
                    cmdMan = new SqlCommand(strInsertPhysValTemp, conMan);
                    int exexute = cmdMan.ExecuteNonQuery();
                }
                else
                {
                    DataTable AffT = GetPhyValByLine(int.Parse(t.Rows[0][0].ToString()), i);
                    if (ReqLine == i)
                    {
                        PrHabbit = decimal.Parse(t.Rows[0][31].ToString());
                        NoOfPat = decimal.Parse(t.Rows[0][29].ToString());
                    }
                    else
                    {
                        PrHabbit = decimal.Parse(AffT.Rows[0][9].ToString());
                        NoOfPat= decimal.Parse(AffT.Rows[0][3].ToString());
                    }
                    string strInsertPhysValTemp = @"INSERT INTO [PhysicianValueByLineTemp] ([AffiliationID],[LineID],[NoOfPatients],[WaitingTime]
                                                ,[Deleted],[PrescriptionHappit],[LastModificationDate],[LastModifierID],
                                                [Status],[New],[NoOfOperations])
                                                VALUES("
                                                   + int.Parse(t.Rows[0][0].ToString()) + ", "
                                                   + i + ", "
                                                   + NoOfPat + ", "
                                                   + decimal.Parse(t.Rows[0][30].ToString()) + ", "
                                                   + 0 + ", "
                                                   + PrHabbit + ", '"
                                                   + DateTime.Now.ToString("MM/dd/yyyy") + "', "
                                                   + EmployeeHRCodeFromAdmin + ", "
                                                   + 0 + ", "
                                                   + 0 + ", "
                                                   + ReqNoOp + ") ";
                    cmdMan = new SqlCommand(strInsertPhysValTemp, conMan);
                    int exexute = cmdMan.ExecuteNonQuery();
                }
            }
            //insert into EntityTemp
            DataTable tt = GetAffProposed(recID);
            string insertEntity = @"INSERT INTO EntityTemp (EntityID,EntityName,EntityCode,EntityAddress,EntityTypeID,
                                                          BrickID,Tel1,Tel2,Tel3,Fax,EntityEmailAddress,EntityWebSite,
                                                          EntryEmployeeID,EntryDate,Deleted,Status,RequestID)
                                                          VALUES("
                                              + RecEntId + ", N'"
                                              + tt.Rows[0][24].ToString() + "', "
                                              + RecEntId + ", N'"
                                              + tt.Rows[0][15].ToString() + "', "
                                              + 2 + ", "
                                              + int.Parse(tt.Rows[0][28].ToString()) + ", '"
                                              + tt.Rows[0][17].ToString() + "', '"
                                              + tt.Rows[0][18].ToString() + "', '"
                                              + tt.Rows[0][19].ToString() + "', '"
                                              + tt.Rows[0][20].ToString() + "', '"
                                              + tt.Rows[0][21].ToString() + "', '"
                                              + tt.Rows[0][22].ToString() + "', "
                                              + EmployeeHRCodeFromAdmin + ", '"
                                              + DateTime.Now.ToString("MM/dd/yyyy") + "', "
                                              + 0 + ", "
                                              + 0 + ", "
                                              + int.Parse(tt.Rows[0][56].ToString()) + ") ";
            cmdMan = new SqlCommand(insertEntity, conMan);
            int exexuteEntity = cmdMan.ExecuteNonQuery();


            string cmdManStr = "update Affiliations_Proposed set [Status] = 'In Progress', COVP_Approved = 1, COSignature = 'Commercial Director', AdminSignature = 'Bassem Gerguis', ProceedBySignature = 'Fady Fawzy', ProceedBy = 1, AdminDate = '" + DateTime.Now.ToString("MM/dd/yyyy") + "',CODate='" + DateTime.Now.ToString("MM/dd/yyyy") + "', ProceedByDate='" + DateTime.Now.ToString("MM/dd/yyyy") +"' where RecID=" + recID;
            cmdMan = new SqlCommand(cmdManStr, conMan);
            int InProgressRecs = cmdMan.ExecuteNonQuery();
        }

        public static void DeleteOneLine(int recID, int EmployeeHRCodeFromAdmin)
        {
            DataTable t = GetAffProposed(recID);
            DataTable PE = GetPhyEnt(int.Parse(t.Rows[0][0].ToString()));
            int RecPhyId = int.Parse(PE.Rows[0][0].ToString());
            int RecEntId = int.Parse(PE.Rows[0][1].ToString());

            string strInsert = @"INSERT INTO AffiliationsTemp (AffiliationID, AffiliationName, PhysicianID, EntityID, BestTimeFrom, BestTimeTo, Notes,EntryEmployeeID, EntryDate,Deleted , Status, New,RequestID)
                                VALUES ("
                                + int.Parse(t.Rows[0][0].ToString()) + ", N'"
                                + t.Rows[0][1].ToString() + "', "
                                + RecPhyId + ", "
                                + RecEntId + ", '"
                                + t.Rows[0][8].ToString() + "', '"
                                + t.Rows[0][9].ToString() + "', '"
                                + t.Rows[0][10].ToString() + "', "
                                + EmployeeHRCodeFromAdmin + ", '"
                                + DateTime.Now.ToString("MM/dd/yyyy") + "', "
                                + 0 + ", "
                                + 0 + ", "
                                + 0 + ", "
                                + int.Parse(t.Rows[0][56].ToString()) + ")";
            cmdMan = new SqlCommand(strInsert, conMan);
            int ii = cmdMan.ExecuteNonQuery();

            DataTable AffT = GetPhyValByLine(int.Parse(t.Rows[0][0].ToString()), int.Parse(t.Rows[0][6].ToString()));
            decimal ReqNoOp = 0;
            if (t.Rows[0][71].ToString() == "") { ReqNoOp = 0; } else { ReqNoOp = decimal.Parse(t.Rows[0][71].ToString()); }
            string strInsertPhysValTemp = @"INSERT INTO [PhysicianValueByLineTemp] ([AffiliationID],[LineID],[NoOfPatients],[WaitingTime]
                                                ,[Deleted],[PrescriptionHappit],[LastModificationDate],[LastModifierID],
                                                [Status],[New],[NoOfOperations])
                                                VALUES("
                                            + int.Parse(t.Rows[0][0].ToString()) + ", "
                                            + int.Parse(t.Rows[0][6].ToString()) + ", "
                                            + decimal.Parse(AffT.Rows[0][3].ToString()) + ", "
                                            + decimal.Parse(AffT.Rows[0][4].ToString()) + ", "
                                            + 0 + ", "
                                            + 0 + ", '"
                                            + DateTime.Now.ToString("MM/dd/yyyy") + "', "
                                            + EmployeeHRCodeFromAdmin + ", "
                                            + 0 + ", "
                                            + 0 + ", "
                                            + ReqNoOp + ")";
            cmdMan = new SqlCommand(strInsertPhysValTemp, conMan);
            int exexute = cmdMan.ExecuteNonQuery();

            string cmdManStr = "update Affiliations_Proposed set [Status] = 'In Progress', COVP_Approved = 1, COSignature = 'Commercial Director', AdminSignature = 'Bassem Gerguis', ProceedBySignature = 'Fady Fawzy', ProceedBy = 1, AdminDate = '" + DateTime.Now.ToString("MM/dd/yyyy") + "',CODate='" + DateTime.Now.ToString("MM/dd/yyyy") + "', ProceedByDate='" + DateTime.Now.ToString("MM/dd/yyyy") + "' where RecID=" + recID;
            cmdMan = new SqlCommand(cmdManStr, conMan);
            int InProgressRecs = cmdMan.ExecuteNonQuery();
        }

        public static void DeleteAllLines(int recID, int EmployeeHRCodeFromAdmin)
        {
            DataTable t = GetAffProposed(recID);
            DataTable PE = GetPhyEnt(int.Parse(t.Rows[0][0].ToString()));
            int RecPhyId = int.Parse(PE.Rows[0][0].ToString());
            int RecEntId = int.Parse(PE.Rows[0][1].ToString());

            int ReqLine = int.Parse(t.Rows[0][6].ToString());
            decimal PrHabbit = 0;
            decimal NoOfPat = 0;

            string strInsert = @"INSERT INTO AffiliationsTemp (AffiliationID, AffiliationName, PhysicianID, EntityID, BestTimeFrom, BestTimeTo, Notes, EntryEmployeeID, 
                                EntryDate, Deleted, [Status], [New], RequestID) VALUES ("
                            + int.Parse(t.Rows[0][0].ToString()) + ", N'"
                            + t.Rows[0][1].ToString() + "', "
                            + RecPhyId + ", "
                            + RecEntId + ", '"
                            + t.Rows[0][8].ToString() + "', '"
                            + t.Rows[0][9].ToString() + "', '"
                            + t.Rows[0][10].ToString() + "', "
                            + EmployeeHRCodeFromAdmin + ", '"
                            +DateTime.Now.ToString("MM/dd/yyyy") + "', "
                            + 1 + ", "
                            + 0 + ", "
                            + 0 + ", "
                            + int.Parse(t.Rows[0][56].ToString()) + ")";
            cmdMan = new SqlCommand(strInsert, conMan);
            int ii = cmdMan.ExecuteNonQuery();

            decimal ReqPHabbit = 0;
            decimal ReqNoOp = 0;

            if (t.Rows[0][9].ToString() == "" || t.Rows[0][9].ToString() == "NULL") { ReqPHabbit = 0; } else { ReqPHabbit = decimal.Parse(t.Rows[0][9].ToString()); }
            if (t.Rows[0][71].ToString() == ""|| t.Rows[0][71].ToString() == "NULL") { ReqNoOp = 0; } else { ReqNoOp = decimal.Parse(t.Rows[0][71].ToString()); }

            for (int i = 1; i < 9; i++)
            {
                if (i == 8)
                {
                    DataTable AffT = GetPhyValByLine(int.Parse(t.Rows[0][0].ToString()), 13);
                    if (ReqLine == 13)
                    {
                        PrHabbit = decimal.Parse(t.Rows[0][31].ToString());
                        NoOfPat = decimal.Parse(AffT.Rows[0][3].ToString());
                    }
                    else
                    {
                        PrHabbit = decimal.Parse(AffT.Rows[0][9].ToString());
                        NoOfPat = decimal.Parse(AffT.Rows[0][3].ToString());
                    }
                    string strInsertPhysValTemp = @"INSERT INTO [PhysicianValueByLineTemp] ([AffiliationID],[LineID],[NoOfPatients],[WaitingTime]
                                                ,[Deleted],[PrescriptionHappit],[LastModificationDate],[LastModifierID],
                                                [Status],[New],[NoOfOperations])
                                                VALUES("
                                                    + int.Parse(t.Rows[0][0].ToString()) + ", "
                                                    + 13 + ", "
                                                    + NoOfPat + ", "
                                                    + decimal.Parse(t.Rows[0][30].ToString()) + ", "
                                                    + 1 + ", "
                                                    + ReqPHabbit + ", '"
                                                    + DateTime.Now.ToString("MM/dd/yyyy") + "', "
                                                    + EmployeeHRCodeFromAdmin + ", "
                                                    + 0 + ", "
                                                    + 0 + ", "
                                                    + ReqNoOp + ") ";
                    cmdMan = new SqlCommand(strInsertPhysValTemp, conMan);
                    int exexute = cmdMan.ExecuteNonQuery();
                }
                else
                {
                    DataTable AffT = GetPhyValByLine(int.Parse(t.Rows[0][0].ToString()), i);
                    if (ReqLine == i)
                    {
                        PrHabbit = decimal.Parse(t.Rows[0][31].ToString());
                        NoOfPat = decimal.Parse(t.Rows[0][29].ToString());
                    }
                    else
                    {
                        PrHabbit = decimal.Parse(AffT.Rows[0][9].ToString());
                        NoOfPat = decimal.Parse(AffT.Rows[0][3].ToString());
                    }
                    string strInsertPhysValTemp = @"INSERT INTO [PhysicianValueByLineTemp] ([AffiliationID],[LineID],[NoOfPatients],[WaitingTime]
                                                ,[Deleted],[PrescriptionHappit],[LastModificationDate],[LastModifierID],
                                                [Status],[New],[NoOfOperations])
                                                VALUES("
                                                   + int.Parse(t.Rows[0][0].ToString()) + ", "
                                                   + i + ", "
                                                   + NoOfPat + ", "
                                                    + decimal.Parse(t.Rows[0][30].ToString()) + ", "
                                                    + 1 + ", "
                                                    + PrHabbit + ", '"
                                                    + DateTime.Now.ToString("MM/dd/yyyy") + "', "
                                                    + EmployeeHRCodeFromAdmin + ", "
                                                    + 0 + ", "
                                                    + 0 + ", "
                                                    + ReqNoOp + ") ";
                    cmdMan = new SqlCommand(strInsertPhysValTemp, conMan);
                    int exexute = cmdMan.ExecuteNonQuery();
                }
            }
            string cmdManStr = "update Affiliations_Proposed set [Status] = 'In Progress', COVP_Approved = 1, COSignature = 'Commercial Director', AdminSignature = 'Bassem Gerguis', ProceedBySignature = 'Fady Fawzy', ProceedBy = 1, AdminDate = '" + DateTime.Now.ToString("MM/dd/yyyy") + "',CODate='" + DateTime.Now.ToString("MM/dd/yyyy") + "', ProceedByDate='" + DateTime.Now.ToString("MM/dd/yyyy") + "' where RecID=" + recID;
            cmdMan = new SqlCommand(cmdManStr, conMan);
            int InProgressRecs = cmdMan.ExecuteNonQuery();
        }

        public static void RejectCommercial(int recID, int EmployeeHRCodeFromAdmin)
        {
            string cmdManStr = "update Affiliations_Proposed set [Status] = 'Rejected',SD_Approved=1,SDSignature='Sales Dirctor', COSignature = 'Commercial Director', CODate = '" + DateTime.Now.ToString("MM/dd/yyyy") + "',CO_Comment='' where RecID =" + recID;
            cmdMan = new SqlCommand(cmdManStr, conMan);
            int rejRecs = cmdMan.ExecuteNonQuery();
        }
        public static void RejectCairo(int recID, int EmployeeHRCodeFromAdmin)
        {
            string cmdManStr = "update Affiliations_Proposed set [Status]='Rejected',SDSignature='Hossam Gouda',SDDate='" + DateTime.Now.ToString("MM/dd/yyyy") + "',SD_Comment='' where RecID =" + recID;
            cmdMan = new SqlCommand(cmdManStr, conMan);
            int rejRecs = cmdMan.ExecuteNonQuery();
        }
        public static void RejectUpper(int recID, int EmployeeHRCodeFromAdmin)
        {
            string cmdManStr = "update Affiliations_Proposed set [Status]='Rejected',SDSignature='Sales Dirctor',SDDate='" + DateTime.Now.ToString("MM/dd/yyyy") + "',SD_Comment='' where RecID =" + recID;
            cmdMan = new SqlCommand(cmdManStr, conMan);
            int rejRecs = cmdMan.ExecuteNonQuery();
        }
        public static void RejectAdmin(int recID, int EmployeeHRCodeFromAdmin)
        {
            string cmdManStr = "update Affiliations_Proposed set [Status] = 'Rejected',SD_Approved=1,SDSignature='Sales Dirctor', COSignature = 'Commercial Director', CODate = '" + DateTime.Now.ToString("MM/dd/yyyy") + "',CO_Comment='' where RecID =" + recID;
            cmdMan = new SqlCommand(cmdManStr, conMan);
            int rejRecs = cmdMan.ExecuteNonQuery();


        }
        public static void Exist(int recID, int EmployeeHRCodeFromAdmin)
        {
            string cmdManStr = "update Affiliations_Proposed set [Status] = 'In Progress', COVP_Approved = 1, COSignature = 'Commercial Director', AdminSignature = 'Bassem Gerguis', ProceedBySignature = 'Fady Fawzy', ProceedBy = 1, AdminDate = '" + DateTime.Now.ToString("MM/dd/yyyy") + "',CODate= AdminDate,ProceedByDate=AdminDate where RecID=" + recID;
            cmdMan = new SqlCommand(cmdManStr, conMan);
            int InProgressRecs = cmdMan.ExecuteNonQuery();


        }
    }
}