<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="rendezvous.UserProfileInfo"%>
<%@ page import="rendezvous.State"%>
<%@ page import="rendezvous.ProfilePlacementPriority"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="rendezvous.Customer"%>
<%@ page import="rendezvous.UserProfile"%>
<%@ page import="rendezvous.HairColor"%>
<%@ page import="staff.ProfileFinderEM"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="Stylesheet/topbar.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/customerCenter.css" type="text/css"
	rel="stylesheet">
<title>Profile Info - Rendezvous</title>
</head>
<body>
	<!-- Check Information -->
	<%
	try {
		if (!session.getAttribute("staffSession").equals("EM")) {
			response.sendRedirect("staffLogin.jsp");
		}
		if (session.getAttribute("staffSSN") == null) {
			response.sendRedirect("staffLogin.jsp");
		}
	} catch (Exception ex) {

	}
		try {
			String pid = request.getParameter("pid");
			if(pid == null)
				pid = ProfileFinderEM.Id;
			if(pid.length() <= 0){
				response.sendRedirect("fullCustomerList.jsp");
				return;
			}

			int option = Integer.parseInt(request.getParameter("op"));
	%>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!-- Top bar -->
	<div class="titleBar"></div>
	<div class=rendezvous>Rendezvous</div>
	<!-- Buttons -->
	<div class="signOut">
		<a href="profileFinderEM.jsp">Back</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="signOut.jsp">Sign Out</a>
	</div>
	<div class="staffSSN">
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<%
		UserProfileInfo info = UserProfileInfo.getProfileInfo(pid);
		if(info == null){
			response.sendRedirect("profileFinderEM.jsp");
			return;
		}
	%>
	<div class="infoContainer">
		<!--===========-->
		<!-- Edit Form -->
		<%
			if(option == 1){ /* Edit Account Info */
		%>
		<form method="post" action="profileInfoEditEM.jsp?pid=<%=info.getProfileId()%>&op=1">
			<div>
				<b style="font-weight: 550;">Creation Date:&nbsp;&nbsp;</b><%=info.getCreationDate() %>
			</div>
			<div>
				<b style="font-weight: 550;">Last Active:&nbsp;&nbsp;</b><%=info.getLastActive()%>
			</div>
			<div>
				<b style="font-weight: 550;">Customer Id:&nbsp;&nbsp;</b><%=info.getUsername()%>
			</div>
			<div>
				<b style="font-weight: 550;">Profile Id:&nbsp;&nbsp;</b>
				<input type="text" name="newId" value="<%=info.getProfileId()%>" maxlength="24"
				class="infoContainerTextfield" style="width:20em;">
			</div>
			<div>
				<b style="font-weight: 550;">Profile Name(Optional):&nbsp;&nbsp;</b>
				<input type="text" name="newName" value="<%=info.getProfileName()==null?"":info.getProfileName()%>" maxlength="24"
				class="infoContainerTextfield" style="width:20em;">
			</div>
			<div class="doneBTNContainer">
				<input type="submit" value="Done" class="doneBTN">
			</div>
		</form>
		<%
			} else {
		%>
		<!--===========-->
		<div>
			<b style="font-weight: 550;">Creation Date:&nbsp;&nbsp;</b><%=info.getCreationDate() %>
		</div>
		<div>
			<b style="font-weight: 550;">Last Active:&nbsp;&nbsp;</b><%=info.getLastActive()%>
		</div>
		<div>
			<b style="font-weight: 550;">Customer Id:&nbsp;&nbsp;</b><%=info.getUsername()%>
		</div>
		<div>
			<b style="font-weight: 550;">Profile Id:&nbsp;&nbsp;</b><%=info.getProfileId()%>
		</div>
		<div>
			<b style="font-weight: 550;">Profile Name(Optional):&nbsp;&nbsp;</b><%=info.getProfileName()==null?"":info.getProfileName()%>
		</div>
		<div style="color: red; text-align: center; font-size: 0.8em;">
			<% 
				if(option == 11) {
					out.println("Edit Failed (occupied ID or invalid field)");
				}
			%>
		</div>
		<div class="editBTN">
			<a href="userProfileTempEM.jsp?pid=<%=info.getProfileId()%>&op=1">Edit&nbsp;<i class="fa fa-edit"></i></a>
		</div>
		<%
			}
		%>
		<hr>
		<!--=============================================================================-->
		<!--=============================================================================-->
		<!--==================================2222222====================================-->
		<!--=============================================================================-->
		<!--===========-->
		<!-- Edit Form -->
		<%
			if(option == 2){ /* Edit Account Info */
				boolean isMale = info.getGender().equals("Male");
		%>
		<form method="post" action="profileInfoEditEM.jsp?pid=<%=info.getProfileId()%>&op=2">
			<div>
				<b style="font-weight: 550;">Age(yr.):&nbsp;&nbsp;</b>
				<input type="text" name="newAge" value="<%=info.getAge()%>" maxlength="3"
					class="infoContainerTextfield" style="width:5em;">
			</div>
			<div>
				<b style="font-weight: 550;">Gender:&nbsp;&nbsp;</b>
				<select name="newGender">
					<%
						if(isMale){
					%>
							<option value ="Female">Female</option>
							<option value ="Male" selected>Male</option>
					<%
						} else {
					%>
							<option value ="Female" selected>Female</option>
							<option value ="Male">Male</option>
					<%
						}
					%>
				</select>
			</div>
			<div>
				<b style="font-weight: 550;">Height(ft.):&nbsp;&nbsp;</b>
				<input type="text" name="newHeight" value="<%=info.getHeight()%>" maxlength="5"
					class="infoContainerTextfield" style="width:5em;">
			</div>
			<div>
				<b style="font-weight: 550;">Weight(lb.):&nbsp;&nbsp;</b>
				<input type="text" name="newWeight" value="<%=info.getWeight()%>" maxlength="5"
					class="infoContainerTextfield" style="width:5em;">
			</div>
			<div>
				<b style="font-weight: 550;">Hair Color:&nbsp;&nbsp;</b>
				<select name="newHairColor"> 
					<%
						for(int i = 0; i < HairColor.HAIR_COLOR.size(); i++){
							boolean selected = HairColor.HAIR_COLOR.get(i).equals(info.getHairColor());
							if(selected){
					%>
					<option value ="<%=HairColor.HAIR_COLOR.get(i)%>" selected><%=HairColor.HAIR_COLOR.get(i)%></option>
					<%
							} else {
					%>
					<option value ="<%=HairColor.HAIR_COLOR.get(i)%>"><%=HairColor.HAIR_COLOR.get(i)%></option>
					<%
							}
						}
					%>
				</select>
			</div>
			<div class="doneBTNContainer">
				<input type="submit" value="Done" class="doneBTN">
			</div>
		</form>
		<%
			} else {
		%>
		<div>
			<b style="font-weight: 550;">Age(yr.):&nbsp;&nbsp;</b><%=info.getAge()%>
		</div>
		<div>
			<b style="font-weight: 550;">Gender:&nbsp;&nbsp;</b><%=info.getGender()%>
		</div>
		<div>
			<b style="font-weight: 550;">Height(ft.):&nbsp;&nbsp;</b><%=info.getHeight()%>
		</div>
		<div>
			<b style="font-weight: 550;">Weight(lb.):&nbsp;&nbsp;</b><%=info.getWeight()%>
		</div>
		<div>
			<b style="font-weight: 550;">Hair Color:&nbsp;&nbsp;</b><%=info.getHairColor()%>
		</div>
		<div style="color: red; text-align: center; font-size: 0.8em;">
			<% 
				if(option == 21) {
					out.println("Edit Failed (numeric input only)");
				}
			%>
		</div>
		<div class="editBTN">
			<a href="userProfileTempEM.jsp?pid=<%=info.getProfileId()%>&op=2">Edit&nbsp;<i class="fa fa-edit"></i></a>
		</div>
		<%
			}
		%>
		<hr>
		<!--=============================================================================-->
		<!--=============================================================================-->
		<!--==================================3333333====================================-->
		<!--=============================================================================-->
		<!--===========-->
		<!-- Edit Form -->
		<%
			if(option == 3){ /* Edit Account Info */
		%>
		<form method="post" action="profileInfoEditEM.jsp?pid=<%=info.getProfileId()%>&op=3">
			<div>
				<b style="font-weight: 550;">Address:&nbsp;&nbsp;</b>
				<input type="text" name="newAddress" value="<%=info.getAddress()%>" maxlength="50"
					class="infoContainerTextfield" style="width:25.5em;">
			</div>
			<div>
				<b style="font-weight: 550;">City:&nbsp;&nbsp;</b>
				<input type="text" name="newCity" value="<%=info.getCity()%>" maxlength="20"
					class="infoContainerTextfield" style="width:13em;">
			</div>
			<div>
				<b style="font-weight: 550;">State:&nbsp;&nbsp;</b>
				<select name="newState"> 
					<%
						for(int i = 0; i < State.STATE.size(); i++){
							boolean selected = State.STATE.get(i).equals(info.getState());
							if(selected){
					%>
					<option value ="<%=State.STATE.get(i)%>" selected><%=State.STATE.get(i)%></option>
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
			<div class="doneBTNContainer">
				<input type="submit" value="Done" class="doneBTN">
			</div>
		</form>
		<%
			} else {
		%>
		<!--===========-->
		<div>
			<b style="font-weight: 550;">Address:&nbsp;&nbsp;</b>
		</div>
		<div style="margin-left: 3em;">
			<%=info.getAddress() %><br><%=info.getCity()%>, <%=info.getState()%>
		</div>
		<div style="color: red; text-align: center; font-size: 0.8em;">
			<% 
				if(option == 31) {
					out.println("Edit Failed (All fields should be valid)");
				}
			%>
		</div>
		<div class="editBTN">
			<a href="userProfileTempEM.jsp?pid=<%=info.getProfileId()%>&op=3">Edit&nbsp;<i class="fa fa-edit"></i></a>
		</div>
		<%
			}
		%>	
		<hr>
		<!--=============================================================================-->
		<!--=============================================================================-->
		<!--==================================4444444====================================-->
		<!--=============================================================================-->
		<!--===========-->
		<!-- Edit Form -->
		<%
			if(option == 4){ /* Edit Account Info */
				boolean isMale = info.getGender().equals("Male");
		%>
		<form method="post" action="profileInfoEditEM.jsp?pid=<%=info.getProfileId()%>&op=4">
			<div>
				<b style="font-weight: 550;">Preferred GeoRange(mi.):&nbsp;&nbsp;</b>
				<input type="text" name="newGeoRange" value="<%=info.getGeoRange()%>" maxlength="10"
					class="infoContainerTextfield" style="width:7.8em;">
			</div>
			<div>
				<b style="font-weight: 550;">Preferred Age Range(yrs):&nbsp;&nbsp;</b>
				<input type="text" name="newAgeMin" value="<%=info.getAgeMin()%>" maxlength="3"
					class="infoContainerTextfield" style="width:3em;">&nbsp;~&nbsp;<input type="text" name="newAgeMax" 
					value="<%=info.getAgeMax()%>" maxlength="3" class="infoContainerTextfield" style="width:3em;">
			</div>
			<div>
				<b style="font-weight: 550;">Hobby:&nbsp;&nbsp;</b>
			</div>
			<div style="margin-left: 4em;">
				<textarea name="newHobby" rows="4" cols="35" placeholder="Hobby" maxlength="100"
					style="resize: none; font-size: 0.8em;"><%=info.getHobby()%></textarea>
			</div>
			<div class="doneBTNContainer">
				<input type="submit" value="Done" class="doneBTN">
			</div>
		</form>
		<%
			} else {
		%>
		<div>
			<b style="font-weight: 550;">Preferred GeoRange(mi.):&nbsp;&nbsp;</b><%=info.getGeoRange()%>
		</div>
		<div>
			<b style="font-weight: 550;">Preferred Age Range(yrs):&nbsp;&nbsp;</b><%=info.getAgeMin()%>&nbsp;~&nbsp;<%=info.getAgeMax()%>
		</div>
		<div>
			<b style="font-weight: 550;">Hobby:&nbsp;&nbsp;</b>
		</div>
		<div style="margin-left: 4em;">
			<%=info.getHobby()%>
		</div>
		<div style="color: red; text-align: center; font-size: 0.8em;">
			<% 
				if(option == 41) {
					out.println("Edit Failed (numeric input only)");
				}
			%>
		</div>
		<div class="editBTN">
			<a href="userProfileTempEM.jsp?pid=<%=info.getProfileId()%>&op=4">Edit&nbsp;<i class="fa fa-edit"></i></a>
		</div>
		<%
			}
		%>
		<hr>
		<!--=============================================================================-->
		<!--====================================DELETE===================================-->
		<!--=============================================================================-->
		<%
			boolean hasPendingDates = info.getNumPendingDate() != 0;
			if(hasPendingDates) {
		%>
				<div class="closeContainerInvalid">
					<a href="">Delete This Profile (Possible When No More Pending Dates)</a>
				</div>
		<%
			} else {
		%>
				<div class="closeContainer">
					<a href="profileInfoEditEM.jsp?pid=<%=info.getProfileId()%>&op=666">Delete This Profile</a>
				</div>
		<%
			}
		%>
	</div>
	<%
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	%>
</body>
</html>