<%@ Page Title="Change My Password" Language="C#" MasterPageFile="~/master/main.master" AutoEventWireup="true" Inherits="subpages_admin_changepass" Codebehind="changepass.aspx.cs" %>
<%@ Register TagPrefix="uc" TagName="menu" Src="~/master/sidebar.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div class="wrapper row-offcanvas row-offcanvas-left">

            <!-- Left side column. contains the logo and sidebar -->
            <aside class="left-side sidebar-offcanvas">
                <uc:menu ID="menu" runat="server"/>
            </aside>

            <!-- Right side column. Contains the navbar and content of the page -->
            <aside class="right-side">
                <!-- Content Header (Page header) -->
                <section class="content-header">
                    <h1 class="page-header">
                        <i class="fa fa-users"></i> User Management
                        <small>Change Password</small>
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="../home"><i class="fa fa-home"></i>Home</a></li>
                        <li><i class="fa fa-users"></i>User Management</li>
                        <li class="active">Change Password</li>
                    </ol>
                </section>

                <!-- Main content -->
                <section class="content">
            
                    <div class='row'>
                        <div class='col-md-5'>
                            <div class="form-group">
                                <asp:TextBox ID="txtCurrentPasssword" TextMode="Password" runat="server" CssClass="form-control" Placeholder="Enter Current Password"></asp:TextBox>
                                 <asp:RequiredFieldValidator ForeColor="Red" ControlToValidate="txtCurrentPasssword" ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please enter your current password!" ValidationGroup="changepass" CssClass="auto-style1" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>

                            <div class="form-group">
                                <asp:TextBox ID="txtNewPassword" TextMode="Password" runat="server" CssClass="form-control" Placeholder="Enter New Password"></asp:TextBox>
                                 <asp:RequiredFieldValidator ForeColor="Red" ControlToValidate="txtNewPassword" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter your new password!" ValidationGroup="changepass" CssClass="auto-style1" Display="Dynamic"></asp:RequiredFieldValidator>

                            </div>

                            <div class="form-group">
                                <asp:TextBox ID="txtNewPassword2" TextMode="Password" runat="server" CssClass="form-control" Placeholder="Enter New Password Again"></asp:TextBox>
                                 <asp:RequiredFieldValidator ForeColor="Red" ControlToValidate="txtNewPassword2" ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please reenter your new password!" ValidationGroup="changepass" CssClass="auto-style1" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ForeColor="Red" ID="CompareValidator1" ControlToValidate="txtNewPassword2" ControlToCompare="txtNewPassword" runat="server" ErrorMessage="Passwords don't match." ValidationGroup="changepass" CssClass="auto-style1" Display="Dynamic"></asp:CompareValidator>
                            </div>
                        </div>
                        <div class='col-md-7'></div>
                    </div>

                    <!-- Display Success / Error Messages Here -->
            <asp:UpdatePanel ID="UpdatePassword" runat="server">
                <ContentTemplate>
                        <div class='row' style="margin-top:30px;">
                            <div class='col-md-5'>
                                <div id="lblError" class="alert alert-danger alert-dismissable" runat="server" visible="false">
                                    <i id="lblErrorLogo" class="fa fa-ban" runat="server"></i>
                                    <button class="close" aria-hidden="true" data-dismiss="alert" type="button">×</button>
                                    <b id="lblErrorMessage" runat="server">Alert!</b>
                                </div> 
                            </div>
                        </div>
                </ContentTemplate>
            </asp:UpdatePanel>
                    
                    <!-- Buttons -->
                    <div class="row">
                        <div class="col-md-5"></div>
                        <div class="col-md-2">
                            <asp:Button ID="btnChange" runat="server" Text="Change Password" 
                                CssClass="btn btn-primary btn-block" ValidationGroup="changepass" 
                                onclick="btnChange_Click" />
                            <a href="home" class="btn btn-primary btn-block">Cancel</a>
                        </div>
                        <div class="col-md-5"></div>
                    </div>

                </section><!-- /.content -->
            </aside><!-- /.right-side -->
        </div><!-- ./wrapper -->
</asp:Content>