package rendezvous;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import staff.ProfileFinderEM;
import staff.ProfileFinderMA;

public class UserProfileInfo {

	private String username;
	private String profileId;
	private String profileName;

	private int age;

	private String address;
	private String city;
	private String state;

	private String gender;

	private double height;
	private double weight;

	private String hairColor;

	private String hobby;

	private double totalRate;
	private int numPendingDate;
	private int numCompletedDate;

	private String creationDate;
	private String lastActive;

	private double geoRange;
	private int ageMin;
	private int ageMax;

	private UserProfileInfo() {

	}

	public static UserProfileInfo getProfileInfo(String pid) {
		if (pid == null) {
			return null;
		}

		try {
			Connection con = MainConnector.getCon();
			StringBuilder statement = new StringBuilder();
			statement.append("SELECT * ");
			statement.append("FROM PROFILE ");
			statement.append("WHERE Id = '").append(pid).append("';");
			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				UserProfileInfo info = new UserProfileInfo();
				info.profileId = pid;
				info.profileName = rs.getString("Name");
				info.username = rs.getString("CId");
				info.age = rs.getInt("Age");

				info.address = rs.getString("Addr");
				info.city = rs.getString("City");
				info.state = rs.getString("State");

				info.gender = rs.getString("Gender");

				info.height = rs.getDouble("Height");
				info.weight = rs.getDouble("Weight");

				info.hairColor = rs.getString("HColor");
				info.hobby = rs.getString("Hobby");

				info.totalRate = rs.getDouble("TotalRate");
				info.numPendingDate = rs.getInt("NumPDate");
				info.numCompletedDate = rs.getInt("NumCDate");

				info.creationDate = rs.getTimestamp("CreateDate").toString();
				info.creationDate = info.creationDate.substring(0, info.creationDate.lastIndexOf('.'));

				info.lastActive = rs.getTimestamp("LastActive").toString();
				info.lastActive = info.lastActive.substring(0, info.lastActive.lastIndexOf('.'));

				info.geoRange = rs.getDouble("GeoRange");
				info.ageMin = rs.getInt("AgeMin");
				info.ageMax = rs.getInt("AgeMax");

				return info;
			}
		} catch (Exception ex) {

		}
		return null;
	}

	/**
	 * Edit profile Id
	 * 
	 * @param oldId
	 * @param newId
	 * @return if edit succeed
	 */
	public static boolean editId(String oldId, String newId, String newName) {
		try {
			if (oldId == null || newId == null)
				return false;

			if (containsSpecial(newId)) {
				return false;
			}
			
			if (newName.contains("'") || newName.contains("\\") || newName.contains("&") || newName.contains("\"")) {
				return false;
			}

			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("UPDATE PROFILE ");
			if (newName.length() >= 0) {
				statement.append("SET Id='").append(newId).append("', Name = '").append(newName).append("' ");
			} else {
				statement.append("SET Id='").append(newId).append("' ");
			}
			statement.append("WHERE Id='").append(oldId).append("';");
			
			PreparedStatement ps = con.prepareStatement(statement.toString());
			int status = ps.executeUpdate();
			ProfileFinderEM.Id = newId;
			ProfileFinderMA.Id = newId;
			return status != 0;

		} catch (Exception ex) {

		}
		return false;
	}

	/**
	 * Edit age, gender, height, and weight of a given profile
	 * 
	 * @param id
	 * @param newAge
	 * @param newGender
	 * @param newHeight
	 * @param newWeight
	 * @param newHairColor
	 * @return
	 */
	public static boolean editPersonalInfo(String id, String newAge, String newGender, String newHeight,
			String newWeight, String newHairColor) {
		try {
			if (id == null)
				return false;

			if (containsSpecial(newAge) || containsSpecial(newGender) || containsSpecial(newHeight)
					|| containsSpecial(newWeight)) {
				return false;
			}

			int age = Integer.parseInt(newAge);
			double height = Double.parseDouble(newHeight);
			double weight = Double.parseDouble(newWeight);

			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("UPDATE PROFILE ");
			statement.append("SET Age=").append(age).append(", ");
			statement.append("Gender='").append(newGender).append("', ");
			statement.append("Height=").append(height).append(", ");
			statement.append("HColor='").append(newHairColor).append("', ");
			statement.append("Weight=").append(weight).append(" ");
			statement.append("WHERE Id='").append(id).append("';");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			int status = ps.executeUpdate();

			return status != 0;

		} catch (Exception ex) {

		}
		return false;
	}

	/**
	 * Edit profile address
	 * 
	 * @param id
	 * @param newAddress
	 * @param newCity
	 * @param newState
	 * @return
	 */
	public static boolean editAddress(String id, String newAddress, String newCity, String newState) {
		try {
			if (id == null || newAddress == null || newCity == null || newState == null)
				return false;

			if (containsSpecial(newAddress) || containsSpecial(newCity) || containsSpecial(newState)) {
				return false;
			}

			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("UPDATE PROFILE ");
			statement.append("SET Addr='").append(newAddress).append("', ");
			statement.append("City='").append(newCity).append("', ");
			statement.append("State='").append(newState).append("' ");
			statement.append("WHERE Id='").append(id).append("';");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			int status = ps.executeUpdate();

			return status != 0;

		} catch (Exception ex) {

		}
		return false;
	}

	/**
	 * Edit profile trivial information
	 * 
	 * @param id
	 * @param newAddress
	 * @param newCity
	 * @param newState
	 * @return
	 */
	public static boolean editOthers(String id, String newGeoRange, String newAgeMin, String newAgeMax,
			String newHobby) {
		try {
			if (id == null || newGeoRange == null || newAgeMin == null || newAgeMax == null || newHobby == null)
				return false;

			if (containsSpecial(newHobby)) {
				return false;
			}

			double geoRange = Double.parseDouble(newGeoRange);
			if (geoRange < 0)
				return false;

			int ageMin = Integer.parseInt(newAgeMin);
			int ageMax = Integer.parseInt(newAgeMax);
			if (ageMin < 0 || ageMax < 0)
				return false;

			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("UPDATE PROFILE ");
			statement.append("SET GeoRange=").append(geoRange).append(", ");
			statement.append("AgeMin=").append(ageMin).append(", ");
			statement.append("AgeMax=").append(ageMax).append(", ");
			statement.append("Hobby='").append(newHobby).append("' ");
			statement.append("WHERE Id='").append(id).append("';");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			int status = ps.executeUpdate();

			return status != 0;

		} catch (Exception ex) {
			
		}
		return false;
	}

	public static boolean closeProfile(String pid) {
		try {
			if (pid == null)
				return false;

			Connection con = MainConnector.getCon();

			// DELETE FROM PROFILE WHERE Id = pId;
			StringBuilder statement = new StringBuilder();
			statement.append("DELETE FROM PROFILE ");
			statement.append("WHERE Id ='").append(pid).append("';");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			int status = ps.executeUpdate();

			return status != 0;

		} catch (Exception ex) {

		}
		return false;
	}

	private static boolean containsSpecial(String str) {
		if (str.length() <= 0) {
			return true;
		}
		if (str.contains("'") || str.contains("\\") || str.contains("&") || str.contains("\"")) {
			return true;
		}
		return false;
	}

	public final String getUsername() {
		return username;
	}

	public final String getProfileName() {
		return this.profileName;
	}

	public final String getProfileId() {
		return profileId;
	}

	public final int getAge() {
		return age;
	}

	public final String getAddress() {
		return address;
	}

	public final String getCity() {
		return city;
	}

	public final String getState() {
		return state;
	}

	public final String getGender() {
		return gender;
	}

	public final double getHeight() {
		return height;
	}

	public final double getWeight() {
		return weight;
	}

	public final String getHairColor() {
		return hairColor;
	}

	public final String getHobby() {
		return hobby;
	}

	public final double getTotalRate() {
		return totalRate;
	}

	public final int getNumPendingDate() {
		return numPendingDate;
	}

	public final int getNumCompletedDate() {
		return numCompletedDate;
	}

	public final String getCreationDate() {
		return creationDate;
	}

	public final String getLastActive() {
		return lastActive;
	}

	public final double getGeoRange() {
		return geoRange;
	}

	public final int getAgeMin() {
		return ageMin;
	}

	public final int getAgeMax() {
		return ageMax;
	}

}
