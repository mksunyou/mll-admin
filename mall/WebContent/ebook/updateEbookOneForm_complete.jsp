<%@page import="gdu.mall.dao.EbookDao"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.util.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//접근 권한
	Manager manager = (Manager)(session.getAttribute("sessionManager"));
	if(manager==null) {//로그인이 되어있지 않은 상태.
		response.sendRedirect(request.getContextPath()+"adminIndex.jsp");
		return;
	} else if(manager.getManagerLevel() < 2) {
		response.sendRedirect(request.getContextPath()+"adminIndex.jsp");
		return;	
	}	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<!-- 관리자 화면 메뉴(네비게이션) include -->
	<div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	
	
	<%
		//ISBN 가져오기.
		String ebookISBN = request.getParameter("ebookISBN");
		
		//categoryNameList 가져오기
		ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
		
		//ebook data가져오기
		Ebook ebook = EbookDao.selectEbookOne(ebookISBN);
		
		//ebookStateList
		String[] ebookStateList = EbookDao.ebookStateList();
		
		//디버깅
		System.out.println("ISBN :"+ebookISBN);
	%>
	
	<h1>updateEbookOneForm</h1>
	
	<form action="<%=request.getContextPath()%>/ebook/updateEbookOneAction.jsp" method="post">
	
		<input type="hidden" name="ebookNo" value="<%=ebook.getEbookNo()%>">
		<input type="hidden" name="ebookISBN" value="<%=ebook.getEbookISBN()%>">
		
		
		<table border="1">
			<tr>
				<td>ebookNo</td>
				<td><%=ebook.getEbookNo() %></td>				
			</tr>
			
			<tr>
				<td>ebookISBN</td>
				<td><%=ebook.getEbookISBN() %>></td>
			</tr>
			
			<tr>
				<td>categoryName</td>
				<td><input type="text" name="categoryName" value="<%=ebook.getCategoryName()%>"></td>
			</tr>
			
			<tr>
				<td>ebookTitle</td>
				<td><input type="text" name="ebookTitle" value="<%=ebook.getEbookTitle()%>"></td>
			</tr>
			
			<tr>
				<td>ebookAuthor</td>
				<td><input type="text" name="ebookAuthor" value="<%=ebook.getEbookAuthor()%>"></td>
			</tr>
			
			<tr>
				<td>ebookCompany</td>
				<td><input type="text" name="ebookCompany" value="<%=ebook.getEbookCompany()%>"></td>
			</tr>
			
			<tr>
				<td>ebookPageCount</td>
				<td><input type="text" name="ebookPageCount" value="<%=ebook.getEbookPageCount()%>"></td>
			</tr>
			
			<tr>
				<td>ebookPrice</td>
				<td><input type="text" name="ebookPrice" value="<%=ebook.getEbookPrice()%>"></td>
			</tr>
			
			<tr>
				<td>ebookImg</td>
				<td><%=ebook.getEbookImg()%></td>
			</tr>
			
			<tr>
				<td>ebookSummary</td>
				<td>
					<textarea rows="5" cols="80" name="ebookSummary"></textarea>
				</td>
			</tr>
			
			<tr>
				<td>ebookDate</td>
				<td><%=ebook.getEbookDate()%></td>
			</tr>
			
			<tr>
				<td>ebookState</td>
				<td>
					<select name="ebookState">
						<%
							for(String esl : ebookStateList) {
								if(esl.equals(ebook.getEbookState())) {
						%>
						 			<option value="<%=esl%>" selected="selected"><%=esl%></option>
						<%
								} else { 
						%>
									<option value = "<%=esl%>"><%=esl%></option>
						<%
								}
							}
						%>
					</select>
				</td>
			</tr>
		</table>
			<!-- 수정완료 -->
	<button type="submit">수정완료</button>
	
	</form>
	

</body>
</html>