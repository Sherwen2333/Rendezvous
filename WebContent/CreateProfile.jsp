<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="rendezvous.ProfileInfo"%>
<%@ page import="rendezvous.State" %>
<%@ page import="rendezvous.HairColor" %>
<%@ page import="rendezvous.Login" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="Stylesheet/topbar.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/createProfile.css" type="text/css" rel="stylesheet">
<title>Create New Profile</title>
</head>
<body>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!-- Top bar -->
	<div class="titleBar"></div>
	<div class=rendezvous>Rendezvous</div>
	<!-- Buttons -->
	<div class="signOut">
		<a href="chooseProfile.jsp">Back</a>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="title">
		Create New Profile
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="formContainer">
	<div class="formInnerContainer">
	  	<div class="instruction">
	  		* You must fill in all fields
	  	</div>
	  	<form method="post" action="CreateProfileCheck.jsp">
	  	    <div> 
				<b>Profile ID:&nbsp;</b><input type="text" name="profileId" maxlength="24" style="text-align: center"
					value="<%=ProfileInfo.profileId_t==null?"":ProfileInfo.profileId_t%>">
			</div>
			<div>
				<b>Age(yrs):&nbsp;</b><input type="text" name="age" maxlength="2"
					value="<%=ProfileInfo.age_t==null?"":ProfileInfo.age_t%>" style="width:3em; text-align: center">
			</div>
			<div>
				<b>Address:&nbsp;</b><input type="text" name="addr" maxlength="50" style="width:25em; text-align: center"
					value="<%=ProfileInfo.addr_t==null?"":ProfileInfo.addr_t%>">
			</div>
			<!-- City/State -->
			<div>
				<b>City:&nbsp;</b><input type="text" name="city" maxlength="20" style="width:15em; text-align: center"
					value="<%=ProfileInfo.city_t==null?"":ProfileInfo.city_t%>">
			</div>
			<div>
				<b>State:&nbsp;</b><select name="state">
					<%
						for (int i = 0;i < State.STATE.size(); i++){
							if(State.STATE.get(i).equals(ProfileInfo.state_t)) {
					%>
						<option value ="<%=State.STATE.get(i)%>" selected="selected"><%=State.STATE.get(i)%></option>
					<%
							} else {
					%>
		  				<option value ="<%=State.STATE.get(i)%>"><%=State.STATE.get(i)%></option>
		  			<%
							}
						} 
		  			%>
			    </select>
			</div>
			<!-- Gender -->
			<div>
				<b>Gender:&nbsp;</b><select name="gender">
	  				<%	
						if("Female".equals(ProfileInfo.gender_t)){
					%>
							<option value ="Male">Male</option>
							<option value ="Female" selected="selected">Female</option>
					<%
						} else {
					%>
		  				<option value ="Male" selected="selected">Male</option>
						<option value ="Female">Female</option>
		  		    <%
			  				} 
			  		%>
	    		</select>
			</div>
			<!-- Height -->
			<div>
				<b>Height(ft.):&nbsp;</b><input type="text" name="height" maxlength="5" style="width:8em; text-align: center"
					value="<%=ProfileInfo.height_t==null?"":ProfileInfo.weight_t%>">
			</div>
			<!-- Weight -->
			<div class="SignInfo">
				<b>Weight(lb.):&nbsp;</b><input type="text" name="weight" maxlength="5" style="width:8em; text-align: center"
					value="<%=ProfileInfo.weight_t==null?"":ProfileInfo.weight_t%>" >
			</div>
			<!-- Hair Color -->
	  		<div>
				<b>Hair Color:&nbsp;</b><select name="hairColor">
					<%
						for(int i=0;i<HairColor.HAIR_COLOR.size();i++){
							if(HairColor.HAIR_COLOR.get(i).equals(ProfileInfo.hairColor_t)){
					%>
					<option value ="<%=HairColor.HAIR_COLOR.get(i)%>" selected="selected"><%=HairColor.HAIR_COLOR.get(i)%></option>
					<%
							} else {%>
		  				<option value ="<%=HairColor.HAIR_COLOR.get(i)%>"><%=HairColor.HAIR_COLOR.get(i)%></option>
		  			<%
							}
						} 
		  			%>
				</select>
			</div>
			<!-- Hobby -->
			<div>
				<b>Hobby:&nbsp;</b>
			</div>
			<div style="margin-left: 3em;">
				<textarea name="hobby" rows="4" cols="35" style="resize: none; font-size:0.8em;"
					maxlength="100" ><%=ProfileInfo.hobby_t==null?"":ProfileInfo.hobby_t%></textarea>
			</div>
			<!-- Age Range -->
			<div class="SignInfo">
					<b>Preferred Age Range:&nbsp;</b><input type="text" name="agemin" maxlength="2" style="width:4em; text-align: center"
					value="<%=ProfileInfo.agemin_t==null?"":ProfileInfo.agemin_t%>"> ~ <input type="text" name="agemax" 
					value="<%=ProfileInfo.agemax_t==null?"":ProfileInfo.agemax_t%>" maxlength="2" style="width:4em; text-align: center">
			</div>
			<!-- Geo Range -->
				<b>Geo Range:&nbsp;</b><input type="text" name="georange" maxlength="10" style="width:10em; text-align: center"
					value="<%=ProfileInfo.georange_t==null?"":ProfileInfo.georange_t%>"> miles
			<!-- Submit -->
			<div class="submitButton">
	      		<input type="submit" value="Sign Up" style="font-size: 2em; color: #07575b;">
	      	</div>
	  	</form>
		<div class="error">
			<%
			try {
				switch (ProfileInfo.status) {
				//case 0:  response.sendRedirect("chooseProfile.jsp");
				case 1:  { 
					out.println("Profile ID cannot be empty.");
					ProfileInfo.init();
				}break;
				case 2:  { 
					out.println("Age cannot be empty.");
					ProfileInfo.init();
				}break;
				case 3:  { 
					out.println("Address cannot be empty.");
					ProfileInfo.init();
				}break;
				case 4:  { 
					out.println("City cannot be empty.");
					ProfileInfo.init();
				}break;
				case 5:  { 
					out.println("Height cannot be empty.");
					ProfileInfo.init();
				}break;
				case 6:  { 
					out.println("Weight cannot be empty.");
					ProfileInfo.init();
				}break;
				case 7:  { 
					out.println("Hobby cannot be empty.");
					ProfileInfo.init();
				}break;
				case 8:  { 
					out.println("AgeMin cannot be empty.");
					ProfileInfo.init();
				}break;
				case 9:  { 
					out.println("AgeMax cannot be empty.");
					ProfileInfo.init();
				}break;
				case 10:  { 
					out.println("Age must be numeric.");
					ProfileInfo.init();
				}break;
				case 11:  { 
					out.println("Height must be numeric.");
					ProfileInfo.init();
				}break;
				case 12:  { 
					out.println("Weight must be numeric.");
					ProfileInfo.init();
				}break;
				case 13:  { 
					out.println("AgeMin must be numeric.");
					ProfileInfo.init();
				}break;
				case 14:  { 
					out.println("AgeMax must be numeric.");
					ProfileInfo.init();
				}break;
				case 15:  { 
					out.println("AgeMin cannot be greater than AgeMax.");
					ProfileInfo.init();
				}break;
				case 16:  { 
					out.println("ProfileId cannot contain &, \\ and '.");
					ProfileInfo.init();
				}break;
				case 17:  { 
					out.println("Duplicate ProfileId.");
					ProfileInfo.init();
				}break;
				case 18:  { 
					out.println("Customer Id error.");
					ProfileInfo.init();
				}break;
				case 20:{
					out.println("Geo Range cannot be empty.");
					ProfileInfo.init();
				}break;
				case 21:{
					out.println("Geo Range must be numeric.");
					ProfileInfo.init();
				}break;
				default: ProfileInfo.init();break;
				}
			} catch (Exception ex) {
			}
			%>
		</div>
	</div>
	</div>
	<div style="padding-bottom: 3em;"></div>
</body>
</html>