<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.ManagerDao" %>
<%@ page import="gdu.mall.vo.Manager" %>
<!-- contact html로! -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>managerInsertForm</title>
</head>
<body>
	<div>
		<a href="<%=request.getContextPath()%>/adminIndex.jsp">관리자 홈</a>
	</div>
	<h1>메니저 등록</h1>
	<form action="<%=request.getContextPath()%>/manager/insertManagerAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>manager_id</td>
				<td><input type="text" name="managerId"></td>
			</tr>
			<tr>
				<td>manager_pw</td>
				<td><input type="password" name="managerPw"></td>
			</tr>
			<tr>
				<td>manager_name</td>
				<td><input type="text" name="managerName"></td>
			</tr>
		</table>
		<button type="submit">매니저 등록</button>
	</form>
</body>
</html>