package rendezvous;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProfileInfo {
	public static int status=0;
	private String profileId;
	private   int age;
	private  String addr;
	private  String city;
	private  String state;
	private  String gender;
	private  double height;
	private  double weight;
	private  String hairColor;
	private  String hobby;
	private  int agemin;
	private  int agemax; 
	public String cid;
	public double georange;
	
	public static String profileId_t;
	public static String age_t;
	public static String addr_t;
	public static String city_t;
	public static String state_t;
	public static String gender_t;
	public static String height_t;
	public static String weight_t;
	public static String hairColor_t;
	public static String hobby_t;
	public static String agemin_t;
	public static String agemax_t;
	public static String georange_t;
	
	public static void init(){
		status=0;
		profileId_t=null;
		age_t=null;
		addr_t=null;
		city_t=null;
		state_t=null;
		gender_t=null;
		height_t=null;
		weight_t=null;
		hairColor_t=null;
		hobby_t=null;
		agemin_t=null;
		agemax_t=null;
		georange_t=null;
	}
	public void setGeorange(double georange){
		this.georange=georange;
	}
	public double getGeorange(){
		return georange;
	}
	public void setCid(String cid){
		this.cid=cid;
	}
	public String getCid(){
		return cid;
	}
	public void setProfileId(String profileId){
		this.profileId=profileId;
	}
	public String getProfileId(){
		return profileId;
	}
	public void setAge(int age){
		this.age=age;
	}
	public int getAge(){
		return age;
	}
	public void setAddr(String addr){
		this.addr=addr;
	}
	public String getAddr(){
		return addr;
	}
	public void setCity(String city){
		this.city=city;
	}
	public String getCity(){
		return city;
	}
	public void setState(String state){
		this.state=state;
	}
	public String getState(){
		return state;
	}
	public void setGender(String gender){
		this.gender=gender;
	}
	public String getGender(){
		return gender;
	}
	public void setHeight(double height){
		this.height=height;
	}
	public double getHeight(){
		return height;
	}
	public void setWeight(double weight){
		this.weight=weight;
	}
	public double getWeight(){
		return weight;
	}
	public void setHairColor(String hairColor){
		this.hairColor=hairColor;
	}
	public String getHairColor(){
		return hairColor;
	}
	public void setHobby(String hobby){
		this.hobby=hobby;
	}
	public String getHobby(){
		return hobby;
	}
	public void setAgemin(int agemin){
		this.agemin=agemin;
	}
	public int getAgemin(){
		return agemin;
	}
	public void setAgemax(int agemax){
		this.agemax=agemax;
	}
	public int getAgemax(){
		return agemax;
	}
	public static int CreateProfile(ProfileInfo pf) throws SQLException{
		if(pf.cid==null)return 18;
		
		Connection con =MainConnector.getCon();

		StringBuilder statement = new StringBuilder();
		statement.append("SELECT Id ");
		statement.append("FROM profile ");
		statement.append("WHERE Id = '").append(pf.getProfileId()).append("' ");
		PreparedStatement ps = con.prepareStatement(statement.toString());
		ResultSet rs = ps.executeQuery();
		if(rs.next()){
			return 17;
		}
		else{
			statement =new StringBuilder();
			statement.append("SELECT Id ");
			statement.append("FROM CUSTOMER ");
			statement.append("WHERE Id = '").append(pf.cid).append("' ");
			ps =con.prepareStatement(statement.toString());
			rs=ps.executeQuery();
			if(!rs.next()){
				return 18;
			}			
			
			StringBuilder statement2 = new StringBuilder();
			statement2.append("CALL CreateProfile( ");
			statement2.append("'"+pf.cid+"'"+", 		'"+pf.profileId+"',		NULL, 		"+pf.age+", ");
			statement2.append("'"+pf.addr+"', 		'"+pf.city+"',		'"+pf.state+"', 		'"+pf.gender+"', ");
			statement2.append("'0', "+pf.agemin+", 		"+pf.agemax+", ");
			statement2.append("@S");
			statement2.append("); ");
			PreparedStatement ps2 = con.prepareStatement(statement2.toString());
			ps2.execute();
			
			statement2= new StringBuilder();
			statement2.append("CALL UpdateProfilePhyChar( ");
			statement2.append("'"+pf.profileId+"'"+", 		'"+pf.gender+"', '"+pf.height+"', ");
			statement2.append("'"+pf.weight+"', 		'"+pf.hairColor+"',		'"+pf.hobby+"', ");
			statement2.append("@S");
			statement2.append("); ");
			ps2 = con.prepareStatement(statement2.toString());
			ps2.execute();
			
			
			
			return 0;
		}
	}
	
	public static boolean Isdigit(String a){
		final String number = "0123456789.";
		  for(int i = 0;i < a.length(); i ++)
		  {
		  	if(number.indexOf(a.charAt(i)) == -1)
		     {  
			 	return false;
		     }  
		  }  
		
		return true;
	}
	
}
