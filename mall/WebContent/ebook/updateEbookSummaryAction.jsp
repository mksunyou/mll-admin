<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%
	//encoding
	request.setCharacterEncoding("UTF-8");
	
	//접근 권한
	Manager manager = (Manager)(session.getAttribute("sessionManager"));
	if(manager==null) {//로그인이 되어있지 않은 상태.
		response.sendRedirect(request.getContextPath()+"adminIndex.jsp");
		return;
	} else if(manager.getManagerLevel() < 2) {
		response.sendRedirect(request.getContextPath()+"adminIndex.jsp");
		return;	
	}	
	
	//수집코드 구현
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookSummary = request.getParameter("ebookSummary");
	
	//디버깅
	System.out.println("수정될 ebookSummary의 ISBN"+ebookISBN);
	System.out.println("수정될 ebookSummary"+ebookSummary);
	
	Ebook ebook = new Ebook();
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookSummary(ebookSummary);
	
	EbookDao.updateEbookSummary(ebook);
	
	response.sendRedirect(request.getContextPath()+"/ebookOne.jsp?ebookISBN="+ebookISBN);
%>