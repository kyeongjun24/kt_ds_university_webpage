package com.mySpring.springEx.enrollment.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mySpring.springEx.common.paging.Criteria;
import com.mySpring.springEx.course.vo.CourseVO;
import com.mySpring.springEx.enrollment.dao.EnrollmentDAO;
import com.mySpring.springEx.enrollment.vo.EnrollmentVO;

@Service("enrollmentService")
@Transactional(propagation = Propagation.REQUIRED)
public class EnrollmentServiceImpl implements EnrollmentService{
	
	@Autowired
	private EnrollmentDAO enrollmentDAO;
	
	@Override
	public void excelDownload(HttpServletResponse response) throws Exception {
		
		List <EnrollmentVO> enrollmentList = enrollmentDAO.excelEnrollmentList();
		
		try {
			//Excel Down 시작
            Workbook workbook = new HSSFWorkbook();
            //시트생성
			Sheet sheet = workbook.createSheet("list_excel");
			
			//행, 열, 열번호
            Row row = null;
            Cell cell = null;
            int rowNo = 0;
            
            // 테이블 헤더용 스타일
            CellStyle headStyle = workbook.createCellStyle();
    
            // 가는 경계선을 가집니다.
            headStyle.setBorderTop(BorderStyle.THIN);
            headStyle.setBorderBottom(BorderStyle.THIN);
            headStyle.setBorderLeft(BorderStyle.THIN);
            headStyle.setBorderRight(BorderStyle.THIN);
    
            // 배경색은 노란색입니다.
            headStyle.setFillForegroundColor(HSSFColorPredefined.YELLOW.getIndex());
            headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
    
            // 데이터는 가운데 정렬합니다.
            headStyle.setAlignment(HorizontalAlignment.CENTER);
    
            // 데이터용 경계 스타일 테두리만 지정
            CellStyle bodyStyle = workbook.createCellStyle();
            bodyStyle.setBorderTop(BorderStyle.THIN);
            bodyStyle.setBorderBottom(BorderStyle.THIN);
            bodyStyle.setBorderLeft(BorderStyle.THIN);
            bodyStyle.setBorderRight(BorderStyle.THIN);

            // 헤더 생성
            row = sheet.createRow(rowNo++);
    
            cell = row.createCell(0);
            cell.setCellStyle(headStyle);
            cell.setCellValue("번호");
    
            cell = row.createCell(1);
            cell.setCellStyle(headStyle);
            cell.setCellValue("강의명");
    
            cell = row.createCell(2);
            cell.setCellStyle(headStyle);
            cell.setCellValue("강의시작일");

            cell = row.createCell(3);
            cell.setCellStyle(headStyle);
            cell.setCellValue("강의종료일");
    
            cell = row.createCell(4);
            cell.setCellStyle(headStyle);
            cell.setCellValue("이름");
    
            cell = row.createCell(5);
            cell.setCellStyle(headStyle);
            cell.setCellValue("회사");
            
            cell = row.createCell(6);
            cell.setCellStyle(headStyle);
            cell.setCellValue("상태");
    
            cell = row.createCell(7);
            cell.setCellStyle(headStyle);
            cell.setCellValue("협약상태");
    
            cell = row.createCell(8);
            cell.setCellStyle(headStyle);
            cell.setCellValue("상태");
            
            cell = row.createCell(9);
            cell.setCellStyle(headStyle);
            cell.setCellValue("등록일");
			
            // 데이터 부분 생성
            for(EnrollmentVO excelData : enrollmentList) {
                
                row = sheet.createRow(rowNo++);
                
                cell = row.createCell(0);
                cell.setCellStyle(bodyStyle);
                cell.setCellValue(excelData.getId());
                
                cell = row.createCell(1);
                cell.setCellStyle(bodyStyle);
                cell.setCellValue(excelData.getSyllabusVO().getName());
                
                cell = row.createCell(2);
                cell.setCellStyle(bodyStyle);
                cell.setCellValue(excelData.getCourseVO().getStartDate());
                
                cell = row.createCell(3);
                cell.setCellStyle(bodyStyle);
                cell.setCellValue(excelData.getCourseVO().getEndDate());
                
                cell = row.createCell(4);
                cell.setCellStyle(bodyStyle);
                cell.setCellValue(excelData.getMemberVO().getName());
                
                cell = row.createCell(5);
                cell.setCellStyle(bodyStyle);
                cell.setCellValue(excelData.getMemberVO().getCompanyName());
                
                cell = row.createCell(6);
                cell.setCellStyle(bodyStyle);
                cell.setCellValue(excelData.getCompanyVO().getContractStat());
                
                cell = row.createCell(7);
                cell.setCellStyle(bodyStyle);
                cell.setCellValue(excelData.getCompanyVO().getContractStat());
                
                cell = row.createCell(8);
                cell.setCellStyle(bodyStyle);
                cell.setCellValue(excelData.getStat());
                
                cell = row.createCell(9);
                cell.setCellStyle(bodyStyle);
                cell.setCellValue(excelData.getJoinDate());
            }

            
            
            // 컨텐츠 타입과 파일명 지정
            response.setContentType("ms-vnd/excel");
            response.setHeader("Content-Disposition", "attachment;filename=enrollment_list.xls");

            // 엑셀 출력
            workbook.write(response.getOutputStream());
            workbook.close();
		} catch (IOException e) {
            e.printStackTrace();
        }

	}
	
	//기준 나누는 메서드 
	@Override
	public List listCriteria(Criteria criteria) throws DataAccessException {
		return enrollmentDAO.listCriteria(criteria);
	}
	
	//검색에 의해 나눠지는 메서드
	@Override
	public List listBySearchEnrollments(String searchType, String searchText) throws DataAccessException {
		List enrollmentsBySearchList = null;
		enrollmentsBySearchList = enrollmentDAO.selectBySearchEnrollmentList(searchType, searchText);
		return enrollmentsBySearchList;
	}
	
	//검색과 기준에 의해 리스트 나눠지는 메서드
	@Override
	public List listCriteriaBySearch(Criteria criteria) throws DataAccessException {
		List enrollmentsCriteriaBySearch = null;
		enrollmentsCriteriaBySearch = enrollmentDAO.selectCriteriaBySearch(criteria);
		return enrollmentsCriteriaBySearch;
	}
	
	//(등록관련) 수강신청 되어있는지 체크
	@Override
	public int checkEnrollment(EnrollmentVO enrollment) throws DataAccessException {
		return enrollmentDAO.checkEnrollment(enrollment);
	}

	
	//등록 페이지 리스트 출력
	@Override
	public List listSylCrs() throws DataAccessException {
		List sylCrsList = null;
		sylCrsList = enrollmentDAO.selectSylCrsList();
		return sylCrsList;
	}
	
	//등록 페이지 리스트 출력 (수정중)
	@Override
	public List exceptListSylCrs(String id) throws DataAccessException {
		List sylCrsList = null;
		sylCrsList = enrollmentDAO.selectExceptList(id);
		return sylCrsList;
	}
	
	//수강신청내역 리스트로 이동
	@Override
	public List listEnrollments() throws DataAccessException {
		List enrollmentsList = null;
		enrollmentsList = enrollmentDAO.selectAllEnrollmentList();
		return enrollmentsList;
	}
	
	//수강신청 등록
	@Override
	public int addEnrollment(EnrollmentVO enrollment) throws DataAccessException {
		return enrollmentDAO.insertEnrollment(enrollment);
	}
	
	//상세 접수내역 페이지로 이동
	@Override
	public EnrollmentVO selectEnrollment(int id) throws DataAccessException {
		return enrollmentDAO.selectEnrollment(id);
	}
	
	// 상세페이지 상태 수정
	@Override
	public int modEnrollment(EnrollmentVO enrollment) throws DataAccessException {
		
		enrollmentDAO.modEnrollmentCompany(enrollment);
		return enrollmentDAO.modEnrollmentStat(enrollment);
	}
	
	// 상태 '삭제' 로 수정
	@Override 
	public int updateDeleteEnrollments(int id) throws DataAccessException {
		return enrollmentDAO.updateDeleteEnrollments(id);
	}
	
	// 상태 '승인' 으로 수정
	@Override 
	public int updateApproveEnrollments(int id) throws DataAccessException {
		return enrollmentDAO.updateApproveEnrollments(id);
	}
		
	// 상태 '수료' 로 수정
	@Override 
	public int updateCompleteEnrollments(int id) throws DataAccessException {
		return enrollmentDAO.updateCompleteEnrollments(id);
	}
	
}
