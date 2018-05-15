<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="staff.EmployeeInfoEdit"%>
<%@ page import="staff.Employee"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	String str = "Succeed! Redirecting...";
	boolean status = true;
	String id = "";
	try {
		id = request.getParameter("id");
		if(id == null) {
			response.sendRedirect("employeeAbout.jsp");
			return;
		}

		status = EmployeeInfoEdit.delete(id);

		if (!status) {
			str = "Failed! Redirecting...";
		}
	} catch (Exception ex) {
		str = "Failed! Redirecting...";
	}
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<% 
	if(status) { 
%>
	<meta http-equiv="refresh" content="3; url=employeeAbout.jsp" />
<% 
	} else {
		String url = "employeeAboutOthers.jsp?id=" + id;
%>
	<meta http-equiv="refresh" content="3; url=<%=url%>" />
<% 
	}
%>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Redirecting...</title>
</head>
<body>
	<div style="font-size: 4em; text-align: center; color: #135589; padding-top: 2em;">
		<i class="fa fa-spinner fa-spin"></i>
	</div>
	<div style="font-size: 1.5em; text-align: center; font-weight: 500; padding-top: 1em;">
		<%
			out.print(str);
		%>
	</div>

</body>
</html>