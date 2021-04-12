package com.mySpring.springEx.board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.mySpring.springEx.board.vo.ArticleVO;

public interface BoardController {
	
	public ModelAndView listArticles(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView selectArticle(@ModelAttribute("id") int id, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView insertNewArticle(@RequestParam("articleMap") ArticleVO articleVO, HttpServletRequest request,HttpServletResponse response) throws Exception;
	
	
	/*
	 * public ModelAndView viewArticle(@RequestParam("id") int id,
	 * HttpServletRequest request, HttpServletResponse response) throws Exception;
	 * public ResponseEntity addNewArticle(MultipartHttpServletRequest multipartRequest,HttpServletResponse response) throws Exception; 
	 * public ResponseEntity modArticle(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception; public ResponseEntity
	 * removeArticle(@RequestParam("id") int id, HttpServletRequest request, HttpServletResponse response) throws Exception;
	 */

}