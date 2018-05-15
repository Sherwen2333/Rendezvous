package staff;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import rendezvous.Date;
import rendezvous.MainConnector;

public final class RecordDateEMInfo {

	/**
	 * Cancel a date
	 * 
	 * @param dateId
	 *            Date ID
	 */
	public static String Id1 = "";
	public static String Id2 = "";
	public static String date_Month = "";
	public static String date_Day = "";
	public static String date_Year = "";
	public static String date_Hour = "";
	public static String date_Minute = "";
	public static String date_Second = "";

	public static String date_UseCurrentTime = "";

	public static String date_Loaction = "";
	public static String date_Zipcode = "";
	public static String repId = "";
	public static String fee = "";
	public static StringBuilder datetime = new StringBuilder();

	public static int status = 0;

	public static void init() {
		Id1 = "";
		Id2 = "";
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
		repId = "";
		fee = "";
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

	public static void writeReviewAndComment(long dateId, String Id1, int rate, String comment) {
		try {
			Connection con = MainConnector.getCon();

			comment = comment.replaceAll("'", "\\\\'");

			StringBuilder statement = new StringBuilder();
			statement.append("CALL CommentAndRateDate (");
			statement.append(dateId).append(", '");
			statement.append(Id1).append("', ");
			statement.append(rate).append(", '").append(comment).append("', @S)");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ps.executeQuery();

		} catch (Exception ex) {

		}
	}

	public static boolean SearchRepId(String SSN) {
		boolean result = false;
		ArrayList<String> list = new ArrayList<String>();
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT SSN ");
			statement.append("FROM employee ");
			statement.append("WHERE SSN = '").append(SSN).append("';");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("SSN"));
			}
			if (list.size() > 0) {
				result = true;
			}
		} catch (Exception ex) {

		}
		return result;
	}

	public static boolean makeDateOnGivenDate(String userA, String userB, String time, String rep, String fee) {
		try {
			if (userA == null || userB == null || time == null)
				return false;

			Connection con = MainConnector.getCon();

			// First Randomly Choose a representative
			StringBuilder statement = new StringBuilder();
			statement.append("SELECT SSN FROM EMPLOYEE");
			PreparedStatement ps;

			// Insert
			statement = new StringBuilder();
			statement.append("INSERT INTO DATEDATA (UserAId, UserBId, DateTime, Fee, RepId) VALUES(");
			statement.append("'").append(userA).append("', ");
			statement.append("'").append(userB).append("', ");
			statement.append("'").append(time).append("', ").append(fee).append(", '").append(rep).append("')");

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

	public static boolean makeDateOnCurrent(String userA, String userB, String rep, String fee) {
		try {
			if (userA == null || userB == null)
				return false;

			Connection con = MainConnector.getCon();

			// First Randomly Choose a representative
			StringBuilder statement = new StringBuilder();
			statement.append("SELECT SSN FROM EMPLOYEE");
			PreparedStatement ps;
			// Insert
			statement = new StringBuilder();
			statement.append("INSERT INTO DATEDATA (UserAId, UserBId, DateTime, Fee, RepId) VALUES(");
			statement.append("'").append(userA).append("', ");
			statement.append("'").append(userB).append("', ");
			statement.append("CURRENT_TIMESTAMP").append(", ").append(fee).append(", '").append(rep).append("')");

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

	public static boolean makeDateOnGivenDateGeo(String userA, String userB, String time, String Loc, String Zip,
			String rep, String fee) {
		try {
			if (userA == null || userB == null || time == null)
				return false;

			Connection con = MainConnector.getCon();

			// First Randomly Choose a representative
			StringBuilder statement = new StringBuilder();
			PreparedStatement ps;
			// Insert
			statement = new StringBuilder();
			statement.append("INSERT INTO DATEDATA (UserAId, UserBId, GeoLoc, ZipCode, DateTime, Fee, RepId) VALUES(");
			statement.append("'").append(userA).append("', ");
			statement.append("'").append(userB).append("', '").append(Loc).append("' ,'").append(Zip).append("', ");
			statement.append("'").append(time).append("', ").append(fee).append(", '").append(rep).append("')");

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

	public static boolean makeDateOnCurrentGeo(String userA, String userB, String Loc, String Zip, String rep,
			String fee) {
		try {
			if (userA == null || userB == null)
				return false;

			Connection con = MainConnector.getCon();

			// First Randomly Choose a representative
			StringBuilder statement = new StringBuilder();
			statement.append("SELECT SSN FROM EMPLOYEE");
			PreparedStatement ps;
			// Insert
			statement = new StringBuilder();
			statement.append("INSERT INTO DATEDATA (UserAId, UserBId, GeoLoc, ZipCode, DateTime, Fee, RepId) VALUES(");
			statement.append("'").append(userA).append("', ");
			statement.append("'").append(userB).append("', '").append(Loc).append("' ,'").append(Zip).append("', ");
			statement.append("CURRENT_TIMESTAMP").append(", ").append(fee).append(", '").append(rep).append("')");

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

	public static boolean CompareTime(String date) {
		boolean result = true;
		String s = "";
		try {
			Connection con = MainConnector.getCon();
			StringBuilder re = new StringBuilder();
			re.append("'").append(date).append("' >current_timestamp");

			StringBuilder statement = new StringBuilder();
			statement.append("select '").append(date).append("' >current_timestamp;");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				s = rs.getString(re.toString());
			}
			if (s.equals("0")) {
				result = false;
			}
		} catch (Exception ex) {

		}
		return result;
	}
}
