package rendezvous;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class DetailInfo {
	public static String cip;
	public static ResultSet rs;

	public static boolean SearchInfo() throws SQLException, ClassNotFoundException {
		Connection con = MainConnector.getCon();

		StringBuilder statement = new StringBuilder();
		statement.append("CALL MostActiveProfile( ");
		statement.append("'" + cip + "'" + ", 	5);");
		PreparedStatement ps = con.prepareStatement(statement.toString());
		ResultSet resultSet = ps.executeQuery();
		rs = resultSet;
		return resultSet.next();
	}

	public static boolean SearchInfo2() throws SQLException, ClassNotFoundException {
		Connection con = MainConnector.getCon();

		StringBuilder statement = new StringBuilder();
		statement.append("CALL MostHighRateProiles( ");
		statement.append("'" + cip + "'" + ", 	5);");
		PreparedStatement ps = con.prepareStatement(statement.toString());
		ResultSet resultSet = ps.executeQuery();
		rs = resultSet;
		return resultSet.next();
	}

}
