
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
 	<h2>All Posts</h2>
		<img src="images/homeimage.jpg" alt="Daniel Tiger's Neighborhood" align=middle style="width:800px;height:375px;">
</div>
  <body>

<%
	ObjectifyService.register(Post.class);
	
	List<Post> posts = ObjectifyService.ofy().load().type(Post.class).list(); 
	  

	Collections.sort(posts); 
	
    
    if (posts.isEmpty()) {

        %>

        <p>There are no posts in this Blog.</p>

        <%

    } else {

        

        for (Post post : posts) {
            pageContext.setAttribute("post_content",post.getContent());
			pageContext.setAttribute("post_user", post.getUser());
			pageContext.setAttribute("post_date", post.getDate());
			pageContext.setAttribute("post_title", post.getTitle());
		%>
				<h2><b>${fn:escapeXml(post_title)}</b></h2>
                <b>by:${fn:escapeXml(post_user.nickname)}</b></p>
                <i>${fn:escapeXml(post_date)}</i>
               	<blockquote>${fn:escapeXml(post_content)}</blockquote>
                
				
        <%
	}
     

}

%>


  </body>

</html>

 