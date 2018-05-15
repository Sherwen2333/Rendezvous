package staff;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import rendezvous.MainConnector;

public final class CustomerList {

	/**
	 * Retrieve a list of all customer's id
	 * 
	 * @return a list of all customer's id
	 */
	public static ArrayList<String> fullCustomerList() {
		ArrayList<String> list = new ArrayList<>();
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT DISTINCT Id ");
			statement.append("FROM CUSTOMER ORDER BY Id ASC;");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				list.add(rs.getString(1));
			}
		} catch (Exception ex) {
			
		}
		return list;
	}
}
