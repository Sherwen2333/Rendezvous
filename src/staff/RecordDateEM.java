package staff;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import rendezvous.MainConnector;

public class RecordDateEM {
	public static String Id1 = "";
	public static String Id2 = "";
	public static int status_t = 0;

	public static void init() {
		Id1 = "";
		Id2 = "";
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

	public static boolean genderCheck(String Id1, String Id2) {
		boolean result = false;
		try {
			Connection con = MainConnector.getCon();
			StringBuilder statement = new StringBuilder();
			statement.append("SELECT Gender ");
			statement.append("From PROFILE ");
			statement.append("WHERE Id='").append(Id1).append("';");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			String gender1 = "";
			if (rs.next()) {
				gender1 = rs.getString("Gender");
			}
			StringBuilder statement2 = new StringBuilder();
			statement2.append("SELECT Gender ");
			statement2.append("From PROFILE ");
			statement2.append("WHERE Id='").append(Id2).append("';");
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

	public static boolean CIdCheck(String Id1, String Id2) {
		boolean result = true;
		ArrayList<String> list = new ArrayList<String>();
		try {
			Connection con = MainConnector.getCon();
			StringBuilder statement = new StringBuilder();
			statement.append("SELECT distinct P.CId ");
			statement.append("FROM  profile P ");
			statement.append("WHERE P.Id='").append(Id1).append("' OR P.Id='").append(Id2).append("';");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("CId"));
			}
			if (list.size() > 1) {
				result = false;
			}

		} catch (Exception ex) {

		}
		return result;
	}
}
