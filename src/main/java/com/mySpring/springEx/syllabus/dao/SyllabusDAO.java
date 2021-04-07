package com.mySpring.springEx.syllabus.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.mySpring.springEx.course.vo.CourseVO;
import com.mySpring.springEx.syllabus.vo.SyllabusVO;


public interface SyllabusDAO {

	public List selectAllSyllabusList() throws DataAccessException;
	public int insertSyllabus(SyllabusVO syllabusVO) throws DataAccessException;
	public int deleteSyllabus(int id) throws DataAccessException;
	public SyllabusVO selectSyllabus(int id) throws DataAccessException;
	public int updateSyllabus(SyllabusVO syllabusVO) throws DataAccessException;

}
