<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="bbs.*"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
<meta charset="utf-8">
<title></title>
<!-- <script src="JS\jquery.min.js" type="text/javascript"></script>
<script src="JS\myJS.js" type="text/javascript"></script> -->
<link rel="stylesheet" href="master.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css">
</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		// get user ID
		userID = (String) session.getAttribute("userID");
	}

	int bbsID = 0;
	if (request.getParameter("bbsID") != null) {
		// get post ID
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
	%>
	<!-- register section start -->
	<section class="register-section">
		<div class="container">
			<div class="row">
				<%
				if (userID == null) {
				%>
				<nav>
					<ul>
						<li><a href="SignupPage.jsp" class="register-signup">SignUp</a></li>
						<li><a href="LoginPage.jsp">Login</a></li>
					</ul>
				</nav>
				<%
				} else {	/* show logout button if user logged in */
				%>
				<nav class="nav_Login">
					<ul>
						<li><a href="logoutAction.jsp">Logout</a></li>
					</ul>
				</nav>
				<%
				}
				%>
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
					<a href="ContactPage.jsp" class="row justify-content-center align-items-center"> Contact</a>
				</nav>
			</div>
		</div>
	</header>
	<!-- header end -->

	<!-- CommunityPage start -->
	<div class="CommunityPage">
		<!-- view section start -->
		<section class="view-section">
			<div class="container">
				<div class="view-title-header row">
					<div class="title-box">
						<span><%=bbs.getTitle().replaceAll(" ", "&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n", "<br>")%></span>
					</div>
				</div>
				<div class="view-info-header row align-items-center">
					<div class="userName-box">
						<span><%=bbs.getUserName()%></span>
					</div>
					<i class="bi bi-dot"></i>
					<div class="date-box">
						<span><%=bbs.getDate().substring(0, 11) + bbs.getDate().substring(11, 13) + "h " + bbs.getDate().substring(14, 16) + "m"%></span>
					</div>
				</div>
				<div class="view-content row justify-content-center">
					<div class="content-box">
						<span><%=bbs.getContent().replaceAll(" ", "&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n", "<br>")%></span>
					</div>
				</div>
				
				<div class="control-box row align-items-center">
					<a href="CommunityPage.jsp" class="listButton">List</a>
						<%
						// show the update and delete button if the user is writer
						if (userID != null && userID.equals(bbs.getUserID())) {
						%>
					<a href="UpdatePage.jsp?bbsID=<%=bbsID%>">Update</a> 
					<a href="deleteAction.jsp?bbsID=<%=bbsID%>" onclick="return confirm('Are you sure to delete?')">Delete</a>
						<%
						}
						%>
				</div>
			</div>
		</section>
		<!-- view section end -->
	</div>
	<!-- CommunityPage end -->

	<div class="container">
		<!-- copyright text -->
		<p class="copyright">&copy; 2022 Cha Jeong Min</p>		
	</div>

</body>
</html>
