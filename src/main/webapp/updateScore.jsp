<%@page import="java.io.PrintWriter"%>
<%@page import="user.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>

	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		// get user ID
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null) {
		// not logged in
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Please login first')");
		script.println("location.href='LoginPage.jsp'");
		script.println("</script>");
	}
	int userScore = 0;
	if (request.getParameter("userScore") != null) {
		// get user score
		userScore = Integer.parseInt(request.getParameter("userScore"));
	}

	if (userScore == 0) {
		// user score missing
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Invalid information')");
		script.println("location.href='MainPage.jsp'");
		script.println("</script>");
	}
	UserDAO DAO = new UserDAO();
	int result = DAO.updateScore(userID, userScore);

	if (result == -1) {
		// DB error
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Failed to update score')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		// update success
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Update score success')");
		script.println("location.href='MainPage.jsp'");
		script.println("</script>");
	}
	%>
</body>
</html>