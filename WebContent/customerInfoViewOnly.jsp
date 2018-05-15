<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="staff.CustomerInfo"%>
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
<link href="Stylesheet/customerCenterViewOnly.css" type="text/css" rel="stylesheet">
<title>Customer Info - Rendezvous</title>
</head>
<body>
	<!-- Check Information -->
	<%
		try {
			if(session.getAttribute("username") == null){
				response.sendRedirect("login.jsp");
				return;
			}
		} catch (Exception ex) {

		}
		try {
			String id = (String) session.getAttribute("username");
			if(id.length() <= 0){
				response.sendRedirect("customerCenter.jsp");
				return;
			}
	%>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<%
			CustomerInfo info = CustomerInfo.getCustomerInfo(id);
			int option = Integer.parseInt(request.getParameter("op"));
	%>
	<!-- Top bar -->
	<div class="titleBar"></div>
	<div class="rendezvous"><a href="chooseProfile.jsp">Rendezvous</a></div>
	<!-- Buttons -->
	<div class="signOut">
		<a href="chooseProfile.jsp">Back</a>&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="signOut.jsp">Sign Out</a>
	</div>
	<div class="staffSSN">
	</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="infoContainer">
		<!--===========-->
		<!-- Edit Form -->
		<%
			if(option == 8){ /* Edit Account Info */
		%>
		<form method="post" action="customerInfoEdit.jsp?id=null&op=8">
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
				if(option == 81) {
					out.println("Edit Failed (occupied ID or invalid field)");
				}
			%>
		</div>
		<div class="editBTN">
			<a href="customerInfoViewOnly.jsp?&op=8">Edit&nbsp;<i class="fa fa-edit"></i></a>
		</div>
		<%
			}
		%>
		<!--=============================================================================-->
		<!--=============================================================================-->
		<!--==================================2222222====================================-->
		<!--=============================================================================-->
		<hr>
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
		<!--=============================================================================-->
		<!--=============================================================================-->
		<!--==================================3333333====================================-->
		<!--=============================================================================-->
		<hr>
		<div>
			<b style="font-weight: 550;">Address:&nbsp;&nbsp;</b><%=info.getAddress() %>
		</div>
		<div>
			<b style="font-weight: 550;">City:&nbsp;&nbsp;</b><%=info.getCity()%>, <%=info.getState()%>, <%=info.getZip()%>
		</div>
		<!--=============================================================================-->
		<!--=============================================================================-->
		<!--==================================4444444====================================-->
		<!--=============================================================================-->
		<hr>
		<div>
			<b style="font-weight: 550;">Credit Card Number:&nbsp;&nbsp;</b><%=info.getCreditCardNum() %>
		</div>
		<div>
			<b style="font-weight: 550;">Profile Placement Priority:&nbsp;&nbsp;</b><%=info.getPpp() %>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="upgrade.jsp">[Change Plan]</a>
		</div>
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
			%>
			<div><a href="profileInfo_Cus.jsp?pid=<%=info.getProfiles().get(i)%>&op=0"><%=info.getProfiles().get(i)%></a></div>
			<%
				}
			%>
		</div>
	</div>
	<%
		} catch (Exception ex) {

		}
	%>
</body>
</html>