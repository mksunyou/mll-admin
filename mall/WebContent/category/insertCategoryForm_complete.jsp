<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.util.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	//Manager로그인 세션 추가
	Manager manager = (Manager)(session.getAttribute("sessionManager"));
	if(manager==null) {//로그인이 되어있지 않은 상태.
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if(manager.getManagerLevel() < 2) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;	
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<a href="<%=request.getContextPath()%>/category/categoryList.jsp">카테고리 리스트</a>
	</div>
	<h1>카테고리 등록</h1>
	
	<form action="<%=request.getContextPath()%>/category/insertCategoryAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>categoryName</td>
				<td><input type="text" name="categoryName"></td>
			</tr>
		</table>
		<button type="submit">카테고리 등록</button>
	</form>
</body>
</html>