package rendezvous;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class Search {
	public static String Id_t = "";
	public static String City_t = "";
	public static String State_t = "";
	public static String HeightMin_t = "";
	public static String HeightMax_t = "";
	public static String WeightMin_t = "";
	public static String WeightMax_t = "";
	public static String HColor_t = "";
	public static String AgeMin_t = "";
	public static String AgeMax_t = "";
	public static int search_status = 0;

	public static void init() {
		Id_t = "";
		City_t = "";
		State_t = "";
		HeightMin_t = "";
		HeightMax_t = "";
		WeightMin_t = "";
		WeightMax_t = "";
		HColor_t = "";
		AgeMin_t = "";
		AgeMax_t = "";
	}

	public static ArrayList<String> SearchBaseOnId(String Id) {
		ArrayList<String> list = new ArrayList<String>();
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT Id ");
			statement.append("FROM PROFILE ");
			statement.append("WHERE Id = '").append(Id).append("'");
			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("Id"));
			}
		} catch (Exception ex) {

		}
		return list;
	}

	public static ArrayList<String> SearchBaseOnAge(int ageMin, int ageMax) {
		ArrayList<String> list = new ArrayList<String>();
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("CALL SearchBaseOnAge (");
			statement.append("'").append(UserProfile.getProfileId()).append("',");
			statement.append(ageMin).append(",").append(ageMax).append(");");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("Id"));
			}
		} catch (Exception ex) {

		}
		return list;
	}

	public static ArrayList<String> SearchBaseOnCityNState(String city, String state) {
		ArrayList<String> list = new ArrayList<String>();
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("CALL SearchBaseOnCityNState (");
			statement.append("'").append(UserProfile.getProfileId()).append("','");
			statement.append(city).append("','").append(state).append("');");
			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("Id"));
			}
		} catch (Exception ex) {

		}
		return list;
	}

	public static ArrayList<String> SearchBaseOnState(String state) {
		ArrayList<String> list = new ArrayList<String>();
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("CALL SearchBaseOnState (");
			statement.append("'").append(UserProfile.getProfileId()).append("','");
			statement.append(state).append("');");
			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("Id"));
			}
		} catch (Exception ex) {

		}
		return list;
	}

	public static ArrayList<String> SearchBaseOnPhyCharHW(double hmin, double hmax, double wmin, double wmax) {
		ArrayList<String> list = new ArrayList<String>();
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("CALL SearchBaseOnPhyCharHW (");
			statement.append("'").append(UserProfile.getProfileId()).append("',");
			statement.append(hmin).append(",").append(hmax).append(",");
			statement.append(wmin).append(",").append(wmax).append(");");
			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("Id"));
			}
		} catch (Exception ex) {

		}
		return list;
	}

	public static ArrayList<String> SearchBaseOnPhyCharHWC(double hmin, double hmax, double wmin, double wmax,
			String hc) {
		ArrayList<String> list = new ArrayList<String>();
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("CALL SearchBaseOnPhyCharHWC (");
			statement.append("'").append(UserProfile.getProfileId()).append("',");
			statement.append(hmin).append(",").append(hmax).append(",");
			statement.append(wmin).append(",").append(wmax);
			statement.append(",'").append(hc).append("');");
			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("Id"));
			}
		} catch (Exception ex) {

		}
		return list;
	}

	public static ArrayList<String> ArrayCombine(ArrayList<String> a, ArrayList<String> b) {
		ArrayList<String> result = new ArrayList<String>();
		if ((!a.isEmpty()) || (!b.isEmpty())) {
			for (String s : a) {
				if (b.contains(s)) {
					result.add(s);
				}
			}
		} else
			return null;
		return result;
	}
	public static ArrayList<String> GetAllProfileId() {
		ArrayList<String> list = new ArrayList<String>();
		try {
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("SELECT Id ");
			statement.append("FROM PROFILE; ");
			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("Id"));
			}
		} catch (Exception ex) {

		}
		return list;
	}
	public static boolean ProfileCheck(String Id) {
		boolean result=true;
		ArrayList<String> list=new ArrayList<String>();
		try {
			Connection con = MainConnector.getCon();
			StringBuilder statement = new StringBuilder();
			statement.append("SELECT distinct P.CId ");
			statement.append("FROM  profile P ");
			statement.append("WHERE P.Id='").append(Id).append("' OR P.Id='").append(UserProfile.getProfileId()).append("';");

			PreparedStatement ps = con.prepareStatement(statement.toString());
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				list.add(rs.getString("CId"));
			}
			if(list.size()>1) {
				result=false;
			}
			
		} catch (Exception ex) {

		}
		return result;
	}

}
