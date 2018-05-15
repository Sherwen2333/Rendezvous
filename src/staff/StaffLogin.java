package staff;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public final class StaffLogin {

	public static boolean status = true;

	/**
	 * Verify a login information
	 * 
	 * @param login
	 *            Login info to be verified
	 * @return Return <code>0</code> if is failed, <code>1</code> if user is
	 *         employee , <code>2</code> if user is manager.
	 */
	public static int verifyLoginInfo(String username, String password) {
		// Neither field should be null
		if (username == null || password == null)
			return 0;

		// Find login info pair from the database
		try {
			final String CONNECTION = "jdbc:mysql://localhost:3306/Rendezvous?useSSL=false";
			final String SQL_USERNAME = "root";
			final String SQL_PASSWORD = "rendezvous@305";
			final String DRIVER = "com.mysql.jdbc.Driver";
			Class.forName(DRIVER);
			final Connection con = DriverManager.getConnection(CONNECTION, SQL_USERNAME, SQL_PASSWORD);

			username = username.replaceAll("'", "\\\'");
			password = password.replaceAll("'", "\\\'");

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT * ");
			statement.append("FROM EMPLOYEE ");
			statement.append("WHERE SSN = '").append(username).append("' ");
			statement.append("AND Password = '").append(password).append("' ");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return 1;
			}

			statement = new StringBuilder();
			statement.append("SELECT * ");
			statement.append("FROM MANAGER ");
			statement.append("WHERE SSN = '").append(username).append("' ");
			statement.append("AND Password = '").append(password).append("' ");

			ps = con.prepareStatement(statement.toString());
			rs = ps.executeQuery();
			if (rs.next()) {
				return 2;
			}

		} catch (Exception ex) {

		}
		return 0;
	}
}
