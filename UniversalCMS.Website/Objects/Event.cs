using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UniversalCMS.Website.Objects
{
    public class Event
    {
        public int EventId { get; set; }
        public string Title { get; set; }
        public string ImgBanner { get; set; }
        public DateTime RegistrationStartDate { get; set; }
        public DateTime RegistrationEndDate { get; set; }
        public DateTime EventStartDate { get; set; }
        public DateTime EventEndDate { get; set; }
        public string DownloadLink { get; set; }
        public string RegistrationLink { get; set; }
        public string Venue { get; set; }
        public string Location { get; set; }
        public string Week { get; set; }
        public DateTime DateAdded { get; set; }
    }
}
