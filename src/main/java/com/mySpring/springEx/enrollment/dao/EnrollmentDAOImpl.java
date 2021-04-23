package com.mySpring.springEx.enrollment.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.mySpring.springEx.common.paging.Criteria;
import com.mySpring.springEx.course.vo.CourseVO;
import com.mySpring.springEx.enrollment.vo.EnrollmentVO;
import com.mySpring.springEx.member.vo.MemberVO;

@Repository("enrollmentDAO")
public class EnrollmentDAOImpl implements EnrollmentDAO{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List selectBySearchEnrollmentList(String searchType, String searchText) throws DataAccessException {
		List<EnrollmentVO> enrollmentsBySearchList = null;
		Map<String, String> mapSearch = new HashMap<String, String>();
		mapSearch.put("searchType", searchType);
		mapSearch.put("searchText", searchText);
		enrollmentsBySearchList = sqlSession.selectList("mapper.enrollment.selectBySearchEnrollmentList", mapSearch);
		return enrollmentsBySearchList;
	}
	
	// ������ ���� ���� �޼���
	@Override
	public List<EnrollmentVO> listCriteria(Criteria criteria) throws DataAccessException {
		return sqlSession.selectList("mapper.enrollment.listCriteria", criteria);
	}
	
	//criteria�� ���� ����Ʈ ������ �޼���
	@Override
	public List selectCriteriaBySearch(Criteria criteria) throws DataAccessException {
		return sqlSession.selectList("mapper.enrollment.selectCriteriaBySearchEnrollmentList", criteria);
	}
	
	//����¡ ����Ʈ �̾ƿ��� �޼���
	@Override
	public List<EnrollmentVO> listPaging(int page) throws DataAccessException {
		if (page <= 0) {
			page = 1;
		}
		page = (page - 1) * 10;
		return sqlSession.selectList("mapper.enrollment.selectEnrollmentListByPaging", page);
	}
	
////////////////////////////////////////////////	
	
	//��� ������ ����Ʈ ���
	@Override
	public List selectSylCrsList() throws DataAccessException {
		List<EnrollmentVO> sylCrsList = null;
		sylCrsList = sqlSession.selectList("mapper.enrollment.syllabusCourseEnrollment");
		return sylCrsList;
	}
	
	//��� ������ ����Ʈ ��� (����)
	@Override
	public List selectExceptList(String id) throws DataAccessException {
		List<EnrollmentVO> sylCrsList = null;
		sylCrsList = sqlSession.selectList("mapper.enrollment.exceptEnrollment", id);
		return sylCrsList;
	}
	
	//(��ϰ���) ������û �Ǿ��ִ��� üũ
	public int checkEnrollment(EnrollmentVO enrollmentVO)  throws DataAccessException{
		int result = sqlSession.insert("mapper.enrollment.checkEnrollment", enrollmentVO);
		return result;
	}
	
	// List page
	@Override
	public List selectAllEnrollmentList() throws DataAccessException {
		List<EnrollmentVO> enrollmentsList = null;
		enrollmentsList = sqlSession.selectList("mapper.enrollment.selectAllEnrollmentList");
		return enrollmentsList;
	}
	

	// Detail page --> course
	@Override
	public List enrollmentCourse(int id) throws DataAccessException {
		List<EnrollmentVO> enrollmentsList = null;
		enrollmentsList = sqlSession.selectList("mapper.enrollment.enrollmentCourse", id);
		return enrollmentsList;
	}
	
	//���� �ٿ·ε�
	@Override
	public List excelEnrollmentList() throws DataAccessException {
		List<EnrollmentVO> enrollmentsList = null;
		enrollmentsList = sqlSession.selectList("mapper.enrollment.excelEnrollmentList");
		return enrollmentsList;
	}
	

	
	//������û ���
	@Override
	public int insertEnrollment(EnrollmentVO enrollmentVO)  throws DataAccessException{
		int result = sqlSession.insert("mapper.enrollment.addEnrollment", enrollmentVO);
		return result;
	}
	
	// Detail page --> member
	@Override
	public EnrollmentVO enrollmentMember(int id) throws DataAccessException {
		EnrollmentVO vo = sqlSession.selectOne("mapper.enrollment.enrollmentMember", id);
		return vo;
	}
	
	
	
	// �������� (ȸ��) ����
	@Override
	public int modEnrollmentCompany(EnrollmentVO enrollmentVO)  throws DataAccessException{
		int result = sqlSession.update("mapper.enrollment.modEnrollmentCompany", enrollmentVO);
		
		System.out.println(result);
		System.out.println(enrollmentVO.getId());
		return result;
	}
	
	// �������� (����) ����
	@Override
	public int modEnrollmentStat(EnrollmentVO enrollmentVO)  throws DataAccessException{
		int result = sqlSession.update("mapper.enrollment.modEnrollmentStat", enrollmentVO);
		return result;
	}
	
	// ���� '����' �� ����
	@Override
	public int updateDeleteEnrollments(int id) throws DataAccessException {
		int result = sqlSession.update("mapper.enrollment.updateDeleteEnrollments", id);
		return result;
	}
	
	// ���� '����' ���� ����
	@Override
	public int updateApproveEnrollments(int id) throws DataAccessException {
		int result = sqlSession.update("mapper.enrollment.updateApproveEnrollments", id);
		return result;
	}
		
	// ���� '����' ���� ����
	@Override
	public int updateCompleteEnrollments(int id) throws DataAccessException {
		int result = sqlSession.update("mapper.enrollment.updateCompleteEnrollments", id);
		return result;
	}
	
}
