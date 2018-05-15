package rendezvous;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Random;

public final class DateProcessing {

	/**
	 * Cancel a date
	 * 
	 * @param dateId
	 *            Date ID
	 */
	public static String pid = "";

	public static String date_Month = "";
	public static String date_Day = "";
	public static String date_Year = "";
	public static String date_Hour = "";
	public static String date_Minute = "";
	public static String date_Second = "";

	public static String date_UseCurrentTime = "";

	public static String date_Loaction = "";
	public static String date_Zipcode = "";

	public static StringBuilder datetime = new StringBuilder();

	public static int status = 0;

	public static void init() {
		pid = "";

		date_Month = "";
		date_Day = "";
		date_Year = "";
		date_Hour = "";
		date_Minute = "";
		date_Second = "";
		date_UseCurrentTime = "";
		date_Loaction = "";
		date_Zipcode = "";
		datetime = new StringBuilder();
	}

	public static void cancelDate(long dateId) {
		// Null Id
		if (dateId < 0)
			return;

		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("CALL CancelDate ");
			statement.append("(").append(dateId).append(", @S);");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ps.executeQuery();

		} catch (Exception ex) {

		}
	}

	public static Date getDateDetail(long dateId) {
		// Null Id
		if (dateId < 0)
			return null;

		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT * ");
			statement.append("FROM DATEDATA ");
			statement.append("WHERE DateId=").append(dateId).append(";");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				final String userAId = rs.getString("UserAId");
				final String userBId = rs.getString("UserBId");
				final String dateTime = rs.getTimestamp("DateTime").toString();
				final String geoLoc = rs.getString("GeoLoc");
				final String zipCode = rs.getString("ZipCode");
				final double fee = rs.getDouble("Fee");
				final String repId = rs.getString("RepId");
				final String commentA = rs.getString("CommentA");
				final String commentB = rs.getString("CommentB");
				final double rateA = rs.getDouble("RateA");
				final double rateB = rs.getDouble("RateB");
				Date dateData = new Date(dateId, userAId, userBId, dateTime, geoLoc, zipCode, fee, repId, commentA,
						commentB, rateA, rateB);
				return dateData;
			} else {
				return null;
			}
		} catch (Exception ex) {

		}

		return null;
	}

	public static void writeReviewAndComment(long dateId, int rate, String comment) {
		try {
			Connection con = MainConnector.getCon();

			comment = comment.replaceAll("'", "\\\\'");

			StringBuilder statement = new StringBuilder();
			statement.append("CALL CommentAndRateDate (");
			statement.append(dateId).append(", '");
			statement.append(UserProfile.getProfileId()).append("', ");
			statement.append(rate).append(", '").append(comment).append("', @S)");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ps.executeQuery();

		} catch (Exception ex) {

		}
	}

	public static boolean makeDateOnGivenDate(String userA, String userB, String time) {
		try {
			if (userA == null || userB == null || time == null)
				return false;

			Connection con = MainConnector.getCon();

			if (checkTime(time) == false) {
				return false;
			}

			// First Randomly Choose a representative
			StringBuilder statement = new StringBuilder();
			statement.append("SELECT SSN FROM EMPLOYEE");
			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			ArrayList<String> repID = new ArrayList<>();
			while (rs.next()) {
				repID.add(rs.getString("SSN"));
			}
			String rep = null;
			Collections.shuffle(repID);
			if (!repID.isEmpty()) {
				rep = repID.get(0);
			}

			// Second randomly generate a fee
			double fee = (userA.hashCode() * userB.hashCode() + time.hashCode()) % 100;
			if (fee <= 10)
				fee = 25.0;

			// Insert
			statement = new StringBuilder();
			statement.append("INSERT INTO DATEDATA (UserAId, UserBId, DateTime, Fee, RepId) VALUES(");
			statement.append("'").append(userA).append("', ");
			statement.append("'").append(userB).append("', ");
			if (rep != null)
				statement.append("'").append(time).append("', ").append(fee).append(", '").append(rep).append("')");
			else
				statement.append("'").append(time).append("', ").append(fee).append(", ").append(rep).append(")");
			ps = con.prepareStatement(statement.toString());
			int status = ps.executeUpdate();
			if (status == 0)
				return false;

			// Update Pending Date And Fee
			statement = new StringBuilder();
			statement.append("UPDATE PROFILE SET NumPDate = NumPDate + 1, TotalFee = TotalFee + ").append(fee);
			statement.append(" WHERE Id = '").append(userA).append("'; ");
			ps = con.prepareStatement(statement.toString());
			status = ps.executeUpdate();
			if (status == 0)
				return false;

			statement = new StringBuilder();
			statement.append("UPDATE PROFILE SET NumPDate = NumPDate + 1, TotalFee = TotalFee + ").append(fee);
			statement.append(" WHERE Id = '").append(userB).append("'; ");
			ps = con.prepareStatement(statement.toString());
			status = ps.executeUpdate();
			if (status == 0)
				return false;

			return true;

		} catch (Exception ex) {

		}
		return false;
	}

	public static boolean makeDateOnCurrent(String userA, String userB) {
		try {
			if (userA == null || userB == null)
				return false;

			Connection con = MainConnector.getCon();

			// First Randomly Choose a representative
			StringBuilder statement = new StringBuilder();
			statement.append("SELECT SSN FROM EMPLOYEE");
			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			ArrayList<String> repID = new ArrayList<>();
			while (rs.next()) {
				repID.add(rs.getString("SSN"));
			}
			String rep = null;
			Collections.shuffle(repID);
			if (!repID.isEmpty()) {
				rep = repID.get(0);
			}

			// Second randomly generate a fee
			double fee = (userA.hashCode() * userB.hashCode()) % 100;
			if (fee <= 10)
				fee = 25.0;

			// Insert
			statement = new StringBuilder();
			statement.append("INSERT INTO DATEDATA (UserAId, UserBId, DateTime, Fee, RepId) VALUES(");
			statement.append("'").append(userA).append("', ");
			statement.append("'").append(userB).append("', ");
			if (rep != null)
				statement.append("CURRENT_TIMESTAMP").append(", ").append(fee).append(", '").append(rep).append("')");
			else
				statement.append("CURRENT_TIMESTAMP").append(", ").append(fee).append(", ").append(rep).append(")");
			ps = con.prepareStatement(statement.toString());
			int status = ps.executeUpdate();
			if (status == 0)
				return false;

			// Update Pending Date And Fee
			statement = new StringBuilder();
			statement.append("UPDATE PROFILE SET NumPDate = NumPDate + 1, TotalFee = TotalFee + ").append(fee);
			statement.append(" WHERE Id = '").append(userA).append("'; ");
			ps = con.prepareStatement(statement.toString());
			status = ps.executeUpdate();
			if (status == 0)
				return false;

			statement = new StringBuilder();
			statement.append("UPDATE PROFILE SET NumPDate = NumPDate + 1, TotalFee = TotalFee + ").append(fee);
			statement.append(" WHERE Id = '").append(userB).append("'; ");
			ps = con.prepareStatement(statement.toString());
			status = ps.executeUpdate();
			if (status == 0)
				return false;

			return true;

		} catch (Exception ex) {

		}
		return false;
	}

	public static boolean makeDateOnGivenDateGeo(String userA, String userB, String time, String Loc, String Zip) {
		try {
			if (userA == null || userB == null || time == null)
				return false;

			Connection con = MainConnector.getCon();

			if (checkTime(time) == false) {
				return false;
			}

			// First Randomly Choose a representative
			StringBuilder statement = new StringBuilder();
			statement.append("SELECT SSN FROM EMPLOYEE");
			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			ArrayList<String> repID = new ArrayList<>();
			while (rs.next()) {
				repID.add(rs.getString("SSN"));
			}
			String rep = null;
			Collections.shuffle(repID);
			if (!repID.isEmpty()) {
				rep = repID.get(0);
			}

			// Second randomly generate a fee
			double fee = (userA.hashCode() * userB.hashCode() + time.hashCode()) % 100;
			if (fee <= 10)
				fee = 25.0;

			// Insert
			statement = new StringBuilder();
			statement.append("INSERT INTO DATEDATA (UserAId, UserBId, GeoLoc, ZipCode, DateTime, Fee, RepId) VALUES(");
			statement.append("'").append(userA).append("', ");
			statement.append("'").append(userB).append("', '").append(Loc).append("' ,'").append(Zip).append("', ");
			if (rep != null)
				statement.append("'").append(time).append("', ").append(fee).append(", '").append(rep).append("')");
			else
				statement.append("'").append(time).append("', ").append(fee).append(", ").append(rep).append(")");
			ps = con.prepareStatement(statement.toString());
			int status = ps.executeUpdate();
			if (status == 0)
				return false;

			// Update Pending Date And Fee
			statement = new StringBuilder();
			statement.append("UPDATE PROFILE SET NumPDate = NumPDate + 1, TotalFee = TotalFee + ").append(fee);
			statement.append(" WHERE Id = '").append(userA).append("'; ");
			ps = con.prepareStatement(statement.toString());
			status = ps.executeUpdate();
			if (status == 0)
				return false;

			statement = new StringBuilder();
			statement.append("UPDATE PROFILE SET NumPDate = NumPDate + 1, TotalFee = TotalFee + ").append(fee);
			statement.append(" WHERE Id = '").append(userB).append("'; ");
			ps = con.prepareStatement(statement.toString());
			status = ps.executeUpdate();
			if (status == 0)
				return false;

			return true;

		} catch (Exception ex) {

		}
		return false;
	}

	public static boolean makeDateOnCurrentGeo(String userA, String userB, String Loc, String Zip) {
		try {
			if (userA == null || userB == null)
				return false;

			Connection con = MainConnector.getCon();

			// First Randomly Choose a representative
			StringBuilder statement = new StringBuilder();
			statement.append("SELECT SSN FROM EMPLOYEE");
			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			ArrayList<String> repID = new ArrayList<>();
			while (rs.next()) {
				repID.add(rs.getString("SSN"));
			}
			String rep = null;
			Collections.shuffle(repID, new Random(20));
			if (!repID.isEmpty()) {
				rep = repID.get(0);
			}

			// Second randomly generate a fee
			double fee = (userA.hashCode() * userB.hashCode()) % 100;
			if (fee <= 10)
				fee = 25.0;

			// Insert
			statement = new StringBuilder();
			statement.append("INSERT INTO DATEDATA (UserAId, UserBId, GeoLoc, ZipCode, DateTime, Fee, RepId) VALUES(");
			statement.append("'").append(userA).append("', ");
			statement.append("'").append(userB).append("', '").append(Loc).append("' ,'").append(Zip).append("', ");
			if (rep != null)
				statement.append("CURRENT_TIMESTAMP").append(", ").append(fee).append(", '").append(rep).append("')");
			else
				statement.append("CURRENT_TIMESTAMP").append(", ").append(fee).append(", ").append(rep).append(")");
			ps = con.prepareStatement(statement.toString());
			int status = ps.executeUpdate();
			if (status == 0)
				return false;

			// Update Pending Date And Fee
			statement = new StringBuilder();
			statement.append("UPDATE PROFILE SET NumPDate = NumPDate + 1, TotalFee = TotalFee + ").append(fee);
			statement.append(" WHERE Id = '").append(userA).append("'; ");
			ps = con.prepareStatement(statement.toString());
			status = ps.executeUpdate();
			if (status == 0)
				return false;

			statement = new StringBuilder();
			statement.append("UPDATE PROFILE SET NumPDate = NumPDate + 1, TotalFee = TotalFee + ").append(fee);
			statement.append(" WHERE Id = '").append(userB).append("'; ");
			ps = con.prepareStatement(statement.toString());
			status = ps.executeUpdate();
			if (status == 0)
				return false;

			return true;

		} catch (Exception ex) {

		}
		return false;
	}

	public static boolean checkTime(String time) {
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT CURRENT_TIMESTAMP <= '").append(time).append("'");
			PreparedStatement ps;

			ps = con.prepareStatement(statement.toString());

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				if (rs.getInt(1) == 1) {
					return true;
				}
			}
		} catch (SQLException e) {

		}

		return false;
	}
}
