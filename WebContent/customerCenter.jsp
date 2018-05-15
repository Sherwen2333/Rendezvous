<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="staff.StaffLogin"%>
<%@ page import="staff.Employee"%>

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
<title>Customer Center - Rendezvous</title>
</head>
<body>
	<!-- Check Information -->
	<%
		try {
			if (session.getAttribute("staffSession") == null) {
				response.sendRedirect("staffLogin.jsp");
				return;
			}
			if (session.getAttribute("staffSSN") == null) {
				response.sendRedirect("staffLogin.jsp");
				return;
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
		<%
			if(session.getAttribute("staffSession").equals("MA")){
		%>
		<a href="managerHome.jsp">Back</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="signOut.jsp">Sign Out</a>
		<%
			} else {
		%>
		<a href="employeeHome.jsp">Back</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="signOut.jsp">Sign Out</a>
		<%
			}
		%>
	</div>
	<div class="staffSSN">
		ID:
		<%=session.getAttribute("staffSSN")%>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="ccTitle">
		<i class="fa fa-terminal"></i>&nbsp;&nbsp;Customer Center
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="container">
		<a class="option" href="fullCustomerList.jsp">Full Customer List</a>
	</div>
	<div class="container editContainer">
		<a class="option" href="customerCenter.jsp?op=1">Edit Customer Info</a>
	</div>
	<%
		try {
			String op = request.getParameter("op");
			if(op.length() == 1) {
	%>
	<div class="searchContainer">
		<form method="post" action="customerCenter.jsp?op=333">
			<input type="text" name="Id" placeholder="Enter Customer ID" maxlength="24" class="textfield">
			<input type="submit" value="Submit">
		</form>
	</div>
	<%
			} else if (op.length() == 2) {
	%>
	<div class="searchContainer">
		<form method="post" action="customerCenter.jsp?op=333">
			<input type="text" name="Id" placeholder="Enter Customer ID" maxlength="24" class="textfield">
			<input type="submit" value="Submit">
		</form>
		Invalid Input
	</div>
	<%
			} else if (op.length() == 3) {
				String id = request.getParameter("Id");
				response.sendRedirect("customerInfo.jsp?id=" + id + "&op=0");
			}
		} catch (Exception ex) {
			
		}
	%>
	<%
		} catch (Exception ex) {
			response.sendRedirect("signOut.jsp");
		}
	%>
</body>
</html>