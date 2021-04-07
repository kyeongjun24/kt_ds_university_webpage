package com.mySpring.springEx.syllabus.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.mySpring.springEx.course.vo.CourseVO;
import com.mySpring.springEx.syllabus.vo.SyllabusVO;

public interface SyllabusService {

	public List listSyllabuses() throws DataAccessException;
	public int addSyllabus(SyllabusVO syllabusVO) throws DataAccessException;
	public int removeSyllabus(int id)  throws DataAccessException;
	public SyllabusVO selectSyllabus(int id) throws DataAccessException;
	public int updateSyllabus(SyllabusVO syllabusVO) throws DataAccessException;

}
