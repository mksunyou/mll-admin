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
	
	request.setCharacterEncoding("UTF-8");
	
	String categoryName = request.getParameter("categoryName");
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookTitle = request.getParameter("ebookTitle");
	String ebookAuthor = request.getParameter("ebookAuthor");
	String ebookCompany = request.getParameter("ebookCompany");
	int ebookPageCount = Integer.parseInt(request.getParameter("ebookPageCount"));
	int ebookPrice =  Integer.parseInt(request.getParameter("ebookPrice"));
	String ebookSummary= request.getParameter("ebookSummary");
	
	//디버깅
	System.out.println(categoryName+"categoryName");
	System.out.println(ebookISBN+"ebookISBN");
	System.out.println(ebookTitle+"ebookTitle");
	System.out.println(ebookAuthor+"ebookAuthor");
	System.out.println(ebookCompany+"ebookCompany");
	System.out.println(ebookPageCount+"ebookPageCount");
	System.out.println(ebookPrice+"ebookPrice");
	System.out.println(ebookSummary+"ebookSummary");
	
	//전처리
	Ebook ebook = new Ebook();
	ebook.setCategoryName(categoryName);
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookTitle(ebookTitle);
	ebook.setEbookAuthor(ebookAuthor);
	ebook.setEbookCompany(ebookCompany);
	ebook.setEbookPageCount(ebookPageCount);
	ebook.setEbookPrice(ebookPrice);
	ebook.setEbookSummary(ebookSummary);
	
	//중복이 있으면 다시 입력폼으로 이동
	String returnEbookISBN = EbookDao.selectEbookISBN(ebookISBN);
	if(returnEbookISBN != null) {//이미 존재하는 ISBN이라면,
		System.out.println("사용중인 ISBN입니다.");
		response.sendRedirect(request.getContextPath()+"/insertEbookForm.jsp");
		return;
	}
	
	//중복이 없으면
	EbookDao.insertEbook(ebook);
	
	response.sendRedirect(request.getContextPath()+"/ebookList.jsp");
	
	
%>