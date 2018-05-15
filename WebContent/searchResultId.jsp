<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	page import="java.util.ArrayList"%>
<%@ page import="rendezvous.Login"%>
<%@ page import="rendezvous.UserProfile"%>
<%@ page import="rendezvous.Search"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="Stylesheet/topbar.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/search.css" type="text/css" rel="stylesheet">
<title>Search Result - Rendezvous</title>
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
		<a href="userProfile.jsp">Back</a>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="searchTitle">
		<i class="fa fa-search"></i> Search Result
	</div>
	<%
		String Id = "";
		if (!request.getParameter("Id").isEmpty()) {
			Id = request.getParameter("Id");
		}
		ArrayList<String> list = new ArrayList<String>();

		if (!Id.isEmpty()) {
			if (Id.contains("'") || Id.contains("\\") || Id.contains("&")) {
	%>
	<div style="color: grey; text-align: center; font-size: 1.2em;">
		Sorry, there are no such profiles.
	</div>
	<%
		} else {
				if(Search.ProfileCheck(Id)){
					%>
					<div style="color: grey; text-align: center; font-size: 1.2em;">
							This is your profile.
					</div>
					<%
				}
				else{
				list = Search.SearchBaseOnId(Id);
				if (list.size() == 0) {
	%>
	<div style="color: grey; text-align: center; font-size: 1.2em;">
			Sorry, there are no such profiles.
	</div>
	<%
				} else {
	%>
	<div style="text-align: center; font-size: 1.2em; font-weight: 550; margin-bottom: 1em;">
		Profile ID
	</div>
	<%
					for (String s : list) {
	%>
	<div class="result">
		<a href="profileInfo_Cus_ViewOnly.jsp?pid=<%=s%>" ><%=s%></a>
	</div>
	<%
					}
				}
		}
			}
		} else {
	%>
	<div style="color: grey; text-align: center; font-size: 1.2em;">
			Sorry, there are no such profiles.
	</div>
	<%
		}
	%>


</body>
</html>