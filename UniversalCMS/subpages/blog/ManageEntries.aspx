<%@ Page Title="" Language="C#" MasterPageFile="~/master/main.master" AutoEventWireup="true" Inherits="subpages_blog_ManageEntries" Codebehind="ManageEntries.aspx.cs" %>
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
                        Manage Blog Articles
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="/dashboard"><i class="fa fa-home"></i>Dashboard</a></li>
                        <li class="active"><i class="fa fa-book"> Manage Blog Articles</i></li>
                    </ol>
                </section>
                <section class="content"><!-- content -->
                    <div align="left" class="row">
                        <div class="col-md-6">
                            <asp:TextBox ID="txtSearch" CssClass="form-control awesomplete" MaxLength="200" runat="server" placeholder="Enter search query here. Leave blank to display all." />
                        </div>
                        <div class="col-md-2">
                            <asp:DropDownList ID="ddlSearchCategory" runat="server" CssClass="form-control awesomplete">
                                <asp:ListItem Text="- Select Search Criteria -" Value="" />
                                <asp:ListItem Text="Title" Value="title" />
                                <asp:ListItem Text="Category" Value="category" />
                                <asp:ListItem Text="Article ID" Value="articleId" />
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-2">
                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
                        </div>
                        <div class="col-md-2" align="right">
                            <asp:Button ID="btnAddEntry" runat="server" Text="+ Add New Blog Entry" PostBackUrl="~/addentry" CssClass="btn btn-secondary" />
                        </div>
                    </div>
                    <br />

                    <asp:GridView ID="grdEntries" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="articleId" DataSourceID="sqldsEntries" CssClass="table table-responsive" EmptyDataText="- No articles added. -">
                        <Columns>
                            <asp:BoundField DataField="articleId" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="articleId" />
                            <asp:BoundField DataField="title" HeaderText="Title" SortExpression="title" />
                            <asp:BoundField DataField="dateAdded" HeaderText="Date Added" SortExpression="dateAdded" />
                            <asp:CheckBoxField DataField="isActive" HeaderText="is shown?" SortExpression="isActive" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button ID="btnView" runat="server" Text="Edit Article" PostBackUrl='<%# "~/viewentry/" + Eval("articleId").ToString() %>' />
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


                    <asp:SqlDataSource ID="sqldsEntries" runat="server" ConnectionString="<%$ ConnectionStrings:conn %>"></asp:SqlDataSource>


                </section><!-- /.content -->
            </aside><!-- /.right-side -->
        </div><!-- ./wrapper -->
</asp:Content>
