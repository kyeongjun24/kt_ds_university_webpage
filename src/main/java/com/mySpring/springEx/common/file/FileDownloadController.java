package com.mySpring.springEx.common.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mySpring.springEx.board.service.BoardService;
import com.mySpring.springEx.board.vo.ArticleVO;
import com.mySpring.springEx.board.vo.ArticleFileVO;

@Controller
public class FileDownloadController {
	private static final String ARTICLE_FILE_REPO = "C:\\Users\\lho16\\git workspace\\uni17_admin\\src\\main\\webapp\\resources\\articleFile";
	@RequestMapping("fileDown.do")
	   public ModelAndView filedown(HttpServletRequest request, String filename) throws Exception {
	      
		 String id = request.getParameter("id");
		 System.out.println(id);
		 System.out.println("filename :: " + filename);
	     String path = ARTICLE_FILE_REPO + "\\" + id + "\\";
	      
	      HashMap map = new HashMap();
	      map.put("path", path); 
	      
	   
	      return new ModelAndView("downloadView", map); 

	   }

}
