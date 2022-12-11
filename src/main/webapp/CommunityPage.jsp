<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="bbs.*"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
<meta charset="utf-8">
<title></title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css">
<link rel="stylesheet" href="master.css">

</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
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
		<!-- board section start -->
		<section class="board-section">
			<div class="container">
				<div class="row justify-content-center align-items-center">
					<table class="community-table">
						<thead>
							<tr>
								<th><div>Index</div></th>
								<th><div>Title</div></th>
								<th><div>Writer</div></th>
								<th><div>Date</div></th>
							</tr>
						</thead>
						<tbody>
							<%
							bbsDAO DAO = new bbsDAO();
							int totalCount = -2;
							totalCount=DAO.getCount();
							if(totalCount==-2 || totalCount==-1){
						    	PrintWriter script = response.getWriter();
						    	script.println("<script>");
						    	script.println("alert('DB Error')");
						    	script.println("</script>");
						    }
							int totalPage=1;
							totalPage=totalCount/10+1;
							
							
							ArrayList<BBS> list = DAO.getList(pageNumber);
							for (int i = 0; i < list.size(); i++) {
							%>
							<tr>
								<td class="number"><div><%=list.get(i).getID()%></div></td>
								<td class="subject"><div><a href="ViewPage.jsp?bbsID=<%=list.get(i).getID()%>"><%=list.get(i).getTitle().replaceAll(" ", "&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n", "<br>")%></a></div></td>
								<td class="writer"><div><%=list.get(i).getUserName()%></div></td>
								<td class="date"><div><%=list.get(i).getDate().substring(0, 11) + list.get(i).getDate().substring(11, 13) + "h "
		+ list.get(i).getDate().substring(14, 16) + "m"%></div></td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
					
					<!-- under table start-->
					<div class="under-community-table container">
						<div class="row justify-content-center">
							<div class="page-nav">
								<% 
									if(pageNumber>1){
								%>
								<div class="left-nav">
									<a href="CommunityPage.jsp?pageNumber=<%=pageNumber-1%>"><i class="bi bi-arrow-left-circle"></i> Prev</a>
								</div>
								<%
									}
								%>
								<div class="mid-nav row align-items-center justify-content-center">
								
									<%
										int pageNumber_1=pageNumber-2, 
											pageNumber_2=pageNumber-1,
											pageNumber_4=pageNumber+1,
											pageNumber_5=pageNumber+2;
										
										if(pageNumber_1>0 && DAO.nextPage(pageNumber_1)){
									%>
									<a href="CommunityPage.jsp?pageNumber=<%=pageNumber_1%>"><%=pageNumber_1 %></a>
									<%
										}if(pageNumber_2>0 && DAO.nextPage(pageNumber_2)){
									%>
									<a href="CommunityPage.jsp?pageNumber=<%=pageNumber_2%>"><%=pageNumber_2 %></a>
									<%
										}
									%>
									<a class="current-page"><%=pageNumber %></a>
									<%
										if(pageNumber_4>0 && DAO.nextPage(pageNumber_4)){
									%>
									<a href="CommunityPage.jsp?pageNumber=<%=pageNumber_4%>"><%=pageNumber_4 %></a>
									<%
										}if(pageNumber_5>0 && DAO.nextPage(pageNumber_5)){
									%>
									<a href="CommunityPage.jsp?pageNumber=<%=pageNumber_5%>"><%=pageNumber_5 %></a>
									<%
										}
									%>						
								</div>
								
								<%
									if (DAO.nextPage(pageNumber + 1)) {
								%>
								<div class="right-nav">
									<a href="CommunityPage.jsp?pageNumber=<%=pageNumber+1%>">Next <i class="bi bi-arrow-right-circle"></i></a>
								</div>
								<%
									}
								%>
							</div>							
						</div>
						<div class="action-nav row">
							<a href="WritePage.jsp" id="writeButton">Write</a>
						</div>
					</div>
					<!-- under table end-->
					
				</div>
			</div>
		</section>
		<!-- board section end -->
	</div>
	<!-- CommunityPage end -->

	<!-- copyright text -->
	<p class="copyright">&copy; 2022 Cha Jeong Min</p>

</body>
</html>
