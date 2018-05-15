<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	page import="java.util.ArrayList"%>
<%@ page import="rendezvous.Login"%>
<%@ page import="rendezvous.Customer"%>
<%@ page import="rendezvous.UserProfile"%>
<%@ page import="rendezvous.SuggestDate"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="Stylesheet/topbar.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/help.css" type="text/css" rel="stylesheet">
<title>Help</title>
</head>
<body>
	<%
	try {
		if (!session.getAttribute("staffSession").equals("EM")) {
			response.sendRedirect("staffLogin.jsp");
		}
		if (session.getAttribute("staffSSN") == null) {
			response.sendRedirect("staffLogin.jsp");
		}
	} catch (Exception ex) {
		response.sendRedirect("staffLogin.jsp");
		return;
	}
	%>
	<div class="titleBar"></div>
	<div class=rendezvous>Rendezvous</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!-- Button -->
	<div class="signOut">
		<a href="employeeHome.jsp">Back</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="signOut.jsp">Sign Out</a>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="helpTOP_Icon"><i class="fa fa-info-circle"></i></div>
	<div class="helpTOP_Text">Help</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="helpTitle">
		Customer-Representative Level
		<div class="helpList">
			Record a date
			<div class="helpText">
				Click the "Record Date" on the homepage of the Customer-Representative.
			</div>
		</div>
		<div class="helpList">
			Add, Edit and Delete information for a customer
			<div class="helpText">
				Click the "Customer Center" on the homepage of the Customer-Representative.
			</div>
		</div>
		<div class="helpList">
			Produce customer mailing lists
			<div class="helpText">
				Click the "Mailing List" on the homepage of the Customer-Representative.
			</div>
		</div>
		<div class="helpList">
			Produce a list of profiles as date suggestions for a given profile (based on that profile's past dates)
			<div class="helpText">
				Click the "Profile Suggestion" on the homepage of the Customer-Representative.
				<br>
				(* The suggestion based on one profile's past dates is already set on the recommendation of the profile's homepage.)
			</div>
		</div>
	</div>
</body>
</html>

