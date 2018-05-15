package staff;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import rendezvous.MainConnector;

public final class SummaryRevenueCalendar {

	public static ArrayList<String> ProduceSummaryRevenueCalendar(String date1, String date2) {
		ArrayList<String> list = new ArrayList<>();
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("CALL ProduceSummaryRevenueCalendar('");
			statement.append(date1).append("', '").append(date2);
			statement.append("'); ");
			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				list.add(rs.getString("SummaryRevenue"));
			}
		} catch (Exception ex) {

		}
		return list;
	}
}
