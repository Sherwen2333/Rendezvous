<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="rendezvous.ProfileInfo"%>

<%@ page import="rendezvous.UserProfile"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="CreateProfileInfo" class="rendezvous.ProfileInfo" scope="page"></jsp:useBean>
	
	<% String mm =(String)session.getAttribute("username");
	%>
	
	
	<jsp:setProperty name="CreateProfileInfo" property="cid" value="<%=mm %>"/>
	<%
	
	ProfileInfo.profileId_t=request.getParameter("profileId");
	ProfileInfo.age_t=request.getParameter("age");
	ProfileInfo.addr_t=request.getParameter("addr");
	ProfileInfo.city_t=request.getParameter("city");
	ProfileInfo.state_t=request.getParameter("state");
	ProfileInfo.gender_t=request.getParameter("gender");
	ProfileInfo.height_t=request.getParameter("height");
	ProfileInfo.weight_t=request.getParameter("weight");
	ProfileInfo.hairColor_t=request.getParameter("hairColor");
	ProfileInfo.hobby_t=request.getParameter("hobby");
	ProfileInfo.agemin_t=request.getParameter("agemin");
	ProfileInfo.agemax_t=request.getParameter("agemax");
	ProfileInfo.georange_t=request.getParameter("georange");
	//System.out.println(ProfileInfo.age_t+"sd");
	//System.out.println(ProfileInfo.age_t);
	//System.out.println(ProfileInfo.addr_t);
	//System.out.println(ProfileInfo.city_t);
	
	if(ProfileInfo.profileId_t==null?true:ProfileInfo.profileId_t.isEmpty()){
		ProfileInfo.status=1;
	}
	else if(ProfileInfo.age_t==null?true:ProfileInfo.age_t.isEmpty()){
		ProfileInfo.status=2;
	}
	else if(ProfileInfo.addr_t==null?true:ProfileInfo.addr_t.isEmpty()){
		ProfileInfo.status=3;
	}
	else if(ProfileInfo.city_t==null?true:ProfileInfo.city_t.isEmpty()){
		ProfileInfo.status=4;
	}
	else if(ProfileInfo.height_t==null?true:ProfileInfo.height_t.isEmpty()){
		ProfileInfo.status=5;
	}
	else if(ProfileInfo.weight_t==null?true:ProfileInfo.weight_t.isEmpty()){
		ProfileInfo.status=6;
	}
	else if(ProfileInfo.hobby_t==null?true:ProfileInfo.hobby_t.isEmpty()){
		ProfileInfo.status=7;
	}
	else if(ProfileInfo.agemin_t==null?true:ProfileInfo.agemin_t.isEmpty()){
		ProfileInfo.status=8;
	}
	else if(ProfileInfo.agemax_t==null?true:ProfileInfo.agemax_t.isEmpty()){
		ProfileInfo.status=9;
	}
	else if(ProfileInfo.georange_t==null?true:ProfileInfo.georange_t.isEmpty()){
		ProfileInfo.status=20;
	}
	else if(!ProfileInfo.Isdigit(ProfileInfo.age_t)){	
		ProfileInfo.status=10;
	}
	else if(!ProfileInfo.Isdigit(ProfileInfo.height_t)){	
		ProfileInfo.status=11;
	}
	else if(!ProfileInfo.Isdigit(ProfileInfo.weight_t)){	
		ProfileInfo.status=12;
	}
	else if(!ProfileInfo.Isdigit(ProfileInfo.agemin_t)){	
		ProfileInfo.status=13;
	}
	else if(!ProfileInfo.Isdigit(ProfileInfo.agemax_t)){	
		ProfileInfo.status=14;
	}
	else if(Integer.parseInt(ProfileInfo.agemin_t)>Integer.parseInt(ProfileInfo.agemax_t)){
		ProfileInfo.status=15;
	}
	else if(ProfileInfo.profileId_t.contains("&") || ProfileInfo.profileId_t.contains("\\") || ProfileInfo.profileId_t.contains("'") ){
		ProfileInfo.status=16;
	}
	else if(!ProfileInfo.Isdigit(ProfileInfo.georange_t)){
		ProfileInfo.status=21;
	}
	if(ProfileInfo.status!=0){
		response.sendRedirect("CreateProfile.jsp"); 
	 	return ;
	}else {
	%>
		<jsp:setProperty name="CreateProfileInfo" property="*" />
	<%
		int status=ProfileInfo.CreateProfile(CreateProfileInfo);
		if(status!=0){
			ProfileInfo.status=status;
			response.sendRedirect("CreateProfile.jsp");
			return ;
		}
		ProfileInfo.init();
		session.setAttribute("profileId", CreateProfileInfo.getProfileId());
		UserProfile.fetchProfileData(CreateProfileInfo.getProfileId());
		response.sendRedirect("userProfile.jsp");
	} %>
	
	
</body>
</html>