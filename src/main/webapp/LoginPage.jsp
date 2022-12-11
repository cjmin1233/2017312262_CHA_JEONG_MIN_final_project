<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title></title>
    <script src="JS\jquery.min.js" type="text/javascript"></script>
	<script src="JS\pageControl.js" type="text/javascript"></script>
    
    <link rel="stylesheet" href="master.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css">
  </head>
  <body>
    <!-- signup section start -->
    <section class="SignPage">
      <div class="container row justify-content-center">
        <div class="row justify-content-center align-items-center">
          <div class="brand-name">
			<a href="MainPage.jsp">CJM</a>
		  </div>
          <!-- signup title -->
          <div class="sign-title-box row">
          	<div class="sign-title">
	          <span>Login</span>
	        </div>
          </div>

          <div class="sign-content">
            <form class="sign-form" action="loginAction.jsp" method="post">
	          <label for="userID">ID:</label><br>
	          <input type="text" name="userID" value="" placeholder="ID" class="box" id="LoginID">
	          <i class="bi bi-check-lg" id="idCheckIcon"></i>
	          <div><p class="ErrorMsg hidden" id="idError"></p></div>
	          
	          <label for="userPassword">Password:</label><br>
	          <input type="password" name="userPassword" value="" placeholder="Password" class="box" id="LoginPassword">
	          <i class="bi bi-check-lg" id="passwordCheckIcon"></i>
	          <div><p class="ErrorMsg hidden" id="passwordError"></p></div>
	          
              <input type="button" name="" value="Login" id="LoginButton">
            </form>
          </div>
          <div class="sign-nav row align-items-center">
          	<span>New to our website?</span>
          	<a href="SignupPage.jsp" class="btn">Create an Account</a>
          </div>
        </div>
      </div>
    </section>
    <!-- signup section end -->
    
    <!-- copyright text -->
    <div class="container">
		<p class="copyright">&copy; 2022 Cha Jeong Min</p>    
    </div>
  </body>
</html>
