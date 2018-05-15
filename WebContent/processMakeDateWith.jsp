<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="rendezvous.UserProfileInfo"%>
<%@ page import="rendezvous.State"%>
<%@ page import="rendezvous.ProfilePlacementPriority"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="rendezvous.Customer"%>
<%@ page import="rendezvous.UserProfile"%>
<%@ page import="config.DateConstants"%>
<%@ page import="rendezvous.Like"%>
<%@ page import="rendezvous.MakeDateWith"%>
<%@ page import="rendezvous.DateProcessing"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="Stylesheet/topbar.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/customerCenter.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/makeDate.css" type="text/css" rel="stylesheet">

<title>Profile Info - Rendezvous</title>
</head>
<body>
	<!--=============================================================================-->
	<!--============================= Check Information =============================-->
	<!--=============================================================================-->
	<!-- Check Information -->
	<%
		
		try {
			if(session.getAttribute("username") == null) {
				response.sendRedirect("login.jsp");
				return;
			}
		} catch (Exception ex) {
		}
		
	%>
	<!--=============================================================================-->
	<!--================================ Top Bar ====================================-->
	<!--=============================================================================-->
	<!-- Top bar -->
	<div class="titleBar"></div>
	<div class=rendezvous>Rendezvous</div>
	<!-- Buttons -->
	<div class="signOut">
		<a href="userProfile.jsp">Back to UserProfile</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="signOut.jsp">Sign Out</a>
	</div>
	<div class="staffSSN">
	</div>
	<div>
	<%
		try {
			String pid = DateProcessing.pid;

			String date_Month = DateProcessing.date_Month;
			String date_Day = DateProcessing.date_Day;
			String date_Year = DateProcessing.date_Year;
			String date_Hour = DateProcessing.date_Hour;
			String date_Minute = DateProcessing.date_Minute;
			String date_Second = DateProcessing.date_Second;

			String date_UseCurrentTime = DateProcessing.date_UseCurrentTime;
			//out.print(date_UseCurrentTime == null);

			String date_Loaction = DateProcessing.date_Loaction;
			String date_Zipcode = DateProcessing.date_Zipcode;
			
			StringBuilder datetime = DateProcessing.datetime;
			DateProcessing.init();
			int option=0;
			if(date_UseCurrentTime == null){
				if(date_Loaction.length()>0&&date_Zipcode.length()>0)
					option = 2;
				else
					option=0;
			}
			else{
				if(date_Loaction.length()>0&&date_Zipcode.length()>0)
					option = 3;
				else
					option=1;
			}
			
			boolean status1=false;
			
			switch(option) {
			case 0: {
				//System.out.println((String)session.getAttribute("profileId")+"^^^^"+pid+"^^^"+datetime.toString());
				status1 = DateProcessing.makeDateOnGivenDate((String)session.getAttribute("profileId"), pid, datetime.toString());
				if(status1==false){
					out.println("Fail to make a date!!!");
				}
				else{
					
					out.println("Making a date successfully!!!");
				}
				break;
			}
			case 1: {
				//System.out.println((String)session.getAttribute("profileId")+"^^^^"+pid);
				status1 = DateProcessing.makeDateOnCurrent((String)session.getAttribute("profileId"), pid);
				if(status1==false){
					out.println("Fail to make a date!!!");
				}
				else{
					out.println("Making a date successfully!!!");
				}
				break;
			}
			case 2: {
				//System.out.println((String)session.getAttribute("profileId")+"^^^^"+pid+"^^^"+datetime.toString());
				status1 = DateProcessing.makeDateOnGivenDateGeo
						((String)session.getAttribute("profileId"), pid, datetime.toString(),date_Loaction,date_Zipcode);
				if(status1==false){
					out.println("Fail to make a date!!!");
				}
				else{
					
					out.println("Making a date successfully!!!");
				}
				break;
			}
			case 3: {
				//System.out.println((String)session.getAttribute("profileId")+"^^^^"+pid);
				status1 = DateProcessing.makeDateOnCurrentGeo
						((String)session.getAttribute("profileId"), pid,date_Loaction,date_Zipcode);
				if(status1==false){
					%><div style="font-size: 1em; margin-top: 1em; color: blue;">
					Fail to make a date!!!
					</div>
					<%
				}
				else{
					%><div style="font-size: 1em; margin-top: 1em; color: blue;">
					Making a date successfully!!!
					</div>
					<%
				}
				break;
			}
			}
			
			return;
		} catch (Exception ex) {
			//ex.printStackTrace();
		}
	%>
	</div>
</body>
</html>