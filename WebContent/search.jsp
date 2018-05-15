<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	page import="java.util.ArrayList"%>
<%@ page import="rendezvous.Login"%>
<%@ page import="rendezvous.UserProfile"%>
<%@ page import="rendezvous.Search"%>
<%@ page import="rendezvous.State"%>
<%@ page import="rendezvous.HairColor"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="Stylesheet/topbar.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/search.css" type="text/css" rel="stylesheet">
<title>Search - Rendezvous</title>
</head>
<body>
	<%
		if (session.getAttribute("username") == null)
			response.sendRedirect("login.jsp");
	%>
	<div class="titleBar"></div>
	<div class=rendezvous>Rendezvous</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!-- Button -->
	<div class="signOut">
		<a href="userProfile.jsp">Back</a>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!-- Search Profiles -->
	<div class="searchTitle">
		<i class="fa fa-search"></i> Search Profiles
	</div>
	<div class="formContainer">
		<div class="formInnerContainer">
			<div class="formTitle">Search By Profile ID</div>
		    <form method = "POST" action="searchResultId.jsp">
		    	<div class="submitBTN">
		        	Profile ID:&nbsp;&nbsp;<input type="text" name="Id" maxlength="24" style="width: 20em;">
		        </div>
		        <div class="submitBTN">
		        	<input type="submit" value="Submit">
		        </div>
	       </form>
       </div>
    </div>
    <div class="formContainer">
		<div class="formInnerContainer">
			<div class="formTitle">Advance Search</div>
		    <form class="formContent" method = "POST" action="searchCheck.jsp">
		    	<div>
		        	City:&nbsp;&nbsp;<input type="text" name="City" value="<%=Search.City_t.isEmpty()?"":Search.City_t%>" maxlength="20">
		        </div>
		        <div>
			        State:&nbsp;<select name="State">
			  			<option value ="">--------------------</option>
			  			<% 
			  				for(int i = 0; i < State.STATE.size(); i++){
			  			%>
		  				<option value = "<%=State.STATE.get(i) %>"><%=State.STATE.get(i)%></option>
		  				<%
			  				}
			  			%>
					</select>
				</div>
		        <hr>
		        <div>
			        Height(ft.):&nbsp;&nbsp;<input value="<%=Search.HeightMin_t.isEmpty()?"":Search.HeightMin_t%>" 
			        	type="text" name="HeightMin" maxlength="5" style="width:8em;">&nbsp;&nbsp;to&nbsp;&nbsp;<input type="text" 
			        	name="HeightMax" value="<%=Search.HeightMax_t.isEmpty()?"":Search.HeightMax_t%>" maxlength="5" style="width:8em;">
		        </div>
		        <div>
			        Weight(lb.):&nbsp;<input value="<%=Search.WeightMin_t.isEmpty()?"":Search.WeightMin_t%>" 
			        	type="text" name="WeightMin" maxlength="5" style="width:8em;">&nbsp;&nbsp;to&nbsp;&nbsp;<input type="text" 
			        	name="WeightMax" value="<%=Search.WeightMax_t.isEmpty()?"":Search.WeightMax_t%>" maxlength="5" style="width:8em;">
		        </div>
		        <div>
		        	Hair Color:&nbsp;<select name="HColor">
			  			<option value ="">---------------------</option>
			  			<% 
			  				for(int i=0;i<HairColor.HAIR_COLOR.size();i++){
			  					%>
			  					<option value = "<%=HairColor.HAIR_COLOR.get(i) %>"><%=HairColor.HAIR_COLOR.get(i)%></option>
			  					<%
			  				}
			  			%>
					</select>
				</div>
		        <hr>
		        <div>
			        Age(yrs):&nbsp;<input value="<%=Search.AgeMin_t.isEmpty()?"":Search.AgeMin_t%>" 
			        	type="text" name="AgeMin" maxlength="3" style="width:5em;">&nbsp;&nbsp;to&nbsp;&nbsp;<input type="text" 
			        	name="AgeMax" value="<%=Search.AgeMax_t.isEmpty()?"":Search.AgeMax_t%>" maxlength="3" style="width:5em;">
		        </div>
		        <hr>
		        <div class="error">
					<%
						try {
							switch (Search.search_status){
							case 1:  { 
								out.println("Height should be numeric and positive");
								Search.init();
								break;
							}
							case 2:  { 
								out.println("Height should be numeric and positive");
								Search.init();
								break;
							}
							case 3:  { 
								out.println("Weight should be numeric and positive");
								Search.init();
								break;
							}
							case 4:  { 
								out.println("Weight should be numeric and positive");
								Search.init();
								break;
							}
							case 5:  { 
								out.println("Age should be a positive integer");
								Search.init();
								break;
							}
							case 6:  { 
								out.println("Age should be a positive integer");
								Search.init();
								break;
							}
							case 7:  { 
								out.println("State field shoule not be null if city is given");
								Search.init();
								break;
							}
							default: Search.init();
							}
						} catch (Exception ex) {
						}
					%>
				</div>
				<div class="submitBTN">
		        	<input type="submit" value="Submit">
		        </div>
		    </form>
		</div>
	</div>
	<div style="padding: 2em;"></div>
</body>
</html>