<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="user.*"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
<meta charset="utf-8">
<title></title>
<link rel="stylesheet" href="master.css">

</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		// get the user ID if the user logged in
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
				} else {	/* if user logged in, show the logout button */
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
		<!-- ranking-section start -->
		<section class="ranking-section">
			<div class="container row justify-content-center align-items-center">
				<div class="ranking-title">
					<h1>Ranking</h1>
				</div>
				<div class="ranking-box row justify-content-center align-items-center">
					<div class="ranking-header row justify-content-between align-items-center">
						<div></div>
						<div>userID</div>
						<div>score</div>
					</div>
					<%
					UserDAO userDAO = new UserDAO();
					ArrayList<User> list = userDAO.getRanking();
					int maxlength=20;
					if(list.size()<maxlength)maxlength=list.size();
					
					// show the top 20 on the ranking chart.
					for (int i = 0; i < maxlength; i++) {
					%>
					<div class="ranking-chart row justify-content-between">
						<div class="row align-items-center">
							<div class="rank-num row justify-content-center align-items-center">
								<%
									if(i>=0&&i<=2){
								%>
								<img alt="rankImage" src="img/big_<%=i+1%>.png" class="rankNumber">
								<%
									}else{
								%>
								<span class="rankNumber"><%=i+1%></span>
								<%
									}
								%>
							</div>
							<span class="rankName"><%=list.get(i).getUserName()%></span>
						</div>
						<div class="rank-score row justify-content-center align-items-center">
							<span><%=list.get(i).getUserScore() %></span>
						</div>
					</div>
					<%
					}
					%>
				</div>
			</div>
		</section>
		<!-- ranking-section end -->

	</div>
	<!-- MainPage end -->

	<div class="container">
		<!-- copyright text -->
		<p class="copyright">&copy; 2022 Cha Jeong Min</p>		
	</div>

</body>
</html>
