<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="staff.DateList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		try {
			final int op = Integer.parseInt(request.getParameter("op"));
			switch (op) {
			case 1: {
				final int month = Integer.parseInt(request.getParameter("month"));
				final int day = Integer.parseInt(request.getParameter("day"));
				final int year = Integer.parseInt(request.getParameter("year"));

				if (month < 0 && day > 0) {
					response.sendRedirect("dateList.jsp?op=300");
					return;
				}
				
				// By Month
				if (day < 0 && month > 0) {
					final StringBuilder from = new StringBuilder();
					from.append(year).append('-').append(month).append('-');
					from.append(1).append(' ').append("00:00:00");

					final StringBuilder to = new StringBuilder();
					to.append(year).append('-').append(month).append('-');
					if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10
							|| month == 12)
						to.append(31).append(' ').append("23:59:59");
					else
						to.append(30).append(' ').append("23:59:59");

					DateList.getByDate(from.toString(), to.toString());
					if (DateList.list.isEmpty()) {
						response.sendRedirect("dateList.jsp?op=200");
						return;
					} else {
						response.sendRedirect("dateList.jsp?op=11");
						return;
					}
				} 
				// By Day
				else if (month < 0) {
					final StringBuilder from = new StringBuilder();
					from.append(year).append('-').append(1).append('-');
					from.append(1).append(' ').append("00:00:00");

					final StringBuilder to = new StringBuilder();
					to.append(year).append('-').append(12).append('-');
					to.append(31).append(' ').append("23:59:59");

					DateList.getByDate(from.toString(), to.toString());
					if (DateList.list.isEmpty()) {
						response.sendRedirect("dateList.jsp?op=200");
						return;
					} else {
						response.sendRedirect("dateList.jsp?op=11");
						return;
					}
				}
				// By Year
				else if (month > 0 && day > 0) {
					final StringBuilder from = new StringBuilder();
					from.append(year).append('-').append(month).append('-');
					from.append(day).append(' ').append("00:00:00");

					final StringBuilder to = new StringBuilder();
					to.append(year).append('-').append(month).append('-');
					to.append(day).append(' ').append("23:59:59");

					DateList.getByDate(from.toString(), to.toString());
					if (DateList.list.isEmpty()) {
						response.sendRedirect("dateList.jsp?op=200");
						return;
					} else {
						response.sendRedirect("dateList.jsp?op=11");
						return;
					}
				}

				break;
			}
			case 2: {
				String cid = request.getParameter("cid");
				if (cid.length() <= 0) {
					response.sendRedirect("dateList.jsp?op=300");
					return;
				}
				DateList.getByCustomer(cid);
				if (DateList.list.isEmpty()) {
					response.sendRedirect("dateList.jsp?op=200");
					return;
				} else {
					response.sendRedirect("dateList.jsp?op=22");
					return;
				}
			}
			}
			response.sendRedirect("dateList.jsp?op=100");
		} catch (Exception ex) {
			response.sendRedirect("dateList.jsp?op=100");
		}
	%>

</body>
</html>