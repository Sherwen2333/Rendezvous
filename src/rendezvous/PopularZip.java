package rendezvous;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class PopularZip {

	public static ArrayList<String> MostActiveZip() {
		ArrayList<String> list = new ArrayList<String>();
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("CALL MostActiveZip (");
			statement.append("'").append(UserProfile.getCId()).append("',");
			statement.append("5").append(");");
			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("ZipCode"));
			}

		} catch (Exception ex) {

		}
		return list;
	}

}
