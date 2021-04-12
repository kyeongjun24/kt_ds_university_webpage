package com.mySpring.springEx.board.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.mySpring.springEx.board.vo.ArticleVO;
import com.mySpring.springEx.board.vo.ArticleFileVO;


public interface BoardDAO {
	
	public List selectAllArticlesList() throws DataAccessException;
	public ArticleVO selectArticle(int id) throws DataAccessException;
	public int insertNewArticle(Map articleMap) throws DataAccessException;
	
	
	//public void insertNewImage(Map articleMap) throws DataAccessException;
	/* public void updateArticle(Map articleMap) throws DataAccessException; */
	/* public void deleteArticle(int id) throws DataAccessException; */
	/* public List selectImageFileList(int id) throws DataAccessException; */
	
}