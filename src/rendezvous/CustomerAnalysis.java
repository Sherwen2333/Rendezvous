package rendezvous;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CustomerAnalysis {
	public static ArrayList<String> Find(String cid) throws SQLException{
		ArrayList<String> list= new ArrayList<String>();
		Connection con = MainConnector.getCon();
		StringBuilder statement = new StringBuilder();
		statement.append("CALL ParticularCustDateList( ");
		statement.append("'").append(cid).append("');");
		PreparedStatement ps = con.prepareStatement(statement.toString());
		ResultSet rs = ps.executeQuery();
		while(rs.next()){
			list.add(rs.getString("Id"));
		}
		return list;
	}
	public static ArrayList<String> MostActiveCustomer(int size) throws SQLException{
		ArrayList<String> list= new ArrayList<String>();
		Connection con = MainConnector.getCon();
		StringBuilder statement = new StringBuilder();
		statement.append("CALL MostActiveCustomers("+size+");");
		PreparedStatement ps = con.prepareStatement(statement.toString());
		ResultSet rs = ps.executeQuery();
		while(rs.next()){
			list.add(rs.getString("Id"));
		}
		return list;
	}
	public static ArrayList<String> HighRatedCustomer(int size) throws SQLException{
		ArrayList<String> list= new ArrayList<String>();
		Connection con = MainConnector.getCon();
		StringBuilder statement = new StringBuilder();
		statement.append("CALL HighestRatedCustomer("+size+");");
		PreparedStatement ps = con.prepareStatement(statement.toString());
		ResultSet rs = ps.executeQuery();
		while(rs.next()){
			list.add(rs.getString("Id"));
		}
		return list;
	}
	public static ArrayList<String> HighRatedCalendarDates() throws SQLException{
		ArrayList<String> list= new ArrayList<String>();
		Connection con = MainConnector.getCon();
		StringBuilder statement = new StringBuilder();
		statement.append("CALL HighRatedCalendarDates();");
		PreparedStatement ps = con.prepareStatement(statement.toString());
		ResultSet rs = ps.executeQuery();
		while(rs.next()){
			list.add(rs.getString("DATE"));
		}
		return list;
	}

}
