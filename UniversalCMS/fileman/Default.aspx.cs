using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Objects;

public partial class fileman_Default : System.Web.UI.Page
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