package bbs;

import java.sql.*;
import java.util.ArrayList;

public class bbsDAO {
	private Connection conn;
	private ResultSet rs;
	
	public bbsDAO() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL database connection
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/new_schema?" + "user=root&password=root");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	public String getDate() {
		// Get current date time
		String sql="select now()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	public int getNext() {
		String sql="select ID from community_table order by ID desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;	// return next post ID
			}
			return 1;	// first post
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// DB error
	}
	
	public int write(String Title, String userID, String userName, String Content) {
		//	write new post on the DB
		String sql="insert into community_table values(?,?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, Title);
			pstmt.setString(3, userID);
			pstmt.setString(4, userName);
			pstmt.setString(5, getDate());
			pstmt.setString(6, Content);
			pstmt.setInt(7, 1);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// DB error
	}
	public ArrayList<BBS> getList(int pageNumber){
		// select 'Available' post from the table according to the pageNumber
		String sql = "select * from community_table where Available = 1 order by ID desc limit ?, 10";
		ArrayList<BBS> list=new ArrayList<BBS>();
		
		// if page number is 2, list will be 10th data~19th data.
		int min_Count= (pageNumber-1)*10;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, min_Count);
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				BBS bbs=new BBS();
				bbs.setID(rs.getInt(1));
				bbs.setTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setUserName(rs.getString(4));
				bbs.setDate(rs.getString(5));
				bbs.setContent(rs.getString(6));
				bbs.setAvailable(rs.getInt(7));
				list.add(bbs);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;	// return the page list
	}
	public int getCount() {
		// get all available post count
		String sql="select count(*) from community_table where Available = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);	// return the count
			}
		}catch(Exception e) {
			e.printStackTrace();
		}	
		return -1;	// DB error
	}
	public boolean nextPage(int pageNumber) {
		// check from the DB whether the next page exist or not.
		// if next page exist, return true.
		String sql = "select * from community_table where Available = 1 order by ID desc limit ?, 10";
		
		int min_Count= (pageNumber-1)*10;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, min_Count);
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return true;	// next page available
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;	// there's no next page
	}
	public BBS getBBS(int ID) {
		// get the correspond ID's post
		String sql = "select * from community_table where ID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				BBS bbs=new BBS();
				bbs.setID(rs.getInt(1));
				bbs.setTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setUserName(rs.getString(4));
				bbs.setDate(rs.getString(5));
				bbs.setContent(rs.getString(6));
				bbs.setAvailable(rs.getInt(7));
				return bbs;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;	// no post
	}
	public int update(int ID, String Title, String Content) {
		// update the post
		String sql="update community_table set Title=?, Content=? where ID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, Title);
			pstmt.setString(2, Content);
			pstmt.setInt(3, ID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// DB error
	}
	public int delete(int ID) {
		//	delete the post
		String sql="update community_table set Available=0 where ID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);			
			pstmt.setInt(1, ID);
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;	// DB error
	}
}
