<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="rendezvous.Login"%>
<%@ page import="rendezvous.Customer"%>
<%@ page import="rendezvous.UserProfile"%>
<%@ page import="rendezvous.DateProcessing"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cancel Date</title>
</head>
<body>
	<%
		try {
			String para = request.getParameter("dateId");
			long dateId = Long.parseLong(para);
			DateProcessing.cancelDate(dateId);
		} catch (Exception ex) {

		}
		response.sendRedirect("pendingDates.jsp");
	%>
</body>
</html>