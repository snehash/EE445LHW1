package blog;

import java.io.IOException;
import java.util.Date;
//import java.util.logging.Logger;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;




public class NewPostBlogServlet extends HttpServlet {
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException{
		
		if(request.getParameter("new post") != null ){
			response.sendRedirect("/NewPost.jsp");
		}
		else if(request.getParameter("submit") != null){
			UserService userService = UserServiceFactory.getUserService();
			User user = userService.getCurrentUser();

			String content = request.getParameter("content"); 
			String title = request.getParameter("title");
			if(content != null && content.length() > 0){
				Post post = new Post(user, title, content);
				ObjectifyService.ofy().save().entity(post).now();
			}
			 
			
			response.sendRedirect("/home.jsp");
		}
		
		else if(request.getParameter("cancel") != null){
			
			response.sendRedirect("/home.jsp");
		}

	}
}
