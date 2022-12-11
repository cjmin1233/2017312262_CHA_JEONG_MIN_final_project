<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="user.*"%>
<%@page import="java.util.ArrayList"%>
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
		userID = (String) session.getAttribute("userID");
	}
	%>

	<!-- register section start -->
	<section class="register-section">
		<div class="container">
			<div class="row align-items-center">
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
				} else {
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
					<a href="RankingPage.jsp" class="row justify-content-center align-items-center">Ranking</a> 
					<a href="CommunityPage.jsp" class="row justify-content-center align-items-center">Community</a>
					<a href="ContactPage.jsp" class="row justify-content-center align-items-center">Contact</a>
				</nav>
			</div>
		</div>
	</header>
	<!-- header end -->
	<!-- MainPage start -->
	<div class="MainPage">
		<!-- contact-section start -->
		<section class="contact-section">
			<div class="container">
				<div class="row justify-content-center">
					<div class="contact-title">
						<h1>Contact Me</h1>
					</div>
				</div>
				<div class="row justify-content-center">
					<form class="contact-form" action="sendAction.jsp">
						<div class="row">
							<div class="left input-group">
								<label for="contactName">Name</label>
								<input type="text" id="contactName" name="contactName" placeholder="Your Name Here" class="input-control">
							</div>
							<div class="right input-group">
								<label for="contactInfo">Email or Phone</label>
								<input type="text" id="contactInfo" name="contactInfo" placeholder="Your Email or Phone Here" class="input-control">
							</div>
						</div>
						<div class="row">
							<div class="input-group">
								<label for="contactMessage">Message</label>
								<textarea id="contactMessage" name="contactMessage" placeholder="Your Message Here" class="input-control"></textarea>
							</div>
						</div>
						<div class="form-btn">
							<button type="button" class="btn" name="button" id="SendButton">Send Message</button>
						</div>
					</form>
				</div>
			</div>
		</section>
		<!-- contact-section end -->
	</div>
	<!-- MainPage end -->

	<!-- copyright text -->
	<p class="copyright">&copy; 2022 Cha Jeong Min</p>

</body>
</html>
