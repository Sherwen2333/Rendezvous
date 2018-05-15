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

<title>Make Date - Rendezvous</title>
</head>
<body>
	<!--=============================================================================-->
	<!--============================= Check Information =============================-->
	<!--=============================================================================-->
	<!-- Check Information -->
	<%
		try {
			if(session.getAttribute("username") == null) {
				response.sendRedirect("login.jsp");
				return;
			}
		} catch (Exception ex) {
			
		}
		try {
			String pid = request.getParameter("pid");
			if(pid.length() <= 0){
				response.sendRedirect("chooseProfile.jsp");
				return;
			}
			
			String username = (String) session.getAttribute("username");
			if(UserProfile.checkCorrespondence(username, pid)){
				response.sendRedirect("profileInfo_Cus.jsp?pid="+pid+"&op=0");
				return;
			}
			
			String backURL;
			if(session.getAttribute("profileId") == null){
				backURL = "chooseProfile.jsp";
			} else {
				backURL = "profileInfo_Cus_ViewOnly.jsp?pid=" + pid;
			}
	%>
	<!--=============================================================================-->
	<!--================================ Top Bar ====================================-->
	<!--=============================================================================-->
	<!-- Top bar -->
	<div class="titleBar"></div>
	<div class=rendezvous>Rendezvous</div>
	<!-- Buttons -->
	<div class="signOut">
		<a href="<%=backURL%>">Back</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="signOut.jsp">Sign Out</a>
	</div>
	<div class="staffSSN">
	</div>
	<!--=============================================================================-->
	<!--========================== Retrieve Attributes ==============================-->
	<!--=============================================================================-->
	<%
		UserProfileInfo info = UserProfileInfo.getProfileInfo(pid);
		if(info == null || request.getParameter("op") == null){
			response.sendRedirect("chooseProfile.jsp");
			return;
		}
		int option = Integer.parseInt(request.getParameter("op"));
	%>
	<!--=============================================================================-->
	<!--============================== Title Icon ===================================-->
	<!--=============================================================================-->
	<div class="md_icon">
		<i class="fa fa-heartbeat"></i>
	</div>
	<div class="md_text">
		Make Date With <em><%=info.getProfileId()%></em>
	</div>
	<!--=============================================================================-->
	<!--================================= Form ======================================-->
	<!--=============================================================================-->
	<div class="formContainer">
	<div class="formInnerContainer">
		<form method="post" action="processMakeDate.jsp?pid=<%=pid%>">
			<div>
				My Profile: <em><%= (String)session.getAttribute("profileId") %></em>
			</div>
			<!--============= Date =============-->
			<div>
				<b>Date(mm-dd-yy)*: </b><select name="date_Month">
				<%
					for(int i = 0; i < DateConstants.MONTH.size(); i++){
						if(i == DateConstants.CURRENT_MONTH){
				%>
				<option value="<%=i+1%>" selected><%=DateConstants.MONTH.get(i)%></option>
				<%
						} else {
				%>
				<option value="<%=i+1%>"><%=DateConstants.MONTH.get(i)%></option>
				<%
						}
					}
				%>
				</select>&nbsp;-&nbsp;<select name="date_Day">
				<%
					for(int i = 0; i < DateConstants.DAY.size(); i++){
						if(i == DateConstants.CURRENT_DAY){
				%>
				<option value="<%=DateConstants.DAY.get(i)%>" selected><%=DateConstants.DAY.get(i)%></option>
				<%
						} else {
				%>
				<option value="<%=DateConstants.DAY.get(i)%>"><%=DateConstants.DAY.get(i)%></option>
				<%
						}
					}
				%>
				</select>&nbsp;-&nbsp;<select name="date_Year">
				<%
					for(int i = 0; i < DateConstants.YEAR.size(); i++){
				%>		
				<option value="<%=DateConstants.YEAR.get(i)%>"><%=DateConstants.YEAR.get(i)%></option>
				<%
					}
				%>
				</select>
			</div>
			<!--============= Time =============-->
			<div>
				<b>Time(hh:mm:ss)*: </b><select name="date_Hour">
				<%
					for(int i = 0; i < DateConstants.HOUR.size(); i++){
				%>
				<option value="<%=i%>"><%=DateConstants.HOUR.get(i)%></option>
				<%
					}
				%>
				</select>&nbsp;:&nbsp;<select name="date_Minute">
				<%
					for(int i = 0; i < DateConstants.MINUTE.size(); i++){
				%>
				<option value="<%=i%>"><%=DateConstants.MINUTE.get(i)%></option>
				<%
					}
				%>
				</select>&nbsp;:&nbsp;<select name="date_Second">
				<%
					for(int i = 0; i < DateConstants.SECOND.size(); i++){
				%>
				<option value="<%=i%>"><%=DateConstants.SECOND.get(i)%></option>
				<%
					}
				%>
				</select>
			</div>
			<div style="text-align: right; font-size: 0.9em;">
				<b>Use Current Time**: </b><input type="checkbox" name="date_UseCurrentTime">
			</div>
			<!--============= Location =============-->
			<div>
				<b>Location: </b><input type="text" name="date_Loaction" maxlength="100" style="width:30em;">
			</div>
			<!--============= ZipCode =============-->
			<div>
				<b>ZipCode: </b><input type="text" name="date_Zipcode" maxlength="5" style="width:8em;">
			</div>
			<!--=================================-->
			<!--============= Error =============-->
			<div class="error">
				<%
					switch(option){
					case 1: {
						out.print("Invalid Date or Time");
						break;
					}
					case 2: {
						out.print("Location and zipcode must be filled together");
						break;
					}
					case 3: {
						out.print("You can only date a profile of a different gender");
						break;
					}
					case 4: {
						out.print("Failed");
						break;
					}
					case 100: {
						out.print("Success!");
						break;
					}
					}
				%>
			</div>
			<!--============= Submit =============-->
			<div class="submitBTN">
				<input class="submitBTN" type="submit" value="Request">
			</div>
			<!--============= Hint =============-->
			<div style="font-size: 0.6em; margin-top: 1em; color: grey;">
				* Must be fill in with valid date and time
			</div>
			<div style="font-size: 0.6em; margin-top: -0.5em; color: grey;">
				** You may ignore Date and Time fields when "Use Current Time" is checked
			</div>
		</form>
	</div>
	</div>
	<!--=============================================================================-->
	<!--=============================== Exception ===================================-->
	<!--=============================================================================-->
	<%
		} catch (Exception ex) {
			response.sendRedirect("chooseProfile.jsp");
			return;
		}
	%>
</body>
</html>