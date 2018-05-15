<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="rendezvous.GeoLocation"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="Stylesheet/geoDate.css" type="text/css" rel="stylesheet">
<title>Make Geo Date</title>
</head>
<body>
	<%
		if(session.getAttribute("username") == null){
			response.sendRedirect("login.jsp");
			return;
		}
		if(session.getAttribute("profileId") == null){
			response.sendRedirect("chooseProfile.jsp");
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
		<a href="userProfile.jsp">Back</a>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="geoTitle">
		Broadcast Your Location<br>AND<br>Start a Geo-Date
	</div>
	<div class="formContainer">
		<form action="GeoTemp.jsp" method="post">
			<input type="text" name="detailaddr" maxlength="50" class="tf" placeholder="Enter Location Here"
				value="<%=GeoLocation.detailaddr_t == null ? "" : GeoLocation.detailaddr_t%>">
		</form>
	</div>
	<%
		if (GeoLocation.status == 0) {
		} else if (GeoLocation.status == 1) {
			out.println("Address cannot be empty.");
			GeoLocation.status = 0;
			GeoLocation.detailaddr_t = null;
		}
	%>
	<div style="margin: 5em;"></div>
</body>
</html>