package rendezvous;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Like {

	public static boolean hasLiked(String likee, String liker) {
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT * ");
			statement.append("FROM LIKES ");
			statement.append("WHERE LikerId='").append(liker).append("' AND ");
			statement.append("LikeeId='").append(likee).append("';");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			return rs.next();

		} catch (Exception ex) {

		}
		return false;
	}

	public static void likeAProfile(String likee, String liker) {
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("CALL LikeAProfile (");
			statement.append("'").append(liker).append("', ");
			statement.append("'").append(likee).append("', @S);");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ps.executeQuery();

		} catch (Exception ex) {

		}
	}

	public static void unlikeAProfile(String likee, String liker) {
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("CALL UnlikeAProfile (");
			statement.append("'").append(liker).append("', ");
			statement.append("'").append(likee).append("', @S);");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ps.executeQuery();

		} catch (Exception ex) {

		}
	}

	public static int referAProfile(String userA, String userB, String userC) {
		try {
			if (userA.equals(userB) || userA.equals(userC) || userB.equals(userC)) {
				return 0;
			}

			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT * FROM PROFILE P WHERE P.Id = '" + userA + "'");
			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			if (rs.next() == false) {
				return 11;
			}

			statement = new StringBuilder();
			statement.append("SELECT * FROM PROFILE P WHERE P.Id = '" + userB + "'");
			ps = con.prepareStatement(statement.toString());
			rs = ps.executeQuery();
			if (rs.next() == false) {
				return 12;
			}

			statement = new StringBuilder();
			statement.append("SELECT * FROM PROFILE P WHERE P.Id = '" + userC + "'");
			ps = con.prepareStatement(statement.toString());
			rs = ps.executeQuery();
			if (rs.next() == false) {
				return 13;
			}

			statement = new StringBuilder();
			statement.append("CALL ReferAProfile (");
			statement.append("'").append(userA).append("', ");
			statement.append("'").append(userB).append("', ");
			statement.append("'").append(userC).append("', @S);");
			ps = con.prepareStatement(statement.toString());
			ps.executeQuery();

			return 2;
		} catch (Exception ex) {

		}
		return 3;
	}

}
