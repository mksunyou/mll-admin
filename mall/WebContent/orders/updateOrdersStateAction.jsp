<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%
	//encoding
	request.setCharacterEncoding("UTF-8");
	
	//접근 권한
	Manager manager = (Manager)(session.getAttribute("sessionManager"));
	if(manager==null) {//로그인이 되어있지 않은 상태.
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if(manager.getManagerLevel() < 2) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;	
	}	
	
	//수집코드 구현
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	String ordersState = request.getParameter("ordersState");
	
	//디버깅
	System.out.println("수정될 ordersNo"+ordersNo+"ordersState"+ordersState);
	
	//전처리
	Orders orders = new Orders();
	orders.setOrdersNo(ordersNo);
	orders.setOrdersState(ordersState);
	
	//dao실행
	OrdersDao.updateOrdersState(orders);
	
	response.sendRedirect(request.getContextPath()+"/ordersList.jsp?ordersNo="+ordersNo);
	
%>