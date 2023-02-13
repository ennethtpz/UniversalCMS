using System;
using Objects;
using System.Data.SqlClient;
using ReinST.Central.DataManagement;
using ReinST.Central.Helpers;
using System.Data;

/// <summary>
/// Summary description for UserManagement
/// </summary>
namespace Functions
{
    public static class UserManagement
    {
        private static string keyFromConfig = "conn";

        public static User GetUser(string username)
        {
            try
            {
                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    SqlParameter[] inputParam = {
                                                new SqlParameter("@un", username.Trim())
                                            };

                    using (DataSet ds = da.ReturnDataSet("SELECT TOP 1 * FROM Users WHERE username=@un", inputParam))
                    {
                        if (ds.Tables[0].Rows.Count != 0)
                        {
                            User user = new User();
                            user.userID = Convert.ToInt32(ds.Tables[0].Rows[0]["userID"]);
                            user.username = ds.Tables[0].Rows[0]["username"].ToString();
                            user.ecryPass = ds.Tables[0].Rows[0]["ecryPass"].ToString();
                            user.dateAdded = Convert.ToDateTime(ds.Tables[0].Rows[0]["dateAdded"]);
                            user.userType = Convert.ToInt32(ds.Tables[0].Rows[0]["userType"]);
                            user.name = ds.Tables[0].Rows[0]["name"].ToString();
                            user.dateModified = Convert.ToDateTime(ds.Tables[0].Rows[0]["dateModified"]);
                            user.isActive = Convert.ToBoolean(ds.Tables[0].Rows[0]["isActive"]);
                            return user;
                        }
                        else
                            return null;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static User GetUser(int userID)
        {
            try
            {
                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    SqlParameter[] inputParam = {
                                                new SqlParameter("@uid", userID)
                                            };
                    using (DataSet ds = da.ReturnDataSet("SELECT TOP 1 * FROM Users WHERE userID=@uid", inputParam))
                    {
                        if (ds.Tables[0].Rows.Count != 0)
                        {
                            User user = new User();
                            user.userID = Convert.ToInt32(ds.Tables[0].Rows[0]["userID"]);
                            user.username = ds.Tables[0].Rows[0]["username"].ToString();
                            user.ecryPass = ds.Tables[0].Rows[0]["ecryPass"].ToString();
                            user.dateAdded = Convert.ToDateTime(ds.Tables[0].Rows[0]["dateAdded"]);
                            user.userType = Convert.ToInt32(ds.Tables[0].Rows[0]["userType"]);
                            user.name = ds.Tables[0].Rows[0]["name"].ToString();
                            user.dateModified = Convert.ToDateTime(ds.Tables[0].Rows[0]["dateModified"]);
                            user.isActive = Convert.ToBoolean(ds.Tables[0].Rows[0]["isActive"]);
                            return user;
                        }
                        else
                            return null;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void AddUser(string username, string password, int userType, string name)
        {
            try
            {
                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    string ecryptedPass = StringHelper.GenerateBCryptHash(password.Trim());
                    string command = "INSERT INTO Users (username, ecryPass, userType, name) VALUES (@un, @pwd, @userType, @name)";

                    SqlParameter[] param =
                    {
                        new SqlParameter("@un", username.Trim()),
                        new SqlParameter("@pwd", ecryptedPass),
                        new SqlParameter("@userType", userType),
                        new SqlParameter("@name", name.Trim()),
                    };

                    da.ExecuteNonQuery(command, param);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void ChangePassword(int userID, string newPassword)
        {
            try
            {
                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    string encryptedPass = StringHelper.GenerateBCryptHash(newPassword.Trim());
                    string command = "UPDATE Users SET ecryPass=@pwd, dateModified=getDate() WHERE userID=@uid";

                    SqlParameter[] param = {
                                         new SqlParameter("@uid", userID),
                                         new SqlParameter("@pwd", encryptedPass)
                                       };

                    da.ExecuteNonQuery(command, param);
                } 
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void SetUserActiveStatus(int userID, bool isActive)
        {
            try
            {
                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    string command = "UPDATE Users SET isActive=@isActive, dateModified=getDate() WHERE userID=@uid";

                    SqlParameter[] param = {
                                         new SqlParameter("@uid", userID),
                                         new SqlParameter("@isActive", isActive)
                                       };

                    da.ExecuteNonQuery(command, param);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void SetUserType(int userID, int userType)
        {
            try
            {
                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    string command = "UPDATE Users SET userType=@userType, dateModified=getDate() WHERE userID=@uid";

                    SqlParameter[] param = {
                                         new SqlParameter("@uid", userID),
                                         new SqlParameter("@userType", userType)
                                       };

                    da.ExecuteNonQuery(command, param);
                } 
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void AddUserType(string userType)
        {
            try
            {
                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    string command = "INSERT INTO UserTypes ([Type]) VALUES (@type)";

                    SqlParameter[] param =
                    {
                        new SqlParameter("@type", userType.Trim()),
                    };

                    da.ExecuteNonQuery(command, param);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void DeleteUserType(int userType)
        {
            try
            {
                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    string command = "DELETE FROM UserTypes WHERE userType=@type";

                    SqlParameter[] param =
                    {
                        new SqlParameter("@type", userType),
                    };

                    da.ExecuteNonQuery(command, param);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static bool AuthenticateUser(User user, string rawPass)
        {
            if (user != null)
                return StringHelper.VerifyBCryptHash(rawPass, user.ecryPass);
            else
                return false;
        }
    }
}