<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="config.DateConstants"%>
<%@ page import="staff.SaleReport"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="Stylesheet/topbar.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/saleReport.css" type="text/css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Sale Report - Rendezvous</title>
</head>
<body>
	<!-- Check Information -->
	<%
		try {
			if (!session.getAttribute("staffSession").equals("MA")) {
				response.sendRedirect("staffLogin.jsp");
			}
			if (session.getAttribute("staffSSN") == null) {
				response.sendRedirect("staffLogin.jsp");
			}
		} catch (Exception ex) {

		}
	%>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!-- Top bar -->
	<div class="titleBar"></div>
	<div class=rendezvous><a href="managerHome.jsp">Rendezvous</a></div>
	<!-- Buttons -->
	<div class="signOut">
		<a href="managerHome.jsp">Back</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="signOut.jsp">Sign Out</a>
	</div>
	<div class="staffSSN">
		ID:
		<%=session.getAttribute("staffSSN")%>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="titleIcon">
		<i class="fa fa-line-chart"></i>
	</div>
	<div class="titleText">Sale Report</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<%
		try{
			String month = request.getParameter("month");
			String year = request.getParameter("year");
			
			// op = 0 -> default; op = 1 -> this year; op = 2 Past Year					
			int op = Integer.parseInt(request.getParameter("op"));
	%>
	<!--=============================================================================-->
	<!--=================================== Option ==================================-->
	<!--=============================================================================-->
	<div class="optionContainer">
		<%	if(op != 1 && (op < 10 || op > 19)){ %>
				<a class="option" href="saleReport.jsp?op=1&month=0&year=0">This Year</a>
		<%	} else { %>
				<a class="optionSelected" href="">This Year</a>
		<%} %>
		<%	if(op != 2 && (op < 20 || op > 29)){ %>
				<a class="option" href="saleReport.jsp?op=2&month=0&year=0">Past Year</a>
		<%	} else { %>
				<a class="optionSelected" href="">Past Year</a>
		<%} %>
	</div>
	<!--=============================================================================-->
	<!--==================================== Form ===================================-->
	<!--=============================================================================-->
	<%if(op != 0) {%>
	<div class="formContainer">
		<form method="post" action="processSaleReport.jsp?op=<%=op%>">
			<div>
				<select name="month">
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
				</select><%if(op == 2 || (op >= 20 && op <= 29)) {%>&nbsp;&nbsp;<select name="year">
				<%
					for(int i = 0; i < DateConstants.PAST_5_YEAR.size(); i++){
				%>		
				<option value="<%=DateConstants.PAST_5_YEAR.get(i)%>"><%=DateConstants.PAST_5_YEAR.get(i)%></option>
				<%
					}
				%>
				</select><%}%>&nbsp;&nbsp;<input class="submitBTN" type="submit" value="Retrieve">
			</div>
		</form>
		<div class="error">
		<%
			if(op == 9){
				out.print("Failed to retrieve data");
			} else if (op == 18 || op == 28) {
				out.print("No available data");
			}
		%>
		</div>
	</div>
	<%}%>
	<!--=============================================================================-->
	<!--=================================== Report ==================================-->
	<!--=============================================================================-->
	<%
		if(op == 11 || op == 21) {
			String mm = request.getParameter("month");
			if(mm.length() == 1) {
				mm = "0" + mm;
			}
			String yy = request.getParameter("year");
	%>
	<div class="reportContainer">
		<div class="reportInnerContainer">
			<div><i class="fa fa-quote-left"></i> <%=mm%>&nbsp;-&nbsp;<%=yy%> <i class="fa fa-quote-right"></i></div>
			<div>Revenue: $<%=SaleReport.revenue %>&nbsp;&nbsp;(Last year: $<%=SaleReport.lastYearRevenue%>)</div>
			<div>Number of dates: <%=SaleReport.numDates %></div>
		</div>
	</div>
	<%
		}
	%>
	<!--=============================================================================-->
	<!--================================== Exception ================================-->
	<!--=============================================================================-->
	<%
		}catch(Exception ex){
			
		}
	%>
</body>
</html>