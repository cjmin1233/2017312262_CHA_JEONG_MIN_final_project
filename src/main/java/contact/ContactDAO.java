package contact;

import java.sql.*;

public class ContactDAO {
	private Connection conn;
	
	public ContactDAO() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL database connection
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/new_schema?" + "user=root&password=root");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	public int write(String contactName, String contactInfo, String contactMessage) {
		// write the contact message info to the DB
		String sql="insert into contact_table values(?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, contactName);
			pstmt.setString(2, contactInfo);
			pstmt.setString(3, contactMessage);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// DB error
	}
}
