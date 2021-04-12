<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.ManagerDao" %>
<%@ page import="gdu.mall.vo.Manager" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

	// 1. 수집
	request.setCharacterEncoding("UTF-8");
	String managerId = request.getParameter("managerId");
	String managerPw = request.getParameter("managerPw");
	String managerName = request.getParameter("managerName");
	System.out.println(managerId);
	System.out.println(managerPw);
	System.out.println(managerName);//디버깅
	
	// 2-1. 중복된 아이디가 있으면 다시 입력폼으로 이동
	String returnManagerId = ManagerDao.selectManagerId(managerId);
	if(returnManagerId != null) { //이미 아이디가 존재한다
		System.out.println("사용중인 아이디 입니다");
		response.sendRedirect(request.getContextPath()+"/manager/insertManagerForm.jsp");
		return;
	}
	// 2-2. 중복된 아이디가 없으면 입력
	
	ManagerDao.insertManager(managerId, managerPw, managerName);

	// 3.출력
%>
	<div>
		매니저 등록 성공. 승인 후 사용 가능합니다.
		<a href="<%=request.getContextPath() %>/adminIndex.jsp">관리자 홈</a>
	</div>