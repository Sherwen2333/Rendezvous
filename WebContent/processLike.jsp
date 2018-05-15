<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="rendezvous.Like"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
		/*
		 * op = 0: unlike
		 * op = 1: like
		 */
		try {
			String likee = request.getParameter("likee");
			String liker = request.getParameter("liker");
			int option = Integer.parseInt(request.getParameter("op"));
%>
<meta http-equiv="refresh" content="3; URL=profileInfo_Cus_ViewOnly.jsp?pid=<%=likee%>">
<title>Redirecting...</title>
</head>
<body>
	<h2 style="text-align: center; padding: 2em;">
	<%
			switch (option) {
			case 0: {
				Like.unlikeAProfile(likee, liker);
				response.sendRedirect("profileInfo_Cus_ViewOnly.jsp?pid=" + likee);
				return;
			}
			case 1: {
				Like.likeAProfile(likee, liker);
				response.sendRedirect("profileInfo_Cus_ViewOnly.jsp?pid=" + likee);
				return;
			}
			case 8: {
				String referTo = request.getParameter("referTo");
				int status = Like.referAProfile(liker, likee, referTo);
				switch(status) {
				case 0: {
					out.print("Duplicate ID");
					break;
				}
				case 11: {
					out.print("No Such ID " + liker);
					break;
				}
				case 12: {
					out.print("No Such ID " + likee);
					break;
				}
				case 13: {
					out.print("No Such ID " + referTo);
					break;
				}
				case 2: {
					response.sendRedirect("profileInfo_Cus_ViewOnly.jsp?pid=" + likee);
					return;
				}
				case 3: {
					out.print("Failed");
					break;
				}
				}
			}
			default: break;
			}
			
		} catch (Exception ex) {

		}
	%>
	</h2>
	<h3 style="text-align: center;">Redirecting..</h3>
</body>
</html>