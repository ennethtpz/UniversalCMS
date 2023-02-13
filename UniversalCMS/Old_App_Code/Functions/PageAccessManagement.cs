using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Objects;
using ReinST.Central.DataManagement;

/// <summary>
/// Summary description for PageAccessManagement
/// </summary>
/// 
namespace Functions
{
    public static class PageAccessManagement
    {
        private static string keyFromConfig = "conn";

        public static int InsertPageAccessRule(int userType, int pageID)
        {
            try
            {
                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    SqlParameter[] param = {
                                           new SqlParameter ("@userType", userType),
                                           new SqlParameter ("@pageID", pageID),
                                       };
                    int paId;
                    bool hasEntry = CheckIfhasPageAccessRule(userType, pageID, out paId);

                    if (!hasEntry)
                    {
                        paId = da.ReturnIndex("INSERT INTO PageAccess (userType, pageID) VALUES (@userType, @pageID)", param);
                    }
                    return paId;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //private bool checkIfhasPageAccessRule(SqlParameter[] param, out int paId)
        //{
        //    try
        //    {
        //        string strQuery = "SELECT TOP 1 paId FROM PageAccess WHERE userType=@userType AND pageID=@pageID";
        //        SqlDataReader dr = da.ReturnReader(strQuery, param);

        //        bool hasEntry = dr.HasRows;

        //        if (hasEntry)
        //        {
        //            dr.Read();
        //            paId = Convert.ToInt32(dr["paId"]);
        //            dr.Close();
        //        }
        //        else
        //        {
        //            paId = 0;
                    
        //        }

        //        return hasEntry;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //    finally
        //    {
        //        da.CloseConnection();
        //    }
        //}

        private static bool CheckIfhasPageAccessRule(int userType, int pageID, out int paId)
        {
            try
            {
                bool hasEntry = false;
                paId = 0;

                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    string strQuery = "SELECT TOP 1 paId FROM PageAccess WHERE userType=@userType AND pageID=@pageID";

                    SqlParameter[] param = {
                                           new SqlParameter ("@userType", userType),
                                           new SqlParameter ("@pageID", pageID),
                                       };

                    using (DataSet ds = da.ReturnDataSet(strQuery, param))
                    {
                        if (ds != null)
                        {
                            if (ds.Tables[0].Rows.Count != 0)
                            {
                                hasEntry = true;
                                paId = Convert.ToInt32(ds.Tables[0].Rows[0]["paId"]);
                            }
                        }
                    }
   
                    return hasEntry;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public static bool CheckIfhasPageAccessRule(int userType, int pageID)
        {
            try
            {
                bool hasEntry = false;

                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    string strQuery = "SELECT TOP 1 paId FROM PageAccess WHERE userType=@userType AND pageID=@pageID";

                    SqlParameter[] param = {
                                           new SqlParameter ("@userType", userType),
                                           new SqlParameter ("@pageID", pageID),
                                       };


                    using (DataSet ds = da.ReturnDataSet(strQuery, param))
                    {
                        if (ds != null)
                            if (ds.Tables[0].Rows.Count != 0)
                                hasEntry = true;
                    }
                }

                return hasEntry;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static List<PageAccess> GetAllAllowedPages(int userType)
        {
            try
            {
                List<PageAccess> pages = new List<PageAccess>();

                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    string strQuery = "SELECT pageId FROM PageAccess WHERE userType=@userType";

                    SqlParameter[] param = {
                                           new SqlParameter ("@userType", userType),
                                       };

                    using (DataSet ds = da.ReturnDataSet(strQuery, param))
                    {
                        foreach (DataRow row in ds.Tables[0].Rows)
                        {
                            PageAccess pa = new PageAccess();
                            int id = Convert.ToInt32(row["pageId"]);
                            pa.pageId = id;
                            pages.Add(pa);
                        }
                    }
                }

                return pages;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public static void DeleteRule(int paId)
        {
            try
            {
                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    string strQuery = "DELETE FROM PageAccess WHERE paId=@paId";

                    SqlParameter[] param = {
                                           new SqlParameter ("@paId", paId),
                                       };

                    da.ExecuteNonQuery(strQuery, param);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        

    }
}