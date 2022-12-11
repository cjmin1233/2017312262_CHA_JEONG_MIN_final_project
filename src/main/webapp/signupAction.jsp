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
		User user = new User();
		// get the user signup form input
		String request_userName = request.getParameter("userName");
		String request_userID = request.getParameter("userID");
		String request_userEmail = request.getParameter("userEmail");
	    String request_userPassword = request.getParameter("userPassword");
	    String request_Confirm = request.getParameter("Confirm");
	    
	    user.setUserName(request_userName);
	    user.setUserID(request_userID);
	    user.setUserEmail(request_userEmail);
	    user.setUserPassword(request_userPassword);
	    user.setUserScore(0);
	    
	    String userID=null;
	    if(session.getAttribute("userID")!=null){
	    	userID=(String)session.getAttribute("userID");
	    }
	    if(userID!=null){
	    	// user already logged in
	    	PrintWriter script = response.getWriter();
	    	script.println("<script>");
	    	script.println("alert('You already logged in')");
	    	script.println("location.href='MainPage.jsp'");
	    	script.println("</script>");
	    }
	    
		if(user.getUserName()==null || user.getUserID()==null || user.getUserEmail()==null || user.getUserPassword()==null || request_Confirm==null ||
		user.getUserName()=="" || user.getUserID()=="" || user.getUserEmail()=="" || user.getUserPassword()=="" || request_Confirm==""){
			// missing input remain
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Please fill the form')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			UserDAO userDAO = new UserDAO();
			
			int result=userDAO.SignUp(user);
			if(result==-1){
				// same user ID exist
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('The ID already exist')");
				script.println("history.back()");
				script.println("</script>");
			}
			else{
				// signup success
				session.setAttribute("userID", user.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('Signup success')");
				script.println("location.href='MainPage.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>