package rendezvous;

public final class Date {
	private long dateId;
	private String userAId;
	private String userBId;
	private String dateTime;
	private String geoLoc;
	private String zipCode;
	private double fee;
	private String repId;
	private String commentA;
	private String commentB;
	private double rateA;
	private double rateB;

	
	public Date(long dateId, String userAId, String dateTime, String geoLoc, double fee) {
		this.dateId = dateId;
		this.userAId = userAId;
		this.dateTime = dateTime;
		this.geoLoc = geoLoc;
		this.fee = fee;
	}
	
	public Date(long dateId, String userAId, String userBId, String dateTime, String geoLoc, String zipCode, double fee,
			String repId, String commentA, String commentB, double rateA, double rateB) {
		this.dateId = dateId;
		this.userAId = userAId;
		this.userBId = userBId;
		this.dateTime = dateTime;
		this.geoLoc = geoLoc;
		this.zipCode = zipCode;
		this.fee = fee;
		this.repId = repId;
		this.commentA = commentA;
		this.commentB = commentB;
		this.rateA = rateA;
		this.rateB = rateB;
	}

	public final long getDateId() {
		return dateId;
	}

	public final String getUserAId() {
		return userAId;
	}

	public final String getUserBId() {
		return userBId;
	}

	public final String getDateTime() {
		return dateTime;
	}

	public final String getGeoLoc() {
		return geoLoc;
	}

	public final String getZipCode() {
		return zipCode;
	}

	public final double getFee() {
		return fee;
	}

	public final String getRepId() {
		return repId;
	}

	public final String getCommentA() {
		return commentA;
	}

	public final String getCommentB() {
		return commentB;
	}

	public final double getRateA() {
		return rateA;
	}

	public final double getRateB() {
		return rateB;
	}

}