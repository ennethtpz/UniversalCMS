using ReinST.Central.Helpers;
using UniversalCMS.Website.Functions;
using UniversalCMS.Website.Objects;
using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;

namespace Admin.mobile_gallery
{
    public partial class Gallery : System.Web.UI.Page
    {
        List<string> galleryImages;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                int articleCode = int.Parse(Request.QueryString["id"]);

                ArticleManager articleManager = new ArticleManager();
                Article article = articleManager.GetArticle(articleCode);

                if (article != null) 
                {
                    lblTitle.Text = article.title;

                    galleryImages = StringHelper.GetAllImagesWithFullURL(article.articleContent);
                    if (galleryImages != null)
                    {
                        if (galleryImages.Count != 0)
                        {
                            rptGallery.DataSource = galleryImages;
                            rptGallery.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }

        protected void rptrGallery_ItemDatabound(object s, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                //Reference the Repeater Item.
                RepeaterItem item = e.Item;

                //get ze index
                int index = item.ItemIndex;

                //Reference the Controls.
                HyperLink hprlnkLightBox = (HyperLink)item.FindControl("hprlnkLightBox");
                Image imgPhoto = (Image)item.FindControl("imgPhoto");

                //Set the items, according to index
                hprlnkLightBox.NavigateUrl = "../" + galleryImages[index];
                imgPhoto.ImageUrl = "../" + galleryImages[index] + "?width=100";
            }
        }





    }
}