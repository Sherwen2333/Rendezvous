<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	page import="java.util.ArrayList"%>
<%@ page import="rendezvous.Login"%>
<%@ page import="rendezvous.Customer"%>
<%@ page import="rendezvous.UserProfile"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="Stylesheet/liked.css" type="text/css" rel="stylesheet">
<title>Likes - Rendezvous</title>
</head>
<body>
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
	<!-- Like Title -->
	<div class="likesTitle">
		<div class="likesIcon">
			<i class="fa fa-heart"></i>
		</div>
		<div class="likesText">Likes</div>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!-- Like Container -->
	<div style="width: 100%; margin-left: 50%; margin-top: 1.5em; margin-bottom: 0em;">
		<div style="width: 20%; margin-left: -10%; align: center;">
			<table width="100%">
				<col width="50%" />
				<col width="50%" />
				<tr>
					<td class="likeReceived"><a href="profileLikes.jsp">Received</a></td>
					<td class="likeGiven"><a href="profileLiked.jsp">Given</a></td>
				</tr>
			</table>
		</div>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="likesContainer">
		<%
			ArrayList<String> listGiven = UserProfile.fetchDataAsLiker();
			if (listGiven.size() <= 0) {
		%>
		<div class="likeNoData">No Data Found</div>
		<%
			} else {
				for (int i = 0; i < listGiven.size(); i += 2) {
		%>
		<div class="likesRow">
			<div class="likerId">
				<a href="profileInfo_Cus_ViewOnly.jsp?pid=<%=listGiven.get(i)%>"><i class="fa fa-user-circle-o"></i>
				<%
					out.println("  " + listGiven.get(i));
				%>
				</a>
			</div>
			<!-- End of likerId -->
			<div class="likeTime">
				<%
					out.println("  " + listGiven.get(i + 1));
				%>
			</div>
			<!-- End of likeTime -->
		</div>
		<!-- End of likesRow -->
		<%
			}// End of for
			}// End of else
		%>
	</div>
</body>
</html>