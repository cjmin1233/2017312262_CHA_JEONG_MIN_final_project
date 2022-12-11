<%@page import="java.io.PrintWriter"%>
<%@page import="user.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%-- <jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty property="user" name="userID" />
<jsp:setProperty property="user" name="userPassword" /> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>

	<%
	User user = new User();
	// get the userID and password
	String request_userID = request.getParameter("userID");   
    String request_userPassword = request.getParameter("userPassword");
    user.setUserID(request_userID);
    user.setUserPassword(request_userPassword);
    //
    String userID=null;
    if(session.getAttribute("userID")!=null){
    	// get the userID from the session
    	userID=(String)session.getAttribute("userID");
    }
    if(userID!=null){
    	// already logged in
    	PrintWriter script = response.getWriter();
    	script.println("<script>");
    	script.println("alert('You already logged in')");
    	script.println("location.href='MainPage.jsp'");
    	script.println("</script>");
    	
    }
    //
	UserDAO userDAO = new UserDAO();
	int result = userDAO.Login(user.getUserID(), user.getUserPassword());

	if (result == 1) {
		// Login succeed
		session.setAttribute("userID", user.getUserID());
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Login success')");
		script.println("location.href='MainPage.jsp'");
		script.println("</script>");
	} else if (result == 0) {
		// Wrong password
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('The password is not correct')");
		script.println("history.back()");
		script.println("</script>");
	} else if (result == -1) {
		// ID invalid
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('This ID is not exist')");
		script.println("history.back()");
		script.println("</script>");
	} else if (result == -2) {
		// Error exception
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('DB Error')");
		script.println("history.back()");
		script.println("</script>");
	}
	%>
</body>
</html>