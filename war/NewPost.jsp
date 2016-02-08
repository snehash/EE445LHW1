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

<form action="/newpost" method="post">
  Title<br>
  <input type="text" name="title"><br>
  Author: ${fn:escapeXml(user.nickname)} <br> 
  Content: <br>
  <div><textarea name="content" rows="30" cols="100"></textarea></div>
  <div><input type="submit" value="Submit" name="submit" /></div>
  <div><input type="submit" value="Cancel" name="cancel" /></div>
  
  
</form>



</body>
</html>
