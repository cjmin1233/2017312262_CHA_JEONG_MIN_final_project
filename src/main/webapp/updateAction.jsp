<%@page import="java.io.PrintWriter"%>
<%@page import="bbs.*"%>
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
	int bbsID=0;
	if(request.getParameter("bbsID")!=null){
		// get the post ID
		bbsID=Integer.parseInt(request.getParameter("bbsID"));
	}
	if(bbsID==0){
		// post ID missing
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('This post is invalid')");
		script.println("location.href='CommunityPage.jsp'");
		script.println("</script>");
	}
	BBS bbs=new bbsDAO().getBBS(bbsID);
	if(!userID.equals(bbs.getUserID())){
		// writer ID does not match
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('You have no authority')");
		script.println("location.href='CommunityPage.jsp'");
		script.println("</script>");
	} else{
		
    	if(request.getParameter("Title")==null || request.getParameter("Content")==null || request.getParameter("Title").equals("") || request.getParameter("Content").equals("")){
    		// title or content input missing
    		PrintWriter script = response.getWriter();
    		script.println("<script>");
    		script.println("alert('Please fill the form')");
    		script.println("history.back()");
    		script.println("</script>");
    	}
    	else{
    		bbsDAO DAO=new bbsDAO();
    		int result = DAO.update(bbsID, request.getParameter("Title"), request.getParameter("Content"));
    		
    		if(result == -1){
	    		// DB error
    			PrintWriter script = response.getWriter();
	    		script.println("<script>");
	    		script.println("alert('Failed to update post')");
	    		script.println("history.back()");
	    		script.println("</script>");
    		}else{
    			// update success
    			PrintWriter script = response.getWriter();
	    		script.println("<script>");
	    		script.println("alert('Update post success')");
	    		script.println("location.href='CommunityPage.jsp'");
	    		script.println("</script>");
    		}
    		
    	}
    }
	%>
</body>
</html>