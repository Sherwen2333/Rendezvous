<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="Stylesheet/managerHome.css" type="text/css"
	rel="stylesheet">
<title>Manager - Rendezvous</title>
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
	<div class=rendezvous>Rendezvous</div>
	<!-- Buttons -->
	<div class="signOut">
		<a href="helpMA.jsp">Help</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="signOut.jsp">Sign Out</a>
	</div>
	<div class="staffSSN">
		ID:
		<%=session.getAttribute("staffSSN")%>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="optionContainer">
		<a class="option" href="recordDateMA.jsp">Record Date</a><a 
			class="option" href="mailingList.jsp?option=0&cId=">Mailing List</a><a 
			class="option" href="customerCenter.jsp">Customer Center</a><a 
			class="option" href="suggestListMA.jsp">Profile Suggestion</a><a 
			class="option" href="profileFinderMA.jsp">Profile Finder</a><a 
			class="option" href="employeeAbout.jsp">About</a>
	</div>
	<div class="optionContainer">
		<a class="option" href="saleReport.jsp?op=0&month=0&year=0">Sale Report</a><a 
			class="option" href="comprehensiveList.jsp">User Portrait</a><a 
			class="option" href="employeeCenter.jsp">Employee Center</a><a 
			class="option" href="customerAnalysis.jsp">Customer Analysis</a><a 
			class="option" href="dateList.jsp?op=0">Date List</a><a 
			class="option" href="ListRevenue.jsp">Revenue</a>
	</div>
</body>
</html>