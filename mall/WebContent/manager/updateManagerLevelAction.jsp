<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%
	//include는 눈에 보이는것만! 눈에 보이지 않으면 include 사용 X.
	//로그인이 되어있지 않거나 매니저 레벨이 2 미만일때 return.
	Manager manager =(Manager)(session.getAttribute("sessionManager"));
	if(manager==null) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if(manager.getManagerLevel() < 2) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	//수집 코드 구현
	int managerNo=Integer.parseInt(request.getParameter("managerNo"));
	int managerLevel=Integer.parseInt(request.getParameter("managerLevel"));
	System.out.println(managerNo);//디버깅
	System.out.println(managerLevel);//디버깅
	
	//dao 수정메소드 호출 수정 코드 구현
	ManagerDao.updateManagerLevel(managerNo, managerLevel);
	
	response.sendRedirect(request.getContextPath()+"/manager/managerList.jsp");
%>
