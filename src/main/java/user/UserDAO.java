package user;

import java.sql.*;
import java.util.ArrayList;

//import bbs.BBS;
public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL database connection
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/new_schema?" + "user=root&password=root");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	public int Login(String userID, String userPassword) {
		//	find correspond userID
		String sql="Select userPassword from user_table where userID=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				//	check the password is correct
				if(rs.getString(1).equals(userPassword))return 1;	// login succeed
				else return 0;	// wrong password
			}
			return -1;	// ID invalid
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return -2;	// Error exception
	}
	public int SignUp(User user) {
		//	register new user
		String sql="insert into user_table values(?,?,?,?,?)";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserName());
			pstmt.setString(2, user.getUserEmail());
			pstmt.setString(3, user.getUserID());
			pstmt.setString(4, user.getUserPassword());
			pstmt.setInt(5, user.getUserScore());
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	// DB error
	}
	public ArrayList<User> getRanking(){
		//	get the ranking list order by userScore
		String sql = "select * from user_table order by userScore desc";
		
		ArrayList<User> list=new ArrayList<User>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				User user=new User();
				user.setUserName(rs.getString(1));
				user.setUserEmail(rs.getString(2));
				user.setUserID(rs.getString(3));
				user.setUserPassword(rs.getString(4));
				user.setUserScore(rs.getInt(5));
				
				list.add(user);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;	//	return ranking list
	}
	public User getUser(String userID) {
		//	find the user match with the userID
		String sql = "select * from user_table where userID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				User user=new User();
				user.setUserName(rs.getString(1));
				user.setUserEmail(rs.getString(2));
				user.setUserID(rs.getString(3));
				user.setUserPassword(rs.getString(4));
				user.setUserScore(rs.getInt(5));
				return user;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;	//	invalid user
	}
	public int updateScore(String userID, int userScore) {
		//	update the user score
		String sql="update user_table set userScore=? where userID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userScore);
			pstmt.setString(2, userID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// DB error
	}

}
