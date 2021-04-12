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
	
	//수집코드
	String categoryName = request.getParameter("categoryName");//삭제될 categoryName호출
	System.out.println("삭제될 categoryName: "+categoryName);//삭제 디버깅
	
	//dao 삭제 메소드 호출 코드 구현
	CategoryDao.deleteCategory(categoryName);
	
	//삭제 후 다시 categoryList로 이동.
	response.sendRedirect(request.getContextPath()+"/categoryList.jsp");
	
	
%>