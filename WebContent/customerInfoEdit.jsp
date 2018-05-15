<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="staff.CustomerInfo"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Processing...</title>
</head>
<body>
	<%
		try {
			String id = request.getParameter("id");
			int option = Integer.parseInt(request.getParameter("op"));
			
			switch (option) {
			case 1: {
				String newId = request.getParameter("newId");
				String newPassword = request.getParameter("newPassword");
				boolean status = CustomerInfo.editIdAndPassword(id, newId, newPassword);

				if (status) {
					response.sendRedirect("customerInfo.jsp?id=" + newId + "&op=0");
				} else {
					response.sendRedirect("customerInfo.jsp?id=" + id + "&op=11");
				}
				break;
			}
			case 8:{
				id = (String) session.getAttribute("username");
				String newId = request.getParameter("newId");
				String newPassword = request.getParameter("newPassword");
				boolean status = CustomerInfo.editIdAndPassword(id, newId, newPassword);

				if (status) {
					session.setAttribute("username", newId);
					response.sendRedirect("customerInfoViewOnly.jsp?&op=0");
				} else {
					response.sendRedirect("customerInfoViewOnly.jsp?&op=81");
				}
				break;
			}
			case 2: {
				String newLast = request.getParameter("newLast");
				String newFirst = request.getParameter("newFirst");
				String newTele = request.getParameter("newTele");
				String newEmail = request.getParameter("newEmail");
				
				boolean status = CustomerInfo.editPersonalInfo(id, newLast, newFirst, newTele, newEmail);
				
				if (status) {
					response.sendRedirect("customerInfo.jsp?id=" + id + "&op=0");
				} else {
					response.sendRedirect("customerInfo.jsp?id=" + id + "&op=21");
				}
			}
			case 3: {
				String newAddress = request.getParameter("newAddress");
				String newCity = request.getParameter("newCity");
				String newState = request.getParameter("newState");
				String newZip = request.getParameter("newZip");
				
				boolean status = CustomerInfo.editAddress(id, newAddress, newCity, newState, newZip);
				
				if (status) {
					response.sendRedirect("customerInfo.jsp?id=" + id + "&op=0");
				} else {
					response.sendRedirect("customerInfo.jsp?id=" + id + "&op=31");
				}
			}
			case 4: {
				String newCCN = request.getParameter("newCCN");
				String newPPP = request.getParameter("newPPP");
				
				boolean status = CustomerInfo.editPayment(id, newCCN, newPPP);
				
				if (status) {
					response.sendRedirect("customerInfo.jsp?id=" + id + "&op=0");
				} else {
					response.sendRedirect("customerInfo.jsp?id=" + id + "&op=41");
				}
			}
			case 666: {
				CustomerInfo.closeAccount(id);
				response.sendRedirect("fullCustomerList.jsp");
			}
			}

		} catch (Exception ex) {

		}
	%>
</body>
</html>