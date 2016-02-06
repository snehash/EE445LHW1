
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>

<%@ page import="com.google.appengine.api.users.User" %>

<%@ page import="com.google.appengine.api.users.UserService" %>

<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="com.googlecode.objectify.*" %>

<%@ page import="blog.Post" %>

<%@ page import="java.util.Collections" %>


<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

 

<html>

  <head>
   <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
 </head>
<div class="center">
 	<h2>Welcome to a blog about all things Daniel Tiger.</h2>
		<img src="images/homeimage.jpg" alt="Daniel Tiger's Neighborhood" align=middle style="width:800px;height:375px;">
</div>
  <body>

 

<%

    


   
    UserService userService = UserServiceFactory.getUserService();

    User user = userService.getCurrentUser();

    if (user != null) {

      pageContext.setAttribute("user", user);

%>

<p>Hello, ${fn:escapeXml(user.nickname)}! (You can

<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>

<%

    } else {

%>

<p>Hello!

<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>

to make a new post.</p>

<%

    }

%>

 

<%

    //DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

    //Key guestbookKey = KeyFactory.createKey("Guestbook", guestbookName);

    // Run an ancestor query to ensure we see the most up-to-date

    // view of the Greetings belonging to the selected Guestbook.

    //Query query = new Query("Greeting", guestbookKey).addSort("date", Query.SortDirection.DESCENDING);

    //List<Entity> greetings = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5));

	ObjectifyService.register(Post.class);
	
	List<Post> greetings = ObjectifyService.ofy().load().type(Post.class).list(); 
	  

	Collections.sort(greetings); 
	
    
    if (greetings.isEmpty()) {

        %>

        <p>There are no posts in this Blog.</p>

        <%

    } else {

        %>

        <p>Posts in blog.</p>

        <%
        

        for (Post greeting : greetings) {
            pageContext.setAttribute("greeting_content",

                                     greeting.getContent());

            if (greeting.getUser() == null) {

                %>

                <p>An anonymous person wrote:</p>

                <%

            } else {

                pageContext.setAttribute("greeting_user",

                                         greeting.getUser());

                %>

                <p><b>${fn:escapeXml(greeting_user.nickname)}</b> wrote:</p>

                <%

            }

            %>

            <blockquote>${fn:escapeXml(greeting_content)}</blockquote>

            <%

        }

    }

%>

 
 

  </body>

</html>

 