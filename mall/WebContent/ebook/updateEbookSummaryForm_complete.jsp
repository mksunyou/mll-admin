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
<title>updateEbookSummaryForm</title>
</head>
<body>
	<!-- 관리자 화면 메뉴(네비게이션) include -->
	<div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<%
		Ebook ebook = new Ebook();
		ebook.setEbookISBN(request.getParameter("ebookISBN"));
	%>
	<h1>updateEbookSummaryForm</h1>
	<form action="<%=request.getContextPath()%>/ebook/updateEbookSummaryAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>ebookSummary</td>
				<td>
					<input type="hidden" name="ebookISBN" value="<%=ebook.getEbookISBN()%>">
					<textarea rows="5" cols="80" name="ebookSummary"></textarea>
				</td>
				<td>
					<button type="submit">수정</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>