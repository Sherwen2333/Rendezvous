<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="staff.EmployeeInfoEdit"%>
<%@ page import="staff.Employee"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		try {
			boolean check = true;
			String id = request.getParameter("newSSN");
			String newPassword = request.getParameter("newPassword");
			
			String newLast = request.getParameter("newLast");
			String newFirst = request.getParameter("newFirst");
			
			String newTele = request.getParameter("newTele");
			String newEmail = request.getParameter("newEmail");
			
			
			String newAddress = request.getParameter("newAddress");
			String newCity = request.getParameter("newCity");
			String newState = request.getParameter("newState");
			String newZip = request.getParameter("newZip");
			
			
			String newRate = request.getParameter("newRate");
		
			Employee em = new Employee(id, newPassword, newLast, newFirst, newAddress, newCity,
					newState, newZip, newTele, newEmail, null, 0);
			EmployeeInfoEdit.info = em;
			
			check = EmployeeInfoEdit.checkSSN(id);
			if(!check){
				EmployeeInfoEdit.status = 100;
				response.sendRedirect("employeeAboutOthers_Create.jsp");
				return;
			}
			check = EmployeeInfoEdit.checkTele(newTele);
			if(!check){
				EmployeeInfoEdit.status = 300;
				response.sendRedirect("employeeAboutOthers_Create.jsp");
				return;
			}
			check = EmployeeInfoEdit.checkRate(newRate);
			if(!check){
				EmployeeInfoEdit.status = 400;
				response.sendRedirect("employeeAboutOthers_Create.jsp");
				return;
			}
			
			check = EmployeeInfoEdit.checkZip(newZip);
			if(!check){
				EmployeeInfoEdit.status = 200;
				response.sendRedirect("employeeAboutOthers_Create.jsp");
				return;
			}
			check = EmployeeInfoEdit.checkZip(newZip);
			if(!check){
				EmployeeInfoEdit.status = 200;
				response.sendRedirect("employeeAboutOthers_Create.jsp");
				return;
			}
			
			if(newPassword.isEmpty() || newLast.isEmpty() || newFirst.isEmpty() || newEmail.isEmpty()
					|| newAddress.isEmpty() || newCity.isEmpty()){
				EmployeeInfoEdit.status = 100;
				response.sendRedirect("employeeAboutOthers_Create.jsp");
				return;
			}
			
			em = new Employee(id, newPassword, newLast, newFirst, newAddress, newCity,
					newState, newZip, newTele, newEmail, null, Double.parseDouble(newRate));
			EmployeeInfoEdit.info = em;
			
			boolean status = EmployeeInfoEdit.create(em);
			if(status) {
				EmployeeInfoEdit.status = 0;
				response.sendRedirect("employeeAboutOthers.jsp?id=" + id);
				return;
			} else {
				EmployeeInfoEdit.status = 500;
				response.sendRedirect("employeeAboutOthers_Create.jsp");
				return;
			}
			
		} catch(Exception ex) {
			//ex.printStackTrace();
			response.sendRedirect("employeeAboutOthers_Create.jsp");
		}
	%>

</body>
</html>