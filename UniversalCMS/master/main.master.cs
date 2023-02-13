using System;
using System.Collections.Generic;
using System.Linq;
using Functions;
using Objects;

public partial class masterpages_main : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Request.IsAuthenticated)
            {
                User user = (User)Session["user"];
                if (user != null)
                    Session.Add("user", user);
                else
                    LogOutAndGoHome();
            }
            else
                LogOutAndGoHome();
        }
        catch (Exception ex)
        {
            LogOutAndGoHome();
        }
    }

    private void LogOutAndGoHome()
    {
        Session.Clear();
        Response.Redirect("~/home");
    }
}
