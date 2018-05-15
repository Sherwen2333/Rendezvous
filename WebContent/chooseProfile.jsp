<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="rendezvous.Login"%>
<%@ page import="rendezvous.Customer"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- Head -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="Stylesheet/chooseProfile.css" type="text/css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Choose Profile - Rendezvous</title>
</head>
<!-- Body -->
<body>
	<%
		if(session.getAttribute("username") == null) {
			response.sendRedirect("login.jsp");
			return;
		}
	%>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="titleBar"></div>
	<div class="rendezvous">
		Rendezvous
	</div>
	<div class="signOut">
	<%
		try {
			String ppp = (String) session.getAttribute("ppp");
			if (ppp == null) {
				String username = (String) session.getAttribute("username");
				ppp = Customer.getProfilePlacementPriority(username);
				session.setAttribute("ppp", ppp);
			}
			if (ppp != null) {
	%>
	<!-- Link to upgrade -->
	<a href="upgrade.jsp">Change Plan</a>
	<%
			} else
				out.println("Unable to retrive your plan.");
		} catch (Exception ex) {
		}
	%>
		&nbsp;&nbsp;&nbsp;&nbsp;<a href="help.jsp">Help</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="signOut.jsp">Sign Out</a>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!-- Page title -->
	<div class="welcomeIcon">
		<i class="fa fa-user-circle-o"></i>
	</div>
	<div class="welcomeText">
		<%
			try {
				String username = (String) session.getAttribute("username");
				if (username == null) {
					session.setAttribute("session", "FALSE");
					Login.status = true;
					response.sendRedirect("login.jsp");
					return;
				}
				out.println(username);
			} catch (Exception ex) {
			}
		%>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!-- Button Block -->
	<div class="optionContainer">
		<a class="option" href="CreateProfile.jsp">Create New Profile</a>
		<a class="option" href="accountAnalysis.jsp">Account Analysis</a>
		<a class="option" href="customerInfoViewOnly.jsp?op=0">Account Detail</a>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<%
		try {
			String username = (String) session.getAttribute("username");
			ArrayList<String> list = Customer.getProfileList(username);
			if (list != null && !list.isEmpty()) {
	%>
	<div class="profileContainer">
		<form action="userProfileTemp.jsp">
			<select name="profId" class="profile">
				<%
					for (int i = 0; i < list.size(); i++) {
				%>
				<option class="profOption" value="<%=list.get(i)%>"><%=list.get(i)%></option>
				<%
					}
				%>
			</select>
			<input class="submit" type="submit" value="Go">
		</form>
	</div>
	<%
			}

		} catch (Exception ex) {
		}
	%>

</body>
</html>