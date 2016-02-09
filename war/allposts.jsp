
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
			
			<div class="center">
		 	<h2>All Posts</h2>
			</div>
			<% 
			ObjectifyService.register(Post.class);
			
			List<Post> posts = ObjectifyService.ofy().load().type(Post.class).list(); 
			  
		
			Collections.sort(posts); 
	   
	        for (Post post : posts) {
	            pageContext.setAttribute("post_content",post.getContent());
				pageContext.setAttribute("post_user", post.getUser());
				pageContext.setAttribute("post_date", post.getDate());
				pageContext.setAttribute("post_title", post.getTitle());
				//pageContext.setAttribute("post_no", Integer.toString(posts.indexOf(post)));
	        
					
			%>
				
				<form action="/newpost" method="post" id="post">
						<div class="post">
							<h2 name="post_title"><b>${fn:escapeXml(post_title)}</b></h2>
			                <p name="post_user"><b>by:${fn:escapeXml(post_user.nickname)}</b> <i>${fn:escapeXml(post_date)}</i> </p>
			               	<blockquote name="post_content">${fn:escapeXml(post_content)}</blockquote>
				 			<input type="submit" value="Delete Post" name="delete" id="del" /> 
				 			<!-- <input type="submit" value="Edit Post" name="edit"  id="del"/> -->
				 			<input type="hidden" name="post_no" id="post_no" value="<%=posts.indexOf(post)%>" />
				 			
		                </div>
		        	</form>
						
		        <%
	        }
		}
     



    else {

%>

	<!-- <p>Hello! Sign in to make a new post.</p> -->
	
	<ul>
	  <li><a href="<%="home.jsp"%>">Home</a></li>
	  <li><a href="<%="allposts.jsp"%>">All Posts</a></li>
	  <li><a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign In</a></li>
	</ul>
	
	 <div class="center">
 	<h2>All Posts</h2>
	</div>
	
	<% 
	ObjectifyService.register(Post.class);
	
	List<Post> posts = ObjectifyService.ofy().load().type(Post.class).list(); 
	  

	Collections.sort(posts); 
   
        
        for (Post post : posts) {
            pageContext.setAttribute("post_content",post.getContent());
			pageContext.setAttribute("post_user", post.getUser());
			pageContext.setAttribute("post_date", post.getDate());
			pageContext.setAttribute("post_title", post.getTitle());
			//pageContext.setAttribute("post_no", Integer.toString(posts.indexOf(post)));
			
		%>
		
		<form action="/newpost" method="post" id="post">
				<div class="post">
					<h2 name="post_title"><b>${fn:escapeXml(post_title)}</b></h2>
	                <p name="post_user"><b>by:${fn:escapeXml(post_user.nickname)}</b> <i>${fn:escapeXml(post_date)}</i> </p>
	               	<blockquote name="post_content">${fn:escapeXml(post_content)}</blockquote>
		 			<!-- <input type="submit" value="Delete Post" name="delete" id="del" /> -->
		 			<!-- <input type="submit" value="Edit Post" name="edit"  id="del"/> -->
		 			<input type="hidden" name="post_no" id="post_no" value="<%=posts.indexOf(post)%>" />
		 			
                </div>
        	</form>
				
        <%
	}
     

}


    

%>

 




	


  </body>

</html>