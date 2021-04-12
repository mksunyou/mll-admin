<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%
	//관리자 인증 코드
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager==null || manager.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	//인코딩
	request.setCharacterEncoding("UTF-8");
	
	//수집코드
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String managerId = request.getParameter("managerId");
	String commentContent = request.getParameter("commentContent");
	
	//디버깅
	System.out.println("insert notice"+noticeNo+"managerId"+managerId+"commentContent"+commentContent);
	
	//전처리
	Comment comment = new Comment();
	comment.setNoticeNo(noticeNo);
	comment.setManagerId(managerId);
	comment.setCommentContent(commentContent);
	
	CommentDao.insertComment(comment);
	
	response.sendRedirect(request.getContextPath()+"/noticeOne.jsp?noticeNo="+noticeNo);
	
	
%>