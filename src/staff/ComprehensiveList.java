package staff;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import rendezvous.MainConnector;

public final class ComprehensiveList {

	/**
	 * Retrieve a list of all customer's id
	 * 
	 * @return a list of all customer's id
	 */
	public static ArrayList<String> getComprehensiveList() {
		ArrayList<String> list = new ArrayList<>();
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("CALL ComprehensiveList(); ");
			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("TotalCustomer"));
				list.add(rs.getString("TOtalProfile"));
				list.add(rs.getString("AvgAge"));
				list.add(rs.getString("AvgHeight"));
				list.add(rs.getString("MostActiveState"));
				list.add(rs.getString("UserPaid"));
			}
		} catch (Exception ex) {

		}
		return list;
	}
}
