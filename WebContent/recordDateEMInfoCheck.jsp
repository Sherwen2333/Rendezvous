<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	page import="java.util.ArrayList"%>
<%@ page import="rendezvous.Login"%>
<%@ page import="rendezvous.UserProfile"%>
<%@ page import="staff.RecordDateEM"%>
<%@ page import="staff.RecordDateEMInfo"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.lang.Comparable"%>
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
	try {
		if (!session.getAttribute("staffSession").equals("EM")) {
			response.sendRedirect("staffLogin.jsp");
		}
		if (session.getAttribute("staffSSN") == null) {
			response.sendRedirect("staffLogin.jsp");
		}
	} catch (Exception ex) {
		response.sendRedirect("staffLogin.jsp");
		return;
	}
	%>
	<%
	try {
		RecordDateEMInfo.status = 0;
		RecordDateEMInfo.Id1 = RecordDateEM.Id1;
		RecordDateEMInfo.Id2 = RecordDateEM.Id2;
		if (!request.getParameter("date_Month").isEmpty()) {
			RecordDateEMInfo.date_Month = request.getParameter("date_Month");	
		}else{
			RecordDateEMInfo.status=1;
		}
		if (!request.getParameter("date_Day").isEmpty()) {
			RecordDateEMInfo.date_Day = request.getParameter("date_Day");
		}else{
			RecordDateEMInfo.status=1;
		}
		if (!request.getParameter("date_Year").isEmpty()) {
			RecordDateEMInfo.date_Year = request.getParameter("date_Year");
		}else{
			RecordDateEMInfo.status=1;
		}
		if (!request.getParameter("date_Hour").isEmpty()) {
			RecordDateEMInfo.date_Hour = request.getParameter("date_Hour");
		}else{
			RecordDateEMInfo.status=1;
		}
		if (!request.getParameter("date_Minute").isEmpty()) {
			RecordDateEMInfo.date_Minute = request.getParameter("date_Minute");
		}else{
			RecordDateEMInfo.status=1;
		}
		if (!request.getParameter("date_Second").isEmpty()) {
			RecordDateEMInfo.date_Second = request.getParameter("date_Second");
		}else{
			RecordDateEMInfo.status=1;
		}
		RecordDateEMInfo.date_UseCurrentTime = request.getParameter("date_UseCurrentTime");
		if (!request.getParameter("date_Loaction").isEmpty()) {
			RecordDateEMInfo.date_Loaction = request.getParameter("date_Loaction");
		}
		
		try {
			if (!request.getParameter("date_Zipcode").isEmpty()) {
				RecordDateEMInfo.date_Zipcode = request.getParameter("date_Zipcode");
				int value = Integer.valueOf(request.getParameter("date_Zipcode"));
				if (value < 0) {
					RecordDateEMInfo.status=3;
				}
			}
			
		} catch (Exception e) {
			RecordDateEMInfo.status=3;
		}
		
		if (!request.getParameter("repId").isEmpty()) {
			RecordDateEMInfo.repId = request.getParameter("repId");
			if(!RecordDateEMInfo.SearchRepId(request.getParameter("repId"))){
				RecordDateEMInfo.status=6;
			}
		}
		else 
			RecordDateEMInfo.status=4;
		
		
		try {
		if (!request.getParameter("fee").isEmpty()) {
			RecordDateEMInfo.fee = request.getParameter("fee");
				double value = Double.valueOf(request.getParameter("fee"));
				if (value < 0) {
					RecordDateEMInfo.status=5;
				}
		}
		else{
			RecordDateEMInfo.status=4;
		}
		}catch (Exception e) {
			RecordDateEMInfo.status=5;
		}
			
	
		
		if (RecordDateEMInfo.date_Loaction.isEmpty() && !RecordDateEMInfo.date_Zipcode.isEmpty()) {
			RecordDateEMInfo.status=2;
		}

		if (!RecordDateEMInfo.date_Loaction.isEmpty() && RecordDateEMInfo.date_Zipcode.isEmpty()) {
			RecordDateEMInfo.status=2;
		}
		
		RecordDateEMInfo.datetime = new StringBuilder();
		RecordDateEMInfo.datetime.append(RecordDateEMInfo.date_Year).append("-").append(RecordDateEMInfo.date_Month).append("-").append(RecordDateEMInfo.date_Day).append(" ");
		RecordDateEMInfo.datetime.append(RecordDateEMInfo.date_Hour).append(":").append(RecordDateEMInfo.date_Minute).append(":").append(RecordDateEMInfo.date_Second);
		
		//System.out.println(UserProfile.getProfileId()+"^^"+DateProcessing.pid+"^^"+DateProcessing.datetime+
		//		"^^"+DateProcessing.date_Loaction+"^^"+DateProcessing.date_Zipcode);
		if(RecordDateEMInfo.date_UseCurrentTime==null){
			
			if(!RecordDateEMInfo.CompareTime(RecordDateEMInfo.datetime.toString())){
				RecordDateEMInfo.status=7;
			}
		}
		if (RecordDateEMInfo.status!= 0) {
			RecordDateEMInfo.init();
			response.sendRedirect("recordDateEMInfo.jsp");
		} else {
			response.sendRedirect("processRecordDateEMInfo.jsp");
		}
		return;
	} catch (Exception ex) {
		//ex.printStackTrace();
	}
	%>
</body>
</html>