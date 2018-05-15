package staff;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import rendezvous.MainConnector;

public class MailingList {

	/**
	 * Retrieve a list of all customer's email
	 * 
	 * @return a list of all customer's email
	 */
	public static ArrayList<String> allEmailList() {
		ArrayList<String> list = new ArrayList<>();
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT DISTINCT Email ");
			statement.append("FROM CUSTOMER ;");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				list.add(rs.getString(1));
			}
		} catch (Exception ex) {

		}
		return list;
	}

	/**
	 * Retrieve a list of all customer's mail address
	 * 
	 * @return a list of all customer's mail addresss
	 */
	public static ArrayList<String> allMailList() {
		ArrayList<String> list = new ArrayList<>();
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT Id, Addr, City, State, Zip ");
			statement.append("FROM CUSTOMER ;");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				StringBuilder address = new StringBuilder();
				address.append(rs.getString("Id")).append(", ");
				address.append(rs.getString("Addr")).append(", ");
				address.append(rs.getString("City")).append(", ");
				address.append(rs.getString("State")).append(" ");
				address.append(rs.getString("Zip"));
				list.add(address.toString());
			}
		} catch (Exception ex) {

		}
		return list;
	}

	/**
	 * Retrieve a list of a specific customer mailing address
	 * 
	 * @return a list of a specific customer mailing address
	 */
	public static ArrayList<String> oneMailList(String cId) {
		// 0->Email; 1 -> cID; 2->Address; 3 -> City, State, ZIP
		ArrayList<String> list = new ArrayList<>();
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT Id, Email, Addr, City, State, Zip ");
			statement.append("FROM CUSTOMER WHERE Id='").append(cId).append("';");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				list.add(rs.getString("Email"));
				list.add(rs.getString("Id"));
				list.add(rs.getString("Addr"));
				StringBuilder address = new StringBuilder();
				address.append(rs.getString("City")).append(", ");
				address.append(rs.getString("State")).append(" ");
				address.append(rs.getString("Zip"));
				list.add(address.toString());
			}

		} catch (Exception ex) {

		}
		return list;
	}
}