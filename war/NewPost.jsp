<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.google.appengine.api.users.User" %>

<%@ page import="com.google.appengine.api.users.UserService" %>

<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
   <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
 </head>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Create New Post</title>
</head>
<body>

<%
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	pageContext.setAttribute("user", user);
%>

<ul>
  <li><a href="<%="home.jsp"%>">Home</a></li>
  <li><a href="<%="allposts.jsp"%>">All Posts</a></li>
  <li><a href="<%="NewPost.jsp"%>">New Post</a></li>
</ul>

<div class="center">
 	<h2>Write a New Post</h2>
</div>

<form action="/newpost" method="post" id="new post">
  <input type="text" name="title" placeholder="Title">
  <h6><b>by: ${fn:escapeXml(user.nickname)}</b> </h6>
  <div><textarea name="content" rows="23" cols="100" placeholder="Place Content of Post Here"></textarea></div>
  <div><input type="submit" value="Submit" name="submit" /> <input type="submit" value="Cancel" name="cancel" /></div>
  
  
</form>





</body>
</html>
