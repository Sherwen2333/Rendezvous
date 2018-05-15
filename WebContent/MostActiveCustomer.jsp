<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="config.DateConstants"%>
<%@ page import="rendezvous.CustomerAnalysis"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="Stylesheet/topbar.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/customerAnalysis.css" type="text/css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Customer Analysis</title>
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
	<div class=rendezvous>
		<a href="managerHome.jsp">Rendezvous</a>
	</div>
	<!-- Buttons -->
	<div class="signOut">
		<a href="customerAnalysis.jsp">Back</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
			href="signOut.jsp">Sign Out</a>
	</div>
	<div class="staffSSN">
		ID:
		<%=session.getAttribute("staffSSN")%>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="titleIcon">
		<i class="fa fa-bar-chart"></i>
	</div>
	<div class="titleText">Customer Analysis</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<%
		try {
	%>
	<!--=============================================================================-->
	<!--=================================== Option ==================================-->
	<!--=============================================================================-->
	<div class="optionContainer">
		<a class="option option1" href="">Most Active Customers</a>
	</div>

	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<%
		int max = Integer.parseInt(request.getParameter("max"));
		if(max < 0){
			max = 0;
		}
		ArrayList<String> list = CustomerAnalysis.MostActiveCustomer(max);
	%>
	<div style="width: 100%; text-align: center; margin-top: 2em;">
		<form method="get" action="MostActiveCustomer.jsp">
			<div class="formText">
				Displaying <%=list.size()%>; Max Lines: <input type="text" name="max" 
					value="<%=max%>" maxlength="4" style="width: 4em; text-align: center;">
			</div>
		</form>
	</div>
	<div class="MostActiveCustomer">
		<table style="width: 100%; text-align: center; margin: 1em 0em;">
			<tr>
				<th>Most Active Customer ID</th>
			</tr>
			<%
				for (int i = 0; i < list.size(); i++) {
			%>
			<tr>
				<td><a href="customerInfo.jsp?id=<%=list.get(i)%>&op=0"><%=list.get(i)%></a></td>
			</tr>
			<%
				}
			%>
		</table>
	</div>
	<!--=============================================================================-->
	<!--================================== Exception ================================-->
	<!--=============================================================================-->
	<%
		} catch (Exception ex) {

		}
	%>
</body>
</html>