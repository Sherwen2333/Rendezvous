<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="rendezvous.Customer"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="Stylesheet/topbar.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/upgrade.css" type="text/css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Upgrade - Rendezvous</title>
</head>
<body>
	<%
		if(session.getAttribute("username") == null) {
			response.sendRedirect("login.jsp");
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
		<a href="chooseProfile.jsp">Back</a>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!-- Upgrade Title -->
	<div class="upgradeTitle">
		<div class="upgradeIcon">
			<i class="fa fa-certificate"></i>
		</div>
		<div class="upgradeText">Choose Plan</div>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<%
		try {
			String ppp = (String) session.getAttribute("ppp");
			if (ppp == null) {
				String username = (String) session.getAttribute("username");
				ppp = Customer.getProfilePlacementPriority(username);
				session.setAttribute("ppp", ppp);
			}
	%>
	<!--=============================================================================-->
	<!--================================  Plan  =====================================-->
	<!--=============================================================================-->
	<div class="currentPlan">
	<%
		if(ppp.equals("a") || ppp.equals("A")) {
			out.println("Current plan: Super");
		} else if(ppp.equals("b") || ppp.equals("B")) {
			out.println("Current plan: Good");
		} else {
			out.println("Current plan: Free");
		}
	%>
	</div>
	<div class="optionContainer">
			<a class="option" href="upgrade_process.jsp?op=0">Free</a>
			<a class="option" href="upgrade_process.jsp?op=11">Good</a>
			<a class="option" href="upgrade_process.jsp?op=222">Super</a>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<%
		} catch (Exception ex) {

		}
	%>
	<div style="margin-bottom: 10em">
	</div>
</body>
</html>