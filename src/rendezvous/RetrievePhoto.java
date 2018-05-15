package rendezvous;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public final class RetrievePhoto {

	public static ArrayList<String> retrieve(String profId) {
		// Null Id
		if (profId == null)
			return null;

		ArrayList<String> result = new ArrayList<>();
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT DISTINCT URL ");
			statement.append("FROM PHOTOS ");
			statement.append("WHERE Id='").append(profId).append("';");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				result.add(rs.getString("URL"));
			}
		} catch (Exception ex) {

		}
		return result;
	}
}
