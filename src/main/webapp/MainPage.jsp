<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="bbs.*"%>
<%@page import="user.*"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
<meta charset="utf-8">
<title></title>
<script src="JS\jquery.min.js" type="text/javascript"></script>
<script src="JS\myJS.js" type="text/javascript"></script>
<link rel="stylesheet" href="master.css">

</head>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	int userScore=0;
	if(userID!=null){
		// if user logged in, get the user score
		User user=new UserDAO().getUser(userID);
		userScore=user.getUserScore();
	}
	%>
	<!-- this section does not show on the web page, just score and image container -->
	<span id="topScore" class="hidden"><%=userScore%></span>
	<div class="enemy_container hidden">
		<img alt="golem0" src="img/enemy/golem_0.png" class="golemImage">
		<img alt="golem1" src="img/enemy/golem_1.png" class="golemImage">
		<img alt="golem2" src="img/enemy/golem_2.png" class="golemImage">
		<img alt="golem3" src="img/enemy/golem_3.png" class="golemImage">
		
		<img alt="slime0" src="img/enemy/slime_0.png" id="slimeImage0" class="slimeImage">
		<img alt="slime1" src="img/enemy/slime_1.png" id="slimeImage1" class="slimeImage">
		<img alt="slime2" src="img/enemy/slime_2.png" id="slimeImage2" class="slimeImage">
		<img alt="slime3" src="img/enemy/slime_3.png" id="slimeImage3" class="slimeImage">
		
		<img alt="bat0" src="img/enemy/bat_0.png" id="batImage0" class="batImage">
		<img alt="bat1" src="img/enemy/bat_1.png" id="batImage1" class="batImage">
		<img alt="bat2" src="img/enemy/bat_2.png" id="batImage2" class="batImage">
		<img alt="bat3" src="img/enemy/bat_3.png" id="batImage3" class="batImage">
	</div>
	<img alt="background" src="img/background.png" id="backgroundImage" class="hidden">
	<img alt="player1" src="img/pikachu-running-1.png" id="playerImage1" class="playerImage hidden">
	<img alt="player2" src="img/pikachu-running-2.png" id="playerImage2" class="playerImage hidden">
	<img alt="player3" src="img/pikachu-running-3.png" id="playerImage3" class="playerImage hidden">
	<img alt="player4" src="img/pikachu-running-4.png" id="playerImage4" class="playerImage hidden">
	
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
				} else { /* if user logged in, show the logout button */
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
	<!-- MainPage start -->
	<div class="MainPage">
		<!-- canvas section start -->
		<section class="canvas-section">
			<div class="container">
				<div class="row align-items-center justify-content-center">
					<div class="canvas-box">
						<canvas id="canvas"></canvas>
					</div>
				</div>
			</div>
		</section>
		<!-- canvas section end -->
		<!-- result section start -->
		<section class="result-section">
			<div class="container">
				<div class="row justify-content-center align-items-center">
					<div class="result-content row align-items-center">
						<div class="result-title">
							<h1>Result</h1>
						</div>
						<div class="result-score row align-items-center">
							<span id="current-score">Score: 1000</span>
							<span id="highest-score">Highest score: 2000</span>
						</div>
						<div class="update-score-box">
							<a href="#" id="updateScoreButton" class="btn">Update your score!</a>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- result section end -->
		<!-- sub section start -->
		<section class="sub-section">
			<div class="container">
				<div class="row justify-content-between">
					<!-- sub ranking content -->
					<div class="sub-box">
						<div class="sub-box-title">
							<span>TOP 10 Best Ranking</span>
						</div>
						<div class="underLine"></div>
						<%
							UserDAO userDAO=new UserDAO();
							ArrayList<User> list=userDAO.getRanking();
							
							int maxLength=10;
							if(list.size()<maxLength)maxLength=list.size();
							
							// show the top 10 ranking on the left sub box
							for (int i = 0; i < maxLength; i++) {
							%>
							<div class="sub-ranking-chart row justify-content-between">
								<div class="row align-items-center">
									<div class="rank-num row justify-content-center align-items-center">
										<%
											if(i>=0&&i<=2){	// 1st~3rd: special ranking image
										%>
										<img alt="rankImage" src="img/<%=i+1%>.png" class="rankNumber">
										<%
											}else{
										%>
										<span class="rankNumber"><%=i+1%></span>
										<%
											}
										%>
									</div>
									<span class="rankName"><%=list.get(i).getUserName() %></span>				
								</div>
								<div class="rank-score row justify-content-center align-items-center">
									<span><%=list.get(i).getUserScore() %></span>
								</div>
							</div>
							<%
							}
							%>
					</div>
					<!-- sub community content -->
					<div class="sub-box">
						<div class="sub-box-title">
							<span>Community</span>
						</div>
						<div class="underLine"></div>
						<%
							bbsDAO DAO = new bbsDAO();
							ArrayList<BBS> bbsList = DAO.getList(1);
							maxLength=10;
							if(bbsList.size()<maxLength)maxLength=bbsList.size();
							
							// show the 10 recent post on the right sub box, from the community DB table
							for (int i = 0; i < maxLength; i++) {
						%>
						<div class="sub-community-recent row">
							<div class="recent-title row align-items-center">
								<a href="ViewPage.jsp?bbsID=<%=bbsList.get(i).getID()%>"><%=bbsList.get(i).getTitle().replaceAll(" ", "&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n", "<br>")%></a>															
							</div>
						</div>
						<%
						}
						%>
					</div>
				</div>
			</div>
		</section>
		<!-- sub section end -->
	</div>
	<!-- MainPage end -->

	<div class="container">
		<!-- copyright text -->
		<p class="copyright">&copy; 2022 Cha Jeong Min</p>		
	</div>

</body>
</html>
