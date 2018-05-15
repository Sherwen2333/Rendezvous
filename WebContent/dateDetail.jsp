<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	page import="java.util.ArrayList"%>
<%@ page import="rendezvous.Login"%>
<%@ page import="rendezvous.Customer"%>
<%@ page import="rendezvous.UserProfile"%>
<%@ page import="rendezvous.DateProcessing"%>
<%@ page import="rendezvous.Date"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="Stylesheet/dateDetail.css" type="text/css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Date Detail</title>
</head>
<body>
	<%
		if (session.getAttribute("username") == null)
			response.sendRedirect("login.jsp");
		Date detail;
		try {
			String para = request.getParameter("dateId");
			long dateId = Long.parseLong(para);
			detail = DateProcessing.getDateDetail(dateId);
			if(!detail.getUserAId().equals(UserProfile.getProfileId()) && !detail.getUserBId().equals(UserProfile.getProfileId())){
				response.sendRedirect("completedDates.jsp");
			}
			if (dateId < 100000) {
				para = String.format("%06d", dateId);
			}
			boolean isA = detail.getUserAId().equals(UserProfile.getProfileId());
	%>
	<div class="titleBar"></div>
	<div class=rendezvous>Rendezvous</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!-- Button -->
	<div class="backBTN">
		<a href="completedDates.jsp">Back</a>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!-- Date Title -->
	<div class="dateTitle">
		<div class="dateIcon">
			<i class="fa fa-calendar-check-o"></i>
		</div>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="detailContainer">
		<div class="detailInnerContainer">
			<div class="detail_title">Date Detail</div>
			<div class="detail_dateId">
				DateId:
				<%
				out.print(para);
			%>
			</div>
			<!-- Fee / Time / RepId -->
			<table style="text-align: center; width:100%; margin-top: 1em;">
				<col width="30%" />
				<col width="40%" />
				<col width="30%" />
				<tr>
					<th class="block-title">Fee</th>
					<th class="block-title">Time</th>
					<th class="block-title">Representative</th>
				</tr>
				<tr>
					<td><%
						out.print("$" + detail.getFee());
					%></td>
					<td><%
						out.print(detail.getDateTime().substring(0, detail.getDateTime().lastIndexOf('0') - 1));
					%></td>
					<td><%
						out.print(detail.getRepId());
					%></td>
				</tr>
			</table>
			<!-- Geo Information -->
			<table style="text-align: center; width:100%; margin-top: 1em;">
				<col width="70%" />
				<col width="30%" />
				<tr>
					<th class="block-title">Location</th>
					<th class="block-title">Zipcode</th>
				</tr>
				<tr>
					<td><%
						out.print(detail.getGeoLoc());
					%></td>
					<td><%
						out.print(detail.getZipCode());
					%></td>
				</tr>
			</table>
			<!-- Review -->
			<div class="review">Review</div>
			<!-- User A Rate & Comment -->
			<div class="headerA">
				<i class="fa fa-user"></i>
				<%
					out.print(detail.getUserAId());
						if (isA) {
							out.print(" (Me)");
						}
				%>
			</div>
			<div class="comment_block_A">
				<div class="rate">
					<%
						for (int i = 0; i < detail.getRateA(); i++) {
					%>
					<i class="fa fa-star" style="color: #11aac4;"></i>
					<%
						}
							for (double i = detail.getRateA(); i < 5; i++) {
					%>
					<i class="fa fa-star" style="color: lightgrey;"></i>
					<%
						}
					%>
				</div>
				<!-- End of Rate -->
				<div class="comment">
					<i class="fa fa-comment"></i>
					<%
						out.print(detail.getCommentA());
					%>
				</div>
				<!-- End of Comment -->
				<div class="write">
					<%
						if(isA){
							if(detail.getCommentA() == null && detail.getRateA() == 0){
								%>
								<a href="rateAndComment.jsp?dateId=<%=dateId%>">Write My Review <i class="fa fa-edit"></i></a>
								<%
							}
						}
					%>
				</div>
			</div>
			<!-- User B Rate & Comment -->
			<div class="headerB">
				<%
					out.print(detail.getUserBId());
						if (!isA) {
							out.print(" (Me)");
						}
				%>
				<i class="fa fa-user"></i>
			</div>
			<div class="comment_block_B">
				<div class="rate">
					<%
						for (int i = 0; i < detail.getRateB(); i++) {
					%>
					<i class="fa fa-star" style="color: #11aac4;"></i>
					<%
						}
							for (double i = detail.getRateB(); i < 5; i++) {
					%>
					<i class="fa fa-star" style="color: lightgrey;"></i>
					<%
						}
					%>
				</div>
				<!-- End of Comment -->
				<div class="comment">
					<i class="fa fa-comment"></i>
					<%
						out.print(detail.getCommentB());
					%>
				</div><!-- End of Comment -->
				<div class="write">
					<%
						if(!isA){
							if(detail.getCommentB() == null && detail.getRateB() == 0){
								%>
								<a href="rateAndComment.jsp?dateId=<%=dateId%>">Write My Review <i class="fa fa-edit"></i></a>
								<%
							}
						}
					%>
				</div>
			</div>
		</div>
	</div>
	<%
		} catch (Exception ex) {

		}
	%>
</body>
</html>