package com.mySpring.springEx.enrollment.vo;

import org.springframework.stereotype.Component;

@Component("enrollmentScheduleVO")
public class EnrollmentScheduleVO {


	private String enrsStartDate;
	private String enrsEndDate;
	
	
	public EnrollmentScheduleVO() {
	}

	public EnrollmentScheduleVO(String enrsStartDate, String enrsEndDate) {
		this.enrsStartDate = enrsStartDate;
		this.enrsEndDate = enrsEndDate;
	}

	public String getEnrsStartDate() {
		return enrsStartDate;
	}

	public void setEnrsStartDate(String enrsStartDate) {
		this.enrsStartDate = enrsStartDate;
	}

	public String getEnrsEndDate() {
		return enrsEndDate;
	}

	public void setEnrsEndDate(String enrsEndDate) {
		this.enrsEndDate = enrsEndDate;
	}

}
