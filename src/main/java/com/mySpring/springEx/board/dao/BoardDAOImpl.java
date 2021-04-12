package com.mySpring.springEx.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.mySpring.springEx.board.vo.ArticleVO;
import com.mySpring.springEx.board.vo.ArticleFileVO;


@Repository("boardDAO")
public class BoardDAOImpl implements BoardDAO {
	
	@Autowired
	private SqlSession sqlSession;

	// 공지사항 리스트
	@Override
	public List selectAllArticlesList() throws DataAccessException {
		List<ArticleVO> articlesList = sqlSession.selectList("mapper.board.selectAllArticlesList");
		return articlesList;
	}

	// 공지사항 선택
	@Override
	public ArticleVO selectArticle(int id) throws DataAccessException {
		ArticleVO vo = sqlSession.selectOne("mapper.board.selectArticle", id);
		return vo;
	}
	
	// 공지사항 추가
	@Override
	public int insertNewArticle(Map articleMap) throws DataAccessException {
		int id = selectNewId();
		System.out.println(id);
		articleMap.put("id", id);
		sqlSession.insert("mapper.board.insertNewArticle",articleMap);
		return id;
	}
    
	//占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙占싸듸옙
	/*
	@Override
	public void insertNewImage(Map articleMap) throws DataAccessException {
		List<ImageVO> imageFileList = (ArrayList)articleMap.get("imageFileList");
		int articleNO = (Integer)articleMap.get("articleNO");
		int imageFileNO = selectNewImageFileNO();
		for(ImageVO imageVO : imageFileList){
			imageVO.setImageFileNO(++imageFileNO);
			imageVO.setArticleNO(articleNO);
		}
		sqlSession.insert("mapper.board.insertNewImage",imageFileList);
	}
	
   */
	


	/*
	 * @Override public void updateArticle(Map articleMap) throws
	 * DataAccessException { sqlSession.update("mapper.board.updateArticle",
	 * articleMap); }
	 * 
	 * @Override public void deleteArticle(int id) throws DataAccessException {
	 * sqlSession.delete("mapper.board.deleteArticle", id); }
	 */
	
	private int selectNewId() throws DataAccessException {
		return sqlSession.selectOne("mapper.board.selectNewId");
	}
	
	/*
	 * @Override public List selectImageFileList(int id) throws DataAccessException
	 * { List<ImageVO> imageFileList = null; imageFileList =
	 * sqlSession.selectList("mapper.board.selectImageFileList",id); return
	 * imageFileList; }
	 */
	
	/*
	 * private int selectNewImageFileNO() throws DataAccessException { return
	 * sqlSession.selectOne("mapper.board.selectNewImageFileNO"); }
	 */

}
