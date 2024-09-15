using System;
using System.Web.UI.WebControls;

namespace UniversalCMS.subpages.blog
{
    public partial class ManageEntriesByCategory : System.Web.UI.Page
    {
        const string baseQuery = "SELECT a.[articleId], a.[title], a.[dateAdded], a.[isActive] FROM [Articles] a INNER JOIN [ArticleCategories] b ON a.[articleId] = b.[articleId] INNER JOIN [Categories] c ON b.[categoryId]=c.[categoryId]";
        const string orderBy = "ORDER BY a.[articleId] DESC";
        const string key = "query";

        string categoryId;
        string defaultWhere;

        protected void Page_Load(object sender, EventArgs e)
        {
            categoryId = Request.QueryString["id"];

            if (string.IsNullOrEmpty(categoryId))
                Response.Redirect("~/managecategories");

            defaultWhere = "WHERE c.[categoryId]=@catId";

            string strQuery = string.Empty;

            if (!IsPostBack)
            {
                strQuery = baseQuery + " " + defaultWhere + " " + orderBy;
                ViewState.Add(key, strQuery);

                sqldsEntries.SelectParameters.Clear();
                sqldsEntries.SelectParameters.Add(new Parameter("catId", System.Data.DbType.Int32, categoryId));
            }
            else
            {
                if (ViewState[key] != null && ViewState[key] is string val)
                    strQuery = val;
            }

            if (!string.IsNullOrEmpty(strQuery))
                sqldsEntries.SelectCommand = strQuery;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string queryText = txtSearch.Text;
            string searchCategory = ddlSearchCategory.Text;

            string newQuery = string.Empty;
            sqldsEntries.SelectParameters.Clear();
            sqldsEntries.SelectParameters.Add(new Parameter("catId", System.Data.DbType.Int32, categoryId));

            if (!string.IsNullOrEmpty(searchCategory) && !string.IsNullOrWhiteSpace(queryText))
            {
                newQuery = baseQuery + " " + defaultWhere + " AND a.[" + searchCategory + "] LIKE @queryText";
                newQuery += " " + orderBy;
                sqldsEntries.SelectParameters.Add(new Parameter("queryText", System.Data.DbType.String, "%" + queryText + "%"));
            }
            else
                newQuery = baseQuery + " " + defaultWhere + " " + orderBy;

            ViewState.Add(key, newQuery);
            sqldsEntries.SelectCommand = newQuery;
            grdEntries.DataBind();
        }
    }
}