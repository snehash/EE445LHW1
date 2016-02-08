
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

  <body>



<%

    


   
    UserService userService = UserServiceFactory.getUserService();

    User user = userService.getCurrentUser();

    if (user != null) {

      pageContext.setAttribute("user", user);

%>


	<!-- <p>Hello, ${fn:escapeXml(user.nickname)}! </p> -->
	
	<ul>
	  <li><a href="<%="home.jsp"%>">Home</a></li>
	  <li><a href="<%="allposts.jsp"%>">All Posts</a></li>
	  <li><a href="<%="NewPost.jsp"%>">New Post</a></li>
	  <li><a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">Sign Out</a></li>
	</ul>

<%

    } else {

%>

	<!-- <p>Hello! Sign in to make a new post.</p> -->
	
	<ul>
	  <li><a href="<%="home.jsp"%>">Home</a></li>
	  <li><a href="<%="allposts.jsp"%>">All Posts</a></li>
	  <li><a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign In</a></li>
	</ul>

     
<%

    }

%>
 
 	<div class="center">
 	<h2>Welcome to a blog about all things Daniel Tiger.</h2>
		<img src="images/homeimage.jpg" alt="Daniel Tiger's Neighborhood" align=middle style="width:320px;height:150px;">
	</div>
 

<%


	ObjectifyService.register(Post.class);
	
	List<Post> posts = ObjectifyService.ofy().load().type(Post.class).list(); 
	  

	Collections.sort(posts); 
	posts = posts.subList(0, 3 > posts.size() ? posts.size() : 3);

	
    
    if (posts.isEmpty()) {

        %>

        <p>There are no posts in this Blog.</p>

        <%

    } else {

        %>

        <p>Posts</p>

        <%
        

        for (Post post : posts) {
            pageContext.setAttribute("post_content",post.getContent());
			pageContext.setAttribute("post_user", post.getUser());
			pageContext.setAttribute("post_date", post.getDate());
			pageContext.setAttribute("post_title", post.getTitle());
		%>
				<div class="post">
					<h2><b>${fn:escapeXml(post_title)}</b></h2>
	                <p><b>by:${fn:escapeXml(post_user.nickname)}</b> <i>${fn:escapeXml(post_date)}</i> </p>
	               	<blockquote>${fn:escapeXml(post_content)}</blockquote>
                </div>
				
        <%
	}
     

}

%>


  </body>

</html>

 