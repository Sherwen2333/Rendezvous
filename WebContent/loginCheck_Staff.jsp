<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="staff.StaffLogin"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>Login Check/Staff</title>
</head>
<!-- Body -->
<body>
	<!-- Check login info & redirect to user homepage if succeed -->
	<%
		try {
			String id = request.getParameter("username");
			String password = request.getParameter("password");
			int status = StaffLogin.verifyLoginInfo(id, password);
			if (status == 1) {
				out.print("Employee");
				session.setAttribute("staffSSN", id);
				session.setAttribute("staffSession", "EM");
				response.sendRedirect("employeeHome.jsp");
			} else if (status == 2) {
				out.print("Manager");
				session.setAttribute("staffSSN", id);
				session.setAttribute("staffSession", "MA");
				response.sendRedirect("managerHome.jsp");
			} else {
				StaffLogin.status = false;
				response.sendRedirect("staffLogin.jsp");
			}
		} catch (Exception ex) {
			StaffLogin.status = false;
			response.sendRedirect("staffLogin.jsp");
		}
	%>

</body>
</html>