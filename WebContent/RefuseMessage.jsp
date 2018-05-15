<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="rendezvous.GeoLocation"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
		<%
		String inviter=request.getParameter("inviter");
		String invitee=request.getParameter("invitee");
		if(inviter==null || invitee == null){
			response.sendRedirect("Message.jsp");
			return ;
		}
		else {
			GeoLocation.DeleteOneMessageReceived(invitee,inviter);
			response.sendRedirect("Message.jsp");
		}
		
		%>
</body>
</html>