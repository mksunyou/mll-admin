<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.util.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%//관리자 인증 코드
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
<title>insertEbookForm</title>
</head>
<body>

	<%
		ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
		System.out.println(categoryNameList.size()+" <--categoryNameList.size()");
	
	%>
	<!-- ebook리스트로 돌아가기. -->
	<div>
		<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">ebookList</a>
	</div>
	
	<h1>insertEbookForm</h1>
	
	<!-- table -->
	<form action="<%=request.getContextPath()%>/ebook/insertEbookAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>categoryName</td>
				<td>
					<select name="categoryName">
						<option value="">선택</option>
						<%
							for(String cn : categoryNameList) {
						%>
							<option value="<%=cn%>"><%=cn%></option>
						<%
							}
						%>
					</select>
				</td>
			</tr>
			
			<tr>
				<td>ebookISBN</td>
				<td><input type="text" name="ebookISBN"></td>
			</tr>
			
			<tr>
				<td>ebookTitle</td>
				<td><input type="text" name="ebookTitle"></td>
			</tr>
			
			<tr>
				<td>ebookAuthor</td>
				<td><input type="text" name="ebookAuthor"></td>
			</tr>
			
			<tr>
				<td>ebookCompany</td>
				<td><input type="text" name="ebookCompany"></td>
			</tr>
			
			<tr>
				<td>ebookPageCount</td>
				<td><input type="text" name="ebookPageCount"></td>
			</tr>
			
			<tr>
				<td>ebookPrice</td>
				<td><input type="text" name="ebookPrice"></td>
			</tr>
			
			<tr>
				<td>ebookSummary</td>
				<td>
					<textarea rows="5" cols="80" name="ebookSummary"></textarea>
				</td>
			</tr>
			
		</table>
		<button type = "submit">ebook 추가</button>
	</form>
</body>
</html>