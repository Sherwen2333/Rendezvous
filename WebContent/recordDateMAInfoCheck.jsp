<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	page import="java.util.ArrayList"%>
<%@ page import="rendezvous.Login"%>
<%@ page import="rendezvous.UserProfile"%>
<%@ page import="staff.RecordDateMA"%>
<%@ page import="staff.RecordDateMAInfo"%>
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
		if (!session.getAttribute("staffSession").equals("MA")) {
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
		RecordDateMAInfo.status = 0;
		RecordDateMAInfo.Id1 = RecordDateMA.Id1;
		RecordDateMAInfo.Id2 = RecordDateMA.Id2;
		if (!request.getParameter("date_Month").isEmpty()) {
			RecordDateMAInfo.date_Month = request.getParameter("date_Month");	
		}else{
			RecordDateMAInfo.status=1;
		}
		if (!request.getParameter("date_Day").isEmpty()) {
			RecordDateMAInfo.date_Day = request.getParameter("date_Day");
		}else{
			RecordDateMAInfo.status=1;
		}
		if (!request.getParameter("date_Year").isEmpty()) {
			RecordDateMAInfo.date_Year = request.getParameter("date_Year");
		}else{
			RecordDateMAInfo.status=1;
		}
		if (!request.getParameter("date_Hour").isEmpty()) {
			RecordDateMAInfo.date_Hour = request.getParameter("date_Hour");
		}else{
			RecordDateMAInfo.status=1;
		}
		if (!request.getParameter("date_Minute").isEmpty()) {
			RecordDateMAInfo.date_Minute = request.getParameter("date_Minute");
		}else{
			RecordDateMAInfo.status=1;
		}
		if (!request.getParameter("date_Second").isEmpty()) {
			RecordDateMAInfo.date_Second = request.getParameter("date_Second");
		}else{
			RecordDateMAInfo.status=1;
		}
		RecordDateMAInfo.date_UseCurrentTime = request.getParameter("date_UseCurrentTime");
		if (!request.getParameter("date_Loaction").isEmpty()) {
			RecordDateMAInfo.date_Loaction = request.getParameter("date_Loaction");
		}
		
		try {
			if (!request.getParameter("date_Zipcode").isEmpty()) {
				RecordDateMAInfo.date_Zipcode = request.getParameter("date_Zipcode");
				int value = Integer.valueOf(request.getParameter("date_Zipcode"));
				if (value < 0) {
					RecordDateMAInfo.status=3;
				}
			}
			
		} catch (Exception e) {
			RecordDateMAInfo.status=3;
		}
		
		if (!request.getParameter("repId").isEmpty()) {
			RecordDateMAInfo.repId = request.getParameter("repId");
			if(!RecordDateMAInfo.SearchRepId(request.getParameter("repId"))){
				RecordDateMAInfo.status=6;
			}
		}
		else 
			RecordDateMAInfo.status=4;
		
		
		try {
		if (!request.getParameter("fee").isEmpty()) {
				RecordDateMAInfo.fee = request.getParameter("fee");
				double value = Double.valueOf(request.getParameter("fee"));
				if (value < 0) {
					RecordDateMAInfo.status=5;
				}
		}
		else{
			RecordDateMAInfo.status=4;
		}
		}catch (Exception e) {
			RecordDateMAInfo.status=5;
		}
			
	
		
		if (RecordDateMAInfo.date_Loaction.isEmpty() && !RecordDateMAInfo.date_Zipcode.isEmpty()) {
			RecordDateMAInfo.status=2;
		}

		if (!RecordDateMAInfo.date_Loaction.isEmpty() && RecordDateMAInfo.date_Zipcode.isEmpty()) {
			RecordDateMAInfo.status=2;
		}
		
		RecordDateMAInfo.datetime = new StringBuilder();
		RecordDateMAInfo.datetime.append(RecordDateMAInfo.date_Year).append("-").append(RecordDateMAInfo.date_Month).append("-").append(RecordDateMAInfo.date_Day).append(" ");
		RecordDateMAInfo.datetime.append(RecordDateMAInfo.date_Hour).append(":").append(RecordDateMAInfo.date_Minute).append(":").append(RecordDateMAInfo.date_Second);
		
		//System.out.println(UserProfile.getProfileId()+"^^"+DateProcessing.pid+"^^"+DateProcessing.datetime+
		//		"^^"+DateProcessing.date_Loaction+"^^"+DateProcessing.date_Zipcode);
		if(RecordDateMAInfo.date_UseCurrentTime==null){
			/*
			Timestamp now = new Timestamp(System.currentTimeMillis());
			StringBuilder date=new StringBuilder();
			date.append(RecordDateMAInfo.date_Year).append("-");
			if(RecordDateMAInfo.date_Month.length()==1){
				date.append("0");
			}
			date.append(RecordDateMAInfo.date_Month).append("-");
			if(RecordDateMAInfo.date_Day.length()==1){
				date.append("0");
			}
			date.append(RecordDateMAInfo.date_Day).append(" ");
			if(RecordDateMAInfo.date_Hour.length()==1){
				date.append("0");
			}
			date.append(RecordDateMAInfo.date_Hour).append(":");
			if(RecordDateMAInfo.date_Minute.length()==1){
				date.append("0");
			}
			date.append(RecordDateMAInfo.date_Minute).append(":");
			if(RecordDateMAInfo.date_Second.length()==1){
				date.append("0");
			}
			date.append(RecordDateMAInfo.date_Second).append(".000");
			System.out.println(now.toString());
			System.out.println(date.toString());
			
			if(((now.toString()).compareTo(date.toString()))==1){
				RecordDateMAInfo.status=7;
			}
			*/
			if(!RecordDateMAInfo.CompareTime(RecordDateMAInfo.datetime.toString())){
				RecordDateMAInfo.status=7;
			}
		}
		if (RecordDateMAInfo.status!= 0) {
			RecordDateMAInfo.init();
			response.sendRedirect("recordDateMAInfo.jsp");
		} else {
			response.sendRedirect("processRecordDateMAInfo.jsp");
		}
		return;
	} catch (Exception ex) {
		//ex.printStackTrace();
	}
	%>
</body>
</html>