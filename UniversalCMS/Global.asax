<%@ Application Language="C#" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e) 
    {
        // Code that runs on application startup
        RegisterRoute(System.Web.Routing.RouteTable.Routes);
    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e) 
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e) 
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }

    protected static void RegisterRoute(System.Web.Routing.RouteCollection routeCollection)
    {
        //homepages
        routeCollection.MapPageRoute("login page", "login", "~/Default.aspx");
        routeCollection.MapPageRoute("home page", "home", "~/Default.aspx");
        routeCollection.MapPageRoute("dashboard page", "dashboard", "~/subpages/Default.aspx");

        routeCollection.MapPageRoute("change pass", "changepassword", "~/subpages/admin/changepass.aspx");
        routeCollection.MapPageRoute("manageusers", "manageusers", "~/subpages/admin/manageusers.aspx");
        routeCollection.MapPageRoute("manageusertypes", "manageusertypes", "~/subpages/admin/manageusertypes.aspx");
        routeCollection.MapPageRoute("managepageaccess", "managepageaccess", "~/subpages/admin/managepageaccess.aspx");

        routeCollection.MapPageRoute("sample page 1", "sample1", "~/subpages/sample/sample1.aspx");
        routeCollection.MapPageRoute("sample page 2", "sample2", "~/subpages/sample/sample2.aspx");
        routeCollection.MapPageRoute("sample page 3", "sample3", "~/subpages/sample/sample3.aspx");

        routeCollection.MapPageRoute("add blog", "addentry", "~/subpages/blog/AddEntry.aspx");
        routeCollection.MapPageRoute("manage blog", "manageblogs", "~/subpages/blog/ManageEntries.aspx");
        routeCollection.MapPageRoute("edit post", "viewentry/{id}", "~/subpages/blog/ViewEntry.aspx");

        routeCollection.MapPageRoute("manage categories", "managecategories", "~/subpages/blog/ManageCategories.aspx");
        routeCollection.MapPageRoute("manage entries by category", "managecategoryentries", "~/subpages/blog/ManageEntriesByCategory.aspx");
    }
      
</script>
