<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	page import="java.util.ArrayList"%>
<%@ page import="rendezvous.Login"%>
<%@ page import="rendezvous.UserProfile"%>
<%@ page import="rendezvous.MakeDateWith"%>
<%@ page import="rendezvous.DateProcessing"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- meta http-equiv="refresh" content="3; url=http://www.google.com/" -->
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>Insert title here</title>
</head>

<body>
	<%
		if (session.getAttribute("username") == null) {
			response.sendRedirect("login.jsp");
			return;
		}
	%>
	<%
	try {
		DateProcessing.status = 0;
		DateProcessing.pid = MakeDateWith.Id_t;
		if (!request.getParameter("date_Month").isEmpty()) {
			DateProcessing.date_Month = request.getParameter("date_Month");	
		}else{
			DateProcessing.status=1;
		}
		if (!request.getParameter("date_Day").isEmpty()) {
			DateProcessing.date_Day = request.getParameter("date_Day");
		}else{
			DateProcessing.status=1;
		}
		if (!request.getParameter("date_Year").isEmpty()) {
			DateProcessing.date_Year = request.getParameter("date_Year");
		}else{
			DateProcessing.status=1;
		}
		if (!request.getParameter("date_Hour").isEmpty()) {
			DateProcessing.date_Hour = request.getParameter("date_Hour");
		}else{
			DateProcessing.status=1;
		}
		if (!request.getParameter("date_Minute").isEmpty()) {
			DateProcessing.date_Minute = request.getParameter("date_Minute");
		}else{
			DateProcessing.status=1;
		}
		if (!request.getParameter("date_Second").isEmpty()) {
			DateProcessing.date_Second = request.getParameter("date_Second");
		}else{
			DateProcessing.status=1;
		}
		DateProcessing.date_UseCurrentTime = request.getParameter("date_UseCurrentTime");
		if (!request.getParameter("date_Loaction").isEmpty()) {
			DateProcessing.date_Loaction = request.getParameter("date_Loaction");
		}
		
		try {
			if (!request.getParameter("date_Zipcode").isEmpty()) {
				DateProcessing.date_Zipcode = request.getParameter("date_Zipcode");
				int value = Integer.valueOf(request.getParameter("date_Zipcode"));
				if (value < 0) {
					DateProcessing.status=3;
				}
			}
		} catch (Exception e) {
			DateProcessing.status=3;
		}
		if (DateProcessing.date_Loaction.length() <= 0 && DateProcessing.date_Zipcode.length() > 0) {
			DateProcessing.status=2;
		}

		if (DateProcessing.date_Loaction.length() > 0 && DateProcessing.date_Zipcode.length() <= 0) {
			DateProcessing.status=2;
		}
		
		DateProcessing.datetime = new StringBuilder();
		DateProcessing.datetime.append(DateProcessing.date_Year).append("-").append(DateProcessing.date_Month).append("-").append(DateProcessing.date_Day).append(" ");
		DateProcessing.datetime.append(DateProcessing.date_Hour).append(":").append(DateProcessing.date_Minute).append(":").append(DateProcessing.date_Second);
		
		//System.out.println(UserProfile.getProfileId()+"^^"+DateProcessing.pid+"^^"+DateProcessing.datetime+
		//		"^^"+DateProcessing.date_Loaction+"^^"+DateProcessing.date_Zipcode);
		if (DateProcessing.status!= 0) {
			response.sendRedirect("makeDateProfile.jsp");
		} else {
			response.sendRedirect("processMakeDateWith.jsp");
		}
		return;
	} catch (Exception ex) {
		//ex.printStackTrace();
	}
	%>
</body>
</html>