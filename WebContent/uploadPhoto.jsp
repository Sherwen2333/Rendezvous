<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.InputStream"%>
<%@	page import="java.util.ArrayList"%>
<%@ page import="rendezvous.UploadPhoto"%>
<%@ page import="rendezvous.Customer"%>
<%@ page import="rendezvous.UserProfile"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="refresh" content="2.7; url=photo.jsp" />
<title>Insert title here</title>
</head>
<body>
	<br>
	<div style="text-align: center; font-size: 2em;">
	<%
		String url = request.getParameter("photoURL");
		if(url==null?true:url.isEmpty()){
			response.sendRedirect("photo.jsp?url=0");
			return ;
		}
		boolean result = UploadPhoto.uploadPhoto(url);
		if(result){
			out.print("Upload Success!");
		} else {
			out.print("Upload Failure!"); 
		}
	%>
	</div>
	<br>
	<div style="text-align: center; font-size: 1em;">
	<%
		out.print("Redirecting in 3 seconds...");
	%>
	</div>
</body>
</html>