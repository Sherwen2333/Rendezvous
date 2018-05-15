package staff;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import rendezvous.MainConnector;

public final class SummaryRevenueCustomer {

	public static ArrayList<String> ProduceSummaryRevenueCustomer(String Id) {
		ArrayList<String> list = new ArrayList<>();
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("CALL ProduceSummaryRevenueCustomer('");
			statement.append(Id);
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

	public static boolean SearchId(String Id) {
		boolean result = false;
		ArrayList<String> list = new ArrayList<String>();
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT Id ");
			statement.append("FROM Customer ");
			statement.append("WHERE Id = '").append(Id).append("'");
			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("Id"));
				if (list.size() > 0) {
					result = true;
				}
			}
		} catch (Exception ex) {

		}
		return result;
	}
}
