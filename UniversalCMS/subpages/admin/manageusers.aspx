<%@ Page Title="Manage Users" Language="C#" MasterPageFile="~/master/main.master" AutoEventWireup="true" Inherits="subpages_admin_manageusers" Codebehind="manageusers.aspx.cs" %>
<%@ Register TagPrefix="uc" TagName="menu" Src="~/master/sidebar.ascx" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .GridPager a, .GridPager span {
            display: block;
            height: auto;
            width: auto;
            font-weight: bold;
            text-align: center;
            text-decoration: none;
            padding: 10px 10px 10px 10px;
            margin-top:20px;
        }

        .GridPager a {
            position: relative;
            padding: 6px 12px;
            color: #428bca;
            text-decoration: none;
            background-color: #fff;
            border: 1px solid #ddd;
        }

        .GridPager span {
            color: #fff;
            cursor: default;
             padding: 6px 12px;
            background-color: #428bca;
            border-color: #428bca;

        }

        .error { border: 1px solid #b94a48!important; background-color: #fee!important; }
    </style>


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
                        Manage Users
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="/dashboard"><i class="fa fa-home"></i>Dashboard</a></li>
                        <li class="active"><i class="fa fa-book"></i>Manage Users</li>
                    </ol>
                </section>
                <section class="content"><!-- content -->

                    <asp:HiddenField ID="hdUsername" runat="server" />
                    <asp:GridView ID="grdUsers" runat="server" DataSourceID="sqldsUsers" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="3" DataKeyNames="userid" CssClass="table table-responsive" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" OnRowCommand="grdUsers_RowCommand" EmptyDataText="- No other users added. -">
                        <Columns>
                            <asp:BoundField DataField="username" HeaderText="Username" SortExpression="username" />
                            <asp:BoundField DataField="name" HeaderText="Name" SortExpression="name" />
                            <asp:BoundField DataField="Type" HeaderText="User Type" SortExpression="Type" />
                            <asp:TemplateField HeaderText="Status" SortExpression="isActive">
                                <ItemTemplate>
                                    <asp:Label ID="activeStat" runat="server" Text='<%# isActiveStatus(Convert.ToBoolean(Eval("isActive"))) %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button ID="btnResetPass" runat="server" Text="Reset Password" CommandName="resetPass" CommandArgument='<%# Eval("username").ToString() %>' />
                                    <asp:Button ID="btnSetActive" runat="server" Text="Activate/Deactivate" CommandName="setStatus" CommandArgument='<%# Eval("username").ToString().Replace(",", "") + "," + Eval("isActive").ToString() %>' />

                                    <asp:ConfirmButtonExtender TargetControlID="btnResetPass" ID="ConfirmButtonExtender1" ConfirmText="Are you sure you want to reset this user's password?" runat="server"></asp:ConfirmButtonExtender>
                                    <asp:ConfirmButtonExtender TargetControlID="btnSetActive" ID="ConfirmButtonExtender2" ConfirmText="Are you sure you want to activate/deactivate this user?" runat="server"></asp:ConfirmButtonExtender>

                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="White" ForeColor="#000066" />
                        <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                        <RowStyle ForeColor="#000066" />
                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#007DBB" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#00547E" />
                        <PagerStyle HorizontalAlign="Right" CssClass="GridPager" Font-Size="X-Small" />
                        <PagerSettings Mode="NextPrevious" Visible="True" />
                    </asp:GridView>
                 

                    <asp:SqlDataSource ID="sqldsUsers" runat="server" ConnectionString="<%$ ConnectionStrings:conn %>" SelectCommand="SELECT a.userID, a.name, a.username, a.dateAdded, b.[Type], a.dateModified, a.isActive FROM users a INNER JOIN UserTypes b ON a.userType=b.userType WHERE username != 'superadmin' AND a.username != @username ORDER BY a.username">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hdUsername" Name="username" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>






                    <hr />

                     <div class="col-md-5">

                         <h3>Add New User</h3>
                         <br />
                            <div class="form-group">
                                <label>Usery Type: </label>
                               <asp:DropDownList ID="ddlUserType" runat="server" AppendDataBoundItems="True" 
                                    DataSourceID="sqldsUserTypes" DataTextField="Type" DataValueField="userType">
                                <asp:ListItem Value="">- SELECT -</asp:ListItem>
                               </asp:DropDownList>
                                &nbsp;<asp:SqlDataSource ID="sqldsUserTypes" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:conn %>" 
                                    SelectCommand="SELECT * FROM [UserTypes]"></asp:SqlDataSource>
                                <asp:RequiredFieldValidator ControlToValidate="ddlUserType" ID="RequiredFieldValidator2" runat="server" ErrorMessage="Select User Type" ForeColor="Red" Display="Dynamic" ValidationGroup="add"></asp:RequiredFieldValidator>
                            &nbsp;<asp:LinkButton ID="lnkbntManageUserTypes" runat="server" 
                                    PostBackUrl="~/manageusertypes">Manage User Types</asp:LinkButton>
                            </div>

                             <div class="form-group">
                                <label>Name: </label>
                                <asp:TextBox ID="txtName" CssClass="form-control awesomplete" MaxLength="200" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ControlToValidate="txtName" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Name" ForeColor="Red" Display="Dynamic" ValidationGroup="add"></asp:RequiredFieldValidator>
                            </div>

                            <div class="form-group">
                                <label>Username: </label>
                                <asp:TextBox ID="txtUsername" CssClass="form-control awesomplete" MaxLength="150" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ControlToValidate="txtUsername" ID="RequiredFieldValidator6" runat="server" ErrorMessage="Enter Username" ForeColor="Red" Display="Dynamic" ValidationGroup="add"></asp:RequiredFieldValidator>
                            </div>

                            <div class="form-group">
                                <label>Password: </label>
                                <asp:TextBox ID="txtPass" CssClass="form-control awesomplete" MaxLength="150" runat="server" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ControlToValidate="txtPass" ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Password" ForeColor="Red" Display="Dynamic" ValidationGroup="add"></asp:RequiredFieldValidator>
                            </div>

                            <div class="form-group">
                                <label>Repeat Password: </label>
                                <asp:TextBox ID="txtRepeatPass" CssClass="form-control awesomplete" MaxLength="150" runat="server" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ControlToValidate="txtRepeatPass" ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please Repeat Password" ForeColor="Red" Display="Dynamic" ValidationGroup="add"></asp:RequiredFieldValidator>
                                <asp:CompareValidator Display="Dynamic" ValidationGroup="add" ForeColor="Red" ID="CompareValidator1" ControlToValidate="txtPass" ControlToCompare="txtRepeatPass" runat="server" ErrorMessage="Passwords Don't Match"></asp:CompareValidator>
                            </div>

                    
                          <br />

                            <div class="form-group">
                                <asp:Button ID="btnAddUser" runat="server" Text="Add New User" CssClass="btn btn-primary" ValidationGroup="add" OnClick="btnAddUser_Click" />
                            </div>
                            

                            <asp:ConfirmButtonExtender TargetControlID="btnAddUser" ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are you sure you want to add this new user?">
                            </asp:ConfirmButtonExtender>



                        </div>
                    </div>







                 

                </section><!-- /.content -->
            </aside><!-- /.right-side -->
        </div><!-- ./wrapper -->
</asp:Content>


