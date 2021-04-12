<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%
	//로그인이 되어있지 않거나 매니저 레벨이 1 미만일때 adminIndex로 돌려보냄. return.
	Manager manager =(Manager)(session.getAttribute("sessionManager"));

	if(manager==null) {
		
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
		
	} else if(manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	//수집 코드 구현
	int categoryNo=Integer.parseInt(request.getParameter("categoryNo"));
	int categoryWeight=Integer.parseInt(request.getParameter("categoryWeight"));
	System.out.println("수정될 categoryNo"+categoryNo);//디버깅
	System.out.println("수정될 categoryWeight"+categoryWeight);//디버깅
	
	//dao 수정 메소드 호출 수정 코드 구현
	CategoryDao.updateCategoryWeight(categoryNo, categoryWeight);
	
	response.sendRedirect(request.getContextPath()+"/categoryList.jsp");
%>