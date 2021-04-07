package com.mySpring.springEx.syllabus.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;

import com.mySpring.springEx.course.vo.CourseVO;
import com.mySpring.springEx.syllabus.vo.SyllabusVO;


@Repository("syllabusDAO")
public class SyllabusDAOImpl implements SyllabusDAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List selectAllSyllabusList() throws DataAccessException {
		List<SyllabusVO> syllabusesList = null;
		syllabusesList = sqlSession.selectList("mapper.syllabus.selectAllSyllabusList");
		return syllabusesList;
	}

	@Override
	public int insertSyllabus(SyllabusVO syllabusVO) throws DataAccessException {
		int result = sqlSession.insert("mapper.syllabus.insertSyllabus", syllabusVO);
		return result;
	}

	@Override
	public int deleteSyllabus(int id) throws DataAccessException {
		int result = sqlSession.delete("mapper.syllabus.deleteSyllabus", id);
		return result;
	}

	@Override
	public SyllabusVO selectSyllabus(int id) throws DataAccessException {
		SyllabusVO syllabusVO = sqlSession.selectOne("mapper.syllabus.selectSyllabus", id);
		return syllabusVO;
	}

	@Override
	public int updateSyllabus(SyllabusVO syllabusVO) throws DataAccessException {
		int result = sqlSession.update("mapper.syllabus.updateSyllabus", syllabusVO);
		return result;
	}
}
