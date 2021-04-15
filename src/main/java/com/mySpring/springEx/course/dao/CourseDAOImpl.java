package com.mySpring.springEx.course.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.mySpring.springEx.course.vo.CourseVO;
import com.mySpring.springEx.member.vo.MemberVO;

@Repository("CourseDAO")
public class CourseDAOImpl implements CourseDAO{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List selectAllCourseList() throws DataAccessException {
		List<CourseVO> courseList = null;
		courseList = sqlSession.selectList("mapper.course.selectAllCoursesList");
		return courseList;
	}
	
	@Override
	public List selectBySearchCourseList(String searchType, String searchText) throws DataAccessException {
		List<CourseVO> coursesBySearchList = null;
		Map<String, String> mapSearch = new HashMap<String, String>();
		mapSearch.put("searchType", searchType);
		mapSearch.put("searchText", searchText);
		coursesBySearchList = sqlSession.selectList("mapper.course.selectBySearchCourseList", mapSearch);
		return coursesBySearchList;
	}

//	@Override
//	public int insertCourse(CourseVO courseVO)  throws DataAccessException{
//		int result = sqlSession.insert("mapper.course.insertCourse", courseVO);
//		System.out.println(courseVO.getId());
//		System.out.println(courseVO.getCapacity());
//		System.out.println(courseVO.getClassroom());
//		System.out.println(courseVO.getEndDate());
//		System.out.println(courseVO.getEndTime());
//		System.out.println(courseVO.getBannerImg());
//		System.out.println(courseVO.getJoinDate());
//		System.out.println(courseVO.getReDate());
//		return result;
//		
//	}

	//--------------------------------------------------------------
	@Override
	public int insertCourse(Map courseMap) throws DataAccessException {
		int id = selectCourse();
		System.out.println(id);
		courseMap.put("id", id);
		sqlSession.insert("mapper.course.insertCourse",courseMap);
		return id;
	}
	
	private int selectCourse() throws DataAccessException {
		return sqlSession.selectOne("mapper.course.selectCourse");
	}
	
	//-------------------------------------------------------------------
	@Override
	public int deleteCourse(int id) throws DataAccessException {
		int result = sqlSession.delete("mapper.course.deleteCourse", id);
		return result;
	}

//	@Override
//	public CourseVO selectCourse(int id) throws DataAccessException {
//		CourseVO vo = sqlSession.selectOne("mapper.course.selectCourse", id);
//		return vo;
//	}

	@Override
	public int updateCourse(CourseVO courseVO) throws DataAccessException {
		int result = sqlSession.update("mapper.course.updateCourse", courseVO);
		return result;
	}


	
}
