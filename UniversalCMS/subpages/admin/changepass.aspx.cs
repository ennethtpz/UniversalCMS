using System;
using Functions;
using ReinST.Central.Helpers;

public partial class subpages_admin_changepass : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnChange_Click(object sender, EventArgs e)
    {
        try
        {
            //verify currentpass first
            Objects.User currentUser = (Objects.User)Session["user"];
            if(StringHelper.VerifyBCryptHash(txtCurrentPasssword.Text.Trim(), currentUser.ecryPass))
            {

                UserManagement.ChangePassword(currentUser.userID, txtNewPassword.Text);

                int currentID = currentUser.userID;
                currentUser = UserManagement.GetUser(currentID);

                Session.Add("user", currentUser);

                txtCurrentPasssword.Text = "";
                txtNewPassword.Text = "";
                txtNewPassword2.Text = "";

                Response.Write("<script>alert('Password changed.');</script>");
            }
            else
            {
                Response.Write("<script>alert('Please check your current password.');</script>");
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
            Response.Write("<script>alert('Something went wrong. Please try again later.');</script>");
        }
    }
}