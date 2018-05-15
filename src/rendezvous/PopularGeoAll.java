package rendezvous;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class PopularGeoAll {

	public static ArrayList<String> MostActiveGeoAll() {
		ArrayList<String> list = new ArrayList<String>();
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT ddc.GeoLoc, COUNT(GeoLoc) ");
			statement.append("FROM DateData ddc ");
			statement.append("WHERE ddc.UserAId IN ");
			statement.append("( ");
			statement.append("SELECT h.Id FROM PROFILE h ");
			statement.append(") ");
			statement.append("OR ");
			statement.append("ddc.UserBId IN ");
			statement.append("( ");
			statement.append("SELECT h.Id FROM PROFILE h ");
			statement.append(") ");
			statement.append("GROUP BY ddc.GeoLoc ");
			statement.append("ORDER BY COUNT(GeoLoc) DESC ");
			statement.append("LIMIT 5 ");
			statement.append("; ");
			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("GeoLoc"));
			}

		} catch (Exception ex) {

		}
		return list;
	}

}
