<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@ page import="rendezvous.GeoLocation"%>
   <%@ page import="rendezvous.DateProcessing" %>
   <%@ page import="java.sql.Timestamp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
		<%
		String inviter=request.getParameter("inviter");
		String invitee=request.getParameter("invitee");
		String addr=request.getParameter("addr");
		if(inviter==null || invitee == null || addr==null){
			response.sendRedirect("Message.jsp");
			return ;
		}
		else {
			if(GeoLocation.CheckMessageExist(invitee, inviter)){
				long t = System.currentTimeMillis();
				t+=3600000;
				Timestamp ts=new Timestamp(t);	
			DateProcessing.makeDateOnGivenDateGeo(inviter, invitee,ts.toString(),addr,null);
			GeoLocation.waiting=false;
			GeoLocation.acceptName=invitee;
			GeoLocation.DeleteOneMessageReceived(invitee,inviter);
			response.sendRedirect("Message.jsp");
			return ;
			}
			else{
				%>
				<script>
				alert("Someone else has always accepted this invitation.");
				</script>
				<%
				response.sendRedirect("Message.jsp");
			}
		}
		
		%>
		
</body>
</html>