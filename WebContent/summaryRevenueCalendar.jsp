<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="staff.CustomerInfo"%>
<%@ page import="staff.Employee"%>
<%@ page import="rendezvous.State"%>
<%@ page import="rendezvous.ProfilePlacementPriority"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="staff.ComprehensiveList"%>
<%@ page import="config.DateConstants"%>
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
<link href="Stylesheet/revenue.css" type="text/css" rel="stylesheet">
<title>Revenue Summary - Rendezvous</title>
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
		<a href="ListRevenue.jsp ">Back</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="signOut.jsp">Sign Out</a>
	</div>
	<div class="staffSSN">
		ID:
		<%=session.getAttribute("staffSSN")%>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="titleIcon">
		<i class="fa fa-bar-chart"></i>
	</div>
	<div class="titleText">Revenue Analysis</div>
	<!--=============================================================================-->
	<!--=================================== Option ==================================-->
	<!--=============================================================================-->
	<div class="optionContainer">
		<a class="option option3" href="">Summary Revenue Calendar</a>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<%
		try{
			String month1 = request.getParameter("month1");
			if(month1 == null) {
				throw new Exception();
			}
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
	%>
	<div class="result">
		<b>Total revenue from <%=datetime1.toString()%> to <%=datetime2.toString()%> is $<%=total%></b>
	</div>
	<%
		}catch(Exception e) {
			
		}
	%>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="instruction">
		<em>Please Choose Date Range</em>
	</div>
	<div class="formContainer">
	<div class="formInnerContainer">
		<form method="post" action="summaryRevenueCalendar.jsp"><!-- processSummaryRevenueCalendar.jsp -->
			<div style="font-size: 1.2em; color: #005a93;">
				<b>
					<i class="fa fa-quote-left"></i> From <i class="fa fa-quote-right"></i>
				</b>
			</div>
			<!--============= Date =============-->
			<div>
				<b>Date(mm-dd-yy)*: </b><select name="month1">
				<%
					for(int i = 0; i < DateConstants.MONTH.size(); i++){
						if(i == DateConstants.CURRENT_MONTH){
				%>
				<option value="<%=i+1%>" selected><%=DateConstants.MONTH.get(i)%></option>
				<%
						} else {
				%>
				<option value="<%=i+1%>"><%=DateConstants.MONTH.get(i)%></option>
				<%
						}
					}
				%>
				</select>&nbsp;-&nbsp;<select name="day1">
				<%
					for(int i = 0; i < DateConstants.DAY.size(); i++){
						if(i == DateConstants.CURRENT_DAY){
				%>
				<option value="<%=DateConstants.DAY.get(i)%>" selected><%=DateConstants.DAY.get(i)%></option>
				<%
						} else {
				%>
				<option value="<%=DateConstants.DAY.get(i)%>"><%=DateConstants.DAY.get(i)%></option>
				<%
						}
					}
				%>
				</select>&nbsp;-&nbsp;<select name="year1">
				<%
					for(int i = 0; i < DateConstants.YEAR.size(); i++){
				%>		
				<option value="<%=DateConstants.YEAR.get(i)%>"><%=DateConstants.YEAR.get(i)%></option>
				<%
					}
					for(int i = 0; i < DateConstants.PAST_5_YEAR.size(); i++){
					%>		
					<option value="<%=DateConstants.PAST_5_YEAR.get(i)%>"><%=DateConstants.PAST_5_YEAR.get(i)%></option>
					<%
						}
				%>
				</select>
			</div>
			<!--============= Time =============-->
			<div>
				<b>Time(hh:mm:ss)*: </b><select name="hour1">
				<%
					for(int i = 0; i < DateConstants.HOUR.size(); i++){
				%>
				<option value="<%=i%>"><%=DateConstants.HOUR.get(i)%></option>
				<%
					}
				%>
				</select>&nbsp;:&nbsp;<select name="minute1">
				<%
					for(int i = 0; i < DateConstants.MINUTE.size(); i++){
				%>
				<option value="<%=i%>"><%=DateConstants.MINUTE.get(i)%></option>
				<%
					}
				%>
				</select>&nbsp;:&nbsp;<select name="second1">
				<%
					for(int i = 0; i < DateConstants.SECOND.size(); i++){
				%>
				<option value="<%=i%>"><%=DateConstants.SECOND.get(i)%></option>
				<%
					}
				%>
				</select>
			</div>
			<br>
			<div style="font-size: 1.2em; color: #005a93;">
				<b>
					<i class="fa fa-quote-left"></i> To <i class="fa fa-quote-right"></i>
				</b>
			</div>
			<!--============= Date =============-->
			<div>
				<b>Date(mm-dd-yy)*: </b><select name="month2">
				<%
					for(int i = 0; i < DateConstants.MONTH.size(); i++){
						if(i == DateConstants.CURRENT_MONTH){
				%>
				<option value="<%=i+1%>" selected><%=DateConstants.MONTH.get(i)%></option>
				<%
						} else {
				%>
				<option value="<%=i+1%>"><%=DateConstants.MONTH.get(i)%></option>
				<%
						}
					}
				%>
				</select>&nbsp;-&nbsp;<select name="day2">
				<%
					for(int i = 0; i < DateConstants.DAY.size(); i++){
						if(i == DateConstants.CURRENT_DAY){
				%>
				<option value="<%=DateConstants.DAY.get(i)%>" selected><%=DateConstants.DAY.get(i)%></option>
				<%
						} else {
				%>
				<option value="<%=DateConstants.DAY.get(i)%>"><%=DateConstants.DAY.get(i)%></option>
				<%
						}
					}
				%>
				</select>&nbsp;-&nbsp;<select name="year2">
				<%
					for(int i = 0; i < DateConstants.YEAR.size(); i++){
				%>		
				<option value="<%=DateConstants.YEAR.get(i)%>"><%=DateConstants.YEAR.get(i)%></option>
				<%
					}
					for(int i = 0; i < DateConstants.PAST_5_YEAR.size(); i++){
					%>		
					<option value="<%=DateConstants.PAST_5_YEAR.get(i)%>"><%=DateConstants.PAST_5_YEAR.get(i)%></option>
					<%
						}
				%>
				</select>
			</div>
			<!--============= Time =============-->
			<div>
				<b>Time(hh:mm:ss)*: </b><select name="hour2">
				<%
					for(int i = 0; i < DateConstants.HOUR.size(); i++){
				%>
				<option value="<%=i%>"><%=DateConstants.HOUR.get(i)%></option>
				<%
					}
				%>
				</select>&nbsp;:&nbsp;<select name="minute2">
				<%
					for(int i = 0; i < DateConstants.MINUTE.size(); i++){
				%>
				<option value="<%=i%>"><%=DateConstants.MINUTE.get(i)%></option>
				<%
					}
				%>
				</select>&nbsp;:&nbsp;<select name="second2">
				<%
					for(int i = 0; i < DateConstants.SECOND.size(); i++){
				%>
				<option value="<%=i%>"><%=DateConstants.SECOND.get(i)%></option>
				<%
					}
				%>
				</select>
			</div>
			<!--============= Submit =============-->
			<div class="submitBTN">
				<input class="submitBTN" type="submit" value="Request" style="font-size: 1.2em;">
			</div>
			<!--============= Hint =============-->
			<div style="font-size: 0.6em; margin-top: 1em; color: grey;">
				* Must be fill in with valid date and time
			</div>
		</form>
		</div>
	</div>
	<%
		} catch (Exception ex) {
	
		}
	%>
	<div style="margin-bottom: 7em;"></div>
</body>
</html>