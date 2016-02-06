package blog;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;


import com.google.appengine.api.users.User;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class Post implements Comparable<Post> {
	@Id Long id;
	User author;
	String title;
	String content;
	Date date;
	private Post(){}
	public Post(User user, String content,String title){
		this.author= user;
		this.content = content;
		this.title = title;
		date = new Date();
	}
	
	public User getUser(){
		return author;
	}
	
	public String getContent(){
		return content;
	}

	public String getTitle(){
		return title;
	}
	
	public String getDate(){
		DateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm");
		return df.format(date);
	}
	@Override
	public int compareTo(Post o) {
		if(date.after(o.date)){
			return -1;
		}
		else if(date.before(o.date)){
			return 1;
		}
		return 0;
	}
	

	static {

        ObjectifyService.register(Post.class);

    }

}
