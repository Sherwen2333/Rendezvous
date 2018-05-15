<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="rendezvous.GeoLocation" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	   <%
		if(session.getAttribute("username") == null){
			response.sendRedirect("login.jsp");
			return;
		}
		if(session.getAttribute("profileId") == null){
			response.sendRedirect("chooseProfile.jsp");
			return;
		}
	   GeoLocation.waiting=false; 
	   GeoLocation.DeleteMessageSent((String)session.getAttribute("profileId"));
	   response.sendRedirect("userProfile.jsp");
	   
	   %>
</body>
</html>