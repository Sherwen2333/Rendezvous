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
		if (session.getAttribute("username") == null)
			response.sendRedirect("login.jsp");
	%>
	<div class="titleBar"></div>
	<div class=rendezvous>Rendezvous</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!-- Button -->
	<div class="signOut">
		<a href="chooseProfile.jsp">Back</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="signOut.jsp">Sign Out</a>
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
		Customer Level
		<div class="helpList">
			Make a date with another customer profile
			<div class="helpText">
				On the homepage of the profile.
			</div>
		</div>
		<div class="helpList">
			Make a geo-date with another customer profile
			<div class="helpText">
				On the homepage of the profile.
			</div>
		</div>
		<div class="helpList">
			Cancel a date
			<div class="helpText">
				1. Click the "Dates" icon on the homepage of the profile.
				<br>
				2. Find the date you want to cancel in the list of "pendind date", and click "cancel"
			</div>
		</div>
		<div class="helpList">
			Comment on a date he/she went on or is going on
			<div class="helpText">
				1. Click the "Dates" icon on the homepage of the profile.
				<br>
				2. Find the date you want to comment in the list of "complete date", and click "See Detail".
			</div>
		</div>
		<div class="helpList">
			Like another customer's profile
			<div class="helpText">
				1. Cilck the "search" button on the homepage of the profile.
				<br>
				2. Input the profile Id you want ti like and submit.
				<br>
				3. Click the profile Id.
				<br>
				4. Click "Like".
			</div>
		</div>
		<div class="helpList">
			Refer a Profile B to Profile C so that Profile C can go on a "blind date" with Profile B.
			<div class="helpText">
				1. Cilck the "search" button on the homepage of the profile.
				<br>
				2. Input the profile Id you want ti like and submit.
				<br>
				3. Click the profile Id.
				<br>
				4. Input the profile C and click "refer to".
			</div>
		</div>
		<div class="helpList">
			A profile's pending dates
			<div class="helpText">
				Click the "Dates" icon on the homepage of the profile.
			</div>
		</div>
		<div class="helpList">
			A profile's past dates
			<div class="helpText">
				1. Click the "Dates" icon on the homepage of the profile.
				<br>
				2. Click the "Completed" button.
			</div>
		</div>
		<div class="helpList">
			A profile's favorites list (based on "likes")
			<div class="helpText">
				1. Click the "Like" icon on the homepage of the profile.
				<br>
				2. Click the "Given" button.
			</div>
		</div>
		<div class="helpList">
			Search for profiles based on physical characteristics, location, etc.
			<div class="helpText">
				Click the "Search" button on the homepage of the profile.
			</div>
		</div>
		<div class="helpList">
			Most active profiles
			<div class="helpText">
				Click the "Account Analysis" button on the page of "choose file".
			</div>
		</div>
		<div class="helpList">
			Most highly rated profiles
			<div class="helpText">
				Click the "Account Analysis" button on the page of "choose file".
			</div>
		</div>
		<div class="helpList">
			Popular geo-date locations
			<div class="helpText">
				Click the "Account Analysis" button on the page of "choose file".
			</div>
		</div>
		<div class="helpList">
			Personalized date suggestion list
			<div class="helpText">
				The left bottom part on the homepage of the profile. 
			</div>
		</div>
	</div>
</body>
</html>

