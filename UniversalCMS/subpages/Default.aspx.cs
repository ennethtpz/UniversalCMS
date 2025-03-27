using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class subpages_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        var appVer = ConfigurationManager.AppSettings["version"];
        if (appVer != null)
            lblVersion.Text = "Version: " + appVer.ToString();
    }
}