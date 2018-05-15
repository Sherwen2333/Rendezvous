<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="rendezvous.Refer2"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
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

		String recommended = request.getParameter("recommended");
		String pid = request.getParameter("pid");
		String id = request.getParameter("Id");

		if (recommended == null || pid == null || id == null) {
			response.sendRedirect("userprofile.jsp");

			return;
		}
		if (!Refer2.CheckIsReferral(id)) {
			response.sendRedirect("userprofile.jsp");

			return;
		}

		else {
			response.sendRedirect("makeDate.jsp?pid=" + recommended + "&op=0");
		}
	%>
</body>
</html>