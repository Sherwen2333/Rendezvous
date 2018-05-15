<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	page import="java.util.ArrayList"%>
<%@ page import="rendezvous.Login"%>
<%@ page import="rendezvous.Customer"%>
<%@ page import="rendezvous.UserProfile"%>
<%@ page import="rendezvous.SuggestDate"%>
<%@ page import="rendezvous.GeoLocation"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="refresh" content="30">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="Stylesheet/userProfile.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/homeLeftSection.css" type="text/css"
	rel="stylesheet">
<link href="Stylesheet/profileSection.css" type="text/css"
	rel="stylesheet">
<title>Home - Rendezvous</title>
</head>
<body>
	<%
		if(session.getAttribute("username") == null){
			response.sendRedirect("login.jsp");
			return;
		}
		if(session.getAttribute("profileId") == null){
			response.sendRedirect("chooseProfile.jsp");
		}
	
		if(GeoLocation.acceptName!=null){
			%>
			<script>
			alert("Congratulations! <%=GeoLocation.acceptName%> has accepted your invitation. Enjoy yourself.");
			</script>
			<%
			GeoLocation.acceptName=null;
			GeoLocation.waiting=false; 
	        GeoLocation.DeleteMessageSent((String)session.getAttribute("profileId"));
		}
	%>
	<%GeoLocation.detailaddr_t=null; %>
	<div class="titleBar"></div>
	<div class=rendezvous>Rendezvous</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!-- Buttons -->
	<div class="topBTN"></div>
	<div class="switch">
		<a href="search.jsp" target="_blank">Search <i class="fa fa-search"></i></a>
		&nbsp;&nbsp;
		<a href="Message.jsp">Message (<%= GeoLocation.CountMessage((String)session.getAttribute("profileId")) %>) 
		<i class="fa fa-envelope"></i></a>
		&nbsp;&nbsp;
		<a href="chooseProfile.jsp">Switch Profile <i class="fa fa-exchange"></i></a>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!-- LEFT SECTION -->
	<div class="leftSection">
		<table class="leftTopBar_Table">
			<col width="20%" />
			<col width="20%" />
			<col width="20%" />
			<col width="20%" />
			<col width="20%" />
			<tr>
				<td class="datesBTN"><a href="pendingDates.jsp" class="dateText"><i class="fa fa-calendar-check-o dateIcon"></i><br />Dates</a></td>
				<td class="photosBTN"><a href="photo.jsp" class="photoText"><i class="fa fa-image photoIcon"></i><br />Photos</a></td>
				<td class="likesBTN"><a href="profileLikes.jsp" class="likesText"><i class="fa fa-heart likesIcon"></i><br />Likes</a></td>
				<td class="referralBTN"><a href="Referrals.jsp?pid=<%=session.getAttribute("profileId")%>" class="referralText"><i class="fa fa-users referralIcon"></i><br />Referrals</a></td>
				<td class="geoBTN"><a href="GeoCheck.jsp" class="geoText"><i class="fa fa-coffee geoIcon"></i><br />Geo Date</a></td>
			</tr>
		</table>

		<!-------------------->
		<!-- Upcoming Dates -->
		<div class="upcomingTitle">Upcoming Date</div>
		<div class="upcomingContainer">
			<%
				ArrayList<String> pendingDate = UserProfile.getFirstUpcomingDate();
				if (pendingDate.size() == 0) {
			%>
			<div class="upcomingNoDate">No Upcoming Date</div>
			<%
				} else {
			%>
			<div class="upcomingId">
			<b>With: </b>
			<%
				out.println(pendingDate.get(0));
			%>
			</div><!-- End Of upcomingId -->
			<div class="upcomingLocation">
			<b>Location: </b>
			<%
				out.println(pendingDate.get(3));
			%>
			</div><!-- End Of upcomingLocation -->
			<div class="upcomingFee">
			<b>Fee: </b>
			<%
				out.println(pendingDate.get(4));
			%>
			</div><!-- End Of upcomingFee -->
			<div class="upcomingDate">
			<%
				out.println(pendingDate.get(1));
			%>
			</div><!-- End Of upcomingDate -->
			<div class="upcomingTime">
			<%
				out.println(pendingDate.get(2));
			%>
			</div><!-- End Of upcomingTime -->
			<%
				}
			%>
			<div></div>
		</div>
		<!-------------------->
		<!-- Recommendation -->
		<div class="recommendationTitle">Recommendation</div>
		<div class="recommendationContainer">
			<div class="recommendationContent">
			    <%
		    		ArrayList<String> list = new ArrayList<String>();
		            list=SuggestDate.suggestDate();
		            if(list.size()==0){
		    	%>
		    		<div>No Data Available</div>
		    	<%	
		    		} else{
		    	%>	
		    	<table style="width:100%; text-align: center; padding: 1.2em;">
		    		<tr class="suggestHeader">
						<th style="font-weight:550;">Profile ID</th>
						<th style="font-weight:550;">Age</th> 
						<th style="font-weight:550;">City</th>
						<th style="font-weight:550;">State</th>
						<th style="font-weight:550;">Rate</th>
					</tr>
					<%
						for(int i = 0; i < list.size(); i += 5){
					%>
					<tr>
						<td><a href="profileInfo_Cus_ViewOnly.jsp?pid=<%=list.get(i)%>" target="_blank"><%=list.get(i)%></a></td>
						<td><%=list.get(i+1)%></td> 
						<td><%=list.get(i+2)%></td>
						<td><%=list.get(i+3)%></td>
						<td><%=list.get(i+4)%>&nbsp;<i class="fa fa-star"></i></td>
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
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!-- Profile Section -->
	<div class="profileContainer">
		<!-- Avatar -->
		<div class="prof_Avatar">
			<i class="fa fa-user-circle-o"></i>
		</div>
		<!-- Profile Id -->
		<div class="prof_Id">
			<%
				out.println(UserProfile.getProfileId());
				String gender = UserProfile.getGender().toLowerCase();
				if (gender.startsWith("m")) {
			%>
			<i class="fa fa-mars" style="color: #67baca; font-weight: bold;"></i>
			<%
				} else {
			%>
			<i class="fa fa-venus" style="color: #ffbebd; font-weight: bold;"></i>
			<%
				}
				if (UserProfile.getProfileName() != null && UserProfile.getProfileName().length() > 0) {
			%><br>
			(<%=UserProfile.getProfileName()%>)
			<%} %>
		</div>
		<!-- Rate -->
		<div class="prof_Rate">
			<%
				out.println(String.format("%.2f ", UserProfile.getTotalRate()));
			%><i class="fa fa-star"></i>
		</div>
		<!-- Pending Date -->
		<!-- Completed Date -->
		<div class="tableDataPC">
			<table style="width:100%; text-align: center;">
			<col width="50%" />
			<col width="50%" />
			<tr>
				<th>Pending</th>
				<th>Completed</th>
			</tr>
			<tr>
				<td><%=UserProfile.getNumPendingDate() %></td>
				<td><%=UserProfile.getNumCompletedDate() %></td>
			</tr>
			</table>
		</div>
		<!-- Age Height Weight -->
		<div class="tableDataA">
			<table style="width:100%; text-align: center;">
			<col width="33.333333%" />
			<col width="33.333333%" />
			<col width="33.333334%" />
			<tr>
				<th>Age(yr.)</th>
				<th>Height(ft.)</th>
				<th>Weight(lb.)</th>
			</tr>
			<tr>
				<td><%=UserProfile.getAge()%></td>
				<td><%
					double height = UserProfile.getHeight();
					if (height == 0.0) {
						out.println("N/A");
					} else {
						out.println(String.format("%.1f", height));
					}
				%></td>
				<td><%
					double weight = UserProfile.getWeight();
					if (weight == 0.0) {
						out.println("N/A");
					} else {
						out.println(String.format("%.1f", weight));
					}
				%></td>
			</tr>
			</table>
		</div>
		<!-- Address -->
		<div class="prof_AddrTitle">Address</div>
		<div class="prof_Address">
			<%
				out.println(UserProfile.getAddress());
			%>
		</div>
		<!-- City, State -->
		<div class="prof_Address">
			<%
				out.println(UserProfile.getCity() + ", " + UserProfile.getState());
			%>
		</div>
		<!-- Hair Color -->
		<div class="prof_HairColorTitle">Hair Color</div>
		<div class="prof_HairColor">
			<%
				out.println(UserProfile.getHairColor());
			%>
		</div>
		<!-- Hobby -->
		<div class="prof_HobbyTitle">Hobby</div>
		<div class="prof_Hobby">
			<%
				out.println(UserProfile.getHobby());
			%>
		</div>
		<!-- Profile Creation Date -->
		<div class="prof_Created">
			<%
				out.println("Created on " + UserProfile.getCreationDate());
			%>
		</div>
		<!-- Edit Button -->
		<div class="prof_Edit">
			<a href="profileInfo_Cus.jsp?pid=<%=UserProfile.getProfileId()%>&op=0">Edit <i class="fa fa-edit"></i></a>
		</div>
	</div>
</body>
</html>