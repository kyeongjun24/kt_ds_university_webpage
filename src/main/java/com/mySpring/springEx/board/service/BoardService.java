package com.mySpring.springEx.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.mySpring.springEx.board.vo.ArticleVO;
import com.mySpring.springEx.board.vo.ArticleFileVO;

public interface BoardService {
	
	public List<ArticleVO> listArticles() throws Exception;
	public ArticleVO selectArticle(int id) throws DataAccessException;
	public int insertNewArticle(Map articleMap) throws Exception;
	
	/*public ArticleVO viewArticle(int articleNO) throws Exception;
		public Map viewArticle(int id) throws Exception;
	 * public void modArticle(Map articleMap) throws Exception; public void
	 * removeArticle(int id) throws Exception;
	 */
}