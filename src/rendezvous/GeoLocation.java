package rendezvous;

import java.io.File;
import java.net.InetAddress;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;
import com.maxmind.geoip2.DatabaseReader;
import com.maxmind.geoip2.model.CityResponse;

public class GeoLocation {
	private String detailaddr;
	public static String detailaddr_t;
	public static int status = 0;

	public void setDetailaddr(String detailaddr) {
		this.detailaddr = detailaddr;
	}

	public String getDetailaddr() {
		return this.detailaddr;
	}

	public static ArrayList<String> NearBy = new ArrayList<String>();
	public static String acceptName = null;
	public static boolean waiting = false;
	public static String inviter = null;
	public static final String DatabasePath = "./GeoLite2-City.mmdb";

	public static void setIP(String profileId, String ip) throws Exception {
		try {
			GeoLocation.getCity(ip);
		} catch (Exception e) {
			ip = "130.245.192.22";
		}
		String la = GeoLocation.getLatitude(ip);
		String lo = GeoLocation.getLongitude(ip);
		Connection con = MainConnector.getCon();
		StringBuilder statement = new StringBuilder();
		statement.append("CALL UpdateProfileIP('" + profileId + "','" + ip + "'," + la + "," + lo + ", @S); ");
		PreparedStatement ps = con.prepareStatement(statement.toString());
		ps.execute();
	}

	public static String getIpAdrress(HttpServletRequest request) {
		String Xip = request.getHeader("X-Real-IP");
		String XFor = request.getHeader("X-Forwarded-For");
		if (StringUtils.isNotEmpty(XFor) && !"unKnown".equalsIgnoreCase(XFor)) {

			int index = XFor.indexOf(",");
			if (index != -1) {
				return XFor.substring(0, index);
			} else {
				return XFor;
			}
		}
		XFor = Xip;
		if (StringUtils.isNotEmpty(XFor) && !"unKnown".equalsIgnoreCase(XFor)) {
			return XFor;
		}
		if (StringUtils.isBlank(XFor) || "unknown".equalsIgnoreCase(XFor)) {
			XFor = request.getHeader("Proxy-Client-IP");
		}
		if (StringUtils.isBlank(XFor) || "unknown".equalsIgnoreCase(XFor)) {
			XFor = request.getHeader("WL-Proxy-Client-IP");
		}
		if (StringUtils.isBlank(XFor) || "unknown".equalsIgnoreCase(XFor)) {
			XFor = request.getHeader("HTTP_CLIENT_IP");
		}
		if (StringUtils.isBlank(XFor) || "unknown".equalsIgnoreCase(XFor)) {
			XFor = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (StringUtils.isBlank(XFor) || "unknown".equalsIgnoreCase(XFor)) {
			XFor = request.getRemoteAddr();
		}
		return XFor;

	}

	public static String getIp(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	public static String getCountry(String ip) throws Exception {
		String dbLocation = DatabasePath;

		File database = new File(dbLocation);
		DatabaseReader dbReader = new DatabaseReader.Builder(database).build();

		InetAddress ipAddress = InetAddress.getByName(ip);
		CityResponse response = dbReader.city(ipAddress);

		String countryName = response.getCountry().getName();
		return countryName;
	}

	public static String getCity(String ip) throws Exception {
		String dbLocation = DatabasePath;

		File database = new File(dbLocation);
		DatabaseReader dbReader = new DatabaseReader.Builder(database).build();

		InetAddress ipAddress = InetAddress.getByName(ip);
		CityResponse response = dbReader.city(ipAddress);

		String cityName = response.getCity().getName();
		return cityName;
	}

	public static String getPostal(String ip) throws Exception {
		String dbLocation = DatabasePath;

		File database = new File(dbLocation);
		DatabaseReader dbReader = new DatabaseReader.Builder(database).build();

		InetAddress ipAddress = InetAddress.getByName(ip);
		CityResponse response = dbReader.city(ipAddress);

		String postal = response.getPostal().getCode();
		return postal;
	}

	public static String getState(String ip) throws Exception {
		String dbLocation = DatabasePath;

		File database = new File(dbLocation);
		DatabaseReader dbReader = new DatabaseReader.Builder(database).build();

		InetAddress ipAddress = InetAddress.getByName(ip);
		CityResponse response = dbReader.city(ipAddress);

		String state = response.getLeastSpecificSubdivision().getName();
		return state;
	}

	public static String getLatitude(String ip) throws Exception {
		String dbLocation = DatabasePath;

		File database = new File(dbLocation);
		DatabaseReader dbReader = new DatabaseReader.Builder(database).build();

		InetAddress ipAddress = InetAddress.getByName(ip);
		CityResponse response = dbReader.city(ipAddress);

		String latitude = response.getLocation().getLatitude().toString();
		return latitude;
	}

	public static String getLongitude(String ip) throws Exception {
		String dbLocation = DatabasePath;

		File database = new File(dbLocation);
		DatabaseReader dbReader = new DatabaseReader.Builder(database).build();

		InetAddress ipAddress = InetAddress.getByName(ip);
		CityResponse response = dbReader.city(ipAddress);

		String longitude = response.getLocation().getLongitude().toString();
		return longitude;
	}

	public static int FindPeopleNearBy(String inviter) throws Exception {
		NearBy = new ArrayList<String>();
		
		Connection con = MainConnector.getCon();
		
		StringBuilder statement = new StringBuilder();
		statement.append("SELECT latitude,longitude, CId ");
		statement.append("FROM PROFILE ");
		statement.append("WHERE Id='" + inviter + "'; ");
		PreparedStatement ps = con.prepareStatement(statement.toString());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			if (rs.getString("latitude") == null || rs.getString("longitude") == null) {
				return 1;
			}
			double la = Double.parseDouble(rs.getString("latitude"));
			double lo = Double.parseDouble(rs.getString("longitude"));
			String thiscid = rs.getString("CId");
			statement = new StringBuilder();
			statement.append("SELECT Id ");
			statement.append("FROM PROFILE ");
			statement.append("WHERE latitude<" + (la + 2) + " and latitude>" + (la - 2) + " and longitude<" + (lo + 2)
					+ " and longitude>" + (lo - 2) + ";");
			ps = con.prepareStatement(statement.toString());
			rs = ps.executeQuery();
			while (rs.next()) {
				statement = new StringBuilder();
				statement.append("SELECT CId ");
				statement.append("FROM PROFILE ");
				statement.append("WHERE Id='" + rs.getString("Id") + "' ;");
				PreparedStatement ps4 = con.prepareStatement(statement.toString());
				ResultSet rs4 = ps4.executeQuery();
				rs4.next();
				String cid = rs4.getString("CId");
				if (!thiscid.equals(cid)) {
					NearBy.add(rs.getString("Id"));
				}
			}
			if (NearBy.isEmpty()) {
				return 3;
			}
			return 0;
		} else {
			return 2;
		}
	}

	public static int SendMessage(String invitee, String inviter, String addr) throws Exception {
		Connection con = MainConnector.getCon();
		String s2 = "SELECT COUNT(*) FROM MESSAGE WHERE inviter='" + inviter + "' AND invitee='" + invitee + "'; ";
		PreparedStatement pp = con.prepareStatement(s2);
		ResultSet rr = pp.executeQuery();
		if (rr.next()) {
			if (!rr.getString("COUNT(*)").equals("0")) {
				return 2;
			}
		}
		StringBuilder statement = new StringBuilder();
		statement.append("SELECT IP ");
		statement.append("FROM PROFILE ");
		statement.append("WHERE Id='" + inviter + "'; ");
		PreparedStatement ps = con.prepareStatement(statement.toString());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			if (rs.getString("IP") == null) {
				return 1;
			}
			String IP = rs.getString("IP");
			String city = GeoLocation.getCity(IP);
			String State = GeoLocation.getState(IP);
			statement = new StringBuilder();
			statement.append("CALL CreateMessage('" + invitee + "','" + inviter + "','" + addr + "','" + city + "','"
					+ State + "', CURRENT_TIMESTAMP, @S); ");
			ps = con.prepareStatement(statement.toString());

			ps.execute();
		}
		return 4;
	}

	public static int CountMessage(String id) throws ClassNotFoundException, SQLException {
		Connection con = MainConnector.getCon();
		StringBuilder statement = new StringBuilder();
		statement.append("SELECT COUNT(*) FROM MESSAGE WHERE invitee='" + id + "';");
		PreparedStatement ps = con.prepareStatement(statement.toString());
		ResultSet rs = ps.executeQuery();
		rs.next();
		int result = Integer.parseInt(rs.getString("COUNT(*)"));
		return result;
	}

	public static ArrayList<String> GetMessage(String id) throws ClassNotFoundException, SQLException {
		ArrayList<String> List = new ArrayList<String>();
		Connection con = MainConnector.getCon();
		StringBuilder statement = new StringBuilder();
		statement.append("SELECT * FROM MESSAGE WHERE invitee='" + id + "';");
		PreparedStatement ps = con.prepareStatement(statement.toString());
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			List.add(rs.getString("inviter") + "@" + rs.getString("addr") + "@" + rs.getString("City") + "@"
					+ rs.getString("State") + "@" + rs.getString("time"));
		}
		return List;
	}

	public static boolean CheckMessageExist(String invitee, String inviter)
			throws ClassNotFoundException, SQLException {
		Connection con = MainConnector.getCon();
		StringBuilder statement = new StringBuilder();
		statement.append("SELECT * FROM MESSAGE WHERE invitee='" + invitee + "' and inviter='" + inviter + "'; ");
		PreparedStatement ps = con.prepareStatement(statement.toString());
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			return true;
		}
		return false;

	}

	public static boolean DeleteMessageSent(String id) throws ClassNotFoundException, SQLException {
		Connection con = MainConnector.getCon();
		StringBuilder statement = new StringBuilder();
		statement.append("CALL DELETEALLMESSAGESENT('" + id + "');");
		PreparedStatement ps = con.prepareStatement(statement.toString());
		boolean rs = ps.execute();
		return rs;
	}

	public static boolean DeleteMessageReceived(String id) throws ClassNotFoundException, SQLException {
		Connection con = MainConnector.getCon();
		StringBuilder statement = new StringBuilder();
		statement.append("CALL DELETEALLMESSAGERECEIVED('" + id + "');");
		PreparedStatement ps = con.prepareStatement(statement.toString());
		boolean rs = ps.execute();
		return rs;
	}

	public static boolean DeleteOneMessageReceived(String invitee, String inviter)
			throws ClassNotFoundException, SQLException {
		Connection con = MainConnector.getCon();
		StringBuilder statement = new StringBuilder();
		statement.append("CALL DELETETHISMESSAGERECEIVED('" + invitee + "','" + inviter + "');");
		PreparedStatement ps = con.prepareStatement(statement.toString());
		boolean rs = ps.execute();
		return rs;
	}
}
