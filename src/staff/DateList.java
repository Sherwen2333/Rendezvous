package staff;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import rendezvous.MainConnector;

public final class DateList {

	public static ArrayList<DateList> list;

	public static String input_cid;
	public static String input_from;
	public static String input_to;

	public final long dateId;
	public final String userA;
	public final String userB;
	public final String time;

	private DateList(long dateId, String userA, String userB, String time) {
		this.dateId = dateId;
		this.userA = userA;
		this.userB = userB;
		this.time = time;
	}

	public static void getByCustomer(String cid) {
		try {
			list = new ArrayList<>();

			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("CALL ProduceListDatesCustomer ( '").append(cid);
			statement.append("');");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				final long dateId = rs.getLong("DateId");
				final String userA = rs.getString("UserAId");
				final String userB = rs.getString("UserBId");
				final String time = (rs.getTimestamp("DateTime").toString()).substring(0,
						rs.getTimestamp("DateTime").toString().lastIndexOf('.'));

				final DateList date = new DateList(dateId, userA, userB, time);
				list.add(date);
			}
			input_cid = cid;
		} catch (Exception ex) {

		}
	}

	public static void getByDate(String from, String to) {
		try {
			list = new ArrayList<>();

			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("CALL ProduceListDatesCalendar ( '").append(from);
			statement.append("', '").append(to).append("');");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				final long dateId = rs.getLong("DateId");
				final String userA = rs.getString("UserAId");
				final String userB = rs.getString("UserBId");
				final String time = (rs.getTimestamp("DateTime").toString()).substring(0,
						rs.getTimestamp("DateTime").toString().lastIndexOf('.'));

				final DateList date = new DateList(dateId, userA, userB, time);
				list.add(date);
			}

			input_from = from;
			input_to = to;
		} catch (Exception ex) {

		}
	}
}
