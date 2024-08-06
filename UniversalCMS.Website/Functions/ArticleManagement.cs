using ReinST.Central.DataManagement;
using ReinST.Central.Helpers;
using UniversalCMS.Website.Objects;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Documents;

namespace UniversalCMS.Website.Functions
{
    public class ArticleManager
    {
        #region Properties

        private string _connStringKey, _baseURL, _adminURL;

        #endregion

        #region Constructor

        /// <summary>
        /// Instantiates a new ArticleManager instance. Uses default connection string.
        /// </summary>
        public ArticleManager()
        {
            _connStringKey = "conn";
        }

        /// <summary>
        /// Instantiates a new ArticleManager instance.
        /// </summary>
        /// <param name="connStringKey">
        /// Connection string key from web.config that contains the database for UniversalCMS.
        /// </param>
        public ArticleManager(string connStringKey)
        {
            _connStringKey = connStringKey;
        }

        /// <summary>
        /// Instantiates a new ArticleManager instance.
        /// </summary>
        /// <param name="connStringKey">
        /// Connection string key from web.config that contains the database for UniversalCMS.
        /// </param>
        /// <param name="baseURL">
        /// Base URL for the client website that this will be used on. (e.g. https://www.reinertupaz.com). 
        /// Take note that there should be no '/' on the end.
        /// </param>
        /// <param name="adminURL">
        /// Base URL of the UniversalCMS instance for this website. (e.g. https://admin.reinertupaz.com).
        /// Take note that there should be no '/' on the end.
        /// </param>
        public ArticleManager(string connStringKey, string baseURL, string adminURL) 
        {
            _connStringKey = connStringKey;
            _baseURL = baseURL;
            _adminURL = adminURL;
        }

        #endregion

        #region Public Methods

        #region Articles

        public Article GetArticleByPageId(string pageId)
        {
            try
            {
                SqlParameter[] param = {
                                           new SqlParameter("@pageId", pageId.Trim())
                                       };

                using (DataAccess da = new DataAccess(_connStringKey))
                {
                    using (DataSet ds = da.ReturnDataSet("SELECT TOP 1 * FROM Articles WHERE pageId=@pageId", param))
                    {
                        if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                            return GetArticleFromDataRow(ds.Tables[0].Rows[0]);
                    }
                }

                return null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public Article GetArticle(string articleCode)
        {
            try
            {
                SqlParameter[] param = {
                                           new SqlParameter("@articleCode", articleCode.Trim())
                                       };

                using (DataAccess da = new DataAccess(_connStringKey))
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

        public Article GetArticle(int articleId)
        {
            try
            {
                SqlParameter[] param = {
                                           new SqlParameter("@articleId", articleId)
                                       };

                using (DataAccess da = new DataAccess(_connStringKey))
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

        public List<Article> GetArticles()
        {
            try
            {
                List<Article> articles = new List<Article>();

                using (DataAccess da = new DataAccess(_connStringKey))
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

        public List<ArticleV2> GetArticlesForAPI(string defaultImageURL, string defaultIconURL)
        {
            try
            {
                List<ArticleV2> articles = new List<ArticleV2>();

                using (DataAccess da = new DataAccess(_connStringKey))
                {
                    DataSet ds = da.ReturnDataSet("SELECT * FROM Articles ORDER BY dateAdded DESC");

                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        ArticleV2 article = new ArticleV2();
                        article.articleId = Convert.ToInt32(row["articleId"]);
                        article.articleDate = Convert.ToDateTime(row["articleDate"]);
                        article.title = row["title"].ToString();
                        article.articleContent = row["articleContent"].ToString().Replace("../../fileman/", _adminURL + "/fileman/");
                        article.dateAdded = Convert.ToDateTime(row["dateAdded"]);
                        article.articleCode = row["articleCode"].ToString();
                        article.isActive = Convert.ToBoolean(row["isActive"]);
                        article.pubURL = _baseURL + "/article/" + row["articleCode"].ToString();
                        article.imgURL = AppendBaseURLToImage(StringHelper.GetFirstImageForShare(row["articleContent"].ToString(), defaultImageURL), _baseURL);
                        article.imgIcon = AppendBaseURLToImage(StringHelper.GetFirstImageIcon(row["articleContent"].ToString(), defaultIconURL), _baseURL);
                        
                        if (row["pageId"] != null)
                            article.pageId = row["pageId"].ToString();
                        
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

        public int InsertArticle(string title, DateTime articleDate, string articleContent, string pageId = null)
        {
            try
            {
                using (DataAccess da = new DataAccess(_connStringKey))
                {
                    var sqlParams = new List<SqlParameter>();
                    sqlParams.Add(new SqlParameter("@title", title.Trim()));
                    sqlParams.Add(new SqlParameter("@articleDate", articleDate));
                    sqlParams.Add(new SqlParameter("@articleContent", articleContent.Trim()));

                    string strQuery = "INSERT INTO Articles (title, articleDate, articleContent) VALUES (@title, @articleDate, @articleContent)";

                    if (!string.IsNullOrWhiteSpace(pageId))
                    {
                        strQuery = "INSERT INTO Articles (title, articleDate, articleContent, pageId) VALUES (@title, @articleDate, @articleContent, @pageId)";
                        sqlParams.Add(new SqlParameter("@pageId", pageId));
                    }
                        
                    int newID = da.ReturnIndex(strQuery, sqlParams.ToArray());
                    return newID;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void UpdateArticle(int articleId, DateTime articleDate, string title, string articleContent, bool isActive, string pageId = null)
        {
            try
            {
                using (DataAccess da = new DataAccess(_connStringKey))
                {
                    var sqlParams = new List<SqlParameter>();
                    sqlParams.Add(new SqlParameter("@articleId", articleId));
                    sqlParams.Add(new SqlParameter("@articleDate", articleDate));
                    sqlParams.Add(new SqlParameter("@title", title.Trim()));
                    sqlParams.Add(new SqlParameter("@articleContent", articleContent.Trim()));
                    sqlParams.Add(new SqlParameter("@isActive", isActive));

                    string strQuery = "UPDATE Articles SET title=@title, articleDate=@articleDate, articleContent=@articleContent, isActive=@isActive";

                    if (!string.IsNullOrWhiteSpace(pageId))
                    {
                        strQuery += ", pageId=@pageId"; 
                        sqlParams.Add(new SqlParameter("@pageId", pageId));
                    }

                    strQuery += " WHERE articleId=@articleId";

                    da.ExecuteNonQuery(strQuery, sqlParams.ToArray());
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void DeleteArticle(int articleId)
        {
            try
            {
                using (DataAccess da = new DataAccess(_connStringKey))
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

        public void InsertCategory(string category)
        {
            try
            {
                using (DataAccess da = new DataAccess(_connStringKey))
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

        public void UpdateCategory(int categoryId, string category)
        {
            try
            {
                using (DataAccess da = new DataAccess(_connStringKey))
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

        public void DeleteCategory(int categoryId)
        {
            try
            {
                using (DataAccess da = new DataAccess(_connStringKey))
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

        public List<Category> GetAllCategories()
        {
            try
            {
                List<Category> categories = new List<Category>();

                using (DataAccess da = new DataAccess(_connStringKey))
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

        public List<Category> GetCategoriesForArticle(int articleId)
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

                using (DataAccess da = new DataAccess(_connStringKey))
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

        public void InsertCategoryForArticle(int articleId, int categoryId)
        {
            try
            {
                using (DataAccess da = new DataAccess(_connStringKey))
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

        public void DeleteCategoryForArticle(int articleId, int categoryId)
        {
            try
            {
                using (DataAccess da = new DataAccess(_connStringKey))
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

        public void DeleteCategoriesForArticle(int articleId)
        {
            try
            {
                using (DataAccess da = new DataAccess(_connStringKey))
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

                if (row["pageId"] != null)
                    article.pageId = row["pageId"].ToString();

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