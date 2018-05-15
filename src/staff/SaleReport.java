package staff;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import rendezvous.MainConnector;

public final class SaleReport {
	public static String revenue;
	public static int numDates;
	public static String lastYearRevenue;

	public static final void reset() {
		revenue = null;
		numDates = 0;
		lastYearRevenue = null;
	}

	public static final void getReportThisYear(String month) {
		try {
			reset();

			Connection con = MainConnector.getCon();

			final StringBuilder statement = new StringBuilder();
			statement.append("CALL SaleReportMonth ( ").append(month).append(")");

			final PreparedStatement ps = con.prepareStatement(statement.toString());
			final ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				revenue = rs.getString("Revenue");
				lastYearRevenue = rs.getString("CompToLastYear");
				numDates = Integer.parseInt(rs.getString("NumOfDate"));
			}
		} catch (Exception ex) {
			reset();
		}

	}

	public static final void getReportPastYear(String month, String year) {
		try {
			reset();

			Connection con = MainConnector.getCon();

			final StringBuilder statement = new StringBuilder();
			statement.append("CALL SaleReportYearMonth ( ").append(year).append(", ").append(month).append(");");

			final PreparedStatement ps = con.prepareStatement(statement.toString());
			final ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				revenue = rs.getString("Revenue");
				lastYearRevenue = rs.getString("CompToLastYear");
				numDates = Integer.parseInt(rs.getString("NumOfDate"));
			}
		} catch (Exception ex) {
			reset();
		}

	}
}
