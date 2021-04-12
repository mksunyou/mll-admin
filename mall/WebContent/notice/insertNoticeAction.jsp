<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*"%>

<%
	//관리자만 접근할 수 있게 하는 메소드 (level 2 이상만 공지 추가 가능함)
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 2) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}


	request.setCharacterEncoding("UTF-8");

	// 1-1\. 수집 코드

	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	String managerId = request.getParameter("managerId");
	
	// 1-2. 디버깅
	System.out.println("noticeTitle : " + noticeTitle);
	System.out.println("noticeContent : " + noticeContent);
	System.out.println("managerId : " +managerId);

	
	// 2-1. 전처리
	Notice notice = new Notice();
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	notice.setManagerId(managerId);

	// 2-2. 디버깅
	System.out.println("notice.noticeTitle : " + notice.getNoticeTitle());
	System.out.println("notice.noticeContent : " + notice.getNoticeContent());
	System.out.println("notice.managerId : " + notice.getManagerId());
	
	// 3. Dao에서 insert 메서드 호출
 	NoticeDao.insertNotice(notice);
	response.sendRedirect(request.getContextPath()+"/noticeList.jsp?"); 
%>