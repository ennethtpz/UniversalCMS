using System;
using System.Web.UI.WebControls;
using Objects;
using Functions;

public partial class subpages_admin_managepageaccess : System.Web.UI.Page
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
                    Response.Redirect("~/dashboard");
                }
            }
        }
        catch
        {
        }
    }
    protected void btnAddAccess_Click(object sender, EventArgs e)
    {
        try
        {
            PageAccessManagement.InsertPageAccessRule(int.Parse(ddlUserType.SelectedValue), int.Parse(ddlPages.SelectedValue));
            sqldsRules.DataBind();
            grdAccessRules.DataBind();
            ddlPages.SelectedValue = "";
            ddlUserType.SelectedValue = "";

        }
        catch (Exception ex)
        {
            //Response.Write(ex.Message);
            Response.Write("<script>alert('Sorry, an error has occured. Please try again later')</script>");
        }
    }

    protected void grdAccessRules_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "del")
            {
                int paId = int.Parse(e.CommandArgument.ToString());

                //insert del command
                PageAccessManagement.DeleteRule(paId);

                Response.Write("<script>alert('Rule deleted')</script>");
                sqldsRules.DataBind();
                grdAccessRules.DataBind();
            }
        }
        catch (Exception ex)
        {
            //Response.Write(ex.Message);
            Response.Write("<script>alert('Sorry, an error has occured. Please try again later')</script>");
        }
    }
}