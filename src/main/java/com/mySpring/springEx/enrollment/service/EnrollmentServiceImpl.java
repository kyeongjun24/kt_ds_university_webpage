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
	

	
	//���� ������ �޼��� 
	@Override
	public List listCriteria(Criteria criteria) throws DataAccessException {
		return enrollmentDAO.listCriteria(criteria);
	}
	
	//�˻��� ���� �������� �޼���
	@Override
	public List listBySearchEnrollments(String searchType, String searchText) throws DataAccessException {
		List enrollmentsBySearchList = null;
		enrollmentsBySearchList = enrollmentDAO.selectBySearchEnrollmentList(searchType, searchText);
		return enrollmentsBySearchList;
	}
	
	//�˻��� ���ؿ� ���� ����Ʈ �������� �޼���
	@Override
	public List listCriteriaBySearch(Criteria criteria) throws DataAccessException {
		List enrollmentsCriteriaBySearch = null;
		enrollmentsCriteriaBySearch = enrollmentDAO.selectCriteriaBySearch(criteria);
		return enrollmentsCriteriaBySearch;
	}
	
	//(��ϰ���) ������û �Ǿ��ִ��� üũ
	@Override
	public int checkEnrollment(EnrollmentVO enrollment) throws DataAccessException {
		return enrollmentDAO.checkEnrollment(enrollment);
	}

	
	//��� ������ ����Ʈ ���
	@Override
	public List listSylCrs() throws DataAccessException {
		List sylCrsList = null;
		sylCrsList = enrollmentDAO.selectSylCrsList();
		return sylCrsList;
	}
	
	//��� ������ ����Ʈ ��� (������)
	@Override
	public List exceptListSylCrs(String id) throws DataAccessException {
		List sylCrsList = null;
		sylCrsList = enrollmentDAO.selectExceptList(id);
		return sylCrsList;
	}
	
	// List page
	@Override
	public List listEnrollments() throws DataAccessException {
		List enrollmentsList = null;
		enrollmentsList = enrollmentDAO.selectAllEnrollmentList();
		return enrollmentsList;
	}
	
	//������û ���
	@Override
	public int addEnrollment(EnrollmentVO enrollment) throws DataAccessException {
		return enrollmentDAO.insertEnrollment(enrollment);
	}
	
	// Detail page --> member
	@Override
	public EnrollmentVO selectEnrollment(int id) throws DataAccessException {
		return enrollmentDAO.enrollmentMember(id);
	}
	
	// Detail page --> course
	@Override
	public List enrollmentCourse(int id) throws DataAccessException {
		List enrollmentsList = null;
		enrollmentsList = enrollmentDAO.enrollmentCourse(id);
		return enrollmentsList;
	}
	
	// �������� ���� ����
	@Override
	public int modEnrollment(EnrollmentVO enrollment) throws DataAccessException {
		
		enrollmentDAO.modEnrollmentCompany(enrollment);
		return enrollmentDAO.modEnrollmentStat(enrollment);
	}
	
	// ���� '����' �� ����
	@Override 
	public int updateDeleteEnrollments(int id) throws DataAccessException {
		return enrollmentDAO.updateDeleteEnrollments(id);
	}
	
	// ���� '����' ���� ����
	@Override 
	public int updateApproveEnrollments(int id) throws DataAccessException {
		return enrollmentDAO.updateApproveEnrollments(id);
	}
		
	// ���� '����' �� ����
	@Override 
	public int updateCompleteEnrollments(int id) throws DataAccessException {
		return enrollmentDAO.updateCompleteEnrollments(id);
	}
	
	// excel
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
            cell.setCellValue("아이디");
    
            cell = row.createCell(2);
            cell.setCellStyle(headStyle);
            cell.setCellValue("이름");

            cell = row.createCell(3);
            cell.setCellStyle(headStyle);
            cell.setCellValue("전화번호");
    
            cell = row.createCell(4);
            cell.setCellStyle(headStyle);
            cell.setCellValue("이메일");
    
            cell = row.createCell(5);
            cell.setCellStyle(headStyle);
            cell.setCellValue("회사");
            
            cell = row.createCell(6);
            cell.setCellStyle(headStyle);
            cell.setCellValue("과정명");
    
            cell = row.createCell(7);
            cell.setCellStyle(headStyle);
            cell.setCellValue("진행일자");
    
            cell = row.createCell(8);
            cell.setCellStyle(headStyle);
            cell.setCellValue("상태");
            
            cell = row.createCell(9);
            cell.setCellStyle(headStyle);
            cell.setCellValue("신청일");
			
            //열 너비
            sheet.setColumnWidth(0, 2000);
            sheet.setColumnWidth(1, 3500);
            sheet.setColumnWidth(2, 3500);
            sheet.setColumnWidth(3, 3500);
            sheet.setColumnWidth(4, 3500);
            sheet.setColumnWidth(5, 3500);
            sheet.setColumnWidth(6, 3500);
            sheet.setColumnWidth(7, 3500);
            sheet.setColumnWidth(8, 3500);
            sheet.setColumnWidth(9, 3500);
            
            int i = 0;
            // 데이터 부분 생성
            for(EnrollmentVO excelData : enrollmentList) {
                
                row = sheet.createRow(rowNo++);
                i = i + 1;
                
                cell = row.createCell(0);
                cell.setCellStyle(bodyStyle);
                cell.setCellValue(i);
                
                cell = row.createCell(1);
                cell.setCellStyle(bodyStyle);
                cell.setCellValue(excelData.getMemberVO().getId());
                
                cell = row.createCell(2);
                cell.setCellStyle(bodyStyle);
                cell.setCellValue(excelData.getMemberVO().getName());
                
                cell = row.createCell(3);
                cell.setCellStyle(bodyStyle);
                cell.setCellValue(excelData.getMemberVO().getPhone());
                
                cell = row.createCell(4);
                cell.setCellStyle(bodyStyle);
                cell.setCellValue(excelData.getMemberVO().getEmail());
                
                cell = row.createCell(5);
                cell.setCellStyle(bodyStyle);
                cell.setCellValue(excelData.getMemberVO().getCompanyName());
                
                cell = row.createCell(6);
                cell.setCellStyle(bodyStyle);
                cell.setCellValue(excelData.getSyllabusVO().getName());
                
                cell = row.createCell(7);
                cell.setCellStyle(bodyStyle);
                cell.setCellValue(excelData.getCourseVO().getStartDate() + " ~ " + excelData.getCourseVO().getStartDate());
                
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
	
}
