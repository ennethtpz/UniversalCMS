using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class subpages_blog_ManageEntries : System.Web.UI.Page
{
    const string baseQuery = "SELECT a.[articleId], a.[title], a.[dateAdded], a.[isActive] FROM [Articles] a";
    const string orderBy = "ORDER BY a.[articleId] DESC";
    const string key = "query";

    protected void Page_Load(object sender, EventArgs e)
    {
        string strQuery = string.Empty;

        if (!IsPostBack)
        {
            strQuery = baseQuery + " " + orderBy;
            ViewState.Add(key, strQuery);
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

        if (!string.IsNullOrEmpty(searchCategory) && !string.IsNullOrWhiteSpace(queryText))
        {
            if (searchCategory.Equals("category", StringComparison.OrdinalIgnoreCase))
            {
                string appendToQuery = " INNER JOIN [ArticleCategories] b ON a.[articleId] = b.[articleId] INNER JOIN [Categories] c ON b.[categoryId]=c.[categoryId]";
                newQuery = baseQuery + appendToQuery;

                newQuery += " WHERE c.[category] LIKE @queryText";
            }
            else
            {
                string appendWhere = " WHERE a.[" + searchCategory + "] LIKE @queryText";
                newQuery = baseQuery + appendWhere;
            }

            newQuery += " " + orderBy;
            sqldsEntries.SelectParameters.Add(new Parameter("queryText", System.Data.DbType.String, "%" + queryText + "%"));
        }
        else
        {
            newQuery = baseQuery + " " + orderBy;
        }

        ViewState.Add(key, newQuery);
        sqldsEntries.SelectCommand = newQuery;
        grdEntries.DataBind();
    }
}