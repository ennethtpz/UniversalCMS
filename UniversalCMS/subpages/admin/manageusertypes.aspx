<%@ Page Title="" Language="C#" MasterPageFile="~/master/main.master" AutoEventWireup="true" Inherits="subpages_admin_manageusertypes" Codebehind="manageusertypes.aspx.cs" %>

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
                        Manage User Types
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="/dashboard"><i class="fa fa-home"></i>Dashboard</a></li>
                        <li><a href="/manageusers"><i class="fa fa-book"></i>Manage Users</a></li>
                        <li class="active"><i class="fa fa-book"></i>Manage User Types</li>
                    </ol>
                </section>
                <section class="content"><!-- content -->



                    <asp:GridView ID="grdUserTypes" runat="server" 
                AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" 
                BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="userType" 
                DataSourceID="sqldsUserTypes" CssClass="table table-responsive" OnRowCommand="grdUserTypes_RowCommand" EmptyDataText="- No user types added. -">
                        <Columns>
                            <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button CommandName="deleteType" CommandArgument='<%# Eval("userType").ToString() %>' ID="btnDelete" runat="server" Text="Delete"></asp:Button>
                                    <asp:ConfirmButtonExtender TargetControlID="btnDelete" ID="ConfirmButtonExtender2" runat="server" ConfirmText="Are you sure you want to delete this new user type?"></asp:ConfirmButtonExtender>
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
            </asp:GridView>





              

                <asp:SqlDataSource ID="sqldsUserTypes" runat="server" 
                ConnectionString="<%$ ConnectionStrings:conn %>" 
                SelectCommand="SELECT * FROM [UserTypes] WHERE UserType!=1"></asp:SqlDataSource>



                <div class="col-md-5">

                         <h3>Add New User</h3>
                         <br />


                             <div class="form-group">
                                <label>User Type: </label>
                                <asp:TextBox ID="txtUserType" CssClass="form-control awesomplete" MaxLength="20" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ControlToValidate="txtUserType" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter user type" ForeColor="Red" Display="Dynamic" ValidationGroup="add"></asp:RequiredFieldValidator>
                            </div>

                    
                          <br />

                            <div class="form-group">
                                <asp:Button ID="btnAddUserType" runat="server" Text="Add New User Type" 
                                    CssClass="btn btn-primary" ValidationGroup="add" 
                                    onclick="btnAddUserType_Click" />
                            </div>
                            

                            <asp:ConfirmButtonExtender TargetControlID="btnAddUserType" ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are you sure you want to add this new user type?">
                            </asp:ConfirmButtonExtender>



                        </div>
       </div>

              

                </section><!-- /.content -->
            </aside><!-- /.right-side -->
        </div><!-- ./wrapper -->
</asp:Content>

