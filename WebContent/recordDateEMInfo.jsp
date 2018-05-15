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
<%@ page import="staff.RecordDateEM"%>
<%@ page import="staff.RecordDateEMInfo"%>
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

<title>Profile Info - Rendezvous</title>
</head>
<body>
	<!--=============================================================================-->
	<!--============================= Check Information =============================-->
	<!--=============================================================================-->
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
		<a href="employeeHome.jsp">Back</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="signOut.jsp">Sign Out</a>
	</div>
	<div class="staffSSN">
	</div>
	<!--=============================================================================-->
	<!--========================== Retrieve Attributes ==============================-->
	<!--=============================================================================-->
	<%
		String pid="";
		pid=RecordDateEM.Id2;
		
		
		int option = 0;
	%>
	<!--=============================================================================-->
	<!--============================== Title Icon ===================================-->
	<!--=============================================================================-->
	<div class="md_icon">
		<i class="fa fa-heartbeat"></i>
	</div>
	<div class="md_text">
		Date between <em><%=RecordDateEM.Id1%></em> and <em><%=RecordDateEM.Id2%></em>
	</div>
	<!--=============================================================================-->
	<!--================================= Form ======================================-->
	<!--=============================================================================-->
	<div class="formContainer">
	<div class="formInnerContainer">
		<form method="post" action="recordDateEMInfoCheck.jsp">
			<!--============= pid =============-->
			<div>
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
			<hr>
			<div><b></b></div>
			<!--============= Location =============-->
			<div>
				<b>Location: </b><input type="text" name="date_Loaction" maxlength="100" style="width:30em;">
			</div>
			<!--============= ZipCode =============-->
			<div>
				<b>ZipCode: </b><input type="text" name="date_Zipcode" maxlength="5" style="width:8em;">
			</div>
			<!--============= RepId =============-->
			<div>
				<b>RepId: </b><input type="text" name="repId" maxlength="24" style="width:8em;">
			</div>
			<!--============= Fee =============-->
			<div>
				<b>Fee: </b><input type="text" name="fee" maxlength="24" style="width:8em;">
			</div>
			<!--=================================-->
			<!--============= Error =============-->
			<div class="error">
				<%
					switch(RecordDateEMInfo.status){
					case 1: {
						out.print("Invalid Date or Time");
						break;
					}
					case 2: {
						out.print("location and zipcode both must be filled or not be filled");
						break;
					}
					case 3: {
						out.print("Zip code must be a positive number");
						break;
					}
					case 4: {
						out.print("Representative Id and Fee must not be null");
						break;
					}
					case 5: {
						out.print("Fee must be a positive number");
						break;
					}
					case 6: {
						out.print("There is no such Representative Id");
						break;
					}
					case 7: {
						out.print("Please don't choose the past time");
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
			response.sendRedirect("employeeHome.jsp");
			return;
		}
	%>
</body>
</html>