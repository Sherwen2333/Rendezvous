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
<title>Representative - Rendezvous</title>
</head>
<body>
	<!-- Check Information -->
	<%
		try {
			if (session.getAttribute("staffSession") == null) {
				response.sendRedirect("staffLogin.jsp");
				return;
			}
			if (session.getAttribute("staffSSN") == null) {
				response.sendRedirect("staffLogin.jsp");
				return;
			}
		} catch (Exception ex) {
			//ex.printStackTrace();
			//response.sendRedirect("home.html");
			//return;
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
	<div class="search">
		<form method="get" action="employeeAboutOthers.jsp">
			<input class="textfield" type="text" name="id" placeholder="Enter Staff ID"><input class="textfield"
				type="submit" value="Search">
		</form>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="aboutOtherTitle">
		<i class="fa fa-hashtag"></i> About
	</div>
	<%
		try {
			String ssn = (String) request.getParameter("Id");
			if(ssn.equals((String) session.getAttribute("staffSSN"))){
				response.sendRedirect("employeeAbout.jsp");
			}
			boolean isManager = ((String) session.getAttribute("staffSession")).equals("MA");
			Employee info = Employee.getEmployee(ssn, isManager);
			if(info == null){
				info = Employee.getEmployee(ssn, !isManager);
			}

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
		<div class="infoInnerContainer_Other">
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
			<div class="editBTN">
				<a href="processEmployeeInfoDeletion.jsp?id=<%=ssn%>">Delete&nbsp;<i class="fa fa-times"></i></a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="employeeAboutOthers_Editable.jsp?id=<%=ssn%>">Edit&nbsp;<i class="fa fa-edit"></i></a>
			</div>
			<%
				}
			%>
		</div>
	</div>
	<%
		} catch (Exception ex) {
			//ex.printStackTrace();
			response.sendRedirect("employeeAbout.jsp");
		}
	%>
</body>
</html>