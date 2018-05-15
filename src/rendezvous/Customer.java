package rendezvous;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class Customer {
	public static String getProfilePlacementPriority(String username) {
		// Neither field should be null
		if (username == null)
			return null;

		// Find Profile Placement Priority from the database
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT PPP ");
			statement.append("FROM Customer ");
			statement.append("WHERE Id = '").append(username).append("'");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			
			if(rs.next())
				return rs.getString(1);
			else 
				return null;
		} catch (Exception ex) {
		}
		return null;
	}
	
	public static ArrayList<String> getProfileList(String username) {
		// Neither field should be null
		if (username == null)
			return null;
		
		ArrayList<String> list = new ArrayList<>();
		
		// Find profile list from the database
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT DISTINCT Id ");
			statement.append("FROM Profile ");
			statement.append("WHERE CId = '").append(username).append("'");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()){
				list.add(rs.getString(1));
			}
		} catch (Exception ex) {

		}
		return list;
	}
}
