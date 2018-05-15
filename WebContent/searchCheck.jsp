<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	page import="java.util.ArrayList"%>
<%@ page import="rendezvous.Login"%>
<%@ page import="rendezvous.UserProfile"%>
<%@ page import="rendezvous.Search"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- meta http-equiv="refresh" content="3; url=http://www.google.com/" -->
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>Insert title here</title>
</head>

<body>
	<%
		if (session.getAttribute("username") == null) {
			response.sendRedirect("login.jsp");
			return;
		}
	%>
	<%
		Search.search_status = 0;
		if (!request.getParameter("City").isEmpty())
			Search.City_t = request.getParameter("City");

		if (!request.getParameter("State").isEmpty())
			Search.State_t = request.getParameter("State");

		if (!request.getParameter("HColor").isEmpty())
			Search.HColor_t = request.getParameter("HColor");

		try {
			if (!request.getParameter("HeightMin").isEmpty()) {
				Search.HeightMin_t = request.getParameter("HeightMin");
				double value = Double.valueOf(request.getParameter("HeightMin"));
				if (value < 0) {
					Search.search_status = 5;
				}
			}
		} catch (Exception e) {
			Search.search_status = 1;
		}

		try {
			if (!request.getParameter("HeightMax").isEmpty()) {
				Search.HeightMax_t = request.getParameter("HeightMax");
				double value = Double.valueOf(request.getParameter("HeightMax"));
				if (value < 0) {
					Search.search_status = 5;
				}
			}
		} catch (Exception e) {
			Search.search_status = 2;
		}

		try {
			if (!request.getParameter("WeightMin").isEmpty()) {
				Search.WeightMin_t = request.getParameter("WeightMin");
				double value = Double.valueOf(request.getParameter("WeightMin"));
				if (value < 0) {
					Search.search_status = 5;
				}
			}
		} catch (Exception e) {
			Search.search_status = 3;
		}

		try {
			if (!request.getParameter("WeightMax").isEmpty()) {
				Search.WeightMax_t = request.getParameter("WeightMax");
				double value = Double.valueOf(request.getParameter("WeightMax"));
				if (value < 0) {
					Search.search_status = 4;
				}
			}
		} catch (Exception e) {
			Search.search_status = 4;
		}

		try {
			if (!request.getParameter("AgeMin").isEmpty()) {
				Search.AgeMin_t = request.getParameter("AgeMin");
				int value = Integer.valueOf(request.getParameter("AgeMin"));
				if (value < 0) {
					Search.search_status = 5;
				}
			}
		} catch (Exception e) {
			Search.search_status = 5;
		}

		try {
			if (!request.getParameter("AgeMax").isEmpty()) {
				Search.AgeMax_t = request.getParameter("AgeMax");
				int value = Integer.valueOf(request.getParameter("AgeMax"));
				if (value < 0) {
					Search.search_status = 5;
				}
			}
		} catch (Exception e) {
			Search.search_status = 6;
		}

		if (!Search.City_t.isEmpty()) {
			if (Search.State_t.isEmpty()) {
				Search.search_status = 7;
			}
		}

		if (Search.search_status == 0) {
			response.sendRedirect("searchResult.jsp");
		} else {
			response.sendRedirect("search.jsp");
		}
	%>
</body>
</html>