package com.mySpring.springEx.syllabus.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mySpring.springEx.course.vo.CourseVO;
import com.mySpring.springEx.syllabus.dao.SyllabusDAO;
import com.mySpring.springEx.syllabus.vo.SyllabusVO;

@Service("syllabusService")
@Transactional(propagation = Propagation.REQUIRED)
public class SyllabusServiceImpl implements SyllabusService{
	
	@Autowired
	private SyllabusDAO syllabusDAO;
	
	@Override
	public List listSyllabuses() throws DataAccessException {
		List syllabusesList = null;
		syllabusesList = syllabusDAO.selectAllSyllabusList();
		return syllabusesList;
	}

	@Override
	public int addSyllabus(SyllabusVO syllabusVO) throws DataAccessException {
		return syllabusDAO.insertSyllabus(syllabusVO);
	}

	@Override
	public int removeSyllabus(int id) throws DataAccessException {
		return syllabusDAO.deleteSyllabus(id);
	}

	@Override
	public SyllabusVO selectSyllabus(int id) throws DataAccessException {
		return syllabusDAO.selectSyllabus(id);
	}

	@Override
	public int updateSyllabus(SyllabusVO syllabusVO) throws DataAccessException {
		return syllabusDAO.updateSyllabus(syllabusVO);
	}

}
