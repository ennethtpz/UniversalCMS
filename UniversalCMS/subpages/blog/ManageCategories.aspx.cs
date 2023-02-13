using System;
using System.Web.UI.WebControls;
using UniversalCMS.Website.Functions;

namespace Admin.subpages.blog
{
    public partial class ManageCategories : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAddCategory_Click(object sender, EventArgs e)
        {
            string newCat = txtCategory.Text.Trim();
            ArticleManagement.InsertCategory(newCat);
            grdCategories.DataBind();
            lblAlert.Text = "New category '" + newCat + "' added.";
            txtCategory.Text = string.Empty;
        }

        protected void articlelDataSource_Deleted(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows == 0)
            {
                lblAlert.Text = "This category cannot be deleted because it has articles tagged to it.";
            } 
            else
            {
                lblAlert.Text = "Category deleted.";
            }
        }

        protected void sqldsCategories_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows == 0)
            {
                lblAlert.Text = "This category cannot be updated.";
            }
            else
            {
                lblAlert.Text = "Category updated.";
            }
        }
    }
}