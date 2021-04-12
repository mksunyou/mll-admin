<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.util.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager==null || manager.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateClientForm</title>
</head>
<body>
		<!-- 관리자 화면 메뉴(네비게이션) include -->
	<div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<%
		String clientMail = request.getParameter("clientMail");
		ArrayList<Client> list = ClientDao.updateClientList(clientMail);	
	%>
	
	<h1>updateClientForm</h1>
	<form action="<%=request.getContextPath()%>/client/updateClientAction.jsp" method="post">
	<table border="1">
	<%
		for(Client c: list) {
	%>
	
		<tr>
			<td>clientMail</td>
			<td><%=c.getClientMail()%></td>
		</tr>
		<tr>
			<td>clienDate</td>
			<td><%=c.getClientDate().substring(0,11)%></td>
		</tr>
		<tr>
			<td>clientPw</td>
			<td>
				<input type="text" name="clientPw">
				<button type="submit">수정</button>
			</td>
		</tr>
	<%
		}
	%>		
	</table>	
	</form>
	
</body>
</html>