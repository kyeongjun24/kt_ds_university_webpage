package com.mySpring.springEx.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mySpring.springEx.board.dao.BoardDAO;
import com.mySpring.springEx.board.vo.ArticleVO;
import com.mySpring.springEx.board.vo.ArticleFileVO;

@Service("boardService")
@Transactional(propagation = Propagation.REQUIRED)
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardDAO boardDAO;

	// 공지사항 리스트
	public List<ArticleVO> listArticles() throws Exception {
		List<ArticleVO> articlesList = boardDAO.selectAllArticlesList();
		return articlesList;
	}

	// 공지사항 선택
	@Override
	public ArticleVO selectArticle(int id) throws DataAccessException {
		return boardDAO.selectArticle(id);
	}

	// 공지사항 추가
	@Override
	public int insertNewArticle(Map articleMap) throws Exception {
		return boardDAO.insertNewArticle(articleMap);
	}
	
	/*
	 * @Override public Map viewArticle(int id) throws Exception { Map articleMap =
	 * new HashMap(); ArticleVO articleVO = boardDAO.selectArticle(id);
	 * List<ImageVO> imageFileList = boardDAO.selectImageFileList(id);
	 * articleMap.put("article", articleVO); articleMap.put("imageFileList",
	 * imageFileList); return articleMap; }
	 */

	// 占쏙옙占쏙옙 占싱뱄옙占쏙옙 占쌩곤옙占싹깍옙
	/*
	 * @Override public int addNewArticle(Map articleMap) throws Exception{ int
	 * articleNO = boardDAO.insertNewArticle(articleMap);
	 * articleMap.put("articleNO", articleNO); boardDAO.insertNewImage(articleMap);
	 * return articleNO; }
	 */

	// 占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙占싱깍옙

	/*
	 * //占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙占싱깍옙
	 * 
	 * @Override public ArticleVO viewArticle(int articleNO) throws Exception {
	 * ArticleVO articleVO = boardDAO.selectArticle(articleNO); return articleVO; }
	 */

	/*
	 * @Override public void modArticle(Map articleMap) throws Exception {
	 * boardDAO.updateArticle(articleMap); }
	 * 
	 * @Override public void removeArticle(int id) throws Exception {
	 * boardDAO.deleteArticle(id); }
	 */

}