using ReinST.Central.DataManagement;
using ReinST.Central.Helpers;
using UniversalCMS.Website.Objects;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace UniversalCMS.Website.Functions
{
    public static class ArticleManagement
    {
        #region Properties
        private const string keyFromConfig = "conn";
        #endregion

        #region Public Methods

        #region Articles

        public static Article GetArticle(string articleCode)
        {
            try
            {
                SqlParameter[] param = {
                                           new SqlParameter("@articleCode", articleCode.Trim())
                                       };

                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    using (DataSet ds = da.ReturnDataSet("SELECT TOP 1 * FROM Articles WHERE articleCode=@articleCode", param))
                    {
                        return GetArticleFromDataRow(ds.Tables[0].Rows[0]);
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static Article GetArticle(int articleId)
        {
            try
            {
                SqlParameter[] param = {
                                           new SqlParameter("@articleId", articleId)
                                       };

                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    using (DataSet ds = da.ReturnDataSet("SELECT TOP 1 * FROM Articles WHERE articleId = @articleId", param))
                    {
                        return GetArticleFromDataRow(ds.Tables[0].Rows[0]);
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static List<Article> GetArticles()
        {
            try
            {
                List<Article> articles = new List<Article>();

                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    using (DataSet ds = da.ReturnDataSet("SELECT * FROM Articles ORDER BY dateAdded DESC"))
                    {
                        foreach (DataRow row in ds.Tables[0].Rows)
                        {
                            articles.Add(GetArticleFromDataRow(row));
                        }

                        if (articles.Count > 0)
                            return articles;
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

        public static List<ArticleV2> GetArticlesForAPI(string defaultImageURL, string defaultIconURL, string baseURL, string adminURL)
        {
            try
            {
                List<ArticleV2> articles = new List<ArticleV2>();

                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    DataSet ds = da.ReturnDataSet("SELECT * FROM Articles ORDER BY dateAdded DESC");

                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        ArticleV2 article = new ArticleV2();
                        article.articleId = Convert.ToInt32(row["articleId"]);
                        article.articleDate = Convert.ToDateTime(row["articleDate"]);
                        article.title = row["title"].ToString();
                        article.articleContent = row["articleContent"].ToString().Replace("../../fileman/", adminURL + "/fileman/");
                        article.dateAdded = Convert.ToDateTime(row["dateAdded"]);
                        article.articleCode = row["articleCode"].ToString();
                        article.isActive = Convert.ToBoolean(row["isActive"]);
                        article.pubURL = baseURL + "/article/" + row["articleCode"].ToString();
                        article.imgURL = AppendBaseURLToImage(StringHelper.GetFirstImageForShare(row["articleContent"].ToString(), defaultImageURL), baseURL);
                        article.imgIcon = AppendBaseURLToImage(StringHelper.GetFirstImageIcon(row["articleContent"].ToString(), defaultIconURL), baseURL);
                        articles.Add(article);
                    }

                    if (articles.Count > 0)
                        return articles;
                    else
                        return null;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static int InsertArticle(string title, DateTime articleDate, string articleContent)
        {
            try
            {
                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    SqlParameter[] param = {
                                           new SqlParameter("@title", title.Trim()),
                                           new SqlParameter("@articleDate", articleDate),
                                           new SqlParameter("@articleContent", articleContent.Trim())
                                       };
                    int newID = da.ReturnIndex("INSERT INTO Articles (title, articleDate, articleContent) VALUES (@title, @articleDate, @articleContent)", param);
                    return newID;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateArticle(int articleId, DateTime articleDate, string title, string articleContent, bool isActive)
        {
            try
            {
                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    SqlParameter[] param = {
                                        new SqlParameter("@articleId", articleId),
                                        new SqlParameter("@articleDate", articleDate),
                                        new SqlParameter("@title", title.Trim()),
                                        new SqlParameter("@articleContent", articleContent.Trim()),
                                        new SqlParameter("@isActive", isActive),
                                    };
                    da.ExecuteNonQuery("UPDATE Articles SET title=@title, articleDate=@articleDate, articleContent=@articleContent, isActive=@isActive WHERE articleId=@articleId", param);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void DeleteArticle(int articleId)
        {
            try
            {
                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    SqlParameter[] param = {
                                           new SqlParameter("@articleId", articleId)
                                       };
                    da.ExecuteNonQuery("DELETE FROM Articles WHERE articleId=@articleId", param);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion

        #region Categories

        public static void InsertCategory(string category)
        {
            try
            {
                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    SqlParameter[] param = {
                                           new SqlParameter("@category", category.Trim()),
                                       };
                    da.ExecuteNonQuery("INSERT INTO Categories (category) VALUES (@category)", param);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void UpdateCategory(int categoryId, string category)
        {
            try
            {
                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    SqlParameter[] param = {
                                            new SqlParameter("@categoryId", categoryId),
                                           new SqlParameter("@category", category.Trim()),
                                       };
                    da.ExecuteNonQuery("UPDATE Categories SET category=@category WHERE categoryId=@categoryId", param);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void DeleteCategory(int categoryId)
        {
            try
            {
                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    SqlParameter[] param = {
                                            new SqlParameter("@categoryId", categoryId),
                                       };
                    da.ExecuteNonQuery("DELETE FROM Categories WHERE categoryId=@categoryId", param);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static List<Category> GetAllCategories()
        {
            try
            {
                List<Category> categories = new List<Category>();

                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    using (DataSet ds = da.ReturnDataSet("SELECT * FROM Categories ORDER BY category"))
                    {
                        foreach (DataRow row in ds.Tables[0].Rows)
                        {
                            Category category = new Category();
                            category.categoryId = Convert.ToInt32(row["categoryId"]);
                            category.category = row["category"].ToString();
                            categories.Add(category);
                        }

                        if (categories.Count > 0)
                            return categories;
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

        public static List<Category> GetCategoriesForArticle(int articleId)
        {
            try
            {
                List<Category> categories = new List<Category>();
                SqlParameter[] param = {
                                            new SqlParameter("@articleId", articleId),
                                       };

                string strQuery = "SELECT a.categoryId, a.category FROM Categories a ";
                strQuery += "INNER JOIN ArticleCategories b ON a.categoryId=b.categoryId ";
                strQuery += "WHERE b.articleId=@articleId ORDER BY b.refId DESC";

                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    using (DataSet ds = da.ReturnDataSet(strQuery, param))
                    {
                        foreach (DataRow row in ds.Tables[0].Rows)
                        {
                            Category category = new Category();
                            category.categoryId = Convert.ToInt32(row["categoryId"]);
                            category.category = row["category"].ToString();
                            categories.Add(category);
                        }

                        if (categories.Count > 0)
                            return categories;
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

        public static void InsertCategoryForArticle(int articleId, int categoryId)
        {
            try
            {
                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    SqlParameter[] param = {
                                            new SqlParameter("@articleId", articleId),
                                            new SqlParameter("@categoryId", categoryId),
                                       };
                    da.ExecuteNonQuery("INSERT INTO ArticleCategories (articleId, categoryId) VALUES (@articleId, @categoryId)", param);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void DeleteCategoryForArticle(int articleId, int categoryId)
        {
            try
            {
                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    SqlParameter[] param = {
                        new SqlParameter("@articleId", articleId),
                        new SqlParameter("@categoryId", categoryId),
                    };
                    da.ExecuteNonQuery("DELETE FROM ArticleCategories WHERE articleId=@articleId AND categoryId=@categoryId", param);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void DeleteCategoriesForArticle(int articleId)
        {
            try
            {
                using (DataAccess da = new DataAccess(keyFromConfig))
                {
                    SqlParameter[] param = {
                                            new SqlParameter("@articleId", articleId),
                                       };
                    da.ExecuteNonQuery("DELETE FROM ArticleCategories WHERE articleId=@articleId", param);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion

        #endregion

        #region Private Methods

        private static Article GetArticleFromDataRow(DataRow row)
        {
            try
            {
                Article article = new Article
                {
                    articleId = Convert.ToInt32(row["articleId"]),
                    articleDate = Convert.ToDateTime(row["articleDate"]),
                    title = row["title"].ToString(),
                    articleContent = row["articleContent"].ToString(),
                    dateAdded = Convert.ToDateTime(row["dateAdded"]),
                    articleCode = row["articleCode"].ToString(),
                    isActive = Convert.ToBoolean(row["isActive"]),
                };
                return article;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private static string AppendBaseURLToImage(string input, string baseURL)
        {
            try
            {
                input = input.Replace("/Uploadsfileman/", "fileman/Uploads/");
                return input.Replace("fileman/", baseURL + "/fileman/");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        
        #endregion

    }
}