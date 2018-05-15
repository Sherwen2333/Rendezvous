package staff;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import rendezvous.MainConnector;

public final class Employee {

	private String ssn;
	private String password;
	private String lastName;
	private String firstName;
	private String address;
	private String city;
	private String state;
	private String zip;
	private String telephone;
	private String email;
	private String since;
	private double hourRate;

	private Employee() {

	}

	public Employee(String ssn, String password, String lastName, String firstName, String address, String city,
			String state, String zip, String telephone, String email, String since, double hourRate) {
		this.ssn = ssn;
		this.password = password;
		this.lastName = lastName;
		this.firstName = firstName;
		this.address = address;
		this.city = city;
		this.state = state;
		this.zip = zip;
		this.telephone = telephone;
		this.email = email;
		this.since = since;
		this.hourRate = hourRate;
	}

	/**
	 * Get a Employee object from database
	 * 
	 * @param ssn
	 *            Employee's SSN
	 * @return A Employee object from database
	 */
	public static Employee getEmployee(String ssn, boolean isManager) {
		if (ssn == null)
			return null;
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT DISTINCT * ");
			if(isManager)
				statement.append("FROM MANAGER ");
			else
				statement.append("FROM EMPLOYEE ");
			statement.append("WHERE SSN='").append(ssn).append("';");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				Employee info = new Employee();
				info.ssn = rs.getString("SSN");
				info.password = rs.getString("Password");
				info.lastName = rs.getString("Last");
				info.firstName = rs.getString("First");
				info.address = rs.getString("Addr");
				info.city = rs.getString("City");
				info.state = rs.getString("State");
				info.zip = rs.getString("Zip");
				info.telephone = rs.getString("Tele");
				info.email = rs.getString("Email");
				info.since = rs.getTimestamp("Start").toString();
				info.since = info.since.substring(0, info.since.lastIndexOf('.'));
				info.hourRate = rs.getDouble("HRate");
				return info;
			}
			
		} catch (Exception ex) {

		}
		return null;
	}

	public final String getSsn() {
		return ssn;
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

	public final String getSince() {
		return since;
	}

	public final double getHourRate() {
		return hourRate;
	}

}
