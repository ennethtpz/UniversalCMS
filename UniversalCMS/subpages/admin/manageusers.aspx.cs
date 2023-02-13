using System;
using System.Configuration;
using System.Web.UI.WebControls;
using Objects;
using Functions;

public partial class subpages_admin_manageusers : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            User user = (User)Session["user"];
            if (user != null)
            {
                hdUsername.Value = user.username;
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

    public string isActiveStatus(bool isActiveStatus)
    {
        if (isActiveStatus)
        {
            return "<font color='green'>Active</font>";
        }
        else
        {
            return "<font color='red'>Inactive</font>";
        }
    }


    protected void grdUsers_RowCommand(object sender,GridViewCommandEventArgs e)
    {

        if (e.CommandName == "resetPass")
        {
            string username = e.CommandArgument.ToString();

            string defualtpass = ConfigurationManager.AppSettings["defaultpass"];

            UserManagement.ChangePassword(UserManagement.GetUser(username).userID, defualtpass);

            Response.Write("<script>alert('Password for " + username + " reset to " + defualtpass + ".')</script>");
        }
        else if (e.CommandName == "setStatus")
        {
            string[] args = e.CommandArgument.ToString().Split(',');

            string username = args[0];
            bool currentStatus = bool.Parse(args[1]);

            UserManagement.SetUserActiveStatus(UserManagement.GetUser(username).userID, !currentStatus);

            Response.Write("<script>alert('Status for " + username + " changed.')</script>");
            sqldsUsers.DataBind();
            grdUsers.DataBind();
        }

    }

    protected void btnAddUser_Click(object sender, EventArgs e)
    {
        try
        {

            User checkUser = UserManagement.GetUser(txtUsername.Text.Trim());
            if (checkUser == null)
            {
                UserManagement.AddUser(txtUsername.Text.Trim(), txtPass.Text.Trim(), int.Parse(ddlUserType.Text.Trim()), txtName.Text.Trim());
                sqldsUsers.DataBind();
                grdUsers.DataBind();
                Response.Write("<script>alert('The username " + txtUsername.Text.Trim() + " is now added.')</script>");
            }
            else
            {
                Response.Write("<script>alert('Sorry. The username " + txtUsername.Text.Trim() + " is already taken.')</script>");
            }

        }
        catch
        {
            Response.Write("<script>alert('Something went wrong. Please try again later.')</script>");
        }
    }
}