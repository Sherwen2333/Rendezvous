<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="staff.StaffLogin"%>
<%@ page import="staff.Employee"%>
<%@ page import="rendezvous.State"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="staff.EmployeeInfoEdit"%>

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
<title>Create - Rendezvous</title>
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
			response.sendRedirect("staffLogin.jsp");
			return;
		}
		try {
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
				response.sendRedirect("employeeHome.jsp");
				return;
			}
		%>
	</div>
	<div class="staffSSN">
		ID:
		<%=session.getAttribute("staffSSN")%>
	</div>
	<div class="search">
		<form method="get" action="employeeAboutOthers.jsp" target="_blank">
			<input class="textfield" type="text" name="id" placeholder="Enter Staff ID"><input class="textfield"
				type="submit" value="Search">
		</form>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="aboutOtherTitle">
		<i class="fa fa-hashtag"></i> Create Employee
	</div>
	<%
		Employee info = EmployeeInfoEdit.info;
		if(info == null) {
	%>
	<div class="infoContainer">
		<div class="infoInnerContainer_Other">
			<form method="post" action="processEmployeeInfoCreation.jsp">
				<div>
					<b style="font-weight: 550;">SSN:&nbsp;</b><input type="text" name="newSSN" maxlength="24"><br>
				</div>
				<div>
					<b style="font-weight: 550;">Password:&nbsp;</b><input type="text" name="newPassword" maxlength="24"><br>
				</div>
				<!-- Name -->
				<div>
					<b style="font-weight: 550;">Last Name:&nbsp;</b>
					<input type="text" name="newLast" maxlength="20"
						style="width:20em;">
				</div>
				<div>
					<b style="font-weight: 550;">First Name:&nbsp;</b>
					<input type="text" name="newFirst" maxlength="20"
						style="width:20em;">
				</div>
				<!-- Address -->
				<div>
					<b style="font-weight: 550;">Address:&nbsp;&nbsp;</b>
					<input type="text" name="newAddress" maxlength="50"
						style="width:21.5em;">
				</div>
				<div>
					<b style="font-weight: 550;">City:&nbsp;&nbsp;</b>
					<input type="text" name="newCity" maxlength="20"
						style="width:13em;">
				</div>
				<div>
					<b style="font-weight: 550;">State:&nbsp;&nbsp;</b>
					<select name="newState"> 
						<%
							for(int i = 0; i < State.STATE.size(); i++){
						%>
						<option value ="<%=State.STATE.get(i)%>"><%=State.STATE.get(i)%></option>
						<%
							}
						%>
					</select>
				</div>
				<div>
					<b style="font-weight: 550;">Zip:&nbsp;&nbsp;</b>
					<input type="text" name="newZip" maxlength="5">
				</div>
				<!-- Contact Information -->
				<div>
					<b style="font-weight: 550;">Telephone:&nbsp;&nbsp;</b>
					<input type="text" name="newTele" maxlength="10">
				</div>
				<div>
					<b style="font-weight: 550;">Email:&nbsp;&nbsp;</b>
					<input type="text" name="newEmail" maxlength="50"
						style="width:20em;">
				</div>
				<!-- Rate -->
				<div>
					<b style="font-weight: 550;">Hourly Rate: </b>$<input type="text" name="newRate" maxlength="6"
						style="width:8em;">/hr<br>
				</div>
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
					<input type="submit" value="Done">
				</div>
			</form>
		</div>
	</div>
	<%
		} else { 
	%>
	<!--=============================================================================-->
	<!--==============================   With Data   ================================-->
	<!--=============================================================================-->
	<div class="infoContainer">
		<div class="infoInnerContainer_Other">
			<form method="post" action="processEmployeeInfoCreation.jsp">
				<div>
					<b style="font-weight: 550;">SSN:&nbsp;</b><input type="text" 
						value="<%=info.getSsn()%>" name="newSSN" maxlength="24"><br>
				</div>
				<div>
					<b style="font-weight: 550;">Password:&nbsp;</b><input type="text" 
					value="<%=info.getPassword()%>" name="newPassword" maxlength="24"><br>
				</div>
				<!-- Name -->
				<div>
					<b style="font-weight: 550;">Last Name:&nbsp;</b>
					<input type="text" name="newLast" maxlength="20"
						value="<%=info.getLastName()%>" style="width:20em;">
				</div>
				<div>
					<b style="font-weight: 550;">First Name:&nbsp;</b>
					<input type="text" name="newFirst" maxlength="20"
						value="<%=info.getFirstName()%>" style="width:20em;">
				</div>
				<!-- Address -->
				<div>
					<b style="font-weight: 550;">Address:&nbsp;&nbsp;</b>
					<input type="text" name="newAddress" maxlength="50"
						value="<%=info.getAddress()%>" style="width:21.5em;">
				</div>
				<div>
					<b style="font-weight: 550;">City:&nbsp;&nbsp;</b>
					<input type="text" name="newCity" maxlength="20"
						value="<%=info.getCity()%>" style="width:13em;">
				</div>
				<div>
					<b style="font-weight: 550;">State:&nbsp;&nbsp;</b>
					<select name="newState"> 
						<%
							for(int i = 0; i < State.STATE.size(); i++){
								if(State.STATE.get(i).equals(info.getState())){
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
				<!-- Rate -->
				<div>
					<b style="font-weight: 550;">Hourly Rate: </b>$<input type="text" name="newRate" maxlength="6"
						value="<%=info.getHourRate()%>" style="width:8em;">/hr<br>
				</div>
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
					<input type="submit" value="Done">
				</div>
			</form>
		</div>
	</div>
	<%
		}
	%>
	<%
		} catch (Exception ex) {
			//ex.printStackTrace();
			response.sendRedirect("employeeAbout.jsp");
		}
	%>
</body>
</html>