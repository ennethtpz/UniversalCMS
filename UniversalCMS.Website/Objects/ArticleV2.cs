using System;

namespace UniversalCMS.Website.Objects
{
    public class ArticleV2
    {
        public int articleId { get; set; }
        public DateTime articleDate { get; set; }
        public string title { get; set; }
        public string articleContent { get; set; }
        public DateTime dateAdded { get; set; }
        public string articleCode { get; set; }
        public bool isActive { get; set; }
        public string pubURL { get; set; }
        public string imgURL { get; set; }
        public string imgIcon { get; set; }
        public string pageId { get; set; }
    }
}
