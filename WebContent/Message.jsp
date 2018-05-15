<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@	page import="java.util.ArrayList"%>
<%@ page import="rendezvous.GeoLocation"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="refresh" content="5">
<link href="Stylesheet/geoDate.css" type="text/css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Message - Rendezvous</title>
</head>
<body>
	<%
		if(session.getAttribute("username") == null){
			response.sendRedirect("login.jsp");
			return;
		}
		if(session.getAttribute("profileId") == null){
			response.sendRedirect("chooseProfile.jsp");
			return;
		}
		ArrayList<String> list = GeoLocation.GetMessage((String)session.getAttribute("profileId"));
	%>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="titleBar"></div>
	<div class="rendezvous">
		Rendezvous
	</div>
	<div class="signOut">
		<a href="userProfile.jsp">Back</a>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="geoTitle">
		Message
	</div>
	
	<div>
		<table style="width: 100%; text-align: center; margin: 1em 0em;">
			<%	
				for (int i = 0; i < list.size(); i++) {
					String[] temp=list.get(i).split("@");
			%>
			<tr>
				<td class="mess">
					<i class="fa fa-paper-plane-o"></i>
					<a href="profileInfo_Cus_ViewOnly.jsp?pid=<%=temp[0]%>"><%=temp[0]%></a> invite you to <%=temp[1]%>, <%=temp[2]%>, <%=temp[3]%> at <%=temp[4]%>
					<br><br>
					<a class="btn" href="AcceptMessage.jsp?inviter=<%=temp[0]%>&invitee=<%=(String)session.getAttribute("profileId")%>&addr=<%=temp[1]%>">Accept</a>
					
					<a class="btn" href="RefuseMessage.jsp?inviter=<%=temp[0]%>&invitee=<%=(String)session.getAttribute("profileId")%>">Decline</a>
				</td>
			</tr>
			<%
				}
			%>
		</table>
	</div>
</body>
</html>