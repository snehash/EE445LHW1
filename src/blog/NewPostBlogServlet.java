package blog;

import java.io.IOException;
import java.util.Collections;
import java.util.Date;
import java.util.logging.Logger;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;




public class NewPostBlogServlet extends HttpServlet {
	private static final Logger log = Logger.getLogger(NewPostBlogServlet.class.getName());
	private static Post lastdeleted = null;
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException{
		
		if(request.getParameter("new post") != null ){
			response.sendRedirect("/NewPost.jsp");
		}
		else if(request.getParameter("submit") != null){
			UserService userService = UserServiceFactory.getUserService();
			User user = userService.getCurrentUser();

			String content = request.getParameter("content"); 
			String title = request.getParameter("title");
			if(title == null || title.length() == 0){
				title = "Untitled";
			}
			if(content == null || content.length() == 0){
				content = "Blank Post";
			}
			
			Post post = new Post(user, content, title);
			ObjectifyService.ofy().save().entity(post).now();
			response.sendRedirect("/home.jsp");
		}
		
		else if(request.getParameter("cancel") != null){
			
			response.sendRedirect("/home.jsp");
		}
		else if(request.getParameter("delete") != null){
			UserService userService = UserServiceFactory.getUserService();
			User user = userService.getCurrentUser();
			String id = request.getParameter("post_no");
			int post_no = Integer.parseInt(id);
			log.info(id);	
		
			List<Post> posts = ObjectifyService.ofy().load().type(Post.class).list(); 
			Collections.sort(posts);
			if(post_no < posts.size()){
				if(posts.get(post_no) != lastdeleted){
					lastdeleted = posts.get(post_no);
					ObjectifyService.ofy().delete().entity(posts.get(post_no)).now(); 
					
				}
			}
			response.sendRedirect("/allposts.jsp");	
			
			
		}


	}
}
