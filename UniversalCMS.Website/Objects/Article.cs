using System;

namespace UniversalCMS.Website.Objects
{
    public class Article
    {
        public int articleId { get; set; }
        public DateTime articleDate { get; set; }
        public string title { get; set; }
        public string articleContent { get; set; }
        public DateTime dateAdded { get; set; }
        public string articleCode { get; set; }
        public bool isActive { get; set; }
    }
}
