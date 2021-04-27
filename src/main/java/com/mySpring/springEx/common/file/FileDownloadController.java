package com.mySpring.springEx.common.file;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class FileDownloadController {
	private static final String ARTICLE_IMAGE_REPO = "E:\\spring-workspace\\admin\src\\main\\webapp\\resources\\image\\";
	private static final String ARTICLE_FILE_REPO = "C:\\Users\\lho16\\git workspace\\uni17_admin\\src\\main\\webapp\\resources\\articleFile";

	@RequestMapping("fileDown.do")
	public ModelAndView filedown(HttpServletRequest request, String filename, String folderName) throws Exception {
		String path = ARTICLE_IMAGE_REPO;
		path += folderName + "\\";

		HashMap map = new HashMap();
		map.put("path", path);

		return new ModelAndView("downloadView", map);
	}

	@RequestMapping("articleFileDown.do")
	public ModelAndView articleFiledown(HttpServletRequest request, String filename) throws Exception {

		String id = request.getParameter("id");
		System.out.println(id);
		System.out.println("filename :: " + filename);
		String path = ARTICLE_FILE_REPO + "\\" + id + "\\";

		HashMap map = new HashMap();
		map.put("path", path);

		return new ModelAndView("downloadView", map);

	}

}
