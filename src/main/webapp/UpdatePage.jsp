<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="bbs.*"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
<meta charset="utf-8">
<title></title>
<script src="JS\jquery.min.js" type="text/javascript"></script>
<script src="JS\pageControl.js" type="text/javascript"></script>
<link rel="stylesheet" href="master.css">

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
	int bbsID = 0;
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if (bbsID == 0) {
		// post ID missing
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('This post is invalid')");
		script.println("location.href='CommunityPage.jsp'");
		script.println("</script>");
	}
	BBS bbs = new bbsDAO().getBBS(bbsID);
	if (!userID.equals(bbs.getUserID())) {
		// writer ID does not match
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('You have no authority')");
		script.println("location.href='CommunityPage.jsp'");
		script.println("</script>");
	}
	%>
	<!-- register section start -->
	<section class="register-section">
		<div class="container">
			<div class="row">
				<nav class="nav_Login">
					<ul>
						<li><a href="logoutAction.jsp">Logout</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</section>
	<!-- register section end -->
	
	<!-- header start -->
	<header class="header">
		<div class="container">
			<div class="row align-items-center justify-content-between">
				<div class="brand-name">
					<a href="MainPage.jsp">CJM</a>
				</div>
				<nav class="nav">
					<a href="MainPage.jsp" class="row justify-content-center align-items-center">Home</a> 
					<a href="RankingPage.jsp" class="row justify-content-center align-items-center"> Ranking</a>
					<a href="CommunityPage.jsp" class="row justify-content-center align-items-center">Community</a>
					<a href="ContactPage.jsp" class="row justify-content-center align-items-center">Contact</a>
				</nav>
			</div>
		</div>
	</header>
	<!-- header end -->

	<!-- CommunityPage start -->
	<div class="CommunityPage">
		<!-- update section start -->
		<section class="update-section">
			<div class="container">
				<div class="row justify-content-center">
					<form class="update-form" action="updateAction.jsp?bbsID=<%=bbsID%>" method="post">
						<div class="update-form-title">
							<input type="text" class="post-title" id="updateTitle" name="Title" value="<%=bbs.getTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>")%>" placeholder="Title"> 							
						</div>
						<div class="update-form-content">
							<textarea rows="" cols="" class="post-content" id="updateContent" name="Content" placeholder="Content"><%=bbs.getContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>")%></textarea>
 						</div>
 						<div class="update-form-contentCounter row align-items-center">
 							<p id="updateContentCounter" class="post-counter">Content : <%=bbs.getContent().length() %> / 2048</p>
 						</div>
 						<input hidden="hidden" type="text">
 						<div class="button">
							<input type="submit" name="" value="Update"> 							
 						</div>
					</form>
				</div>
			</div>
		</section>
		<!-- update section end -->
	</div>
	<!-- CommunityPage end -->

	<div class="container">
		<!-- copyright text -->
		<p class="copyright">&copy; 2022 Cha Jeong Min</p>		
	</div>

</body>
</html>
