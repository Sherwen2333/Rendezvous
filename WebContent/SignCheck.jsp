<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="rendezvous.SignUp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	
	<!-- Get user input -->
	<jsp:useBean id="SignUpInfo" class="rendezvous.SignUp" scope="page"></jsp:useBean>
	<!-- Check telephone and zipcode -->
	<%
	String a=new String();
	a=request.getParameter("tele");
	SignUp.id_t=request.getParameter("id");
	SignUp.password_t=request.getParameter("password");
	SignUp.first_t=request.getParameter("first");
	SignUp.last_t=request.getParameter("last");
	SignUp.addr_t=request.getParameter("addr");
	SignUp.city_t=request.getParameter("city");
	SignUp.state_t=request.getParameter("state");
	SignUp.email_t=request.getParameter("email");
	SignUp.zip_t=request.getParameter("zip");
	SignUp.tele_t=a;
	
	if(a!=null){
	if(a.length()!=10) {
		SignUp.status=16;
	 	response.sendRedirect("signUp.jsp"); 
	 	return ;
	}
	final String number = "0123456789";
	  for(int i = 0;i < a.length(); i ++)
	  {
	  	if(number.indexOf(a.charAt(i)) == -1)
	     {  
	  		SignUp.status=13;
		 	response.sendRedirect("signUp.jsp"); 
		 	return ;
	     }  
	  }  
	}
	if(SignUp.zip_t!=null){
		//if(SignUp.zip_t.length()!=5){
		//	SignUp.status=17;
		//	response.sendRedirect("signUp.jsp");
		//	return ;
		//}
	
	final String number = "0123456789";
	  for(int i = 0;i < SignUp.zip_t.length(); i ++)
	  {
	  	if(number.indexOf(SignUp.zip_t.charAt(i)) == -1)
	     {  
	  		SignUp.status=18;
		 	response.sendRedirect("signUp.jsp"); 
		 	return ;
	     }  
	  }  
	 }
	%>
	<jsp:setProperty name="SignUpInfo" property="*" />
	
	<br />
	<% int status; 
	status=SignUp.CreateCustomer(SignUpInfo);
	if(status==0){
		session.setAttribute("session", "TRUE");
		session.setAttribute("username", SignUpInfo.getId());
		SignUp.init();
		response.sendRedirect("chooseProfile.jsp");
	}
	else {
		SignUp.status=status;
		response.sendRedirect("signUp.jsp");
	}
	
	%> 
</body>
</html>