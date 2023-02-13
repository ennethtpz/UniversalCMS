<%@ Page Title="" Language="C#" MasterPageFile="~/master/main.master" AutoEventWireup="true" Inherits="subpages_admin_managepageaccess" Codebehind="managepageaccess.aspx.cs" %>

<%@ Register TagPrefix="uc" TagName="menu" Src="~/master/sidebar.ascx" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .GridPager a, .GridPager span
        {
            display: block;
            height: auto;
            width: auto;
            font-weight: bold;
            text-align: center;
            text-decoration: none;
            padding: 10px 10px 10px 10px;
            margin-top: 20px;
        }

        .GridPager a
        {
            position: relative;
            padding: 6px 12px;
            color: #428bca;
            text-decoration: none;
            background-color: #fff;
            border: 1px solid #ddd;
        }

        .GridPager span
        {
            color: #fff;
            cursor: default;
            padding: 6px 12px;
            background-color: #428bca;
            border-color: #428bca;
        }

        .error
        {
            border: 1px solid #b94a48!important;
            background-color: #fee!important;
        }
    </style>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="wrapper row-offcanvas row-offcanvas-left">

        <!-- Left side column. contains the logo and sidebar -->
        <aside class="left-side sidebar-offcanvas">
            <uc:menu ID="menu" runat="server" />
        </aside>

        <!-- Right side column. Contains the navbar and content of the page -->
        <aside class="right-side">
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1 class="page-header">Manage Page Access
                    </h1>
                <ol class="breadcrumb">
                    <li><a href="/dashboard"><i class="fa fa-home"></i>Dashboard</a></li>
                    <li class="active"><i class="fa fa-book"></i>Manage Page Access</li>
                </ol>
            </section>
            <section class="content">
                <!-- content -->


                <h3>Current Allow View Rules</h3>
                <asp:GridView ID="grdAccessRules" runat="server" DataSourceID="sqldsRules" AllowPaging="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" CssClass="table table-responsive" OnRowCommand="grdAccessRules_RowCommand" EmptyDataText="- No access rules added. -">
                    <Columns>
                        <asp:BoundField DataField="Type" HeaderText="User Type" SortExpression="Type" />
                        <asp:BoundField DataField="title" HeaderText="Page" SortExpression="title" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="btnDelete" runat="server" Text="Delete Rule" CommandName="del" CommandArgument='<%# Eval("paId").ToString() %>' />
                                <asp:ConfirmButtonExtender TargetControlID="btnDelete" ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are you sure you want delete this rule?">
                    </asp:ConfirmButtonExtender>
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



                <hr />



                <asp:SqlDataSource ID="sqldsRules" runat="server"
                    ConnectionString="<%$ ConnectionStrings:conn %>"
                    SelectCommand="SELECT a.paId, c.[Type], b.title FROM PageAccess a
INNER JOIN Pages b ON a.pageId=b.pageId
INNER JOIN UserTypes c ON a.userType=c.userType"></asp:SqlDataSource>


                <h3>Add Allow View Rule Per User Type</h3>
                <br />
                <div class="col-md-5">
                    <div class="form-group">
                        <label>User Type: </label>
                        <asp:DropDownList ID="ddlUserType" runat="server" AppendDataBoundItems="True" DataSourceID="sqldsUserTypes" DataTextField="Type" DataValueField="userType">
                            <asp:ListItem Value="">- SELECT -</asp:ListItem>
                        </asp:DropDownList>
                        &nbsp;<asp:SqlDataSource ID="sqldsUserTypes" runat="server"
                            ConnectionString="<%$ ConnectionStrings:conn %>"
                            SelectCommand="SELECT * FROM [UserTypes] WHERE UserType!=1"></asp:SqlDataSource>
                        <asp:RequiredFieldValidator ControlToValidate="ddlUserType" ID="RequiredFieldValidator2" runat="server" ErrorMessage="Select User Type" ForeColor="Red" Display="Dynamic" ValidationGroup="add"></asp:RequiredFieldValidator>
                        &nbsp;<asp:LinkButton ID="lnkbntManageUserTypes" runat="server"
                            PostBackUrl="~/manageusertypes">Manage User Types</asp:LinkButton>
                    </div>

                    <div class="form-group">
                        <label>Page: </label>
                        <asp:DropDownList ID="ddlPages" runat="server" AppendDataBoundItems="True" DataSourceID="sqldsPages" DataTextField="Title" DataValueField="pageId">
                            <asp:ListItem Value="">- SELECT -</asp:ListItem>
                        </asp:DropDownList>
                        &nbsp;<asp:SqlDataSource ID="sqldsPages" runat="server"
                            ConnectionString="<%$ ConnectionStrings:conn %>"
                            SelectCommand="SELECT * FROM [Pages]"></asp:SqlDataSource>
                        <asp:RequiredFieldValidator ControlToValidate="ddlUserType" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Select a Page" ForeColor="Red" Display="Dynamic" ValidationGroup="add"></asp:RequiredFieldValidator>
                    </div>


                    <div class="form-group">
                        <asp:Button ID="btnAddAccess" runat="server" Text="Add This Rule" CssClass="btn btn-primary" ValidationGroup="add" OnClick="btnAddAccess_Click"  />
                    </div>


                    <asp:ConfirmButtonExtender TargetControlID="btnAddAccess" ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are you sure you want to add this new rule?">
                    </asp:ConfirmButtonExtender>

                </div>



            </section>
            <!-- /.content -->
        </aside>
        <!-- /.right-side -->
    </div>
    <!-- ./wrapper -->
</asp:Content>


