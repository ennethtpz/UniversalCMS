<%@ Page Title="" Language="C#" MasterPageFile="~/master/main.master" AutoEventWireup="true" Inherits="subpages_sample_sample3" Codebehind="sample3.aspx.cs" %>
<%@ Register TagPrefix="uc" TagName="menu" Src="~/master/sidebar.ascx" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <%--<style>
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
    </style>--%>


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
                        Sample Page 3
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="/dashboard"><i class="fa fa-home"></i>Dashboard</a></li>
                         <li class="active">Sample Page 3</li>
                    </ol>
                </section>
                <section class="content"><!-- content -->



                </section><!-- /.content -->
            </aside><!-- /.right-side -->
        </div><!-- ./wrapper -->
</asp:Content>