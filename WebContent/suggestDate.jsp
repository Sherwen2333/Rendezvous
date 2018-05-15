<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	page import="java.util.ArrayList"%>
<%@ page import="rendezvous.Login"%>
<%@ page import="rendezvous.UserProfile"%>
<%@ page import="rendezvous.SuggestDate"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="Stylesheet/topbar.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/search.css" type="text/css" rel="stylesheet">
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
	<div class="signOut">
		<a href="userProfile.jsp">Back</a>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!-- Search Profiles -->
	<div>
    <br>
    <%
    	ArrayList<String> list = new ArrayList<String>();
            list=SuggestDate.suggestDate();
            if(list.size()==0){
    %>
    <%	
    }
    else{
    %>	<div>SuggestedId		Age		City		State		Rate<br> 
		</div>
	<%
  	for(int i=0;i<list.size();i+=5){
  		%>
  		<div>
  		<a href="http://www.google.com"><%=list.get(i)%></a> <%=list.get(i+1)%> 	<%=list.get(i+2)%> 	<%=list.get(i+3)%> <%=list.get(i+4)%>
  		</div> 
		<%
  	}
    }
    %>
	</div>
</body>
</html>