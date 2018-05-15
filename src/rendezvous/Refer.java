package rendezvous;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class Refer {
	public static ArrayList<String> getRefer(String pid) {
		ArrayList<String> list = new ArrayList<>();

		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT * ");
			statement.append("FROM REFERAL ");
			statement.append("WHERE UserC='").append(pid).append("';");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				list.add(rs.getString("UserA") + "@" + rs.getString("UserC"));
			}
		} catch (Exception e) {

		}

		return list;

	}

	public final String userA;
	public final String userB;
	public final String userC;
	public final String time;

	private Refer(String userA, String userB, String userC, String time) {
		this.userA = userA;
		this.userB = userB;
		this.userC = userC;
		this.time = time;
	}

	public static ArrayList<Refer> getReferal(String pid) {
		ArrayList<Refer> list = new ArrayList<>();

		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT * ");
			statement.append("FROM REFERAL ");
			statement.append("WHERE UserC='").append(pid).append("';");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				String a = rs.getString("UserA");
				String b = rs.getString("UserB");
				String c = rs.getString("UserC");
				String t = rs.getTimestamp("DateTime").toString();
				t = t.substring(0, t.lastIndexOf('.'));
				Refer r = new Refer(a, b, c, t);
				list.add(r);
			}
		} catch (Exception e) {

		}

		return list;

	}
}
