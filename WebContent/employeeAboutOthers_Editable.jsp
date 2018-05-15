<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="staff.EmployeeInfoEdit"%>
<%@ page import="staff.Employee"%>
<%@ page import="rendezvous.State"%>
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
<link href="Stylesheet/about.css" type="text/css" rel="stylesheet">
<title>Edit - Rendezvous</title>
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
			String ssn = (String) request.getParameter("id");
			if(ssn.equals((String) session.getAttribute("staffSSN"))){
				response.sendRedirect("employeeAbout.jsp");
				return;
			}
			boolean isManager = ((String) session.getAttribute("staffSession")).equals("MA");
			if(!isManager) {
				response.sendRedirect("employeeAbout.jsp");
				return;
			}
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
			<form method="post" action="processEmployeeInfoEdit.jsp?id=<%=info.getSsn()%>">
				<div>
					<b style="font-weight: 550;">SSN:&nbsp;</b><%=info.getSsn()%><br>
				</div>
				<div>
					<b style="font-weight: 550;">Password:&nbsp;</b><input type="text" 
						name="newPassword" value="<%=info.getPassword()%>" maxlength="24"><br>
				</div>
				<!-- Name -->
				<div>
					<b style="font-weight: 550;">Last Name:&nbsp;</b>
					<input type="text" name="newLast" value="<%=info.getLastName()%>" maxlength="20"
						style="width:20em;">
				</div>
				<div>
					<b style="font-weight: 550;">First Name:&nbsp;</b>
					<input type="text" name="newFirst" value="<%=info.getFirstName()%>" maxlength="20"
						style="width:20em;">
				</div>
				<!-- Address -->
				<div>
					<b style="font-weight: 550;">Address:&nbsp;&nbsp;</b>
					<input type="text" name="newAddress" value="<%=info.getAddress()%>" maxlength="50"
						style="width:21.5em;">
				</div>
				<div>
					<b style="font-weight: 550;">City:&nbsp;&nbsp;</b>
					<input type="text" name="newCity" value="<%=info.getCity()%>" maxlength="20"
						style="width:13em;">
				</div>
				<div>
					<b style="font-weight: 550;">State:&nbsp;&nbsp;</b>
					<select name="newState"> 
						<%
							for(int i = 0; i < State.STATE.size(); i++){
								boolean selected = State.STATE.get(i).equals(info.getState());
								if(selected){
						%>
						<option value ="<%=State.STATE.get(i)%>" selected><%=State.STATE.get(i)%></option>
						<%
								} else {
						%>
						<option value ="<%=State.STATE.get(i)%>"><%=State.STATE.get(i)%></option>
						<%
								}
							}
						%>
					</select>
				</div>
				<div>
					<b style="font-weight: 550;">Zip:&nbsp;&nbsp;</b>
					<input type="text" name="newZip" value="<%=info.getZip()%>" maxlength="5">
				</div>
				<!-- Contact Information -->
				<div>
					<b style="font-weight: 550;">Telephone:&nbsp;&nbsp;</b>
					<input type="text" name="newTele" value="<%=info.getTelephone()%>" maxlength="10">
				</div>
				<div>
					<b style="font-weight: 550;">Email:&nbsp;&nbsp;</b>
					<input type="text" name="newEmail" value="<%=info.getEmail()%>" maxlength="50"
						style="width:20em;">
				</div>
				<!-- Work Since -->
				<div>
					<b style="font-weight: 550;">Work Since: </b><%=info.getSince()%><br>
				</div>
				<!-- Work Since -->
				<%
					if (isManager) {
				%>
				<div>
					<b style="font-weight: 550;">Hourly Rate: </b>$<input type="text" name="newRate" 
						value="<%=info.getHourRate()%>" maxlength="6" style="width:8em;">/hr<br>
				</div>
				<%
					}
				%>
				<div class="error">
					<%
						switch(EmployeeInfoEdit.status){
						case 0: {
							break;
						}
						case 100: {
							out.print("Empty or invalid field. (Error 100)");
							break;
						}
						case 200: {
							out.print("Zip should be a positive integer. (Error 200)");
							break;
						}
						case 300: {
							out.print("Invalid telephone format. (Error 300)");
							break;
						}
						case 400: {
							out.print("Invalid hourly rate. (Error 400)");
							break;
						}
						case 500: {
							out.print("Failed. (Error 500)");
							break;
						}
						}
						EmployeeInfoEdit.status = 0;
					%>
				</div>
				
				<div class="saveBTNContainer">
					<input type="submit" value="Save">
				</div>
			</form>
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