<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="staff.StaffLogin"%>
<%@ page import="staff.Employee"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="Stylesheet/topbar.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/about.css" type="text/css" rel="stylesheet">
<title>About - Rendezvous</title>
</head>
<body>
	<!-- Check Information -->
	<%
		try {
			if (!session.getAttribute("staffSession").equals("EM") 
					&& !session.getAttribute("staffSession").equals("MA")) {
				response.sendRedirect("staffLogin.jsp");
				return;
			}
			if (session.getAttribute("staffSSN") == null) {
				response.sendRedirect("staffLogin.jsp");
				return;
			}
		} catch (Exception ex) {
			//ex.printStackTrace();
			response.sendRedirect("staffLogin.jsp");
			return;
		}
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
			if(session.getAttribute("staffSession").equals("MA")) {
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
	<%
		try {
			String ssn = (String) session.getAttribute("staffSSN");
			boolean isManager = ((String) session.getAttribute("staffSession")).equals("MA");
			Employee info = Employee.getEmployee(ssn, isManager);
	%>
	<div class="search">
		<form method="get" action="employeeAboutOthers.jsp">
			<input class="textfield" type="text" name="id" placeholder="Enter Staff ID"><input class="textfield"
				type="submit" value="Search">
		</form>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="aboutTitle">
		<i class="fa fa-hashtag"></i> About
	</div>
	<%
			StringBuilder phoneNum = new StringBuilder(info.getTelephone());
			if (phoneNum.length() < 10) {
				phoneNum.reverse();
				while (phoneNum.length() < 10) {
					phoneNum.append('0');
				}
				phoneNum.reverse();
			}
	%>
	<div class="infoContainer">
		<div class="infoInnerContainer">
			<div>
				<b>SSN: </b><%=info.getSsn()%><br>
			</div>
			<div>
				<b>Password: </b><%=info.getPassword()%><br>
			</div>
			<div>
				<b>Name: </b><%=info.getFirstName()%>
				<%=info.getLastName()%><br>
			</div>
			<div>
				<b>Address: </b><%=info.getAddress()%><br>
			</div>
			<div>
				<b>City: </b><%=info.getCity()%>,
				<%=info.getState()%><br>
			</div>
			<div>
				<b>Zip: </b><%=info.getZip()%><br>
			</div>
			<div>
				<b>Telephone: </b><%=phoneNum%><br>
			</div>
			<div>
				<b>Email: </b><%=info.getEmail()%><br>
			</div>
			<div>
				<b>Work Since: </b><%=info.getSince()%><br>
			</div>
			<%
				if (isManager) {
			%>
			<div>
				<b>Hourly Rate: </b>$<%=info.getHourRate()%>/hr<br>
			</div>
			<%
				}
			%>
		</div>
	</div>
	<%
		if (isManager) {
	%>
	<div class="addNewBTN">
		<a href="employeeAboutOthers_Create.jsp">Add New Employee</a>
	</div>
	<%
		}
	%>
	<%
		} catch (Exception ex) {
			//ex.printStackTrace();
			//response.sendRedirect("home.html");
		}
	%>
</body>
</html>