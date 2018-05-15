<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	page import="java.util.ArrayList"%>
<%@ page import="rendezvous.Login"%>
<%@ page import="rendezvous.Customer"%>
<%@ page import="rendezvous.UserProfile"%>
<%@ page import="rendezvous.RetrievePhoto"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="Stylesheet/photo.css" type="text/css" rel="stylesheet">
<title>Album - Rendezvous</title>
</head>
<body>
	<%
		if (session.getAttribute("username") == null){
			response.sendRedirect("login.jsp");
			return ;
		}
		if(session.getAttribute("profileId") == null){
			response.sendRedirect("chooseProfile.jsp");
		}
		String pId=request.getParameter("pId");
		if(pId==null){
			response.sendRedirect("userProfile.jsp");
			return ;
		}else{
			if(pId.equals(session.getAttribute("profileId"))) {
				response.sendRedirect("photo.jsp");
				return ;
			}
			else{

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
	<!-- Photo Title -->
	<div class="photoTitle">
		<div class="photoIcon">
			<i class="fa fa-image"></i>
		</div>
		<div class="photoText">Photos</div>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!-- Upload Container -->
	
	<%
		
	
	%>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!-- Photo Container -->
	<div class="photoContainer">
		<div class="photoContainerInner">
			<%
				String profId = pId;
				ArrayList<String> result = RetrievePhoto.retrieve(profId);
				if (result == null) {
					out.println("Error");
				} else {
					for (int i = 0; i < result.size(); i++) {
						String url = result.get(i);
			%>
			<img class="image" src="<%=url%>">
			<%
				if (i % 3 == 2) {
			%>
			<br>
			<%
				}
					}
				}
			%>
		</div>
	</div>
	<%}
	} %>
</body>
</html>