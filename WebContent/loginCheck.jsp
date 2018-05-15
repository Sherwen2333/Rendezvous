<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="rendezvous.Login"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- meta http-equiv="refresh" content="3; url=http://www.google.com/" -->
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>Login Check</title>
</head>

<body>
	<!-- Get user input -->
	<jsp:useBean id="userInfo" class="rendezvous.Login" scope="page"></jsp:useBean>
	<jsp:setProperty property="*" name="userInfo" />

	<!-- Check login info & redirect to user homepage if succeed -->
	<h2>
		<%
			boolean status = false;
			try {
				status = Login.verifyLoginInfo(userInfo);
				if (status) {
					Login.status = true;
					session.setAttribute("session", "TRUE");
					session.setAttribute("username", userInfo.getUsername());
					response.sendRedirect("chooseProfile.jsp");
				} else {
					Login.status = false;
					response.sendRedirect("login.jsp");
				}
			} catch (Exception ex) {
				
			}
		%>
	</h2>

</body>
</html>