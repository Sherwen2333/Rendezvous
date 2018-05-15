package rendezvous;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class MakeDateWith {
	public static String Id_t = "";
	public static int status_t = 0;

	public static void init() {
		Id_t = "";
	}

	public static ArrayList<String> profileExist(String BId) {
		ArrayList<String> list = new ArrayList<String>();
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT Id ");
			statement.append("From PROFILE ");
			statement.append("WHERE Id='").append(BId).append("';");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("Id"));
			}

		} catch (Exception ex) {

		}
		return list;
	}

	public static boolean genderCheck(String BId) {
		boolean result = false;
		try {
			Connection con = MainConnector.getCon();
			StringBuilder statement = new StringBuilder();
			statement.append("SELECT Gender ");
			statement.append("From PROFILE ");
			statement.append("WHERE Id='").append(BId).append("';");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			String gender1 = "";
			if (rs.next()) {
				gender1 = rs.getString("Gender");
			}
			StringBuilder statement2 = new StringBuilder();
			statement2.append("SELECT Gender ");
			statement2.append("From PROFILE ");
			statement2.append("WHERE Id='").append(UserProfile.getProfileId()).append("';");
			ps = con.prepareStatement(statement2.toString());
			rs = ps.executeQuery();
			String gender2 = "";
			if (rs.next()) {
				gender2 = rs.getString("Gender");
			}
			if (gender1.equals(gender2)) {
				result = true;
			}

		} catch (Exception ex) {

		}
		return result;
	}
}
