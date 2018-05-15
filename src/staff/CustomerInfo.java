package staff;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import rendezvous.MainConnector;
import rendezvous.ProfilePlacementPriority;

public final class CustomerInfo {
	private String id;
	private String password;
	private String lastName;
	private String firstName;
	private String address;
	private String city;
	private String state;
	private String zip;
	private String telephone;
	private String email;
	private long accountNum;
	private String creationDate;
	private long creditCardNum;
	private String ppp;

	private ArrayList<String> profiles;

	private CustomerInfo() {

	}

	/**
	 * Retrieve info of a customer
	 * 
	 * @param cId
	 *            customer id
	 * @return info of a customer
	 * 
	 */
	public static CustomerInfo getCustomerInfo(String cId) {
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT * ");
			statement.append("FROM CUSTOMER ");
			statement.append("WHERE Id='").append(cId).append("';");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				CustomerInfo info = new CustomerInfo();
				info.id = rs.getString("Id");
				info.password = rs.getString("Password");
				info.lastName = rs.getString("Last");
				info.firstName = rs.getString("First");
				info.address = rs.getString("Addr");
				info.city = rs.getString("City");
				info.state = rs.getString("State");
				info.zip = rs.getString("Zip");
				info.telephone = rs.getString("Tele");
				info.email = rs.getString("Email");
				info.accountNum = rs.getLong("AccNum");
				info.creationDate = rs.getTimestamp("ACD").toString();
				info.creationDate = info.creationDate.substring(0, info.creationDate.lastIndexOf('.'));
				info.creditCardNum = rs.getLong("CCN");
				info.ppp = rs.getString("PPP");
				if (info.ppp.equals("A")) {
					info.ppp = ProfilePlacementPriority.PPP.get(0);
				} else if (info.ppp.equals("B")) {
					info.ppp = ProfilePlacementPriority.PPP.get(1);
				} else {
					info.ppp = ProfilePlacementPriority.PPP.get(2);
				}

				info.profiles = new ArrayList<>();
				StringBuilder statement2 = new StringBuilder();
				statement2.append("SELECT DISTINCT Id ");
				statement2.append("FROM PROFILE ");
				statement2.append("WHERE CId='").append(cId).append("';");

				PreparedStatement ps2 = con.prepareStatement(statement2.toString());
				ResultSet rs2 = ps2.executeQuery();
				while (rs2.next()) {
					info.profiles.add(rs2.getString(1));
				}
				return info;
			}
		} catch (Exception ex) {

		}
		return null;
	}

	/**
	 * Edit customer id and password
	 * 
	 * @param oldId
	 * @param newId
	 * @param newPassword
	 * @return
	 */
	public static boolean editIdAndPassword(String oldId, String newId, String newPassword) {
		try {
			if (oldId == null || newId == null || newPassword == null)
				return false;

			if (containsSpecial(newId) || containsSpecial(newPassword)) {
				return false;
			}

			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("UPDATE Customer ");
			statement.append("SET Id='").append(newId).append("', ");
			statement.append("Password='").append(newPassword).append("' ");
			statement.append("WHERE Id='").append(oldId).append("';");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			int status = ps.executeUpdate();

			return status != 0;

		} catch (Exception ex) {

		}
		return false;
	}

	/**
	 * Edit customer personal information
	 * 
	 * @param id
	 * @param newLast
	 * @param newFirst
	 * @param newTele
	 * @param newEmail
	 * @return
	 */
	public static boolean editPersonalInfo(String id, String newLast, String newFirst, String newTele,
			String newEmail) {
		try {
			if (id == null || newLast == null || newFirst == null || newTele == null || newEmail == null)
				return false;

			if (newTele.length() != 10)
				return false;

			if (containsSpecial(newLast) || containsSpecial(newFirst) || containsSpecial(newTele)
					|| containsSpecial(newEmail)) {
				return false;
			}

			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("UPDATE Customer ");
			statement.append("SET Last='").append(newLast).append("', ");
			statement.append("First='").append(newFirst).append("' ,");
			statement.append("Tele=").append(Long.parseLong(newTele)).append(", ");
			statement.append("Email='").append(newEmail).append("' ");
			statement.append("WHERE Id='").append(id).append("';");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			int status = ps.executeUpdate();

			return status != 0;

		} catch (Exception ex) {
			
		}
		return false;
	}

	/**
	 * Edit customer address
	 * 
	 * @param id
	 * @param newAddress
	 * @param newCity
	 * @param newState
	 * @param newZip
	 * @return
	 */
	public static boolean editAddress(String id, String newAddress, String newCity, String newState, String newZip) {
		try {
			if (id == null || newAddress == null || newCity == null || newState == null || newZip == null)
				return false;

			if (newZip.length() != 5)
				return false;

			if (containsSpecial(newAddress) || containsSpecial(newCity) || containsSpecial(newState)
					|| containsSpecial(newZip)) {
				return false;
			}

			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("UPDATE Customer ");
			statement.append("SET Addr='").append(newAddress).append("', ");
			statement.append("City='").append(newCity).append("', ");
			statement.append("State='").append(newState).append("', ");
			statement.append("Zip=").append(Integer.parseInt(newZip)).append(" ");
			statement.append("WHERE Id='").append(id).append("';");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			int status = ps.executeUpdate();

			return status != 0;

		} catch (Exception ex) {
			
		}
		return false;
	}

	/**
	 * Edit customer payment information
	 * 
	 * @param id
	 * @param newCCN
	 * @param newPPP
	 * @return
	 */
	public static boolean editPayment(String id, String newCCN, String newPPP) {
		try {
			if (id == null || newCCN == null || newPPP == null)
				return false;

			if (newCCN.length() != 16)
				return false;

			Connection con = MainConnector.getCon();

			char ppp = newPPP.charAt(newPPP.indexOf('(') + 1);

			StringBuilder statement = new StringBuilder();
			statement.append("UPDATE Customer ");
			statement.append("SET CCN=").append(Long.parseLong(newCCN)).append(", ");
			statement.append("PPP='").append(ppp).append("' ");
			statement.append("WHERE Id='").append(id).append("';");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			int status = ps.executeUpdate();

			return status != 0;

		} catch (Exception ex) {
			
		}
		return false;
	}

	/**
	 * Close/Delete an existing account
	 * 
	 * @param id
	 */
	public static void closeAccount(String id) {
		try {
			if (id == null)
				return;

			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("CALL DeleteAccount ( ");
			statement.append("'").append(id).append("', @S);");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ps.executeQuery();

		} catch (Exception ex) {
			
		}
	}
	
	public static int CheckPendingDate(String Cid) {
		try {
			Connection con = MainConnector.getCon();
			StringBuilder statement = new StringBuilder();
			statement.append("SELECT SUM(NumPDate),CId FROM PROFILE GROUP BY CId");
			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if (rs.getString("CId").equals(Cid)) {
					if (rs.getString("SUM(NumPDate)").equals("0")) {
						return 0; // Good
					} else
						return 1;
				}
			}
			return 3;
		} catch (Exception e) {
			return 4;
		}
	}

	private static boolean containsSpecial(String str) {
		if (str.length() <= 0) {
			return true;
		}
		if (str.contains("'") || str.contains("\\") || str.contains("&")) {
			return true;
		}
		return false;
	}

	public final String getId() {
		return id;
	}

	public final String getPassword() {
		return password;
	}

	public final String getLastName() {
		return lastName;
	}

	public final String getFirstName() {
		return firstName;
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

	public final String getZip() {
		return zip;
	}

	public final String getTelephone() {
		return telephone;
	}

	public final String getEmail() {
		return email;
	}

	public final long getAccountNum() {
		return accountNum;
	}

	public final String getCreationDate() {
		return creationDate;
	}

	public final long getCreditCardNum() {
		return creditCardNum;
	}

	public final String getPpp() {
		return ppp;
	}

	public final ArrayList<String> getProfiles() {
		return profiles;
	}
}
