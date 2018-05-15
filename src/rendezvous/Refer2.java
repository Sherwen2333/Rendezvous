package rendezvous;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Refer2 {
	public static ArrayList<String> getRefer(String pid) {
		ArrayList<String> list = new ArrayList<>();

		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT * ");
			statement.append("FROM REFERAL ");
			statement.append("WHERE UserC='").append(pid).append("';");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				list.add(rs.getString("UserA") + "@" + rs.getString("UserC"));
			}
		} catch (Exception e) {

		}

		return list;

	}

	public final String userA;
	public final String userB;
	public final String userC;
	public final String time;
	public final String id;
	
	public String addr;
	public String atime;
	public static String addr_t;
	public static String atime_t;
	public void setAddr(String addr){
		this.addr=addr;
	}
	public String getAddr(){
		return addr;
	}
	public void setAtime(String atime){
		this.atime=atime;
	}
	public String getAtime(){
		return atime;
	}
	
	private Refer2(String userA, String userB, String userC, String time, String id) {
		this.userA = userA;
		this.userB = userB;
		this.userC = userC;
		this.time = time;
		this.id=id;
	}

	public static ArrayList<Refer2> getReferal(String pid) {
		ArrayList<Refer2> list = new ArrayList<>();

		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT * ");
			statement.append("FROM REFERAL ");
			statement.append("WHERE UserC='").append(pid).append("';");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				String a = rs.getString("UserA");
				String b = rs.getString("UserB");
				String c = rs.getString("UserC");
				String t = rs.getTimestamp("DateTime").toString();
				String id= rs.getString("Id");
				t = t.substring(0, t.lastIndexOf('.'));
				Refer2 r = new Refer2(a, b, c, t,id);
				list.add(r);
			}
		} catch (Exception e) {

		}

		return list;

	}
	
	
	public static boolean CheckIsReferral(String Id) throws SQLException{
		Connection con = MainConnector.getCon();

		StringBuilder statement = new StringBuilder();
		statement.append("SELECT * FROM REFERAL WHERE Id='"+Id+"' ;");
		PreparedStatement ps = con.prepareStatement(statement.toString());
		ResultSet rs = ps.executeQuery();
		if(rs.next())
			return true;
		else
			return false;
	}
	
}
