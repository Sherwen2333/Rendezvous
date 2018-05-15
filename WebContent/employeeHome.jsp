<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="Stylesheet/employeeHome.css" type="text/css"
	rel="stylesheet">
<title>Representative - Rendezvous</title>
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
			response.sendRedirect("staffLogin.jsp");
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
		<a href="helpEM.jsp">Help</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="signOut.jsp">Sign Out</a>
	</div>
	<div class="staffSSN">
		ID:
		<%=session.getAttribute("staffSSN")%>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="optionContainer">
		<a class="option" href="recordDateEM.jsp">Record Date</a><a 
			class="option" href="mailingList.jsp?option=0&cId=">Mailing List</a><a 
			class="option" href="customerCenter.jsp">Customer Center</a><a 
			class="option" href="suggestListEM.jsp">Profile Suggestion</a><a 
			class="option" href="profileFinderEM.jsp">Profile Finder</a><a 
			class="option" href="employeeAbout.jsp">About</a>
	</div>
</body>
</html>