<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <%@ page import="rendezvous.GeoLocation"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
		<%
		  String addr=request.getParameter("detailaddr");
		  GeoLocation.detailaddr_t=addr;
		  //System.out.println("GLDT: "+addr);
		  if(addr==null || addr.isEmpty()){
			  GeoLocation.status=1;
			  response.sendRedirect("GeoCheck.jsp");
			  return;
		  }
		  GeoLocation.waiting=true; 
		  response.sendRedirect("Geowaiting.jsp?addr="+addr);
		%>
		
</body>
</html>