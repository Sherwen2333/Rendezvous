package config;

import java.util.ArrayList;
import java.util.Calendar;

public final class DateConstants {
	public static final ArrayList<String> MONTH = new ArrayList<>();
	public static final ArrayList<Integer> DAY = new ArrayList<>();
	public static final ArrayList<Integer> YEAR = new ArrayList<>();
	
	public static final ArrayList<Integer> PAST_5_YEAR = new ArrayList<>();
	
	public static final ArrayList<Integer> HOUR = new ArrayList<>();
	public static final ArrayList<Integer> MINUTE = new ArrayList<>();
	public static final ArrayList<Integer> SECOND = new ArrayList<>();
	
	public static final int CURRENT_MONTH;
	public static final int CURRENT_DAY;
	
	static {
		MONTH.add("January");
		MONTH.add("February");
		MONTH.add("March");
		MONTH.add("April");
		MONTH.add("May");
		MONTH.add("June");
		MONTH.add("July");
		MONTH.add("August");
		MONTH.add("September");
		MONTH.add("October");
		MONTH.add("November");
		MONTH.add("December");
		
		CURRENT_MONTH = Calendar.getInstance().get(Calendar.MONTH);
		CURRENT_DAY = Calendar.getInstance().get(Calendar.DATE);
	}
	
	static {
		for(int i = 1; i <= 31; i++)
			DAY.add(i);
	}
	
	static {
		int year = Calendar.getInstance().get(Calendar.YEAR);
		YEAR.add(year);
		YEAR.add(year + 1);
		YEAR.add(year + 2);
		
		PAST_5_YEAR.add(year - 1);
		PAST_5_YEAR.add(year - 2);
		PAST_5_YEAR.add(year - 3);
		PAST_5_YEAR.add(year - 4);
		PAST_5_YEAR.add(year - 5);
	}
	
	static {
		for(int i = 0; i <= 23; i++)
			HOUR.add(i);
		for(int i = 0; i <= 59; i++){
			MINUTE.add(i);
			SECOND.add(i);
		}
	}
}
