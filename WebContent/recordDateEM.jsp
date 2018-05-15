<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	page import="java.util.ArrayList"%>
<%@ page import="rendezvous.Login"%>
<%@ page import="rendezvous.Customer"%>
<%@ page import="rendezvous.UserProfile"%>
<%@ page import="staff.RecordDateEM"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="Stylesheet/topbar.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/recordDate.css" type="text/css" rel="stylesheet">
<title>Record Date - Rendezvous</title>
</head>
<body>
	<%
	try {
		if (!session.getAttribute("staffSession").equals("EM")) {
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
	<div class="titleText">Record Date</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="formContainer">
	<div class="formInnerContainer">
		<form method = "POST" action="recordDateEMCheck.jsp">
		    <div style="text-align: center; margin-bottom: 1em;">
				<b><em>Please enter the two profile IDs</em></b>
			</div>
			<div>
				<b>Profile A:&nbsp;&nbsp;</b><input type="text" name="Id1" maxlength="24" style="width: 20em;">
			</div>
			<div style="margin-bottom: 1em;">
				<b>Profile B:&nbsp;&nbsp;</b><input type="text" name="Id2" maxlength="24" style="width: 20em;">
			</div>
			<div class="error">
				<%
					try {
						switch (RecordDateEM.status_t){
						case 1:  { 
							out.println("There are no such Ids.");
							RecordDateEM.init();
							break;
						}
						case 2:  { 
							out.println("This website only allows making a date between different genders.");
							RecordDateEM.init();
							break;
						}
						case 3:  { 
							out.println("Only allow making a date with other customer.");
							RecordDateEM.init();
							break;
						}
						default: RecordDateEM.init();
						}
						
					} catch (Exception ex) {
					}
				%>
			</div>
		    <div class="submitBTN">
				<input type="submit" value="Record a date" class="submitBTN">
			</div>
		</form>
	</div>
	</div>
</body>
</html>