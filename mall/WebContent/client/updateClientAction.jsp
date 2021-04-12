<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%
	Manager manager = (Manager)(session.getAttribute("sessionManager"));
	if(manager==null) {//로그인이 되어있지 않은 상태.
		response.sendRedirect(request.getContextPath()+"adminIndex.jsp");
		return;
	} else if(manager.getManagerLevel() < 2) {
		response.sendRedirect(request.getContextPath()+"adminIndex.jsp");
		return;	
	}
	
	//수집 코드 구현
	String clientPw = request.getParameter("clientPw");
	System.out.println(clientPw);
	
	ClientDao.updateClientPw(clientPw);
	
	response.sendRedirect(request.getContextPath()+"/clientList.jsp");	

%>