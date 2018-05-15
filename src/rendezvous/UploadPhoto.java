package rendezvous;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public final class UploadPhoto {

	/**
	 * Insert a row into TABLE PHOTOS_BLOB
	 * 
	 * @param url
	 *            url of the photo
	 * @return true if success, false otherwise
	 */
	public static final boolean uploadPhoto(String url) {
		try {
			if (url == null)
				return false;

			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("CALL CreatePhoto ");
			statement.append("('").append(UserProfile.getProfileId()).append("', ");
			statement.append("'").append(url).append("', @S);");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ps.executeQuery();
			ps = con.prepareStatement("SELECT @S;");
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				return rs.getInt("@S") == 0 ? true : false;
			}

		} catch (Exception ex) {

		}
		return false;
	}
}
