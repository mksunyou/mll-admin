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
	//수집 코드 구현 - 삭제될 clientNo 호출
	String clientMail = request.getParameter("clientMail");
	System.out.println("삭제될 clientMail"+clientMail);//디버깅
	
	//dao 삭제메소드 코드 구현
	ClientDao.deleteClient(clientMail);
	
	response.sendRedirect(request.getContextPath()+"/clientList.jsp");	
%>
