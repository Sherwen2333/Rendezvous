<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="rendezvous.Login"%>
<%@ page import="rendezvous.Customer"%>
<%@ page import="rendezvous.UserProfile"%>
<%@ page import="rendezvous.GeoLocation" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<p>
	<%
		String id = request.getParameter("profId");
		session.setAttribute("profileId", id);
		UserProfile.fetchProfileData(id);
		String ip=GeoLocation.getIpAdrress(request);
		GeoLocation.setIP(id, ip);
		//System.out.println("id: "+id+"ip: "+ip);
		response.sendRedirect("userProfile.jsp");
		/*out.print(id);
		
		out.println(UserProfile.getProfileId());
		out.println(UserProfile.getAge());
		
		out.println(UserProfile.getAddress());
		out.println(UserProfile.getCity());
		out.println(UserProfile.getState());
		
		out.println(UserProfile.getGender());
		out.println(UserProfile.getHeight());
		out.println(UserProfile.getWeight());
		
		out.println(UserProfile.getHairColor());
		out.println(UserProfile.getHobby());
		out.println(UserProfile.getTotalRate());
		out.println(UserProfile.getNumPendingDate());
		out.println(UserProfile.getNumCompletedDate());
		out.println(UserProfile.getCreationDate());*/
	%><br><br>
</p>
</body>
</html>