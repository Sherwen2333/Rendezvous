<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="rendezvous.UserProfileInfo"%>
<%@ page import="rendezvous.State"%>
<%@ page import="rendezvous.ProfilePlacementPriority"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="rendezvous.Customer"%>
<%@ page import="rendezvous.UserProfile"%>
<%@ page import="rendezvous.HairColor"%>
<%@ page import="rendezvous.Like"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="Stylesheet/topbar.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/customerCenter.css" type="text/css"
	rel="stylesheet">
<title>Profile Info - Rendezvous</title>
</head>
<body>
	<!-- Check Information -->
	<%
		try {
			if(session.getAttribute("username") == null) {
				response.sendRedirect("login.jsp");
				return;
			}
		} catch (Exception ex) {
			
		}
		try {
			String pid = request.getParameter("pid");
			if(pid.length() <= 0){
				response.sendRedirect("chooseProfile.jsp");
				return;
			}
			
			String username = (String) session.getAttribute("username");
			if(UserProfile.checkCorrespondence(username, pid)){
				response.sendRedirect("profileInfo_Cus.jsp?pid="+pid+"&op=0");
				return;
			}
			
			String backURL;
			if(session.getAttribute("profileId") == null){
				backURL = "chooseProfile.jsp";
			} else {
				backURL = "userProfile.jsp";
			}
	%>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!-- Top bar -->
	<div class="titleBar"></div>
	<div class=rendezvous>Rendezvous</div>
	<!-- Buttons -->
	<div class="signOut">
		<a href="<%=backURL%>">Back</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="signOut.jsp">Sign Out</a>
	</div>
	<div class="staffSSN">
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<%
		UserProfileInfo info = UserProfileInfo.getProfileInfo(pid);
		if(info == null){
			response.sendRedirect("chooseProfile.jsp");
			return;
		}
	%>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="title_icon">
		<i class="fa fa-user-circle-o"></i>
	</div>
	<div class="title_text">
		<%=info.getProfileId()%>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<%
		boolean liked = Like.hasLiked(info.getProfileId(), (String)session.getAttribute("profileId"));
		if(liked){
	%>
	<div class="unlikeBTN">
		<a href="makeDate.jsp?pid=<%=info.getProfileId()%>&op=0">
			<i class="fa fa-heartbeat"></i> Make Date
		</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="processLike.jsp?op=0&likee=<%=info.getProfileId()%>&liker=<%=(String)session.getAttribute("profileId")%>">
			<i class="fa fa-heart"></i> Unlike
		</a>
	</div>
	<%
		} else {
	%>
	<div class="likeBTN">
		<a href="makeDate.jsp?pid=<%=info.getProfileId()%>&op=0">
			<i class="fa fa-heartbeat"></i> Make Date
		</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="processLike.jsp?op=1&likee=<%=info.getProfileId()%>&liker=<%=(String)session.getAttribute("profileId")%>">
			<i class="fa fa-heart-o"></i> Like
		</a>
	</div>
	<%
		}
	%>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="referContainer">
		<form action="processLike.jsp?op=8&likee=<%=info.getProfileId()%>&liker=<%=(String)session.getAttribute("profileId")%>"
			method="post">
			<b style="font-weight: 500;">Refer to:&nbsp;</b><input type="text" name="referTo" placeholder="Enter Profile ID Here"
			maxlength="24" style="width:24em; text-align:center;">&nbsp;<input type="submit" value="Refer">
		</form>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="infoContainer">
		<!--===========-->
		<div>
			<b style="font-weight: 550;">Creation Date:&nbsp;&nbsp;</b><%=info.getCreationDate() %>
		</div>
		<div>
			<b style="font-weight: 550;">Last Active:&nbsp;&nbsp;</b><%=info.getLastActive()%>
		</div>
		<div>
			<b style="font-weight: 550;">Customer Id:&nbsp;&nbsp;</b><%=info.getUsername()%>
		</div>
		<div>
			<b style="font-weight: 550;">Profile Id:&nbsp;&nbsp;</b><%=info.getProfileId()%>
		</div>
		<hr>
		<!--=============================================================================-->
		<!--=============================================================================-->
		<!--==================================2222222====================================-->
		<!--=============================================================================-->
		<div>
			<b style="font-weight: 550;">Age(yr.):&nbsp;&nbsp;</b><%=info.getAge()%>
		</div>
		<div>
			<b style="font-weight: 550;">Gender:&nbsp;&nbsp;</b><%=info.getGender()%>
		</div>
		<div>
			<b style="font-weight: 550;">Height(ft.):&nbsp;&nbsp;</b><%=info.getHeight()%>
		</div>
		<div>
			<b style="font-weight: 550;">Weight(lb.):&nbsp;&nbsp;</b><%=info.getWeight()%>
		</div>
		<div>
			<b style="font-weight: 550;">Hair Color:&nbsp;&nbsp;</b><%=info.getHairColor()%>
		</div>
		<hr>
		<!--=============================================================================-->
		<!--=============================================================================-->
		<!--==================================3333333====================================-->
		<!--=============================================================================-->
		<div>
			<b style="font-weight: 550;">Address:&nbsp;&nbsp;</b>
		</div>
		<div style="margin-left: 3em;">
			<%=info.getAddress() %><br><%=info.getCity()%>, <%=info.getState()%>
		</div>
		<hr>
		<!--=============================================================================-->
		<!--=============================================================================-->
		<!--==================================4444444====================================-->
		<!--=============================================================================-->
		<div>
			<b style="font-weight: 550;">Preferred GeoRange(mi.):&nbsp;&nbsp;</b><%=info.getGeoRange()%>
		</div>
		<div>
			<b style="font-weight: 550;">Preferred Age Range(yrs):&nbsp;&nbsp;</b><%=info.getAgeMin()%>&nbsp;~&nbsp;<%=info.getAgeMax()%>
		</div>
		<div>
			<b style="font-weight: 550;">Hobby:&nbsp;&nbsp;</b>
		</div>
		<div style="margin-left: 4em;">
			<%=info.getHobby()%>
		</div>
		<div >
			<a href="photo_view.jsp?pId=<%=info.getProfileId()%>"><b style="font-weight: 550;">Album&nbsp;&nbsp;</b></a>
		</div>
	</div>
	<%
		} catch (Exception ex) {
			//ex.printStackTrace();
		}
	%>
</body>
</html>