<%@ Page Title="Manage Blog Categories" Language="C#" MasterPageFile="~/master/main.master" AutoEventWireup="true" CodeBehind="ManageCategories.aspx.cs" Inherits="Admin.subpages.blog.ManageCategories" %>
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
                    <h1 class="page-header">Manage Blog Categories
                        </h1>
                    <ol class="breadcrumb">
                        <li><a href="/dashboard"><i class="fa fa-home"></i>Dashboard</a></li>
                        <li><a href="/manageblogs"><i class="fa fa-book"></i>Blog Entries</a></li>
                        <li class="active"><i class="fa fa-pencil"> Manage Blog Categories</i></li>
                    </ol>
                </section>
                <section class="content"><!-- content -->
                <asp:Label ID="lblAlert" ForeColor="Red" runat="server"></asp:Label>
                <asp:GridView CssClass="table table-responsive" ID="grdCategories" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="categoryId" DataSourceID="sqldsCategories">
                    <Columns>
                        <asp:TemplateField HeaderText="Category Name" SortExpression="category">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCategory" runat="server" Text='<%# Bind("category") %>' MaxLength="50" ValidationGroup="edit"></asp:TextBox>
                                <asp:RequiredFieldValidator Display="Dynamic" ForeColor="Red" ControlToValidate="txtCategory" ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please enter category name." ValidationGroup="edit"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblCategoryName" runat="server" Text='<%# Bind("category") %>'></asp:Label>
                                <br />
                                <asp:LinkButton ID="lblManageArticles" PostBackUrl='<%# Eval("categoryId", "~/managecategoryentries?id={0}") %>' runat="server">Manage Articles of this Category</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="articleCount" HeaderText="# of Articles" ReadOnly="True" SortExpression="articleCount" />
                        <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" ValidationGroup="edit" ButtonType="Button" />
                    </Columns>
                    <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                    <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                    <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                    <RowStyle BackColor="White" ForeColor="#003399" />
                    <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                    <SortedAscendingCellStyle BackColor="#EDF6F6" />
                    <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
                    <SortedDescendingCellStyle BackColor="#D6DFDF" />
                    <SortedDescendingHeaderStyle BackColor="#002876" />
                    </asp:GridView>

                    <asp:SqlDataSource OnDeleted="articlelDataSource_Deleted" OnUpdated="sqldsCategories_Updated" ID="sqldsCategories" runat="server" ConnectionString="<%$ ConnectionStrings:conn %>" SelectCommand="SELECT a.categoryId, a.category, (SELECT COUNT (b.articleID) FROM ArticleCategories b WHERE a.categoryId=b.categoryId) AS 'articleCount' FROM Categories a ORDER BY a.categoryId DESC" DeleteCommand="DELETE FROM Categories WHERE categoryId=@categoryId AND NOT EXISTS (SELECT * FROM ArticleCategories AS b WHERE b.categoryId=@categoryId)" InsertCommand="INSERT INTO Categories (category) VALUES (@category)" UpdateCommand="UPDATE Categories SET category=@category WHERE categoryId=@categoryId">
                        <DeleteParameters>
                            <asp:Parameter Name="categoryId" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="category" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="category" />
                            <asp:Parameter Name="categoryId" />
                        </UpdateParameters>
                    </asp:SqlDataSource>

                    <hr />

                     <div class="col-md-5">

                         <h3>Add a New Category</h3>


                             <div class="form-group">
                                <label>Category Name: </label>
                                <asp:TextBox ID="txtCategory" CssClass="form-control awesomplete" MaxLength="50" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ControlToValidate="txtCategory" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Category Name" ForeColor="Red" Display="Dynamic" ValidationGroup="add"></asp:RequiredFieldValidator>
                            </div>

                    
                          <br />

                            <div class="form-group">
                                <asp:Button ID="btnAddCategory" runat="server" Text="Add New Category" CssClass="btn btn-primary" ValidationGroup="add" OnClick="btnAddCategory_Click" />
                            </div>
                            

                            <asp:ConfirmButtonExtender TargetControlID="btnAddCategory" ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are you sure you want to add this new category?">
                            </asp:ConfirmButtonExtender>

                        </div>
                    </div>

                </section><!-- /.content -->
            </aside><!-- /.right-side -->
        </div><!-- ./wrapper -->
</asp:Content>
