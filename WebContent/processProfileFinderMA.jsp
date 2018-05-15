<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="staff.CustomerInfo"%>
<%@ page import="staff.Employee"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="staff.ProfileFinderMA"%>
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
		<a href="managerHome.jsp ">Back to Manager Home</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="signOut.jsp">Sign Out</a>
	</div>
	<div class="staffSSN">
		ID:
		<%=session.getAttribute("staffSSN")%>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="searchTitle">
		<i class="fa fa-search"></i> Search Result
	</div>
	<%
		String Id = "";
		if (!request.getParameter("Id").isEmpty()) {
			Id = request.getParameter("Id");
		}
		ArrayList<String> list = new ArrayList<String>();

		if (!Id.isEmpty()) {
			if (Id.contains("'") || Id.contains("\\") || Id.contains("&")) {
	%>
	<div style="color: grey; text-align: center; font-size: 1.2em;">
		Sorry, there are no such profiles.
	</div>
	<%
		} else {
				list = ProfileFinderMA.getProfile(Id);
				if (list.size() == 0) {
	%>
	<div style="color: grey; text-align: center; font-size: 1.2em;">
			Sorry, there are no such profiles.
	</div>
	<%
				} else {
					ProfileFinderMA.Id=request.getParameter("Id");
	%>
	<div style="text-align: center; font-size: 1.2em; font-weight: 550; margin-bottom: 1em;">
		Profile ID
	</div>
	<%
					for (String s : list) {
	%>
	<div class="result">
		<a href="userProfileTempMA.jsp?pid=<%=s%>&op=0"><%=s%></a>
	</div>
	<%
					}
				}
			}
		} else {
	%>
	<div style="color: grey; text-align: center; font-size: 1.2em;">
			Sorry, there are no such profiles.
	</div>
	<%
		}
	%>
</body>
</html>