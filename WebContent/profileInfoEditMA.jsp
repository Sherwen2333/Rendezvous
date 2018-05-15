<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="rendezvous.UserProfileInfo"%>
<%@ page import="rendezvous.State"%>
<%@ page import="rendezvous.ProfilePlacementPriority"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="rendezvous.Customer"%>
<%@ page import="rendezvous.UserProfile"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		try {
			String id = request.getParameter("pid");
			int option = Integer.parseInt(request.getParameter("op"));
			
			switch (option) {
			case 1: {
				String newId = request.getParameter("newId");
				String newName = request.getParameter("newName");
				boolean status = UserProfileInfo.editId(id, newId, newName);

				if (status) {
					response.sendRedirect("userProfileTempMA.jsp?pid=" + newId + "&op=0");
				} else {
					response.sendRedirect("userProfileTempMA.jsp?pid=" + id + "&op=11");
				}
				break;
			}
			case 2: {
				String newAge = request.getParameter("newAge");
				String newGender = request.getParameter("newGender");
				String newHeight = request.getParameter("newHeight");
				String newWeight = request.getParameter("newWeight");
				String newHairColor = request.getParameter("newHairColor");
				boolean status = UserProfileInfo.editPersonalInfo(id, newAge, newGender, newHeight, newWeight, newHairColor);

				if (status) {
					response.sendRedirect("userProfileTempMA.jsp?pid=" + id + "&op=0");
				} else {
					response.sendRedirect("userProfileTempMA.jsp?pid=" + id + "&op=21");
				}
				break;
			}
			case 3: {
				String newAddress = request.getParameter("newAddress");
				String newCity = request.getParameter("newCity");
				String newState = request.getParameter("newState");
				
				boolean status = UserProfileInfo.editAddress(id, newAddress, newCity, newState);
				
				if (status) {
					response.sendRedirect("userProfileTempMA.jsp?pid=" + id + "&op=0");
				} else {
					response.sendRedirect("userProfileTempMA.jsp?pid=" + id + "&op=31");
				}
				break;
			}
			case 4: {
				String newGeoRange = request.getParameter("newGeoRange");
				String newAgeMin = request.getParameter("newAgeMin");
				String newAgeMax = request.getParameter("newAgeMax");
				String newHobby = request.getParameter("newHobby");
				
				boolean status = UserProfileInfo.editOthers(id, newGeoRange, newAgeMin, newAgeMax, newHobby);
				
				if (status) {
					response.sendRedirect("userProfileTempMA.jsp?pid=" + id + "&op=0");
				} else {
					response.sendRedirect("userProfileTempMA.jsp?pid=" + id + "&op=41");
				}
				break;
			}
			case 666: {
				boolean status = UserProfileInfo.closeProfile(id);
				if (status) {
					if(session.getAttribute("profileId") != null){
						if(session.getAttribute("profileId").equals(id)){
							session.removeAttribute("profileId");
						}
					}
					response.sendRedirect("chooseProfile.jsp");
				} else {
					response.sendRedirect("userProfileTempMA.jsp?pid=" + id + "&op=41");
				}
				break;
			}
			}

		} catch (Exception ex) {

		}
	%>

</body>
</html>