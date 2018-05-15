package rendezvous;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class SuggestDate {
	public static ArrayList<String> list = new ArrayList<String>();
	public static ArrayList<String> list2 = new ArrayList<String>();

	public static ArrayList<String> suggestDate() {
		list = new ArrayList<String>();
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("CALL SuggestDate (");
			statement.append("'").append(UserProfile.getProfileId()).append("');");
			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("SuggestedId"));
				list.add(rs.getString("Age"));
				list.add(rs.getString("City"));
				list.add(rs.getString("State"));
				list.add(String.format("%.2f", rs.getDouble("Rate")));
			}

		} catch (Exception ex) {

		}
		return list;
	}

	public static boolean AppendSuggestList(String Id1, String Id2) {
		list = new ArrayList<String>();
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("CALL SuggestDate (");
			statement.append("'").append(Id1).append("');");
			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("SuggestedId"));
				list.add(rs.getString("Age"));
				list.add(rs.getString("City"));
				list.add(rs.getString("State"));
				list.add(String.format("%.2f", rs.getDouble("Rate")));
			}
		} catch (Exception ex) {

		}
		boolean reapted = false;
		if (list.size() != 0) {
			for (int i = 0; i < list.size(); i += 5) {
				if (list.get(i).equals(Id2)) {
					reapted = true;
				}
			}
		}
		if (list2.size() != 0) {
			for (int i = 0; i < list2.size(); i += 5) {
				if (list2.get(i).equals(Id2)) {
					reapted = true;
				}
			}
		}
		if (reapted == false) {
			UserProfileInfo info = UserProfileInfo.getProfileInfo(Id2);
			list2.add(info.getProfileId());
			list2.add(info.getAge() + "");
			list2.add(info.getCity());
			list2.add(info.getState());
			list2.add(String.format("%.2f", info.getTotalRate()));
		}
		return !reapted;
	}

	public static ArrayList<String> suggestByList() {
		ArrayList<String> list3 = new ArrayList<String>();
		ArrayList<String> sl = new ArrayList<String>();
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT distinct UserC ");
			statement.append("FROM suggestby ");
			statement.append("WHERE UserB='").append(UserProfile.getProfileId()).append("';");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				sl.add(rs.getString("UserC"));
			}
		} catch (Exception ex) {

		}
		
		for (int j = 0; j < sl.size(); j++) {
			boolean reapted = false;
			if (list.size() != 0) {
				for (int i = 0; i < list.size(); i++) {
					if (list.get(i).equals(sl.get(j))) {
						reapted = true;
					}
				}
			}
			if (list2.size() != 0) {
				for (int i = 0; i < list2.size(); i++) {
					if (list2.get(i).equals(sl.get(j))) {
						reapted = true;
					}
				}
			}
			if (reapted == false) {
				UserProfileInfo info = UserProfileInfo.getProfileInfo(sl.get(j));
				list3.add(info.getProfileId());
				list3.add(info.getAge() + "");
				list3.add(info.getCity());
				list3.add(info.getState());
				list3.add(String.format("%.2f", info.getTotalRate()));
			}
		}
		return list3;
	}
}
