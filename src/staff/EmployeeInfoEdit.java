package staff;

import java.sql.Connection;
import java.sql.PreparedStatement;

import rendezvous.MainConnector;

public final class EmployeeInfoEdit {
	public static int status = 0;
	public static Employee info;
	
	public static boolean checkZip(String zip){
		try{
			if(zip.length() > 5)
				return false;
			int a = Integer.parseInt(zip);
			if(a < 0)
				return false;
		} catch(Exception ex){
			return false;
		}
		return true;
	}
	
	public static boolean checkSSN(String ssn){
		try{
			if(ssn.length() != 9)
				return false;
			long a = Long.parseLong(ssn);
			if(a < 0)
				return false;
		} catch(Exception ex){
			return false;
		}
		return true;
	}
	
	public static boolean checkRate(String rate){
		try{
			double a = Double.parseDouble(rate);
			if(a < 0)
				return false;
		} catch(Exception ex){
			return false;
		}
		return true;
	}
	
	public static boolean checkTele(String tele){
		try{
			if(tele.length() != 10)
				return false;
			long a = Long.parseLong(tele);
			if(a < 0)
				return false;
		} catch(Exception ex){
			return false;
		}
		return true;
	}
	
	public static boolean edit(Employee info){
		try{
			if(info == null)
				return false;
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("UPDATE Employee ");
			statement.append("SET Last = '").append(info.getLastName()).append("', ");
			statement.append("First = '").append(info.getFirstName()).append("', ");
			statement.append("Tele = ").append(info.getTelephone()).append(", ");
			statement.append("Addr = '").append(info.getAddress()).append("', ");
			statement.append("City = '").append(info.getCity()).append("', ");
			statement.append("State = '").append(info.getState()).append("', ");
			statement.append("Zip = '").append(info.getZip()).append("', ");
			statement.append("Email = '").append(info.getEmail()).append("', ");
			statement.append("HRate = ").append(info.getHourRate()).append(", ");
			statement.append("Password = '").append(info.getPassword()).append("' ");
			statement.append("WHERE SSN = '").append(info.getSsn()).append("';");
			
			PreparedStatement ps = con.prepareStatement(statement.toString());
			int rs = ps.executeUpdate();

			if (rs > 0) {
				return true;
			}
		} catch(Exception ex){

		}
		return false;
	}
	
	public static boolean delete(String ssn){
		try{
			if(ssn == null)
				return false;
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("DELETE FROM Employee WHERE SSN = '");
			statement.append(ssn).append("';");
			
			PreparedStatement ps = con.prepareStatement(statement.toString());
			int rs = ps.executeUpdate();

			if (rs > 0) {
				return true;
			}
		} catch(Exception ex){

		}
		return false;
	}
	
	public static boolean create(Employee info){
		try{
			if(info == null)
				return false;
			Connection con = MainConnector.getCon();

			StringBuilder statement = new StringBuilder();
			statement.append("INSERT INTO Employee (SSN, Password, Last, First, Addr, City, State, Zip, Tele, Email, Start, HRate) VALUES(");
			statement.append("'").append(info.getSsn()).append("', ");
			statement.append("'").append(info.getPassword()).append("', ");
			statement.append("'").append(info.getLastName()).append("', ");
			statement.append("'").append(info.getFirstName()).append("', ");
			statement.append("'").append(info.getAddress()).append("', ");
			statement.append("'").append(info.getCity()).append("', ");
			statement.append("'").append(info.getState()).append("', ");
			statement.append("'").append(info.getZip()).append("', ");
			statement.append("").append(info.getTelephone()).append(", ");
			statement.append("'").append(info.getEmail()).append("', CURRENT_TIMESTAMP, ");
			statement.append("").append(info.getHourRate()).append(" );");
			
			PreparedStatement ps = con.prepareStatement(statement.toString());
			int rs = ps.executeUpdate();

			if (rs > 0) {
				return true;
			}
		} catch(Exception ex){

		}
		return false;
	}
	
}
