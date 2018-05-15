<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	page import="java.util.ArrayList"%>
<%@ page import="rendezvous.Login"%>
<%@ page import="rendezvous.UserProfile"%>
<%@ page import="rendezvous.MakeDateWith"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- meta http-equiv="refresh" content="3; url=http://www.google.com/" -->
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>Insert title here</title>
</head>

<body>
	<%
		if (session.getAttribute("username") == null) {
			response.sendRedirect("login.jsp");
			return;
		}
	%>
	<%
	MakeDateWith.status_t = 0;
		if (request.getParameter("Id").isEmpty()){
			MakeDateWith.status_t=1;
		}
		else if(request.getParameter("Id").contains("'") || request.getParameter("Id").contains("\\")||request.getParameter("Id").contains("&"))
		{
			MakeDateWith.status_t=1;
		}
		else{
			
				ArrayList<String> list =new ArrayList<String>();
			list=MakeDateWith.profileExist(request.getParameter("Id"));
			if(list.size()==0){
				MakeDateWith.status_t=1;
			}
			else{
				//if(MakeDateWith.genderCheck(request.getParameter("Id"))==true){
					//MakeDateWith.status_t=2;
				//}
				//else{
					MakeDateWith.Id_t=request.getParameter("Id");
				//}
			}
			
		}

		if (MakeDateWith.status_t != 0) {
			response.sendRedirect("makeDateWith.jsp");
		} else {
			response.sendRedirect("makeDateProfile.jsp");
		}
	%>
</body>
</html>