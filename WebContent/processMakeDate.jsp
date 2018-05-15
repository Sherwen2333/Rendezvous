<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="rendezvous.DateProcessing"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Processing...</title>
</head>
<body>
	<%
		try {
			String pid = request.getParameter("pid");

			String date_Month = request.getParameter("date_Month");
			String date_Day = request.getParameter("date_Day");
			String date_Year = request.getParameter("date_Year");
			String date_Hour = request.getParameter("date_Hour");
			String date_Minute = request.getParameter("date_Minute");
			String date_Second = request.getParameter("date_Second");

			String date_UseCurrentTime = request.getParameter("date_UseCurrentTime");

			String date_Loaction = request.getParameter("date_Loaction");
			String date_Zipcode = request.getParameter("date_Zipcode");

			if (date_Loaction.length() <= 0 && date_Zipcode.length() > 0) {
				response.sendRedirect("makeDate.jsp?pid=" + pid + "&op=2");
				return;
			}

			if (date_Loaction.length() > 0 && date_Zipcode.length() <= 0) {
				response.sendRedirect("makeDate.jsp?pid=" + pid + "&op=2");
				return;
			}
			
			StringBuilder datetime = new StringBuilder();
			datetime.append(date_Year).append("-").append(date_Month).append("-").append(date_Day).append(" ");
			datetime.append(date_Hour).append(":").append(date_Minute).append(":").append(date_Second);
			
			int option;
			if(date_UseCurrentTime == null)
				option = 0;
			else
				option = 1;
			
			if(date_Loaction.length() > 0)
				option += 10;

			switch(option) {
			case 0: {
				boolean status = DateProcessing.makeDateOnGivenDate((String)session.getAttribute("profileId"), pid, datetime.toString());
				if(status){
					response.sendRedirect("makeDate.jsp?pid=" + pid + "&op=100");
					return;
				} else {
					response.sendRedirect("makeDate.jsp?pid=" + pid + "&op=4");
					return;
				}
			}
			case 1: {
				boolean status = DateProcessing.makeDateOnCurrent((String)session.getAttribute("profileId"), pid);
				if(status){
					response.sendRedirect("makeDate.jsp?pid=" + pid + "&op=100");
					return;
				} else {
					response.sendRedirect("makeDate.jsp?pid=" + pid + "&op=4");
					return;
				}
			}
			case 10: {
				boolean status = DateProcessing.makeDateOnGivenDateGeo((String)session.getAttribute("profileId"), pid, datetime.toString(), date_Loaction, date_Zipcode);
				if(status){
					response.sendRedirect("makeDate.jsp?pid=" + pid + "&op=100");
					return;
				} else {
					response.sendRedirect("makeDate.jsp?pid=" + pid + "&op=4");
					return;
				}
			}
			case 11: {
				boolean status = DateProcessing.makeDateOnCurrentGeo((String)session.getAttribute("profileId"), pid, date_Loaction, date_Zipcode);
				if(status){
					response.sendRedirect("makeDate.jsp?pid=" + pid + "&op=100");
					return;
				} else {
					response.sendRedirect("makeDate.jsp?pid=" + pid + "&op=4");
					return;
				}
			}
			}
			response.sendRedirect("makeDate.jsp?pid=" + pid + "&op=4");
			return;
		} catch (Exception ex) {
			
		}
	%>

</body>
</html>