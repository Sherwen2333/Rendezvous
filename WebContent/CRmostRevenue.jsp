<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.ArrayList"%>
<%@ page import="config.DateConstants"%>
<%@ page import="staff.ListRevenue"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="Stylesheet/topbar.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/revenue.css" type="text/css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Customer Analysis</title>
</head>
<%
	try {
		if (!session.getAttribute("staffSession").equals("MA")) {
			response.sendRedirect("employeeHome.jsp");
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
		<a href="ListRevenue.jsp">Back</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
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
	<div class="titleText">Revenue Analysis</div>
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
		<a class="option option1" href="">Representative Generated Most Total Revenue</a>
	</div>

	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<%
		ArrayList<String> list = ListRevenue.FindMostRevenuedCR();
	%>
	<div style="width: 100%; text-align: center; margin-top: 2em;">
		<form method="get" action="CRmostRevenue.jsp">
			<div class="formText">
				Displaying <%=list.size()%>
			</div>
		</form>
	</div>
	<div class="CRMostRevenue_TableContainer">
		<table style="width: 100%; text-align: center;">
			<tr>
				<th>Representative ID</th>
				<th>Total Revenue</th>
			</tr>
			<%
				for (int i = 0; i < list.size(); i++) {
					String[] temp=list.get(i).split("@");
			%>
			<tr>
				<td><a href="employeeAboutOthers.jsp?id=<%=temp[0]%>"><%=temp[0]%></a></td>
				<td>$<%=temp[1]%></td>
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
			//System.out.println(ex+": "+ex.getLocalizedMessage());
		}
	%>
</body>
</html>