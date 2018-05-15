<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="rendezvous.Login"%>
<%@ page import="rendezvous.Customer"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="rendezvous.PopularGeoAll"%>
<%@ page import="rendezvous.PopularGeo"%>
<%@ page import="rendezvous.PopularZip"%>
<%@ page import="rendezvous.PopularZipAll"%>
<%@ page import="rendezvous.DetailInfo"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- Head -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="Stylesheet/accountAnalysis.css" type="text/css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Account Analysis - Rendezvous</title>
</head>
<!-- Body -->
<body>
	<%
		if(session.getAttribute("username") == null) {
			response.sendRedirect("login.jsp");
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
	<%
		try {
	%>
	<!-- Link to upgrade -->
	<a href="chooseProfile.jsp">Back</a>
	<%
		} catch (Exception ex) {
		}
	%>
		&nbsp;&nbsp;&nbsp;&nbsp;<a href="signOut.jsp">Sign Out</a>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!-- Page title -->
	<div class="welcomeIcon">
		<i class="fa fa fa-leaf"></i>
	</div>
	<div class="welcomeText">
		Account Analysis
	</div>
	<!--=============================================================================-->
	<!--=========================      Most Active Profile      =====================-->
	<!--=============================================================================-->
	<div class="container1">
		<div class="title1">
			Most Active Profile
		</div>
	<%
		DetailInfo.cip = (String)session.getAttribute("username");
		boolean status = DetailInfo.SearchInfo();
		if(status == false) {
			out.print("No Available Data");
		} else {
			DetailInfo.rs.previous();
	%>
		<table>
			<tr>
				<th style="font-weight: 500;">Profile ID</th>
				<th style="font-weight: 500;">Date Times</th>
			</tr>
	<%
		
		while (DetailInfo.rs.next()) {
			   String aa = DetailInfo.rs.getString(1);
		       String bb = DetailInfo.rs.getString(2);
	%>
		    <tr>
				<td><%=aa%></td>
				<td><%=bb%></td>
			</tr>
	<%
		}
	%>
		</table>
	<%
		} 
	%>
	</div>
	<!--=============================================================================-->
	<!--=====================      Most High-Rated Profile      =====================-->
	<!--=============================================================================-->
	<div class="container1">
		<div class="title1">
			Most High-Rated Profile
		</div>
	<%
		DetailInfo.cip = (String)session.getAttribute("username");
		boolean status2 = DetailInfo.SearchInfo2();
		if(status2 == false) {
			out.print("No Available Data");
		} else {
			DetailInfo.rs.previous();
	%>
		<table>
			<tr>
				<th style="font-weight: 500;">Profile ID</th>
				<th style="font-weight: 500;">Total Rate</th>
			</tr>
	<%
		
		while (DetailInfo.rs.next()) {
			   String aa = DetailInfo.rs.getString(1);
		       String bb = DetailInfo.rs.getString(2);
	%>
		    <tr>
				<td><%=aa%></td>
				<td><%=bb%></td>
			</tr>
	<%
		}
	%>
		</table>
	<%
		} 
	%>
	</div>
	<!--=============================================================================-->
	<!--==========================      GEO LOCATION       ==========================-->
	<!--=============================================================================-->
	<div class="container1">
		<div class="title1">
			My Favorite Geo-Location
		</div>
		<%
			ArrayList<String> list = new ArrayList<String>();
			list = PopularGeo.MostActiveGeo();
		%>
		<div>
			<%
			    if(list.size()==0){
			%>
			    	No Available Data
			<%	
			    } else{
			%>
			<table>
			<%
			  	for(String s : list){
			  		if(s == null){
			  			continue;
			  		}
			%>
			<tr>
				<td><%=s%></td>
			</tr>
			<%
			    }
			%>
			</table>
			<%
			    }
			%>
		</div>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="container1">
		<div class="title1">
			Most Favorite Geo-Location
		</div>
		<%
			list = new ArrayList<String>();
			list = PopularGeoAll.MostActiveGeoAll();
		%>
		<div>
			<%
			    if(list.size()==0){
			%>
			    	No Available Data
			<%	
			    } else{
			%>
			<table>
			<%
			  	for(String s : list){
			  		if(s == null){
			  			continue;
			  		}
			%>
			<tr>
				<td><%=s%></td>
			</tr>
			<%
			    }
			%>
			</table>
			<%
			    }
			%>
		</div>
	</div>
	<!--=============================================================================-->
	<!--=================================      ZIP      =============================-->
	<!--=============================================================================-->
	<div class="container1">
		<div class="title1">
			My Favorite Zipcode
		</div>
		<%
			list = PopularZip.MostActiveZip();
		%>
		<div>
			<%
			    if(list.size()==0){
			%>
			    	No Available Data
			<%	
			    } else{
			%>
			<table>
			<%
			  	for(String s : list){
			  		if(s == null){
			  			continue;
			  		}
			%>
			<tr>
				<td><%=s%></td>
			</tr>
			<%
			    }
			%>
			</table>
			<%
			    }
			%>
		</div>
	</div>
	<div class="container1">
		<div class="title1">
			Most Favorite Zipcode
		</div>
		<%
			list = PopularZipAll.MostActiveZipAll();
		%>
		<div>
			<%
			    if(list.size()==0){
			%>
			    	No Available Data
			<%	
			    } else{
			%>
			<table>
			<%
			  	for(String s : list){
			  		if(s == null){
			  			continue;
			  		}
			%>
			<tr>
				<td><%=s%></td>
			</tr>
			<%
			    }
			%>
			</table>
			<%
			    }
			%>
		</div>
	</div>
	
</body>
</html>