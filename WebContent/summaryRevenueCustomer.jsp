<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="staff.CustomerInfo"%>
<%@ page import="staff.Employee"%>
<%@ page import="rendezvous.State"%>
<%@ page import="rendezvous.ProfilePlacementPriority"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="staff.ComprehensiveList"%>
<%@ page import="config.DateConstants"%>
<%@ page import="staff.SummaryRevenueCustomer"%>

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
		<a class="option option4" href="">Summary Revenue Customer</a>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<%
		String result = "";
		String Id = "";
		try {
				if(request.getParameter("Id") == null){
					throw new Exception();
				}
				if (!request.getParameter("Id").isEmpty()) {
					Id = request.getParameter("Id");
					if (Id.contains("'") || Id.contains("\\") || Id.contains("&")) {
						result = "There is no such Id.";
					} else {
						if (!SummaryRevenueCustomer.SearchId(Id)) {
							result = "There is no such Id.";
						} else {
								ArrayList<String> list = new ArrayList<String>();
								list = SummaryRevenueCustomer.ProduceSummaryRevenueCustomer(Id);
								String total = "0";
								if (list.size() == 0)
									total = "0";
								else
									total = list.get(0);
								result = "Total revenue from " + Id + " is: $" + total;
						}
					}
				} else {
					result = "There is no such Id.";
				}
			} catch (Exception ex) {

			}
	%>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="textfieldContainer">
		<form method="post" action="">
			Customer ID:
			<input type="text" name="Id" placeholder="Enter Customer ID" value="<%=Id %>" maxlength="24" class="textfield">
			<input type="submit" value="Submit">
		</form>
	</div>
	<%
		if(!result.isEmpty()) {
	%>
	<div class="result"><%=result %></div>
	<%
		}
	%>
		<%
		} catch (Exception ex) {

		}
		%>
</body>
</html>