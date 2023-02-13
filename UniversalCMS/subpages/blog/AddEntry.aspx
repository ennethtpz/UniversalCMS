<%@ Page Title="" Language="C#" MasterPageFile="~/master/main.master" AutoEventWireup="true" Inherits="subpages_blog_AddEntry" Codebehind="AddEntry.aspx.cs" %>
<%@ Register TagPrefix="uc" TagName="menu" Src="~/master/sidebar.ascx" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <style>
        .cb label
        {
            margin-right: 20px;
            margin-left: 10px;
        }
    </style>

    <link rel="stylesheet" href="../datepicker/jquery-ui.css">
    <link rel="stylesheet" href="../datepicker/style.css">
    <script src="../datepicker/jquery-1.12.4.js"></script>
    <script src="../datepicker/jquery-ui.js"></script>

    <script>
        $(function () {
            $('<%=  "#" + txtDate.ClientID %>').datepicker({
                changeMonth: true,
                changeYear: true
            });
            $('<%=  "#" + txtDate.ClientID %>').datepicker({
                changeMonth: true,
                changeYear: true
            });
        });
    </script>

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
                <h1 class="page-header">Add an Article
                    </h1>
                <ol class="breadcrumb">
                    <li><a href="/dashboard"><i class="fa fa-home"></i>Dashboard</a></li>
                    <li><a href="/manageblogs"><i class="fa fa-book"></i>Blog Entries</a></li>
                    <li class="active"><i class="fa fa-pencil">Add an Article</i></li>
                </ol>
            </section>
            <section class="content">
                <!-- content -->



                <div class="col-md-12">

                    <div class="form-group">
                        <label>Title: </label>
                        <asp:TextBox ID="txtTitle" CssClass="form-control awesomplete" MaxLength="200" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ControlToValidate="txtTitle" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter title" ForeColor="Red" Display="Dynamic" ValidationGroup="add"></asp:RequiredFieldValidator>
                    </div>

                    <%--<div class="form-group">
                        <label>Main URL Identifier (Optional): </label>
                        <asp:TextBox ID="txtURLId" CssClass="form-control awesomplete" MaxLength="250" runat="server"></asp:TextBox>
                    </div>--%>

                    <div class="form-group">
                        <label>Date: </label>
                        <asp:TextBox ID="txtDate" CssClass="form-control awesomplete" MaxLength="200" runat="server" placeholder="-click to pick date-"></asp:TextBox>
                        <ajaxToolkit:MaskedEditExtender Mask="99/99/9999" TargetControlID="txtDate" MaskType="Date" ID="MaskedEditExtender2" runat="server"></ajaxToolkit:MaskedEditExtender>
                        <asp:RequiredFieldValidator ControlToValidate="txtDate" ID="RequiredFieldValidator7" runat="server" ErrorMessage="Please pick date." ForeColor="Red" Display="Dynamic" ValidationGroup="add"></asp:RequiredFieldValidator>
                    </div>

                    <%--<div class="form-group">
                        <label>Main Image: </label>
                        <asp:FileUpload ID="fupImage" runat="server"></asp:FileUpload>
                        <em>*.jpg, .png or .gif files only. 5mb max<br />
                            Recommended dimensions: 1200 x 588 pixels. </em>
                        <br />
                        <asp:RequiredFieldValidator ControlToValidate="fupImage" ID="RequiredFieldValidator2" runat="server" ErrorMessage="Select image to upload." ForeColor="Red" Display="Dynamic" ValidationGroup="add"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ControlToValidate="fupImage" ID="RegularExpressionValidator1" runat="server" ErrorMessage=".png, .jpg or .gif files only." ForeColor="Red" Display="Dynamic" ValidationGroup="add" ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.png|.jpg|.gif)$"></asp:RegularExpressionValidator>
                    </div>--%>

                    <div class="form-group">
                        <label>Content: </label>
                        <%--<asp:TextBox ID="txtContent" TextMode="MultiLine" runat="server" Width="900" Height="500"></asp:TextBox>
                        <ajaxToolkit:HtmlEditorExtender TargetControlID="txtContent" runat="server" EnableSanitization="false"></ajaxToolkit:HtmlEditorExtender>--%>
                        <CKEditor:CKEditorControl ID="txtContent" BasePath="/ckeditor/" runat="server"></CKEditor:CKEditorControl>
                        <asp:RequiredFieldValidator ControlToValidate="txtContent" ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter content." ForeColor="Red" Display="Dynamic" ValidationGroup="add"></asp:RequiredFieldValidator>
                    </div>

                    <div class="form-group">
                        <label>Categories: </label>
                        <asp:CheckBoxList RepeatDirection="Horizontal" CssClass="cb" ID="cbxCategories" runat="server" DataSourceID="sqlDSCategories" DataTextField="category" DataValueField="categoryId">
                        </asp:CheckBoxList>
                        <asp:SqlDataSource ID="sqlDSCategories" runat="server" ConnectionString="<%$ ConnectionStrings:conn %>" SelectCommand="SELECT * FROM [Categories] ORDER BY [category]"></asp:SqlDataSource>
                    </div>

                    <br />

                    <div class="form-group">
                        <asp:Button ID="btnAddEntry" runat="server" Text="Add Blog Entry"
                            CssClass="btn btn-primary" ValidationGroup="add" OnClick="btnAddEntry_Click" />
                    </div>

                    <ajaxToolkit:ConfirmButtonExtender TargetControlID="btnAddEntry" ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are you sure you want to add this entry?">
                    </ajaxToolkit:ConfirmButtonExtender>

                </div>

            </section>
            <!-- /.content -->
        </aside>
        <!-- /.right-side -->
    </div>
    <!-- ./wrapper -->
</asp:Content>
