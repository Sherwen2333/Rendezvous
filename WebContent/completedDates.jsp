<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	page import="java.util.ArrayList"%>
<%@ page import="rendezvous.Login"%>
<%@ page import="rendezvous.Customer"%>
<%@ page import="rendezvous.UserProfile"%>
<%@ page import="rendezvous.Date"%>
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
	<!-- Date Title -->
	<div class="dateTitle">
		<div class="dateIcon">
			<i class="fa fa-calendar-check-o"></i>
		</div>
		<div class="dateText">Dates</div>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!-- Like Container -->
	<div style="width:100%; margin-left: 50%; margin-top: 1.5em; margin-bottom: 0em;">
	<div style="width:20%; margin-left: -10%; align: center;">
		<table width="100%">
			<col width="50%" />
			<col width="50%" />
			<tr>
				<td class="pendingBTN"><a href="pendingDates.jsp">Pending</a></td>
				<td class="completedBTN"><a href="completedDates.jsp">Completed</a></td>
			</tr>
		</table>
	</div>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="dateContainer">
		<%
			// id -> DateTime -> Location -> Fee
			ArrayList<Date> pastDates = UserProfile.getAllCompletedDate2();
			if (pastDates.size() <= 0) {
		%>
		<div class="dateNoData">No Data Found</div>
		<%
			} else {
				for (int i = 0; i < pastDates.size(); i++) {
					Date dateObj = pastDates.get(i);
					String idString = "" + dateObj.getDateId();
					long dateId = dateObj.getDateId();
					if(dateId < 100000) {
						idString = String.format("%06d", dateId);
					}
					if (i % 2 == 0) {
		%>
		<div class="completedLeft">
			<div class="completedLeftText">
				<div class="completedCircle">
					<div class="completedCircleAlign"></div>
				</div>
				<b><% out.print(dateObj.getDateTime()); %></b><br>
			</div>
			<%
				boolean isValidWith = dateObj.getUserAId() != null;//profileInfo_Cus_ViewOnly.jsp
			%>
			<div class="completedLeftInfo">
				DateId: <% out.print(idString);%><br>
				<%
					if(isValidWith) {
				%>
				<a href="profileInfo_Cus_ViewOnly.jsp?pid=<%=dateObj.getUserAId()%>">With: <% out.print(dateObj.getUserAId());%></a><br>
				<%
					} else {
				%>
				With: <% out.print("N/A");%><br>
				<%
					}
				%>
				Location: <% out.print(dateObj.getGeoLoc());%><br>
				Fee: <% out.print(dateObj.getFee());%><br>
			</div>
			<div class="leftCancelBTN">
				<a href="dateDetail.jsp?dateId=<%=dateId%>">See Detail</a>
			</div>
		</div>
		<%
			} else {%>
			<div class="completedRight">
				<div class="completedRightText">
					<div class="completedRightCircle"><div class="completedRightCircleAlign"></div></div>
					<b><% out.print(dateObj.getDateTime()); %></b><br>
				</div>
			<%
				boolean isValidWith = dateObj.getUserAId() != null;
			%>
				<div class="completedRightInfo">
					DateId: <% out.print(idString);%><br>
					<%
						if(isValidWith) {
					%>
					<a href="profileInfo_Cus_ViewOnly.jsp?pid=<%=dateObj.getUserAId()%>">With: <% out.print(dateObj.getUserAId());%></a><br>
					<%
						} else {
					%>
					With: <% out.print("N/A");%><br>
					<%
						}
					%>
					Location: <% out.print(dateObj.getGeoLoc());%><br>
					Fee: <% out.print(dateObj.getFee());%><br>
				</div>
				<div class="rightCancelBTN">
						<a href="dateDetail.jsp?dateId=<%=dateId%>">See Detail</a>
				</div>
			</div>
					<%}
				}
			}
		%>
	</div>
</body>
</html>