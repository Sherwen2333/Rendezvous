package staff;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import rendezvous.MainConnector;

public final class ProfileFinderMA {
	public static String Id = "";
	public static int status = 0;

	public static void init() {
		Id = "";
	}

	public static ArrayList<String> getProfile(String Id) {
		ArrayList<String> list = new ArrayList<>();
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT Id ");
			statement.append("FROM PROFILE ");
			statement.append("WHERE Id='").append(Id).append("';");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("Id"));
			}
		} catch (Exception ex) {

		}
		return list;
	}
}
