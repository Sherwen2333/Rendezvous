<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="staff.MailingList"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="Stylesheet/topbar.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/mailingList.css" type="text/css" rel="stylesheet">
<title>Mailing List</title>
</head>
<!-- Body -->
<body>
	<!-- Check Information -->
	<%
		try {
			if (!session.getAttribute("staffSession").equals("EM") 
					&& !session.getAttribute("staffSession").equals("MA")) {
				response.sendRedirect("staffLogin.jsp");
			}
			if (session.getAttribute("staffSSN") == null) {
				response.sendRedirect("staffLogin.jsp");
			}
		} catch (Exception ex) {

		}
		try {
			int option = Integer.parseInt(request.getParameter("option"));
	%>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!-- Top bar -->
	<div class="titleBar"></div>
	<div class=rendezvous>Rendezvous</div>
	<!-- Buttons -->
	<div class="signOut">
		<%
			if(session.getAttribute("staffSession").equals("MA")){
		%>
		<a href="managerHome.jsp">Back</a>
		<%
			} else {
		%>
		<a href="employeeHome.jsp">Back</a>
		<%
			}
		%>
	</div>
	<div class="staffSSN">
		ID:
		<%=session.getAttribute("staffSSN")%>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="mailTitle">
		<i class="fa fa-envelope"></i>
	</div>
	<div class="mailTitleText">Mailing List</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="allEmailContainer">
		<%
			if(option == 1){
				%><a href="mailingList.jsp?option=1&cId=" class="option selectedOption">All Emailing List</a>&nbsp;&nbsp;<%
			} else {
				%><a href="mailingList.jsp?option=1&cId=" class="option">All Emailing List</a>&nbsp;&nbsp;<%
			}
		%>
		<%
			if(option == 2){
				%><a href="mailingList.jsp?option=2&cId=" class="option selectedOption">All Mailing List</a>&nbsp;&nbsp;<%
			} else {
				%><a href="mailingList.jsp?option=2&cId=" class="option">All Mailing List</a>&nbsp;&nbsp;<%
			}
		%>
		<%
			if(option == 3){
				%><a href="mailingList.jsp?option=3&cId=" class="option selectedOption">By Customer</a><%
			} else {
				%><a href="mailingList.jsp?option=3&cId=" class="option">By Customer</a><%
			}
		%>
	</div>
	<%
			String cId = request.getParameter("cId");

			if (option == 1) {
				ArrayList<String> list = MailingList.allEmailList();
				%>
					<div class="allList">
					<%
						for(int i = 0; i < list.size(); i++){
					%>
							<a href="mailto:<%=list.get(i)%>?subject=Hello%20From%20Rendezvous">
								<%=list.get(i) %>
							</a><br>
					<%
						} 
					%>
					</div>
				<%
			} else if (option == 2) {
				ArrayList<String> list = MailingList.allMailList();
				%>
					<div class="allList">
					<%
						for(int i = 0; i < list.size(); i++){
							StringBuilder googleURL = new StringBuilder("https://www.google.com/maps/search/");
							String temp = list.get(i).substring(list.get(i).indexOf(',') + 2, list.get(i).lastIndexOf(' '));
							googleURL.append(temp.replace(' ', '+'));
						%>
						<a href="<%=googleURL%>" target="_blank"><%=list.get(i)%></a><br><%
						} 
					%>
					</div>
				<%
			} else if (option == 3) {
				%>
					<form class="searchBox" method="get" action="processMailListSearch.jsp">
						<input class="textfield" type="text" name="id" placeholder="Enter Customer ID"><input class="textfield"
				type="submit" value="Search">
					</form>
				<%
					if(cId.length() > 0){
						ArrayList<String> list = MailingList.oneMailList(cId);
						if(list.size() == 4) {
							StringBuilder googleURL = new StringBuilder("https://www.google.com/maps/search/");
							googleURL.append(list.get(2).replace(' ', '+'));
							String temp = list.get(3).substring(0, list.get(3).lastIndexOf(' '));
							googleURL.append(",+").append(temp.replace(' ', '+'));
							%>
								<div class="allList">
								<a href="<%=googleURL%>" target="_blank">
								<%
									for(int i = 1; i < list.size(); i++){
										out.print(list.get(i));%><br><%
									} 
								%>
								</a>
								<br>
								<a href="mailto:<%=list.get(0)%>?subject=Hello%20From%20Rendezvous">
									<b>Email: </b><%=list.get(0) %></a>
								</div>
							<%
						}
					}
			} 
		} catch (Exception ex) {
			response.sendRedirect("signOut.jsp");
		}
	%>
</body>
</html>