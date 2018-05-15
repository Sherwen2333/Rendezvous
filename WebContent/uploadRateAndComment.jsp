<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	page import="java.util.ArrayList"%>
<%@ page import="rendezvous.Login"%>
<%@ page import="rendezvous.Customer"%>
<%@ page import="rendezvous.UserProfile"%>
<%@ page import="rendezvous.DateProcessing"%>
<%@ page import="rendezvous.Date"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Redirecting...</title>
</head>
<body>
	<%
		try {
			long dateId = (long)session.getAttribute("dateId");
			
			String ratePara = request.getParameter("rate");
			int rate = Integer.parseInt(ratePara);
			String comment = request.getParameter("comment");

			out.print(dateId + " " + rate + " " + comment);
			
			session.removeAttribute("dateId");
			
			DateProcessing.writeReviewAndComment(dateId, rate, comment);
			StringBuilder link = new StringBuilder("dateDetail.jsp?dateId=").append(dateId);
			response.sendRedirect(link.toString());
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	%>
</body>
</html>