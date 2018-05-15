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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="Stylesheet/topbar.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/search.css" type="text/css" rel="stylesheet">
<title>Search Result - Rendezvous</title>
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
	<div class="signOut">
		<a href="userProfile.jsp">Back</a>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="searchTitle">
		<i class="fa fa-search"></i> Search Result
	</div>
	<%
		String Id = "", City = "", State = "", HColor = "";
		double HeightMin = 0.0;
		double HeightMax = 9999.9;
		double WeightMin = 0.0;
		double WeightMax = 9999.9;
		int AgeMin = 0;
		int AgeMax = 9999;
		boolean haveId = false;

		if (!Search.City_t.isEmpty())
			City = Search.City_t;
		if (!Search.State_t.isEmpty())
			State = Search.State_t;
		if (!Search.HColor_t.isEmpty())
			HColor = Search.HColor_t;
		try {
			HeightMin = Double.valueOf(Search.HeightMin_t);
		} catch (NumberFormatException e) {
		}
		try {
			HeightMax = Double.valueOf(Search.HeightMax_t);
		} catch (NumberFormatException e) {
		}
		try {
			WeightMin = Double.valueOf(Search.WeightMin_t);
		} catch (NumberFormatException e) {
		}
		try {
			WeightMax = Double.valueOf(Search.WeightMax_t);
		} catch (NumberFormatException e) {
		}
		try {
			AgeMin = Integer.valueOf(Search.AgeMin_t);
		} catch (NumberFormatException e) {
		}
		try {
			AgeMax = Integer.valueOf(Search.AgeMax_t);
		} catch (NumberFormatException e) {
		}
		Search.init();
		ArrayList<String> list = new ArrayList<String>();
		ArrayList<String> list1 = Search.GetAllProfileId();
		ArrayList<String> list2 = Search.GetAllProfileId();
		ArrayList<String> list3 = Search.GetAllProfileId();

		//Get 3 lists and intersect them.	
		if (City.isEmpty()) {
			if (!State.isEmpty()) {
				list1 = Search.SearchBaseOnState(State);
			}
		} else if (!State.isEmpty()) {
			list1 = Search.SearchBaseOnCityNState(City, State);
		}

		if (!HColor.isEmpty())
			list2 = Search.SearchBaseOnPhyCharHWC(HeightMin, HeightMax, WeightMin, WeightMax, HColor);

		else {
			list2 = Search.SearchBaseOnPhyCharHW(HeightMin, HeightMax, WeightMin, WeightMax);
		}
		list3 = Search.SearchBaseOnAge(AgeMin, AgeMax);
		if (!(list1.isEmpty()) || !((list2.isEmpty()) || (!list3.isEmpty()))) {
			list = Search.ArrayCombine(list1, (Search.ArrayCombine(list3, list2)));
		}
		if (list.size() == 0) {
	%>
	<div style="color: grey; text-align: center; font-size: 1.2em;">
		Sorry, there are no such profiles.</div>
	<%
		} else {
	%>
	<div
		style="text-align: center; font-size: 1.2em; font-weight: 550; margin-bottom: 1em;">
		Profile ID</div>
	<%
		int c = 0;
			for (String s : list) {
				if (c >= 10)
					break;
	%>
	<div class="result">
		<a href="profileInfo_Cus_ViewOnly.jsp?pid=<%=s%>"> <%=s%></a>
	</div>
	<%
		c++;
			}
		}
		Search.init();
	%>
</body>
</html>