package rendezvous;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

public class SignUp {

	public static int status = 0;

	private String id;
	private String password;
	private String last;
	private String first;
	private String addr;
	private String city;
	private String state;
	private String zip;
	private long tele;
	private String email;
	private long accNum;
	private Timestamp acd;
	private long ccn;
	private String ppp;

	public static String id_t;
	public static String password_t;
	public static String last_t;
	public static String first_t;
	public static String addr_t;
	public static String city_t;
	public static String state_t;
	public static String zip_t;
	public static String tele_t;
	public static String email_t;

	public static void init() {
		status = 0;
		id_t = null;
		password_t = null;
		last_t = null;
		first_t = null;
		addr_t = null;
		city_t = null;
		state_t = null;
		zip_t = null;
		tele_t = null;
		email_t = null;
	}

	public final String getId() {
		return id;
	}

	public final void setId(String Id) {
		this.id = Id;
	}

	public final String getPassword() {
		return password;
	}

	public final void setPassword(String password) {
		this.password = password;
	}

	public final String getfirst() {
		return first;
	}

	public final void setfirst(String first) {
		this.first = first;
	}

	public final String getLast() {
		return last;
	}

	public final void setLast(String last) {
		this.last = last;
	}

	public final String getAddr() {
		return addr;
	}

	public final void setAddr(String addr) {
		this.addr = addr;
	}

	public final String getCity() {
		return city;
	}

	public final void setCity(String city) {
		this.city = city;
	}

	public final String getState() {
		return state;
	}

	public final void setState(String state) {
		this.state = state;
	}

	public final String getZip() {
		return zip;
	}

	public final void setZip(String zip) {
		this.zip = zip;
	}

	public final long getTele() {
		return tele;
	}

	public final void setTele(long Tele) {
		this.tele = Tele;
	}

	public final String getEmail() {
		return email;
	}

	public final void setEmail(String Email) {
		this.email = Email;
	}

	public final long getAccNum() {
		return accNum;
	}

	public final void setAccNum(long AccNum) {
		this.accNum = AccNum;
	}

	public final Timestamp getACD() {
		return acd;
	}

	public final void setACD(Timestamp ACD) {
		this.acd = ACD;
	}

	public final long getCCN() {
		return ccn;
	}

	public final void setCCN(long CCN) {
		this.ccn = CCN;
	}

	public final String getPPP() {
		return ppp;
	}

	public final void setPPP(String PPP) {
		this.ppp = PPP;
	}

	public static int CreateCustomer(SignUp signup) {
		// check if the id is exist
		try {
			if (signup.id == null)
				return 1;
			if (signup.password == null)
				return 2;
			if (signup.first == null)
				return 3;
			if (signup.last == null)
				return 4;
			if (signup.addr == null)
				return 5;
			if (signup.city == null)
				return 6;
			if (signup.state == null)
				return 7;
			if (signup.zip == null)
				return 8;
			if (signup.tele == 0)
				return 9;
			if (signup.email == null)
				return 10;
			if (signup.id.contains("&") || signup.id.contains("\\") || signup.id.contains("'"))
				return 15;

			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT Id ");
			statement.append("FROM Customer ");
			statement.append("WHERE Id = '").append(signup.id).append("' ");

			PreparedStatement ps = con.prepareStatement(statement.toString());

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				return 11;
			} else {
				StringBuilder statement2 = new StringBuilder();
				statement2.append("CALL CreateAccount( ");
				statement2.append("'" + signup.id + "'" + ", 		'" + signup.password + "',		'" + signup.first
						+ "', 		'" + signup.last + "', ");
				statement2.append("'" + signup.addr + "', 		'" + signup.city + "',		'" + signup.state
						+ "', 		'" + signup.zip + "', ");
				statement2.append("'" + signup.tele + "', 		'" + signup.email + "', ");
				statement2.append("1000000000000000,  		'C', 		@S");
				statement2.append("); ");

				PreparedStatement ps2 = con.prepareStatement(statement2.toString());
				ps2.execute();
				return 0;
			}
		} catch (Exception ex) {

		}
		return 12;
	}

}
