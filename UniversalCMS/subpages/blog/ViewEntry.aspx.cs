using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using UniversalCMS.Website.Functions;
using UniversalCMS.Website.Objects;

public partial class subpages_blog_ViewEntry : System.Web.UI.Page
{
    int id;

    ArticleManager articleManager = new ArticleManager();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            var idFromRoute = Page.RouteData.Values["id"];

            if (idFromRoute != null)
            {
                id = Convert.ToInt32(idFromRoute);

                if (!IsPostBack)
                    loaddata(id);
            }
            else
                Response.Redirect("~/manageblogs");
        }
        catch (Exception ex)
        {
            //Response.Write(ex.Message);
            Response.Redirect("~/manageblogs");
        }
    }

    private void loaddata(int articleId)
    {
        try
        {
            Article article = articleManager.GetArticle(articleId);
            txtArticleCode.Text = article.articleCode;
            txtTitle.Text = article.title;
            txtDate.Text = article.articleDate.ToString("MM/dd/yyyy");
            txtContent.Text = article.articleContent;
            cbxIsActive.Checked = article.isActive;

            List<Category> allCategories = articleManager.GetAllCategories();

            List<ListItem> cats = new List<ListItem>();
            foreach (Category cat in allCategories)
            {
                ListItem item = new ListItem();
                item.Value = cat.categoryId.ToString();
                item.Text = cat.category;
                cbxCategories.Items.Add(item);
            }
            cbxCategories.DataBind();

            List<Category> categories = articleManager.GetCategoriesForArticle(id);
            if(categories != null)
            {
                foreach (Category cat in categories)
                {
                    ListItem currentCheckBox = cbxCategories.Items.FindByValue(cat.categoryId.ToString());
                    if (currentCheckBox != null)
                        currentCheckBox.Selected = true;
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            articleManager.DeleteCategoriesForArticle(id);
            articleManager.DeleteArticle(id);
            Response.Redirect("~/manageblogs");
        }
        catch (Exception ex)
        {
            lblAlert.Text = "Sorry. Something went wrong. Please try again later";
            //Response.Write(ex.Message);
        }
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtDate.Text != null &&
                DateTime.TryParseExact(txtDate.Text.Trim(), "MM/dd/yyyy", null, System.Globalization.DateTimeStyles.None, out DateTime dtArticleDate))
            {
                articleManager.UpdateArticle(id, dtArticleDate, txtTitle.Text, txtContent.Text, cbxIsActive.Checked);
                List<Category> existingCategories = articleManager.GetCategoriesForArticle(id);

                foreach (ListItem li in cbxCategories.Items)
                {
                    if (li.Selected)
                    {
                        bool categoryExists = false;
                        if (existingCategories != null)
                        {
                            foreach (Category cat in existingCategories)
                            {
                                if (li.Value == cat.categoryId.ToString())
                                    categoryExists = true;
                            }
                        }

                        if (!categoryExists)
                            articleManager.InsertCategoryForArticle(id, int.Parse(li.Value));
                    }
                    else
                        articleManager.DeleteCategoryForArticle(id, int.Parse(li.Value));
                }

                lblAlert.Text = "Article updated!";
            }
            else
                lblAlert.Text = "Please enter valid article date in MM/dd/yyyy format!";
        }
        catch (Exception ex)
        {
            //Response.Write(ex.Message);
            lblAlert.Text = "Sorry. Something went wrong. Please try again later";
        }
    }
}