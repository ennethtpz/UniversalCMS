using System;
using System.Web.UI.WebControls;
using UniversalCMS.Website.Functions;

public partial class subpages_blog_AddEntry : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void btnAddEntry_Click(object sender, EventArgs e)
    {
        try
        {

            if (txtDate.Text != null && 
                DateTime.TryParseExact(txtDate.Text.Trim(), "MM/dd/yyyy", null, System.Globalization.DateTimeStyles.None, out DateTime dtArticleDate))
            {
                ArticleManager articleManager = new ArticleManager();
                int newArticleID = articleManager.InsertArticle(txtTitle.Text, dtArticleDate, txtContent.Text);
                foreach (ListItem li in cbxCategories.Items)
                {
                    if (li.Selected)
                        articleManager.InsertCategoryForArticle(newArticleID, int.Parse(li.Value));
                }
                Response.Redirect("~/manageblogs");
            }
            else
                Response.Write("<script>alert('Please enter valid article date in MM/dd/yyyy format!');</script>");


        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('Sorry. Something went wrong. Please try again later');</script>");
        }
    }
}