package com.mySpring.springEx.manager.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.mySpring.springEx.manager.vo.ManagerVO;

@Repository("managerDAO")
public class ManagerDAOImpl implements ManagerDAO{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public ManagerVO loginById(ManagerVO managerVO) throws DataAccessException {
		ManagerVO vo = sqlSession.selectOne("mapper.manager.loginById", managerVO);
		System.out.println(managerVO.getId());
		return vo;
	}

}
