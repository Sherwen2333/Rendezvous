<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	page import="java.util.ArrayList"%>
<%@ page import="rendezvous.Login"%>
<%@ page import="rendezvous.Customer"%>
<%@ page import="rendezvous.UserProfile"%>
<%@ page import="rendezvous.MakeDateWith"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="Stylesheet/completedDate.css" type="text/css" rel="stylesheet">
<title>Completed Dates - Rendezvous</title>
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
	<div class="backBTN">
		<a href="userProfile.jsp">Back</a>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div>
	<form method = "POST" action="makeDateWithCheck.jsp">
		    	<div>
		    		<br>
		    		<br>
		        	Please enter the profile Id you want to make a date with:
		        	<br>
		        	<input type="text" name="Id" maxlength="24" style="width: 20em;">
		        </div>
		        <div class="error">
					<%
						try {
							switch (MakeDateWith.status_t){
							case 1:  { 
								out.println("There is no such profile.");
								MakeDateWith.init();
								break;
							}
							case 2:  { 
								out.println("This website only allows making a date between different genders.");
								MakeDateWith.init();
								break;
							}
							default: MakeDateWith.init();
							}
						} catch (Exception ex) {
						}
					%>
				</div>
		        <div>
		        	<input type="submit" value="Make a date">
		        </div>
	       </form>
	<br>
	
	</div>
</body>
</html>