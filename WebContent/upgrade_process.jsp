<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="rendezvous.Upgrade"%>
<%@ page import="rendezvous.Customer"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		try {
			String username = (String) session.getAttribute("username");
			String newPPP = request.getParameter("op");
			String ppp = (String) session.getAttribute("ppp");
			if (ppp == null) {
				ppp = Customer.getProfilePlacementPriority(username);
				session.setAttribute("ppp", ppp);
			}
			
			if(newPPP.length() == 1) {
				if(ppp.equals(ppp.equals("c") || ppp.equals("C"))){
					
				} else {
					boolean r = Upgrade.upgrade(username, "C");
					if(r){
						session.setAttribute("ppp", "C");
					}
				}
			}
			if(newPPP.length() == 2) {
				if(ppp.equals(ppp.equals("b") || ppp.equals("B"))){
					
				} else {
					boolean r = Upgrade.upgrade(username, "B");
					if(r){
						session.setAttribute("ppp", "B");
					}
				}
			}
			if(newPPP.length() == 3) {
				if(ppp.equals(ppp.equals("a") || ppp.equals("A"))){
					
				} else {
					boolean r = Upgrade.upgrade(username, "A");
					if(r){
						session.setAttribute("ppp", "A");
					}
				}
			}
			
			response.sendRedirect("chooseProfile.jsp");
		} catch (Exception ex) {
			response.sendRedirect("chooseProfile.jsp");
		}
	%>
</body>
</html>