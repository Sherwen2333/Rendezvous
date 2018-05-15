<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="rendezvous.SignUp"%>
<%@ page import="rendezvous.State"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="Stylesheet/signUp.css" type="text/css" rel="stylesheet">
<title>Sign Up</title>
</head>
<body>
	<div class="titleBar"></div>
	<div class="rendezvous"><a href="home.html">Rendezvous</a></div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="title">Sign Up</div>
	<!--=============================================================================-->
	<!--=============================================================================-->
	<!--=============================================================================-->
	<div class="formContainer">
		<div class="formInnerContainer">
			<div class="instruction">* You must fill in all fields</div>
			<form method="post" action="SignCheck.jsp">
				<div class="SignInfo">
					ID: <input type="text" name="id" style="min-width:22em;"
						value="<%=SignUp.id_t == null ? "" : SignUp.id_t%>" maxlength="24"
						class="SignUpTextfield"><br>
				</div>
				<div class="SignInfo">
					Password: <input type="password" name="password" style="min-width:15em;"
						value="<%=SignUp.password_t == null ? "" : SignUp.password_t%>"
						maxlength="24" class="SignUpTextfield"><br>

				</div>
				<div class="SignInfo">
					Last Name: <input type="text" name="last" style="min-width:15em;"
						value="<%=SignUp.last_t == null ? "" : SignUp.last_t%>" maxlength="20"
						class="SignUpTextfield"><br>
				</div>
				<div class="SignInfo">
					First Name: <input type="text" name="first" style="min-width:15em;"
						value="<%=SignUp.first_t == null ? "" : SignUp.first_t%>" maxlength="20"
						class="SignUpTextfield"><br>
				</div>
				<div class="SignInfo">
					Address: <input type="text" name="addr" style="min-width:21em;"
						value="<%=SignUp.addr_t == null ? "" : SignUp.addr_t%>" maxlength="50"
						class="SignUpTextfield"><br>
				</div>
				<div class="SignInfo">
					City: <input type="text" name="city"
						value="<%=SignUp.city_t == null ? "" : SignUp.city_t%>" maxlength="20"
						class="SignUpTextfield"><br>
				</div>
				<div class="SignInfo">
					State: <select name="state">
						<%
							for (int i = 0; i < State.STATE.size(); i++) {
								if (State.STATE.get(i).equals(SignUp.state_t)) {
						%>
						<option value="<%=State.STATE.get(i)%>" selected="selected"><%=State.STATE.get(i)%></option>
						<%
							} else
						%>
						<option value="<%=State.STATE.get(i)%>"><%=State.STATE.get(i)%></option>
						<%
							}
						%>
					</select>
				</div>
				<div class="SignInfo">
					ZipCode: <input type="text" name="zip" style="width:6em;"
						value="<%=SignUp.zip_t == null ? "" : SignUp.zip_t%>" maxlength="5"
						class="SignUpTextfield"><br>

				</div>
				<div class="SignInfo">
					Telephone: <input type="text" name="tele"
						value="<%=SignUp.tele_t == null ? "" : SignUp.tele_t%>" maxlength="10"
						class="SignUpTextfield"><br>
				</div>
				<div class="SignInfo">
					Email: <input type="text" name="email" style="min-width:18em;"
						value="<%=SignUp.email_t == null ? "" : SignUp.email_t%>" maxlength="24"
						class="SignUpTextfield"><br>
				</div>
				<div class="error">
					<%
						try {
							switch (SignUp.status) {
							//case 0:  response.sendRedirect("chooseProfile.jsp");
							case 1: {
								out.println("Incorrect id.");
								SignUp.init();
							}
								break;
							case 2: {
								out.println("Incorrect password.");
								SignUp.init();
							}
								break;
							case 3: {
								out.println("First Name cannot be empty.");
								SignUp.init();
							}
								break;
							case 4: {
								out.println("Last Name cannot be empty.");
								SignUp.init();
							}
								break;
							case 5: {
								out.println("Address cannot be empty.");
								SignUp.init();
							}
								break;
							case 6: {
								out.println("City cannot be empty.");
								SignUp.init();
							}
								break;
							case 7: {
								out.println("State cannot be empty.");
								SignUp.init();
							}
								break;
							case 8: {
								out.println("ZipCode cannot be empty.");
								SignUp.init();
							}
								break;
							case 9: {
								out.println("Telephone cannot be empty.");
								SignUp.init();
							}
								break;
							case 10: {
								out.println("Email cannot be empty.");
								SignUp.init();
							}
								break;
							case 11: {
								out.println("This id has already been used.");
								SignUp.init();
							}
								break;
							case 12: {
								out.println("Unknown error.");
								SignUp.init();
							}
								break;
							case 13: {
								out.println("Telephone number must be numeric.");
								SignUp.init();
							}
								break;
							case 15: {
								out.println("Id cannot contain &, \\ and '.");
								SignUp.init();
							}
								break;
							case 16: {
								out.println("The length of telephone number must be 10.");
								SignUp.init();
							}
								break;
							case 17: {
								out.println("The length of ZipCode must be 5.");
								SignUp.init();
							}
								break;
							case 18: {
								out.println("ZipCode must be numeric.");
								SignUp.init();
							}
								break;
							default:
								SignUp.init();
								break;
							}
						} catch (Exception ex) {
						}
					%>
				</div>
				<div style="text-align: center;">
					<input type="submit" value="SignUp" class="button">
				</div>
			</form>
		</div>
	</div>
</body>
</html>