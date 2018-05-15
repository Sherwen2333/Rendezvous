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
<title>Write</title>
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
			<div>
				<div class="block_left">
					<div class="block-title">Fee</div>
					<%
						out.print("$" + detail.getFee());
					%>
				</div>
				<div class="block_center">
					<div class="block-title">Time</div>
					<%
						out.print(detail.getDateTime().substring(0, detail.getDateTime().lastIndexOf('0') - 1));
					%>
				</div>
				<div class="block_right">
					<div class="block-title">Representative</div>
					<%
						out.print(detail.getRepId());
					%>
				</div>
			</div>
			<!-- Geo Information -->
			<div>
				<div class="block_geo_left">
					<div class="block-title">Location</div>
					<%
						out.print(detail.getGeoLoc());
					%>
				</div>
				<div class="block_geo_right">
					<div class="block-title">Zipcode</div>
					<%
						out.print(detail.getZipCode());
					%>
				</div>
			</div>
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
				<%
					if (!isA) {
				%><div class="rate">
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
				<%
					}
				%>
				<!-- End of Rate -->
				<%
					if (!isA) {
				%>
				<div class="comment">
					<i class="fa fa-comment"></i>
					<%
						out.print(detail.getCommentA());
					%>
				</div>
				<%
					}
				%>
				<!-- End of Comment -->
				<div class="write">
					<%
						if (isA) {
								if (detail.getCommentA() == null && detail.getRateA() == 0) {
									session.setAttribute("dateId", dateId);
					%>
					<form action="uploadRateAndComment.jsp?" method="get">
						Rate: <input type="radio" name="rate" value="1">1 <input
							type="radio" name="rate" value="2">2 <input type="radio"
							name="rate" value="3">3 <input type="radio" name="rate"
							value="4">4 <input type="radio" name="rate" value="5"
							checked>5<br> <br>
						<textarea name="comment" rows="4" cols="35"
							placeholder="Comment Here">Comment Here</textarea>
						<br> <input type="submit" value="Submit">
					</form>
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
			<%
					if (isA) {
				%>
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
				<div class="comment">
					<i class="fa fa-comment"></i>
					<%
						out.print(detail.getCommentB());
					%>
				</div>
				<%
					}
				%>
				<!-- End of Comment -->
				<div class="write">
					<%
						if (!isA) {
								if (detail.getCommentB() == null && detail.getRateB() == 0) {
									session.setAttribute("dateId", dateId);
					%>
					<form action="uploadRateAndComment.jsp?" method="get">
						Rate: <input type="radio" name="rate" value="1">1 <input
							type="radio" name="rate" value="2">2 <input type="radio"
							name="rate" value="3">3 <input type="radio" name="rate"
							value="4">4 <input type="radio" name="rate" value="5"
							checked>5<br> <br>
						<textarea name="comment" rows="4" cols="35"
							placeholder="Comment Here">Comment Here</textarea>
						<br> <input type="submit" value="Submit">
					</form>
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
			ex.printStackTrace();
		}
	%>
</body>
</html>