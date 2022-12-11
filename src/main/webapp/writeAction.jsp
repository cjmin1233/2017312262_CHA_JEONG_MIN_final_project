<%@page import="java.io.PrintWriter"%>
<%@page import="bbs.*"%>
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
		BBS bbs=new BBS();
		// get the post information
		String request_title=request.getParameter("Title");
		String request_content=request.getParameter("Content");
		
		bbs.setTitle(request_title);
		bbs.setContent(request_content);
		//
	    
	    String userID=null;
	    if(session.getAttribute("userID")!=null){
	    	// get the user ID
	    	userID=(String)session.getAttribute("userID");
	    }
	    if(userID==null){
	    	// not logged in
	    	PrintWriter script = response.getWriter();
	    	script.println("<script>");
	    	script.println("alert('Please login first')");
	    	script.println("location.href='LoginPage.jsp'");
	    	script.println("</script>");
	    }else{
	    	User user=new UserDAO().getUser(userID);
	    	if(bbs.getTitle()==null || bbs.getContent()==null || bbs.getTitle()=="" || bbs.getContent()==""){
	    		// missing input form remain
	    		PrintWriter script = response.getWriter();
	    		script.println("<script>");
	    		script.println("alert('Please fill the form')");
	    		script.println("history.back()");
	    		script.println("</script>");
	    	}
	    	else{
	    		bbsDAO DAO=new bbsDAO();
	    		int result = DAO.write(bbs.getTitle(), userID, user.getUserName(), bbs.getContent());
	    		
	    		if(result == -1){
		    		// DB error
	    			PrintWriter script = response.getWriter();
		    		script.println("<script>");
		    		script.println("alert('Failed to writing')");
		    		script.println("history.back()");
		    		script.println("</script>");
	    		}else{
	    			// write success
	    			PrintWriter script = response.getWriter();
		    		script.println("<script>");
		    		script.println("alert('Writing success')");
		    		script.println("location.href='CommunityPage.jsp'");
		    		script.println("</script>");
	    		}
	    		
	    	}
	    }		
	%>
</body>
</html>