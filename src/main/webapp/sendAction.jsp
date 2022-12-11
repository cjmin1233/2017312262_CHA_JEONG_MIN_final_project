<%@page import="java.io.PrintWriter"%>
<%@page import="contact.*"%>
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
		// get the contact form input
		String contactName=request.getParameter("contactName");
		String contactInfo=request.getParameter("contactInfo");
		String contactMessage=request.getParameter("contactMessage");
		
		if(contactName==null || contactInfo==null || contactMessage==null || 
				contactName=="" || contactInfo=="" || contactMessage==""){
			// missing input remain
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Please fill the form')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			ContactDAO DAO=new ContactDAO();
			int result = DAO.write(contactName, contactInfo, contactMessage);
			
			if(result == -1){
				// DB error
				PrintWriter script = response.getWriter();
	    		script.println("<script>");
	    		script.println("alert('Failed to send message')");
	    		script.println("history.back()");
	    		script.println("</script>");
			}else{
				// send success
				PrintWriter script = response.getWriter();
	    		script.println("<script>");
	    		script.println("alert('Sending success')");
	    		script.println("location.href='ContactPage.jsp'");
	    		script.println("</script>");
			}
			
		}
	%>
</body>
</html>