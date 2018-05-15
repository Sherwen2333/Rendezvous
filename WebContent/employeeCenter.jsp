<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="staff.CustomerInfo"%>
<%@ page import="staff.Employee"%>
<%@ page import="rendezvous.State"%>
<%@ page import="rendezvous.ProfilePlacementPriority"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="staff.ComprehensiveList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="Stylesheet/topbar.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/employeeCenter.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/customerAnalysis.css" type="text/css" rel="stylesheet">
<title>Employee Center - Rendezvous</title>
<style>
	.compList {
		margin-left: 36%;
		margin-right: 36%;
		min-width: 350px;
	 	font-size: 1em; 
	 	margin-top: 2em; 
	 	line-height:1.8;
	 	border: 0.1em solid lightgrey;
	 	border-radius: 0.625em;
	 	padding: 1.5em;
	 	font-family: "Avenir Next", Helvetica, "Times New Roman",
		"Franklin Gothic Bold", "Arial Black", "sans-serif";
	}
	
	.compList b {
		font-weight: 500;
	}
	
</style>
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
		<a href="managerHome.jsp">Back to Manager Home</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="signOut.jsp">Sign Out</a>
	</div>
	<div class="staffSSN">
		ID:
		<%=session.getAttribute("staffSSN")%>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="titleIcon">
		<i class="fa fa-map-signs"></i>
	</div>
	<div class="titleText">Employee Center</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="searchContainer">
		<form method="post" action="employeeAboutOthers.jsp">
			Search:
			<input type="text" name="Id" placeholder="Enter Employee ID" maxlength="24" class="textfield">
			<input type="submit" value="Submit">
		</form>
	</div>
	<div class="createContainer">
		<a href="employeeAboutOthers_Create.jsp">Create New Employee</a>
	</div>
	<%
		} catch (Exception ex) {

		}
	%>
</body>
</html>