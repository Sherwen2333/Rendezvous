<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="rendezvous.Refer2"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="Stylesheet/topbar.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/referrals.css" type="text/css" rel="stylesheet">
<title>Referral - Rendezvous</title>
</head>
<body>
	<%
		if (session.getAttribute("username") == null) {
			response.sendRedirect("login.jsp");
			return;
		}
		if (session.getAttribute("profileId") == null) {
			response.sendRedirect("chooseProfile.jsp");
			return;
		}
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
	<div class="headTitle">
		<i class="fa fa-users headIcon"></i>
		<div class="headText">Referral</div>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<%
		String pid = request.getParameter("pid");
		if(!pid.equals(session.getAttribute("profileId"))){
			response.sendRedirect("userProfile.jsp");
			return;
		}
		ArrayList<Refer2> list = Refer2.getReferal(pid);
	%>
	<div class="tableContainer">
		<table>
			<tr>
				<th>Referee</th>
				<th>Recommended</th>
				<th>Time</th>
				<th></th>
			</tr>
			<%
				for (int i = 0; i < list.size(); i++) {
					final Refer2 temp = list.get(i);
			%>
			<tr>
				<td><a href="profileInfo_Cus_ViewOnly.jsp?pid=<%=temp.userA%>"
					target="_blank"><%=temp.userA%></a></td>
				<td><a href="profileInfo_Cus_ViewOnly.jsp?pid=<%=temp.userB%>"
					target="_blank"><%=temp.userB%></a></td>
				<td><%=temp.time%></td>
				<td><a href="blinddate.jsp?recommended=<%=temp.userB%>&pid=<%=session.getAttribute("profileId")%>&Id=<%=temp.id%>"><em>Blind Date</em></a></td>
			</tr>
			<%
				}
			%>
		</table>
	</div>

</body>
</html>