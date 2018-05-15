package rendezvous;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class Upgrade {

	public static boolean upgrade(String username, String newPPP) {
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("UPDATE CUSTOMER SET PPP = '");
			statement.append(newPPP).append("'");
			statement.append("WHERE Id = '").append(username).append("'");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			int rs = ps.executeUpdate();
			
			if(rs > 0)
				return true;
		} catch (Exception ex) {

		}
		return false;
	}

}
