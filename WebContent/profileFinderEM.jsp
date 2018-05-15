<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="staff.CustomerInfo"%>
<%@ page import="staff.Employee"%>
<%@ page import="java.util.ArrayList"%>

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
<link href="Stylesheet/search.css" type="text/css" rel="stylesheet">
<title>Comprehensive List - Rendezvous</title>
</head>
<body>
	<!-- Check Information -->
	<%
		try {
			if (!session.getAttribute("staffSession").equals("EM")) {
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
		<a href="employeeHome.jsp ">Back</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="signOut.jsp">Sign Out</a>
	</div>
	
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="searchTitle">
		<i class="fa fa-search"></i> Search Profiles
	</div>
	<div class="formContainer">
		<div class="formInnerContainer">
			<div class="formTitle">Please Input the profile Id:</div>
		    <form method = "POST" action="processProfileFinderEM.jsp">
		    	<div class="submitBTN">
		        	Profile ID:&nbsp;&nbsp;<input type="text" name="Id" maxlength="24" style="width: 20em;">
		        </div>
		        <div class="submitBTN">
		        	<input type="submit" value="Submit">
		        </div>
	       </form>
       </div>
    </div>
	<%	
		} catch (Exception ex) {

		}
	%>
</body>
</html>