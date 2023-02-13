using System;
using System.Collections.Generic;
using Objects;
using Functions;
using System.Web.Security;



public partial class masterpages_sidebar : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            User user = (User)Session["user"];
            if (user != null)
            {
                if (user.userType != 1)
                {
                    liManageAccounts.Visible = false;
                    liManagePageAccess.Visible = false;

                    List<PageAccess> allowedPages = PageAccessManagement.GetAllAllowedPages(user.userType);

                    if (allowedPages != null)
                    {
                        foreach (PageAccess pa in allowedPages)
                        {
                            enableLink(pa.pageId);
                        }
                    }

                }
                else
                {
                    //admin, allow to view all pages

                    //smp1.Visible = true;
                    //smp2.Visible = true;
                    //smp3.Visible = true;
                }
            }
        }
        catch
        {
        }
    }
    protected void lnkbtnLogout_Click(object sender, EventArgs e)
    {
        Session.Clear();
        FormsAuthentication.SignOut();
        Response.Redirect("~/home");
    }

    private void enableLink(int pageId)
    {
        //set here for allowed pages
        //switch (pageId)
        //{
        //    case 1:
        //        smp1.Visible = true;
        //        break;
        //    case 2:
        //        smp2.Visible = true;
        //        break;
        //    case 3:
        //        smp3.Visible = true;
        //        break;
        //}
    }

}