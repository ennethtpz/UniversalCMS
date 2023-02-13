using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Functions;
using Objects;

public partial class subpages_sample_sample2 : System.Web.UI.Page
{
    public const int pageId = 2;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            User user = (User)Session["user"];
            if (user != null)
            {
                if (user.userType != 1)
                {
                    if (!PageAccessManagement.CheckIfhasPageAccessRule(user.userType, pageId))
                    {
                        Response.Redirect("~/dashboard");
                    }
                }
            }
        }
        catch
        {
        }
    }
}