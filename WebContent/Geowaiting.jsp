<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="rendezvous.GeoLocation"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="refresh" content="3">
<link href="Stylesheet/geoDate.css" type="text/css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Waiting</title>
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
		<a href="GeoCancel.jsp">Back</a>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="geoTitle">
		Waiting
		
	<%
		if (session.getAttribute("username") == null) {
			response.sendRedirect("login.jsp");
			return;
		}
		if (session.getAttribute("profileId") == null) {
			response.sendRedirect("chooseProfile.jsp");
			return;
		}
		if (!GeoLocation.waiting) {
			GeoLocation.DeleteMessageReceived((String) session.getAttribute("profileId"));
			response.sendRedirect("userProfile.jsp");
		} else {
			ArrayList<String> List = new ArrayList<String>();
			int status = GeoLocation.FindPeopleNearBy((String) session.getAttribute("profileId"));
			switch (status) {
			case 0: {
				String addr = request.getParameter("addr");
				if (addr == null || addr.isEmpty()) {
					GeoLocation.status = 1;
					response.sendRedirect("GeoCheck.jsp");
					return;
				}
				List = GeoLocation.NearBy;
				for (int i = 0; i < List.size(); i++) {
					int status2 = GeoLocation.SendMessage(List.get(i), (String) session.getAttribute("profileId"),
							addr);
				}
			}
				break;
			case 1: {
				String ip = GeoLocation.getIp(request);
				GeoLocation.setIP((String) session.getAttribute("profileId"), ip);
				status = GeoLocation.FindPeopleNearBy((String) session.getAttribute("profileId"));
			}
				break;
			case 2: {
				GeoLocation.NearBy = new ArrayList<String>();
				out.println("Unknown Error");
			}
				break;
			case 3: {
				GeoLocation.NearBy = new ArrayList<String>();
				out.println("No one is here. Please retry after several minutes.");
			}
				break;
			}
	%>
	</div>
	<div class="geoTitle" style="font-size: 4em; margin: 0.5em;">
		<i class="fa fa-spinner fa-spin"></i>
	</div>
	<div class="cancelBTN">
		<a href="GeoCancel.jsp">Cancel</a>
	</div>
	<%
		}
	%>
</body>
</html>