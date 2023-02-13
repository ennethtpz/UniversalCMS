<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Gallery.aspx.cs" Inherits="Admin.mobile_gallery.Gallery" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
    <meta name='viewport' content='width=device-width, initial-scale=1' />
    <meta name='apple-mobile-web-app-capable' content='yes' />
    <title>ReinerTupaz.com - Mobile Gallery</title>

    <link rel='stylesheet' href='./css/jquery.mobile-1.1.1.min.css' />
    <script src='./js/jquery-1.7.1.min.js'></script>
    <script src='./js/jquery.mobile-1.1.1.min.js'></script>
    <script src='./js/imageflip.mini.js'></script>

    <style type='text/css'>
        #iGallery {
            list-style: none;
            padding: 0px;
            margin: 0px
        }

            #iGallery li {
                list-style: none;
                padding: 2px;
                margin: 2px;
                border: 1px solid #999;
                float: left
            }
    </style>

    <link rel='stylesheet' href='./css/gallery.css' />

    <script type='text/javascript'>
        $(document).delegate('#home', 'pageinit', function () {
            $('#iGallery').imageflip()
        })
    </script>
</head>
<body>
    <div data-role='page' id='home' data-theme='c' data-title='필리핀 관광청'>
        <div data-role='header' data-theme='d' id='header'>
            <h1>
                <asp:Label ID="lblTitle" runat="server" />
            </h1>
        </div>
        <div data-role='content' id='content'>
            <div class='content-primary'>
                <ul id='iGallery'>
                    <asp:Repeater ID="rptGallery" runat="server" OnItemDataBound="rptrGallery_ItemDatabound">
                        <ItemTemplate>
                            <li>
                                <asp:HyperLink ID="hprlnkLightBox" runat="server">
                                    <asp:Image ID="imgPhoto" runat="server" />
                                </asp:HyperLink>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>
