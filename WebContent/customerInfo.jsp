<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="staff.CustomerInfo"%>
<%@ page import="staff.Employee"%>
<%@ page import="rendezvous.State"%>
<%@ page import="rendezvous.ProfilePlacementPriority"%>
<%@ page import="java.util.ArrayList"%>

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
<title>Customer Info - Rendezvous</title>
</head>
<body>
	<!-- Check Information -->
	<%
		try {
			if (session.getAttribute("staffSession") == null) {
				response.sendRedirect("staffLogin.jsp");
				return;
			}
			if (session.getAttribute("staffSSN") == null) {
				response.sendRedirect("staffLogin.jsp");
				return;
			}
		} catch (Exception ex) {

		}
		try {
			String id = request.getParameter("id");
			if(id.length() <= 0){
				response.sendRedirect("customerCenter.jsp?op=22");
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
		<a href="fullCustomerList.jsp ">Back</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="signOut.jsp">Sign Out</a>
	</div>
	<div class="staffSSN">
		ID:
		<%=session.getAttribute("staffSSN")%>
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<%
		CustomerInfo info = CustomerInfo.getCustomerInfo(id);
		if(info == null){
			response.sendRedirect("customerCenter.jsp?op=22");
		}
	%>
	<div class="infoContainer">
		<!--===========-->
		<!-- Edit Form -->
		<%
			if(option == 1){ /* Edit Account Info */
		%>
		<form method="post" action="customerInfoEdit.jsp?id=<%=info.getId()%>&op=1">
			<div>
				<b style="font-weight: 550;">Creation Date:&nbsp;&nbsp;</b><%=info.getCreationDate() %>
			</div>
			<div>
				<b style="font-weight: 550;">AccountNum:&nbsp;&nbsp;</b><%=String.format("%06d", info.getAccountNum())%>
			</div>
			<div>
				<b style="font-weight: 550;">Customer Id:&nbsp;&nbsp;</b>
				<input type="text" name="newId" value="<%=info.getId()%>" maxlength="24"
				class="infoContainerTextfield" style="width:20em;">
			</div>
			<div>
				<b style="font-weight: 550;">Password:&nbsp;&nbsp;</b>
				<input type="password" name="newPassword" value="<%=info.getPassword()%>" maxlength="24"
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
			<b style="font-weight: 550;">AccountNum:&nbsp;&nbsp;</b><%=String.format("%06d", info.getAccountNum())%>
		</div>
		<div>
			<b style="font-weight: 550;">Customer Id:&nbsp;&nbsp;</b><%=info.getId() %>
		</div>
		<div>
			<b style="font-weight: 550;">Password:&nbsp;&nbsp;</b><%=info.getPassword() %>
		</div>
		<div style="color: red; text-align: center; font-size: 0.8em;">
			<% 
				if(option == 11) {
					out.println("Edit Failed (occupied ID or invalid field)");
				}
			%>
		</div>
		<div class="editBTN">
			<a href="customerInfo.jsp?id=<%=info.getId()%>&op=1">Edit&nbsp;<i class="fa fa-edit"></i></a>
		</div>
		<%
			}
		%>
		<!--=============================================================================-->
		<!--=============================================================================-->
		<!--==================================2222222====================================-->
		<!--=============================================================================-->
		<hr>
		<!--===========-->
		<!-- Edit Form -->
		<%
			if(option == 2){ /* Edit Account Info */
		%>
		<form method="post" action="customerInfoEdit.jsp?id=<%=info.getId()%>&op=2">
			<div>
				<b style="font-weight: 550;">Last Name:&nbsp;&nbsp;</b>
				<input type="text" name="newLast" value="<%=info.getLastName()%>" maxlength="20"
					class="infoContainerTextfield" style="width:20em;">
			</div>
			<div>
				<b style="font-weight: 550;">First Name:&nbsp;&nbsp;</b>
				<input type="text" name="newFirst" value="<%=info.getFirstName()%>" maxlength="20"
					class="infoContainerTextfield" style="width:20em;">
			</div>
			<div>
				<b style="font-weight: 550;">Telephone:&nbsp;&nbsp;</b>
				<input type="text" name="newTele" value="<%=info.getTelephone()%>" maxlength="10"
					class="infoContainerTextfield">
			</div>
			<div>
				<b style="font-weight: 550;">Email:&nbsp;&nbsp;</b>
				<input type="text" name="newEmail" value="<%=info.getEmail()%>" maxlength="50"
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
			<b style="font-weight: 550;">Last Name:&nbsp;&nbsp;</b><%=info.getLastName() %>
		</div>
		<div>
			<b style="font-weight: 550;">First Name:&nbsp;&nbsp;</b><%=info.getFirstName() %>
		</div>
		<div>
			<b style="font-weight: 550;">Telephone:&nbsp;&nbsp;</b><%=info.getTelephone() %>
		</div>
		<div>
			<a href="mailto:<%=info.getEmail()%>?subject=Hello%20From%20Rendezvous">
				<b style="font-weight: 550;">Email:&nbsp;&nbsp;</b><%=info.getEmail()%>
			</a>
		</div>
		<div style="color: red; text-align: center; font-size: 0.8em;">
			<% 
				if(option == 21) {
					out.println("Edit Failed (no field should be empty and telephone should be valid)");
				}
			%>
		</div>
		<div class="editBTN">
			<a href="customerInfo.jsp?id=<%=info.getId()%>&op=2">Edit&nbsp;<i class="fa fa-edit"></i></a>
		</div>
		<%
			}
		%>
		<!--=============================================================================-->
		<!--=============================================================================-->
		<!--==================================3333333====================================-->
		<!--=============================================================================-->
		<hr>
		<!--===========-->
		<!-- Edit Form -->
		<%
			if(option == 3){ /* Edit Account Info */
		%>
		<form method="post" action="customerInfoEdit.jsp?id=<%=info.getId()%>&op=3">
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
			<div>
				<b style="font-weight: 550;">Zip:&nbsp;&nbsp;</b>
				<input type="text" name="newZip" value="<%=info.getZip()%>" maxlength="5"
					class="infoContainerTextfield">
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
			<b style="font-weight: 550;">Address:&nbsp;&nbsp;</b><%=info.getAddress() %>
		</div>
		<div>
			<b style="font-weight: 550;">City:&nbsp;&nbsp;</b><%=info.getCity()%>, <%=info.getState()%>, <%=info.getZip()%>
		</div>
		<div style="color: red; text-align: center; font-size: 0.8em;">
			<% 
				if(option == 31) {
					out.println("Edit Failed (All fields should be valid)");
				}
			%>
		</div>
		<div class="editBTN">
			<a href="customerInfo.jsp?id=<%=info.getId()%>&op=3">Edit&nbsp;<i class="fa fa-edit"></i></a>
		</div>	
		<%
			}
		%>	
		<!--=============================================================================-->
		<!--=============================================================================-->
		<!--==================================4444444====================================-->
		<!--=============================================================================-->
		<hr>
		<!--===========-->
		<!-- Edit Form -->
		<%
			if(option == 4){ /* Edit Account Info */
		%>
		<form method="post" action="customerInfoEdit.jsp?id=<%=info.getId()%>&op=4">
			<div>
				<b style="font-weight: 550;">Credit Card Number:&nbsp;&nbsp;</b>
				<input type="text" name="newCCN" value="<%=info.getCreditCardNum()%>" maxlength="16"
					class="infoContainerTextfield">
			</div>
			<div>
				<b style="font-weight: 550;">Profile Placement Priority:&nbsp;&nbsp;</b>
				<select name="newPPP"> 
					<%
						for(int i = 0; i < ProfilePlacementPriority.PPP.size(); i++){
							boolean selected = ProfilePlacementPriority.PPP.get(i).equals(info.getPpp());
							if(selected){
					%>
					<option value ="<%=ProfilePlacementPriority.PPP.get(i)%>" selected><%=ProfilePlacementPriority.PPP.get(i)%></option>
					<%
							} else {
					%>
					<option value ="<%=ProfilePlacementPriority.PPP.get(i)%>"><%=ProfilePlacementPriority.PPP.get(i)%></option>
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
		<!--===========-->
		<%
			} else {
		%>
		<div>
			<b style="font-weight: 550;">Credit Card Number:&nbsp;&nbsp;</b><%=info.getCreditCardNum() %>
		</div>
		<div>
			<b style="font-weight: 550;">Profile Placement Priority:&nbsp;&nbsp;</b><%=info.getPpp() %>
		</div>
		<div style="color: red; text-align: center; font-size: 0.8em;">
			<% 
				if(option == 41) {
					out.println("Edit Failed (Invalid Credit Card Number)");
				}
			%>
		</div>
		<div class="editBTN">
			<a href="customerInfo.jsp?id=<%=info.getId()%>&op=4">Edit&nbsp;<i class="fa fa-edit"></i></a>
		</div>
		<%
			}
		%>
		<!--=============================================================================-->
		<!--=============================================================================-->
		<!--====================================Profile==================================-->
		<!--=============================================================================-->
		<hr>
		<div>
			<b style="font-weight: 550;">Profiles:</b>
		</div>
		<div class="profileListContainer">
			<%	
				for (int i = 0; i < info.getProfiles().size(); i++){
					if(session.getAttribute("staffSession").equals("MA")) {
			%>
			<div><a href="userProfileTempMA.jsp?pid=<%=info.getProfiles().get(i)%>&op=0"><%=info.getProfiles().get(i)%></a></div>
			<%
				} else {
			%>
			<div><a href="userProfileTempEM.jsp?pid=<%=info.getProfiles().get(i)%>&op=0"><%=info.getProfiles().get(i)%></a></div>
			<%
				} 
				}
			%>
		</div>
		<!--=============================================================================-->
		<!--====================================DELETE===================================-->
		<!--=============================================================================-->
		<%
			boolean hasPendingDates = CustomerInfo.CheckPendingDate(id) != 0;
			if(hasPendingDates) {
		%>
				<div class="closeContainerInvalid">
					<a href="">Delete This Account (Possible When No More Pending Dates)</a>
				</div>
		<%
			} else {
		%>
				<div class="closeContainer">
					<a href="customerInfoEdit.jsp?id=<%=info.getId()%>&op=666">Delete This Account</a>
				</div>
		<%
			}
		%>
	</div>
	<%
		} catch (Exception ex) {

		}
	%>
</body>
</html>