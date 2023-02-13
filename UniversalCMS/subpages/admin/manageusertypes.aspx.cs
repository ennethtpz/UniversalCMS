using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Functions;
using Objects;

public partial class subpages_admin_manageusertypes : System.Web.UI.Page
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
    protected void btnAddUserType_Click(object sender, EventArgs e)
    {
        try
        {
            UserManagement.AddUserType(txtUserType.Text.Trim());
            txtUserType.Text = "";
            sqldsUserTypes.DataBind();
            grdUserTypes.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }

    protected void grdUserTypes_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "deleteType")
            {
                int userType = int.Parse(e.CommandArgument.ToString());
                UserManagement.DeleteUserType(userType);
                sqldsUserTypes.DataBind();
                grdUserTypes.DataBind();
                Response.Write("<script>alert('Usertype deleted.')</script>");
            }
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('Sorry, this usert type cannot be deleted as it already has users in it.')</script>");
        }
       

    }

}