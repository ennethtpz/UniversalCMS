<%@ Control Language="C#" AutoEventWireup="true" Inherits="masterpages_sidebar" Codebehind="sidebar.ascx.cs" %>

<!-- sidebar: style can be found in sidebar.less -->
                <section class="sidebar">
                    <!-- Sidebar user panel -->
                    <div class="user-panel">
                        <div class="pull-left info">
                            <asp:LinkButton ID="lnkbtnLogout" CssClass="btn btn-primary" runat="server" 
                                onclick="lnkbtnLogout_Click">Log Out</asp:LinkButton>
                            <%--reins additions to design. end--%>    
                                
                                
                                                     
                        </div>
                    </div>
                    <!-- sidebar menu: : style can be found in sidebar.less -->
                    <ul class="sidebar-menu">
                        <li class="active">
                            <a id="lnkHome" runat="server" href="/dashboard">
                                <i class="fa fa-dashboard"></i> <span>Dashboard</span>
                            </a>
                        </li>
                        <li class="treeview">
                            <a href="#">
                                <i class="fa fa-user"></i>
                                <span>My Account</span>
                                <i class="fa fa-angle-left pull-right"></i>
                            </a>
                            <ul class="treeview-menu">
                                <li><a href="/changepassword"><i class="fa fa-angle-double-right"></i>Change Password</a></li>
                                <li id="liManageAccounts" runat="server"><a href="/manageusers"><i class="fa fa-angle-double-right"></i>Manage Users</a></li>
                                <li id="liManagePageAccess" runat="server"><a href="/managepageaccess"><i class="fa fa-angle-double-right"></i>Manage Page Access</a></li>
                            </ul>
                        </li>
                        
                        <li class="treeview">
                            <a href="#">
                                <i class="fa fa-user"></i>
                                <span>Blog Posts</span>
                                <i class="fa fa-angle-left pull-right"></i>
                            </a>
                            <ul class="treeview-menu">
                                <li id="Li1" runat="server"><a href="/addentry"><i class="fa fa-angle-double-right"></i>Add Blog Entry</a></li>
                                <li id="Li2" runat="server"><a href="/manageblogs"><i class="fa fa-angle-double-right"></i>Manage Blog Entries</a></li>
                                <li id="Li3" runat="server"><a href="/managecategories"><i class="fa fa-angle-double-right"></i>Manage Blog Categories</a></li>
                            </ul>
                        </li>

                        <li class="treeview">
                            <a href="#">
                                <i class="fa fa-user"></i>
                                <span>File Manager</span>
                                <i class="fa fa-angle-left pull-right"></i>
                            </a>
                            <ul class="treeview-menu">
                                <li id="Li4" runat="server"><a href="/fileman/default.aspx" target="_blank"><i class="fa fa-angle-double-right"></i>Manage Files</a></li>
                            </ul>
                        </li>


                      <%--  <li class="treeview">
                            <a href="#">
                                <i class="fa fa-user"></i>
                                <span>Sample Page Group</span>
                                <i class="fa fa-angle-left pull-right"></i>
                            </a>
                            <ul class="treeview-menu">
                                <li id="smp1" runat="server" visible="false"><a href="/sample1"><i class="fa fa-angle-double-right"></i>Sample Page 1</a></li>
                                <li id="smp2" runat="server" visible="false"><a href="/sample2"><i class="fa fa-angle-double-right"></i>Sample Page 2</a></li>
                                <li id="smp3" runat="server" visible="false"><a href="/sample3"><i class="fa fa-angle-double-right"></i>Sample Page 3</a></li>
                            </ul>
                        </li>--%>


                       
                    </ul>
                </section>
                <!-- /.sidebar -->