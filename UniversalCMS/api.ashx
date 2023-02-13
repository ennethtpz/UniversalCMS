<%@ WebHandler Language="C#" Class="api" %>

using System;
using System.Web;

public class api : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {

        context.Response.ContentType = "application/json";
        Newtonsoft.Json.JsonSerializer serializer = new Newtonsoft.Json.JsonSerializer();
        try
        {
            
            string function = context.Request.QueryString["func"].Trim().ToLower();
            
            if (function == "getuser")
            {
                string username = context.Request.QueryString["username"].Trim().ToLower();
                if (username != null || username != "")
                {
                    Objects.User user = Functions.UserManagement.GetUser(username);
                    if (user != null)
                    {
                        var jsonObj = Newtonsoft.Json.JsonConvert.SerializeObject(user);
                        context.Response.Write(jsonObj);
                    }
                    else
                    {
                        context.Response.Write(createErrorJson(0003, "Username is invalid."));
                    }
                }
                else
                {
                    context.Response.Write(createErrorJson(0002, "No username supplied."));
                }
            }
            else if (function == "getarticles")
            {
                var jsonObj = Newtonsoft.Json.JsonConvert.SerializeObject(RST.Website.Functions.ArticleManagement.GetArticlesForAPI("https://www.reinertupaz.com/images/default_article_pic.jpg", "https://www.reinertupaz.com/images/for%20icon.png"));
                context.Response.Write(jsonObj);
            }
        }
        catch (Exception ex)
        {
            context.Response.Write(createErrorJson(0001, ex.Message));
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
    
    private string createErrorJson(int code, string message)
    {
        Error error = new Error();
        error.code = code;
        error.message = message;
        return Newtonsoft.Json.JsonConvert.SerializeObject(error);
    }
    
    class Error
    {
        public int code { get; set; }
        public string message { get; set; }
    }

}