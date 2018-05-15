<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="rendezvous.Login"%>
<%@ page import="staff.StaffLogin"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Sign Out</title>
</head>
<body>
	<%
		session.removeAttribute("session");
		session.removeAttribute("username");
		session.removeAttribute("profileId");
		session.removeAttribute("ppp");
		
		session.removeAttribute("staffSession");
		session.removeAttribute("staffSSN");		
		
		Login.status = true;
		StaffLogin.status = true;
		
		response.sendRedirect("home.html");
	%>
</body>
</html>