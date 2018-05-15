package staff;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import rendezvous.MainConnector;

public class ListRevenue {
	public static ArrayList<String> FindMostRevenuedCR() throws SQLException {
		ArrayList<String> list = new ArrayList<>();

		Connection con = MainConnector.getCon();
		StringBuilder statement = new StringBuilder();
		statement.append("SELECT Sum(D.fee), D.RepId ");
		statement.append("FROM DATEDATA D ");
		statement.append("Group by RepId ");
		statement.append("order by Sum(D.fee) DESC ");
		statement.append("limit 5");
		PreparedStatement ps = con.prepareStatement(statement.toString());
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			list.add(rs.getString("RepId") + "@" + rs.getString("Sum(D.fee)"));
		}
		return list;
	}

	public static ArrayList<String> FindMostRevenuedCustomer() throws SQLException {
		ArrayList<String> list = new ArrayList<>();

		Connection con = MainConnector.getCon();
		StringBuilder statement = new StringBuilder();
		statement.append("SELECT SUM(P.TotalFee), CId ");
		statement.append("FROM PROFILE P ");
		statement.append("group by CId ");
		statement.append("order by SUM(P.TotalFee) desc ");
		statement.append("limit 5");
		PreparedStatement ps = con.prepareStatement(statement.toString());
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			list.add(rs.getString("CId") + "@" + rs.getString("SUM(P.TotalFee)"));
		}

		return list;
	}

}
