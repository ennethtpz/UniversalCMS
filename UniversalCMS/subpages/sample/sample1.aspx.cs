using System;
using Objects;
using Functions;

public partial class subpages_sample_sample1 : System.Web.UI.Page
{
    public const int pageId = 1;

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