<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="staff.SaleReport"%>
<%@ page import="config.DateConstants"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		try {
			// op = 0 -> default; op = 1 -> this year; op = 2 Past Year					
			int op = Integer.parseInt(request.getParameter("op"));

			if (op == 1 || (op >= 10 && op <= 19)) {
				String month = request.getParameter("month");
				SaleReport.getReportThisYear(month);
				if (SaleReport.lastYearRevenue == null && SaleReport.revenue == null) {
					response.sendRedirect("saleReport.jsp?op=18&month=0&year=0");
				} else {
					response.sendRedirect("saleReport.jsp?op=11&month="+ month + "&year=" + DateConstants.YEAR.get(0));
				}
			} else if (op == 2 || (op >= 20 && op <= 29)) {
				String month = request.getParameter("month");
				String year = request.getParameter("year");
				SaleReport.getReportPastYear(month, year);
				if (SaleReport.lastYearRevenue == null && SaleReport.revenue == null) {
					response.sendRedirect("saleReport.jsp?op=28&month=0&year=0");
				} else {
					response.sendRedirect("saleReport.jsp?op=21&month="+ month + "&year=" + year);
				}
			} else {
				response.sendRedirect("saleReport.jsp?op=9&month=0&year=0");
				return;
			}

		} catch (Exception ex) {

		}
	%>
</body>
</html>