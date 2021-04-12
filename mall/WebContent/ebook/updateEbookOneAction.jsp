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
		String categoryName = request.getParameter("categoryName");
		String ebookTitle = request.getParameter("ebookTitle");
		String ebookAuthor = request.getParameter("ebookAuthor");
		String ebookCompany = request.getParameter("ebookCompany");
		int ebookPageCount = Integer.parseInt(request.getParameter("ebookPageCount"));
		int ebookPrice = Integer.parseInt(request.getParameter("ebookPrice"));
		String ebookSummary = request.getParameter("ebookSummary");
		String ebookState = request.getParameter("ebookState");
		
		//디버깅
		System.out.println("전체 수정 업데이트 ebookSummary의 ISBN"+ebookISBN);
		System.out.println("전체 수정 categoryName"+categoryName);
		System.out.println("전체 수정 ebookTitle"+ebookTitle);
		System.out.println("전체 수정 ebookAuthor"+ebookAuthor);
		System.out.println("전체 수정 ebookCompany"+ebookCompany);
		System.out.println("전체 수정 ebookPageCount"+ebookPageCount);
		System.out.println("전체 수정 ebookPrice"+ebookPrice);
		System.out.println("전체 수정 ebookSummary"+ebookSummary);
		
		Ebook ebook = new Ebook();
		ebook.setEbookState(ebookState);
		ebook.setCategoryName(categoryName);
		ebook.setEbookISBN(ebookISBN);
		ebook.setEbookTitle(ebookTitle);
		ebook.setEbookAuthor(ebookAuthor);
		ebook.setEbookCompany(ebookCompany);
		ebook.setEbookPageCount(ebookPageCount);
		ebook.setEbookPrice(ebookPrice);
		ebook.setEbookSummary(ebookSummary);
		
		EbookDao.updateEbookOne(ebook);
		
		response.sendRedirect(request.getContextPath()+"/ebookOne.jsp?ebookISBN="+ebookISBN);
%>
