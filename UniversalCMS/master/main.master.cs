using System;
using System.Collections.Generic;
using System.Configuration;
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
                {
                    Session.Add("user", user);
                    loadLogo();
                }
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

    private void loadLogo()
    {
        try
        {
            string customLogoURL = ConfigurationManager.AppSettings["logoImgUrl"];
            if (customLogoURL != null)
                imgLogo.ImageUrl = customLogoURL;
            else
                imgLogo.ImageUrl = "../img/default_1.jpg";
        }
        catch 
        {
            imgLogo.ImageUrl = "../img/default_1.jpg";
        }
    }
}
