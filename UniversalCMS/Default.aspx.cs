using System;
using System.Configuration;
using System.Web.Security;
using ReinST.Central.Helpers;
using Objects;
using Functions;

public partial class _Default : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.IsAuthenticated)
        {
            string currentUser = Page.User.Identity.Name;
            if (currentUser != null)
            {
                User user = UserManagement.GetUser(currentUser);
                if (user != null)
                {
                    Session.Add("user", user);
                    Response.Redirect("dashboard");
                }
            }      
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        try
        {
            string EncodedResponse = Request.Form["g-Recaptcha-Response"];
            string RecaptchaSecret = ConfigurationManager.AppSettings["recaptchaSecret"];
            bool captchaDisabled = bool.Parse(ConfigurationManager.AppSettings["disableCaptcha"]);
            bool googleCaptchaVerificationResult = bool.Parse(ReCaptchaHelper.Validate(EncodedResponse, RecaptchaSecret));

            if (captchaDisabled)
                googleCaptchaVerificationResult = true;

            if (googleCaptchaVerificationResult)
            {
                User user = UserManagement.GetUser(txtUsername.Text);
                if (user != null)
                {
                    if (user.isActive)
                    {
                        if (UserManagement.AuthenticateUser(user, txtPassword.Text.Trim()))
                            FormsAuthentication.RedirectFromLoginPage(user.username, cbxRememberMe.Checked);
                        else
                            promptWarning("Sorry. Wrong password.");
                    }
                    else
                        promptWarning("Sorry. This account is disabled. Please contact an admin.");
                }
                else
                    promptWarning("User does not exist.");
            }
            else
                promptWarning("Please prove that you are not a robot.");
        }
        catch (Exception ex)
        {
            promptDanger(ex.Message);
        }
    }

    protected void btnAlertClose_Click(object sender, EventArgs e)
    {
        divInformation.Visible = false;
    }

    private void promptSuccess(string message)
    {
        divInformation.Visible = true;
        lblInformation.Text = " Success";
        lblMessage.InnerText = message;
        errorDialog.Attributes["class"] = "alert alert-success alert-dismissable";
        errorIcon.Attributes["class"] = "icon fa fa-check";
        divInformation.Focus();
    }

    private void promptWarning(string message)
    {
        divInformation.Visible = true;
        lblInformation.Text = " Warning";
        lblMessage.InnerText = message;
        errorDialog.Attributes["class"] = "alert alert-warning alert-dismissable";
        errorIcon.Attributes["class"] = "icon fa fa-warning";
        divInformation.Focus();
    }

    private void promptDanger(string message)
    {
        divInformation.Visible = true;
        lblInformation.Text = " Error";
        lblMessage.InnerText = message;
        errorDialog.Attributes["class"] = "alert alert-danger alert-dismissable";
        errorIcon.Attributes["class"] = "icon fa fa-ban";
        divInformation.Focus();
    }
}