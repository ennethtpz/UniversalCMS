using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for User
/// </summary>
/// 
namespace Objects
{
    public class User
    {
        public int userID { get; set; }
        public string username { get; set; }
        public string ecryPass { get; set; }
        public DateTime dateAdded { get; set; }
        public int userType { get; set; }
        public string name { get; set; }
        public DateTime dateModified { get; set; }
        public bool isActive { get; set; }
    }
}