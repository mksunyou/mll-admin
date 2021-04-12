<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	// 관리자만 접근할 수 있게 하는 메소드 
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}
	
	//수집코드
	String managerId = request.getParameter("managerId");
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	//디버깅
	System.out.println("deleteCommentAction mangerId:"+managerId+"commentNo:"+commentNo+"noticeNo"+noticeNo);
	
	
	if(manager.getManagerLevel() > 1) {//manager.managerLevel == 2
		CommentDao.deleteComment(commentNo);
			
	} else if (manager.getManagerLevel() > 0) {//manager.managerLevel == 1
		CommentDao.deleteComment(commentNo, managerId);
	}
		
	response.sendRedirect(request.getContextPath()+"/noticeOne.jsp?noticeNo="+noticeNo);
%>
