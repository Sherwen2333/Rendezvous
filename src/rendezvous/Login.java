package rendezvous;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public final class Login {
	public static boolean status = true;

	private String username;
	private String password;

	public final String getUsername() {
		return username;
	}

	public final void setUsername(String username) {
		this.username = username;
	}

	public final String getPassword() {
		return password;
	}

	public final void setPassword(String password) {
		this.password = password;
	}

	/**
	 * Verify a login information
	 * 
	 * @param login
	 *            Login info to be verified
	 * @return Return <code>true</code> if is valid, otherwise
	 *         <code>false</code>.
	 */
	public static boolean verifyLoginInfo(Login login) {
		// Neither field should be null
		if (login.username == null || login.password == null)
			return false;

		// Find login info pair from the database
		try {
			final String CONNECTION = "jdbc:mysql://localhost:3306/Rendezvous?useSSL=false";
			final String SQL_USERNAME = "root";
			final String SQL_PASSWORD = "rendezvous@305";
			final String DRIVER = "com.mysql.jdbc.Driver";
			Class.forName(DRIVER);
			final Connection con = DriverManager.getConnection(CONNECTION, SQL_USERNAME, SQL_PASSWORD);

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT * ");
			statement.append("FROM Customer ");
			statement.append("WHERE Id = '").append(login.username).append("' ");
			statement.append("AND Password = '").append(login.password).append("' ");

			PreparedStatement ps = con.prepareStatement(statement.toString());

			ResultSet rs = ps.executeQuery();
			return rs.next();

		} catch (Exception ex) {

		}

		return false;
	}

}
