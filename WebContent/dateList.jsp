<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="config.DateConstants"%>
<%@ page import="staff.DateList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="Stylesheet/topbar.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/dateList.css" type="text/css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Date List</title>
</head>
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
	}
%>
<body>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!-- Top bar -->
	<div class="titleBar"></div>
	<div class=rendezvous><a href="managerHome.jsp">Rendezvous</a></div>
	<!-- Buttons -->
	<div class="signOut">
		<a href="managerHome.jsp">Back</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="signOut.jsp">Sign Out</a>
	</div>
	<div class="staffSSN">
		ID:
		<%=session.getAttribute("staffSSN")%>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="titleIcon">
		<i class="fa fa-heartbeat"></i>
	</div>
	<div class="titleText">Date List</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<%
		try{
			// op = 0 -> default; op = 1 -> by date; op = 2 by customer					
			int op = Integer.parseInt(request.getParameter("op"));
	%>
	<!--=============================================================================-->
	<!--=============================== Option By Date ==============================-->
	<!--=============================================================================-->
	<div class="optionContainer">
		<form method="post" action="processDateList.jsp?op=1">
			By Date:
			<select name="month">
				<option value="-1" selected>-----------</option>
				<%
					for(int i = 0; i < DateConstants.MONTH.size(); i++){
				%>
				<option value="<%=i+1%>"><%=DateConstants.MONTH.get(i)%></option>
				<%
					}
				%>
			</select>&nbsp;
			<select name="day">
				<option value="-1" selected>--</option>
				<%
					for(int i = 0; i < DateConstants.DAY.size(); i++){
				%>
				<option value="<%=i+1%>"><%=DateConstants.DAY.get(i)%></option>
				<%
					}
				%>
			</select>&nbsp;
			<select name="year">
				<option value="<%=DateConstants.YEAR.get(0)%>" selected><%=DateConstants.YEAR.get(0)%></option>
				<%
					for(int i = 0; i < DateConstants.PAST_5_YEAR.size(); i++){
				%>		
				<option value="<%=DateConstants.PAST_5_YEAR.get(i)%>"><%=DateConstants.PAST_5_YEAR.get(i)%></option>
				<%
					}
				%>
			</select>&nbsp;
			<input class="submitBTN" type="submit" value="Retrieve">
		</form>
	</div>
	<div class="optionContainer2">
		<form method="post" action="processDateList.jsp?op=2">
			By Customer:
			<input type="text" name="cid" maxlength="24" class="textfield" placeholder="Enter Customer ID">&nbsp;
			<input class="submitBTN" type="submit" value="Retrieve">
		</form>
	</div>
	<!--=============================================================================-->
	<!--==================================== Error ==================================-->
	<!--=============================================================================-->
	<div class="error">
		<%
			if(op == 100) {
				out.print("Failed to retrieve data (Error Code: 100)");
			} else if(op == 200) {
				out.print("No available data (Error Code: 200)");
			} else if(op == 300) {
				out.print("Invalid Input (Error Code: 300)");
			}
		%>
	</div>
	<!--=============================================================================-->
	<!--==================================== DATA ===================================-->
	<!--=============================================================================-->
	<%
		if((op == 22 || op == 11) && !DateList.list.isEmpty()) {
	%>
	<div class="dataContainer">
		<%
			if(op == 22) {
		%>
		<div style="margin-bottom: 1em; color: grey;">
			<b style="font-weight: 500;">Customer ID: </b><%= DateList.input_cid %>
		</div>
		<%
			} else if (op == 11) {
		%>
		<div style="margin-bottom: 1em; color: grey;">
			<b style="font-weight: 500;">From </b><%= DateList.input_from %><b style="font-weight: 500;"> to </b><%= DateList.input_to %>
		</div>
		<%
			} 
		%>
		<table style="width:50%; margin-left:25%;">
		<tr>
			<th>DateID</th>
			<th>Profile A</th> 
			<th>Profile B</th>
			<th>Date Time</th>
		</tr>
		<%
			for(int i = 0; i < DateList.list.size(); i++) {
				DateList data = DateList.list.get(i);
				String id = String.format("%06d", data.dateId);
		%>
		<tr>
			<td><a href=""><%=id%></a></td>
			<td><%=data.userA%></td>
			<td><%=data.userB%></td>
			<td><%=data.time%></td>
		</tr>
		<%
			}
		%>
		</table>
	</div>
	<%
		}
	%>
	<!--=============================================================================-->
	<!--================================== Exception ================================-->
	<!--=============================================================================-->
	<%
		}catch(Exception ex){
			
		}
	%>
</body>
</html>