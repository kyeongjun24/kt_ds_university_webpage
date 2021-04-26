package com.mySpring.springEx.common.file;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class FileDownloadController {
	private static final String ARTICLE_IMAGE_REPO = "E:\\spring-workspace\\admin\src\\main\\webapp\\resources\\image\\";
	
	@RequestMapping("fileDown.do")
	public ModelAndView filedown(HttpServletRequest request, String filename, String folderName) throws Exception {
		String path = ARTICLE_IMAGE_REPO;
		path += folderName+"\\";
		
		HashMap map = new HashMap();
		map.put("path", path); 
		
		return new ModelAndView("downloadView", map); 

	}
}
