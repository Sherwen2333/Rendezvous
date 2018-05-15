<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	page import="java.util.ArrayList"%>
<%@ page import="rendezvous.Login"%>
<%@ page import="rendezvous.UserProfile"%>
<%@ page import="rendezvous.PopularZip"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="Stylesheet/topbar.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/pendingDate.css" type="text/css" rel="stylesheet">
<title>Search - Rendezvous</title>
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
	<!-- most active zip -->
	<br>
	<br>
	<br>
	<h2>The most popular geo-date locations:</h2>
	<div style="border:1px solid #D0D0D0;width:600px;padding:10px;">
    <br>
    <%
    	ArrayList<String> list = new ArrayList<String>();
            list=PopularZip.MostActiveZip();
            if(list.size()==0){
    %>
    	Sorry, you haven't had a date.
    <%	
    }
    else{
    %>
		Popular Zip: <br> 
	<%
  	for(String s : list){
  		out.println(s);
  		%><br> 
		<%
  	}
    }
    %>
	</div>
</body>
</html>