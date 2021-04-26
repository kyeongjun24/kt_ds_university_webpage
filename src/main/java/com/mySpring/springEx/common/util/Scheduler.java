package com.mySpring.springEx.common.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.mySpring.springEx.course.dao.CourseDAO;

@Component
public class Scheduler{ 
	
	@Autowired
	CourseDAO courseDAO;
	
	/** * 1. 오후 오후 20:38:00에 호출이 되는 스케쥴러 */ 
	@Scheduled(cron = "00 38 20 * * *") 
	public void cronTest1(){ 
		System.out.println("오후 20:38:00에 호출이 됩니다 ");
		int result = courseDAO.updateCourseStatusByDate();
		} 
	
	
	/** * 2. 오후 20:45:00에 호출이 되는 스케쥴러 */
	@Scheduled(cron = "00 45 20 * * *") 
	public void cronTest2(){ 
		System.out.println("오후 20:45:00에 호출이 됩니다 ");
		int result = courseDAO.updateCourseStatusByNumOfApplicants();
		} 
}
