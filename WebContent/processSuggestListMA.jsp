<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="rendezvous.UserProfileInfo"%>
<%@ page import="rendezvous.State"%>
<%@ page import="rendezvous.ProfilePlacementPriority"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="rendezvous.Customer"%>
<%@ page import="rendezvous.UserProfile"%>
<%@ page import="config.DateConstants"%>
<%@ page import="rendezvous.Like"%>
<%@ page import="staff.SuggestListMA"%>
<%@ page import="rendezvous.SuggestDate"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="Stylesheet/topbar.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/customerCenter.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/makeDate.css" type="text/css" rel="stylesheet">
<title>Record Date - Rendezvous</title>
</head>
<body>
	<!--=============================================================================-->
	<!--============================= Check Information =============================-->
	<!--=============================================================================-->
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
		response.sendRedirect("staffLogin.jsp");
		return;
	}
		
		try {
	%>
	<!--=============================================================================-->
	<!--================================ Top Bar ====================================-->
	<!--=============================================================================-->
	<!-- Top bar -->
	<div class="titleBar"></div>
	<div class=rendezvous>Rendezvous</div>
	<!-- Buttons -->
	<div class="signOut">
		<a href="suggestListMA.jsp">Back</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="signOut.jsp">Sign Out</a>
	</div>
	<div class="staffSSN">
	</div>
	<!--=============================================================================-->
	<!--========================== Retrieve Attributes ==============================-->
	<!--=============================================================================-->
	<%
		String Id1="";
		String Id2="";
		Id1=SuggestListMA.Id1;
		Id2=SuggestListMA.Id2;
		SuggestListMA.Id1="";
		SuggestListMA.Id2="";
 		if(SuggestListMA.AppendSuggestList( Id1, Id2)){
			%>
			<div style="text-align: center;font-size: 1.2em;color: red;">
			You add the profile Id to the user's recommendation successfully
			</div>
			<%
		}
		else{
			%>
			<div style="text-align: center;font-size: 1.2em;color: red;">
			The profile Id is already in the user's recommendation.
			</div>
			<%
		}
		} catch (Exception ex) {
			response.sendRedirect("managerHome.jsp");
			return;
		}
	%>
</body>
</html>