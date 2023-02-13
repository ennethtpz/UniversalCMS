<%@ Page Language="C#" AutoEventWireup="true" Inherits="_Default" Codebehind="Default.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Off limits!</title>


    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">

    <!-- Bootstrap Core CSS -->
    <link href="bower_components/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">


    <!-- Timeline CSS -->
    <link href="dist/css/timeline.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="dist/css/sb-admin-2.css" rel="stylesheet">


    <!-- Custom Fonts -->
    <link href="bower_components/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4" style="text-align: center; padding-top: 100px">
                    <%--replace with logo below--%>
                    <%--<img src="img/logo.png" style="width:100%; max-width:400px; margin: 0 auto;"/>--%>
                    <div class="login-panel panel panel-primary">
                        <div class="panel-heading ">
                            <h3 class="panel-title">
                                Hey, what are you doing here?
                            </h3>
                        </div>
                        <div class="panel-body">
                            <div class="form-group">
                                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" Placeholder="Username"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter your username." ControlToValidate="txtUsername" CssClass="label label-danger" ValidationGroup="login"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" Placeholder="Password" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please enter your password." ControlToValidate="txtPassword" CssClass="label label-danger" ValidationGroup="login"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <asp:CheckBox ID="cbxRememberMe" runat="server" />
                                <asp:Label runat="server" Text="Remember Me" />
                            </div>
                            <asp:Button ID="btnLogin" runat="server" Text="Login"
                                CssClass="btn btn-lg btn-primary btn-block" ValidationGroup="login"
                                OnClick="btnLogin_Click" />
                        </div>
                        <center>
                            <div>
                                <div class="g-recaptcha" data-sitekey="<%= ConfigurationManager.AppSettings["recaptchaKey"] %>"></div>
                            </div>
                        </center>
                        <br />
                    </div>
                    <div class="row" id="divInformation" runat="server" visible="false">
                        <div class="col-xs-12 col-sm-12">
                            <div class="box-body">
                                <div id="errorDialog" runat="server" class="alert alert-info alert-dismissable">
                                    <asp:Button ID="btnAlertClose" CssClass="close" aria-hidden="true" runat="server" Text="x" OnClick="btnAlertClose_Click" />
                                    <h4><i id="errorIcon" runat="server" class="icon fa fa-info"></i>
                                        <asp:Label ID="lblInformation" runat="server"></asp:Label></h4>
                                    <span id="lblMessage" runat="server">Danger alert preview.</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <!-- jQuery -->
        <script src="bower_components/jquery/dist/jquery.min.js"></script>

        <!-- Bootstrap Core JavaScript -->
        <script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

        <!-- Custom Theme JavaScript -->
        <script src="dist/js/sb-admin-2.js"></script>
        
        <!-- Recaptcha -->
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    </form>
</body>
</html>
