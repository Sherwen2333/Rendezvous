package rendezvous;

import java.sql.Connection;
import java.sql.PreparedStatement;

public final class DeletePhoto {

	public static void delete(String url) {
		// Null Id
		if (url == null && UserProfile.getProfileId() != null)
			return;

		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("CALL DeletePhoto ");
			statement.append("(");
			statement.append("'").append(UserProfile.getProfileId()).append("', ");
			statement.append("'").append(url).append("', @S);");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ps.executeQuery();

		} catch (Exception ex) {

		}
	}
}
