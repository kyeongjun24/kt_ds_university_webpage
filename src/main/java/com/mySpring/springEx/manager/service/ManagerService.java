package com.mySpring.springEx.manager.service;

import org.springframework.dao.DataAccessException;

import com.mySpring.springEx.manager.vo.ManagerVO;

public interface ManagerService {

	public ManagerVO login(ManagerVO manager) throws DataAccessException;
	public int logLoginInfo(ManagerVO managerVO) throws DataAccessException;
	public int logLoginFailInfo(ManagerVO manager) throws DataAccessException;
	public int logLogoutInfo(ManagerVO managerVO) throws DataAccessException;

	public ManagerVO selectManager(String id);

	public int updateManager(ManagerVO manager);

	

}
