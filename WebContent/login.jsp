<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="rendezvous.Login"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- Head -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="Stylesheet/login.css" type="text/css" rel="stylesheet">
<title>Login - Rendezvous</title>
</head>
<!-- Body -->
<body>
	<div class="rendezvous"><a href="home.html">Rendezvous</a></div>
	<div class="loginBlock">
		<p class="loginTitle">Sign In</p>
		<form action="loginCheck.jsp" method="post">
			<div class="loginInfo">
				Username: <br>
			</div>
			<input type="text" name="username" value="" maxlength="24"
				class="loginTextfield"><br>
			<div class="loginInfo">
				Password: <br>
			</div>
			<input type="password" name="password" value="" maxlength="24"
				class="loginTextfield"><br> <br>
			<!-- Display error message if necessary -->
			<div class="error">
				<%
					try {
						// If logged in redirect to homepage
						if (session.getAttribute("session").equals("TRUE")) {
							// If profile is not chosen
							if (session.getAttribute("profileId") == null) {
								response.sendRedirect("chooseProfile.jsp");
								return;
							}
							// If profile is chosen
							else {
								/* To be filled */
								response.sendRedirect("chooseProfile.jsp");
							}
						}
					} catch (Exception ex) {
					}
					try {
						if (!Login.status) {
							out.println("Incorrect username or password.");
							Login.status = true;
						}
					} catch (Exception ex) {
					}
				%>
			</div>
			<input type="submit" value="Login" class="button">
		</form>
	</div>
</body>
</html>