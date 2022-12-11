<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="bbs.*"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
<meta charset="utf-8">
<title></title>
<link rel="stylesheet" href="master.css">
<script src="JS\jquery.min.js" type="text/javascript"></script>
<script src="JS\pageControl.js" type="text/javascript"></script>

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
					<a href="ContactPage.jsp" class="row justify-content-center align-items-center"> Contact</a>
				</nav>
			</div>
		</div>
	</header>
	<!-- header end -->

	<!-- CommunityPage start -->
	<div class="CommunityPage">
		<!-- write section start -->
		<section class="write-section">
			<div class="container">
				<div class="row justify-content-center">
					<form class="write-form" action="writeAction.jsp" method="post">
						<div class="write-form-title">
							<input type="text" class="post-title" name="Title" value="" placeholder="TItle" id="writeTitle">							
						</div>
						<div class="write-form-content">
							<textarea rows="" cols="" class="post-content" placeholder="Content" id="writeContent" name="Content"></textarea>							
						</div>
						<div class="write-form-contentCounter row align-items-center">
							<p class="post-counter" id="writeContentCounter">Content : 0 / 2048</p>
						</div>
						<input hidden="hidden" type="text">
						<div class="button">
							<input type="submit" name="" value="Write">							
						</div>
					</form>
				</div>
			</div>
		</section>
		<!-- write section end -->
	</div>
	<!-- CommunityPage end -->
	
	<div class="container">
		<!-- copyright text -->
		<p class="copyright">&copy; 2022 Cha Jeong Min</p>		
	</div>

</body>
</html>
