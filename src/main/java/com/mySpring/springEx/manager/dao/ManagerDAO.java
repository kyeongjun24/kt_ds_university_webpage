package com.mySpring.springEx.manager.dao;

import org.springframework.dao.DataAccessException;

import com.mySpring.springEx.manager.vo.ManagerVO;

public interface ManagerDAO {

	public ManagerVO loginById(ManagerVO managerVO) throws DataAccessException;

}
