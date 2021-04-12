package com.mySpring.springEx.board.vo;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Date;

import org.springframework.stereotype.Component;

//공지사항 파일 VO
@Component("articleFileVO")
public class ArticleFileVO {
	private int id;
	private String name;
	private int artId;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public int getartId() {
		return artId;
	}
	public void setartId(int artId) {
		this.artId = artId;
	}


}