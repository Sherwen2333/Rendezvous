<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	page import="java.util.ArrayList"%>
<%@ page import="rendezvous.Login"%>
<%@ page import="rendezvous.UserProfile"%>
<%@ page import="staff.SuggestListMA"%>
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
	try {
		if (!session.getAttribute("staffSession").equals("MA")) {
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
	<%
	SuggestListMA.status_t = 0;
		if (request.getParameter("Id1").isEmpty()){
			SuggestListMA.status_t=1;
		}
		else if(request.getParameter("Id1").contains("'") || request.getParameter("Id1").contains("\\")||request.getParameter("Id1").contains("&"))
		{
			SuggestListMA.status_t=1;
		}
		else if (request.getParameter("Id2").isEmpty()){
			SuggestListMA.status_t=1;
		}
		else if(request.getParameter("Id2").contains("'") || request.getParameter("Id2").contains("\\")||request.getParameter("Id2").contains("&"))
		{
			SuggestListMA.status_t=1;
		}
		
		else{
				ArrayList<String> list1 =new ArrayList<String>();
				ArrayList<String> list2 =new ArrayList<String>();
			list1=SuggestListMA.profileExist(request.getParameter("Id1"));
			list2=SuggestListMA.profileExist(request.getParameter("Id2"));
			if(list1.size()==0){
				SuggestListMA.status_t=1;
			}
			else if(list2.size()==0){
				SuggestListMA.status_t=1;
			}
			else{
				//if(MakeDateWith.genderCheck(request.getParameter("Id"))==true){
					//MakeDateWith.status_t=2;
				//}
				//else{
					SuggestListMA.Id1=request.getParameter("Id1");
					SuggestListMA.Id2=request.getParameter("Id2");
					if(SuggestListMA.CIdCheck(request.getParameter("Id1"), request.getParameter("Id2")))
						SuggestListMA.status_t=3;
				//}
			}
			
		}

		if (SuggestListMA.status_t != 0) {
			SuggestListMA.Id1="";
			SuggestListMA.Id2="";
			response.sendRedirect("suggestListMA.jsp");
		} else {
			response.sendRedirect("processSuggestListMA.jsp");
		}
	%>
</body>
</html>