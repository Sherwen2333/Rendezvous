<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="staff.CustomerInfo"%>
<%@ page import="staff.Employee"%>
<%@ page import="rendezvous.State"%>
<%@ page import="rendezvous.ProfilePlacementPriority"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="staff.SummaryRevenueCalendar"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="Stylesheet/topbar.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/customerCenter.css" type="text/css"
	rel="stylesheet">
<title>Comprehensive List - Rendezvous</title>
</head>
<body>
	<!-- Check Information -->
	<%
		try {
			if (session.getAttribute("staffSession") == null) {
				response.sendRedirect("staffLogin.jsp");
			}
			if (session.getAttribute("staffSSN") == null) {
				response.sendRedirect("staffLogin.jsp");
			}
		} catch (Exception ex) {

		}

		try {
	%>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!-- Top bar -->
	<div class="titleBar"></div>
	<div class=rendezvous>Rendezvous</div>
	<!-- Buttons -->
	<div class="signOut">
		<a href="employeeHome.jsp ">Back to Employee Home</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
			href="signOut.jsp">Sign Out</a>
	</div>
	<div class="staffSSN">
		ID:
		<%=session.getAttribute("staffSSN")%>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<%
			String month1 = request.getParameter("month1");
			String day1 = request.getParameter("day1");
			String year1 = request.getParameter("year1");
			String hour1 = request.getParameter("hour1");
			String minute1 = request.getParameter("minute1");
			String second1 = request.getParameter("second1");

			String month2 = request.getParameter("month2");
			String day2 = request.getParameter("day2");
			String year2 = request.getParameter("year2");
			String hour2 = request.getParameter("hour2");
			String minute2 = request.getParameter("minute2");
			String second2 = request.getParameter("second2");

			StringBuilder datetime1 = new StringBuilder();
			datetime1.append(year1).append("-").append(month1).append("-").append(day1).append(" ");
			datetime1.append(hour1).append(":").append(minute1).append(":").append(second1);

			StringBuilder datetime2 = new StringBuilder();
			datetime2.append(year2).append("-").append(month2).append("-").append(day2).append(" ");
			datetime2.append(hour2).append(":").append(minute2).append(":").append(second2);
			ArrayList<String> list = SummaryRevenueCalendar.ProduceSummaryRevenueCalendar(datetime1.toString(),
					datetime2.toString());
			
			double total = 0;
			if(list == null)
				total = 0.0;
			else if (list.size() == 0 || list.get(0) == null)
				total = 0.0;
			else
				total = Double.parseDouble(list.get(0));
			//response.sendRedirect("processSummaryRevenueCalendar.jsp");
	%>
	<div style="font-size: 2em; margin-top: 1em; color: blue;">
		Total Revenue is: <%=total%>
		<br>
	</div>

	<%
			return;
		} catch (Exception ex) {
			//ex.printStackTrace();
		}
	%>
</body>
</html>