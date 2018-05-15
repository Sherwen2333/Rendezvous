package rendezvous;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

public class UserProfile {

	private static String profileId;
	private static String profileName;

	private static int age;

	private static String address;
	private static String city;
	private static String state;

	private static String gender;

	private static double height;
	private static double weight;

	private static String hairColor;

	private static String hobby;

	private static double totalRate;

	private static int numPendingDate;

	private static int numCompletedDate;

	private static Timestamp creationDate;
	private static String CId;

	/**
	 * Fetch profile data from database and store as global variables
	 * 
	 * @param id
	 *            profile Id
	 */
	public static void fetchProfileData(String id) {
		if (id == null)
			return;

		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT * ");
			statement.append("FROM Profile ");
			statement.append("WHERE Id = '").append(id).append("'");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				UserProfile.profileId = id;
				
				UserProfile.profileName = rs.getString("Name");

				UserProfile.age = rs.getInt("Age");

				UserProfile.address = rs.getString("Addr");
				UserProfile.city = rs.getString("City");
				UserProfile.state = rs.getString("State");

				UserProfile.gender = rs.getString("Gender");

				UserProfile.height = rs.getDouble("Height");
				UserProfile.weight = rs.getDouble("Weight");

				UserProfile.hairColor = rs.getString("HColor");
				UserProfile.hobby = rs.getString("Hobby");

				UserProfile.totalRate = rs.getDouble("TotalRate");
				UserProfile.numPendingDate = rs.getInt("NumPDate");
				UserProfile.numCompletedDate = rs.getInt("NumCDate");

				UserProfile.creationDate = rs.getTimestamp("CreateDate");
				UserProfile.CId = rs.getString("CId");
			}
		} catch (Exception ex) {

		}
	}

	/**
	 * Reset all variables
	 */
	public static void resetProfileData() {
		UserProfile.profileId = null;

		UserProfile.age = -1;

		UserProfile.address = null;
		UserProfile.city = null;
		UserProfile.state = null;

		UserProfile.gender = null;

		UserProfile.height = -1.0;
		UserProfile.weight = -1.0;

		UserProfile.hairColor = null;
		UserProfile.hobby = null;

		UserProfile.totalRate = 0;
		UserProfile.numPendingDate = -1;
		UserProfile.numCompletedDate = -1;

		UserProfile.creationDate = null;
		UserProfile.CId = null;
	}

	/**
	 * Returns a list of the most recent pending date of current profile
	 * 
	 * @return a list of the most recent pending date of current profile; Info
	 *         are [0] = profileId, [1] = DateTime, [2] = Location, [3] = Fee,
	 *         [4] = DateId
	 */
	public static ArrayList<String> getFirstUpcomingDate() {
		// id -> Date -> Time -> Location -> Fee
		ArrayList<String> list = new ArrayList<>();
		if (profileId == null)
			return list;
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("CALL GetPendingDates (");
			statement.append("'").append(profileId).append("');");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				String id = rs.getString("UserAId");
				if (id.equals(profileId)) {
					id = rs.getString("UserBId");
				}
				list.add(id);
				// Time
				String date = rs.getTimestamp("DateTime").toString();
				String time = date.substring(date.indexOf(" ") + 1);
				time = time.substring(0, time.lastIndexOf('.'));
				date = date.substring(0, date.indexOf(" "));
				list.add(date);
				list.add(time);
				// Location
				String location = rs.getString("GeoLoc");
				if (location == null) {
					list.add("N/A");
				} else {
					list.add(location);
				}
				// Fee
				list.add(String.format("$%.2f", rs.getDouble("Fee")));
			}
		} catch (Exception ex) {

		}
		return list;
	}

	/**
	 * Returns a list of likes received by current profile
	 * 
	 * @return a list of likes received by current profile; Info: [2i] =
	 *         profileId, [2i + 1] = Date; (i >= 0)
	 */
	public static ArrayList<String> fetchDataAsLikee() { // Like Received
		// id -> Date -> id -> Date -> .....
		ArrayList<String> list = new ArrayList<>();
		if (profileId == null)
			return list;
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT DISTINCT LikerID, DateTime ");
			statement.append("FROM LIKES ");
			statement.append("WHERE LikeeId = '").append(profileId).append("' ");
			statement.append("ORDER BY DateTime DESC ;");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				// Liker Id
				list.add(rs.getString("LikerID"));
				// Time
				String date = rs.getTimestamp("DateTime").toString();
				date = date.substring(0, date.lastIndexOf('.'));
				list.add(date);
			}
		} catch (Exception ex) {

		}
		return list;
	}

	/**
	 * Returns a list of likes given by current profile
	 * 
	 * @return a list of likes given by current profile; Info: [2i] = profileId,
	 *         [2i + 1] = Date; (i >= 0)
	 */
	public static ArrayList<String> fetchDataAsLiker() { // Like given
		// id -> Date -> id -> Date -> .....
		ArrayList<String> list = new ArrayList<>();
		if (profileId == null)
			return list;
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT DISTINCT LikeeID, DateTime ");
			statement.append("FROM LIKES ");
			statement.append("WHERE LikerId = '").append(profileId).append("' ");
			statement.append("ORDER BY DateTime DESC ;");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				// Liker Id
				list.add(rs.getString("LikeeID"));
				// Time
				String date = rs.getTimestamp("DateTime").toString();
				date = date.substring(0, date.lastIndexOf('.'));
				list.add(date);
			}
		} catch (Exception ex) {

		}
		return list;
	}

	/**
	 * Returns a list of all pending dates of current profile
	 * 
	 * @return a list of all pending dates of current profile; Info are [5i] =
	 *         profileId, [5i+1] = DateTime, [5i+2] = Location, [5i+3] = Fee,
	 *         [5i+4] = DateId (i >= 0)
	 */
	public static ArrayList<String> getAllPendingDate() {
		// profileId -> DateTime -> Location -> Fee -> DateId
		ArrayList<String> list = new ArrayList<>();
		if (profileId == null)
			return list;
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("CALL GetPendingDates (");
			statement.append("'").append(profileId).append("');");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				// profileId
				String id = rs.getString("UserAId");
				if (id.equals(profileId)) {
					id = rs.getString("UserBId");
				}
				list.add(id);
				// Time
				String date = rs.getTimestamp("DateTime").toString();
				date = date.substring(0, date.lastIndexOf('.'));
				list.add(date);
				// Location
				String location = rs.getString("GeoLoc");
				if (location == null) {
					list.add("N/A");
				} else {
					list.add(location);
				}
				// Fee
				list.add(String.format("$%.2f", rs.getDouble("Fee")));
				// DateId
				list.add("" + rs.getLong("DateId"));
			}
		} catch (Exception ex) {

		}
		return list;
	}

	public static ArrayList<Date> getAllPendingDate2() {
		// profileId -> DateTime -> Location -> Fee -> DateId
		ArrayList<Date> list = new ArrayList<>();
		if (profileId == null)
			return list;
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("CALL GetPendingDates (");
			statement.append("'").append(profileId).append("');");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				// profileId
				String id = rs.getString("UserAId");
				if (id.equals(profileId)) {
					id = rs.getString("UserBId");
				}

				// Time
				String date = rs.getTimestamp("DateTime").toString();
				date = date.substring(0, date.lastIndexOf('.'));

				// Location
				String location = rs.getString("GeoLoc");
				if (location == null) {
					location = "N/A";
				}

				// Fee
				double fee = rs.getDouble("Fee");

				Date dateObj = new Date(rs.getLong("DateId"), id, date, location, fee);
				list.add(dateObj);
			}
		} catch (Exception ex) {

		}
		return list;
	}

	/**
	 * Returns a list of all completed dates of current profile
	 * 
	 * @return a list of all completed dates of current profile; Info are [5i] =
	 *         profileId, [5i+1] = DateTime, [5i+2] = Location, [5i+3] = Fee,
	 *         [5i+4] = DateId (i >= 0)
	 */
	public static ArrayList<String> getAllCompletedDate() {
		// profileId -> DateTime -> Location -> Fee -> DateId
		ArrayList<String> list = new ArrayList<>();
		if (profileId == null)
			return list;
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("CALL GetPastDates (");
			statement.append("'").append(profileId).append("');");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				// profileId
				String id = rs.getString("UserAId");
				if (id.equals(profileId)) {
					id = rs.getString("UserBId");
				}
				list.add(id);
				// Time
				String date = rs.getTimestamp("DateTime").toString();
				date = date.substring(0, date.lastIndexOf('.'));
				list.add(date);
				// Location
				String location = rs.getString("GeoLoc");
				if (location == null) {
					list.add("N/A");
				} else {
					list.add(location);
				}
				// Fee
				list.add(String.format("$%.2f", rs.getDouble("Fee")));
				// DateId
				list.add("" + rs.getLong("DateId"));
			}
		} catch (Exception ex) {

		}
		return list;
	}

	/**
	 * Returns a list of all completed dates of current profile
	 * 
	 * @return a list of all completed dates of current profile; Info are [5i] =
	 *         profileId, [5i+1] = DateTime, [5i+2] = Location, [5i+3] = Fee,
	 *         [5i+4] = DateId (i >= 0)
	 */
	public static ArrayList<Date> getAllCompletedDate2() {
		// profileId -> DateTime -> Location -> Fee -> DateId
		ArrayList<Date> list = new ArrayList<>();
		if (profileId == null)
			return list;
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("CALL GetPastDates (");
			statement.append("'").append(profileId).append("');");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				// profileId
				String id = rs.getString("UserAId");
				if (id.equals(profileId)) {
					id = rs.getString("UserBId");
				}

				// Time
				String date = rs.getTimestamp("DateTime").toString();
				date = date.substring(0, date.lastIndexOf('.'));

				// Location
				String location = rs.getString("GeoLoc");
				if (location == null) {
					location = "N/A";
				}

				// Fee
				double fee = rs.getDouble("Fee");

				Date dateObj = new Date(rs.getLong("DateId"), id, date, location, fee);
				list.add(dateObj);
			}
		} catch (Exception ex) {

		}
		return list;
	}

	/**
	 * Check is given user has a profile with id=pid
	 * 
	 * @param username
	 * @param pid
	 * @return
	 */
	public static boolean checkCorrespondence(String username, String pid) {
		try {
			if (username == null || pid == null) {
				return false;
			}
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT * ");
			statement.append("FROM PROFILE ");
			statement.append("WHERE Id='").append(pid).append("' AND ");
			statement.append("CId='").append(username).append("';");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			return rs.next();

		} catch (Exception ex) {

		}
		return false;
	}

	/* *************/
	/* *************/
	/* ** Getters **/
	/* *************/
	/* *************/
	public static final String getProfileId() {
		return profileId;
	}

	public static final String getProfileName() {
		return profileName;
	}

	public static final String getCId() {
		return CId;
	}

	public static final int getAge() {
		return age;
	}

	public static final String getAddress() {
		return address;
	}

	public static final String getCity() {
		return city;
	}

	public static final String getState() {
		return state;
	}

	public static final String getGender() {
		return gender;
	}

	public static final double getHeight() {
		return height;
	}

	public static final double getWeight() {
		return weight;
	}

	public static final String getHairColor() {
		return hairColor;
	}

	public static final String getHobby() {
		return hobby;
	}

	public static final double getTotalRate() {
		return totalRate;
	}

	public static final int getNumPendingDate() {
		return numPendingDate;
	}

	public static final int getNumCompletedDate() {
		return numCompletedDate;
	}

	public static final Timestamp getCreationDate() {
		return creationDate;
	}

}
