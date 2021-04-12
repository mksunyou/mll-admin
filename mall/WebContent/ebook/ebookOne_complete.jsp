<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.util.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	// 관리자
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
<title>ebookOne</title>
</head>
<body>
	<!-- 관리자 화면 메뉴(네비게이션) include -->
	<div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	
<%
	String ebookISBN = request.getParameter("ebookISBN");
	System.out.println(ebookISBN+" <-- param ebookISBN");

	Ebook ebook = EbookDao.selectEbookOne(ebookISBN);
	String[] ebookStateList = EbookDao.ebookStateList();
	
%>
	<h1>ebookOne</h1>
	
	<!-- 상세보기 -->
	<form action="<%=request.getContextPath()%>/ebook/updateEbookStateAction.jsp" method="post">
	<table border="1">
		<tr>
			<td>ebookNo</td>
			<td><%=ebook.getEbookNo() %></td>
			<td>&nbsp;</td>
		</tr>
		
		<tr>
			<td>ebookISBN</td>
			<td><%=ebook.getEbookISBN() %></td>
			<td>&nbsp;</td>
		</tr>
		
		<tr>
			<td>categoryName</td>
			<td><%=ebook.getCategoryName()%></td>
			<td>&nbsp;</td>
		</tr>
		
		<tr>
			<td>ebookTitle</td>
			<td><%=ebook.getEbookTitle() %></td>
			<td>&nbsp;</td>
		</tr>
		
		<tr>
			<td>ebookAuthor</td>
			<td><%=ebook.getEbookAuthor() %></td>
			<td>&nbsp;</td>
		</tr>
		
		<tr>
			<td>ebookCompany</td>
			<td><%=ebook.getEbookCompany() %></td>
			<td>&nbsp;</td>
		</tr>
		
		<tr>
			<td>ebookPageCount</td>
			<td><%=ebook.getEbookPageCount()%></td>
			<td>&nbsp;</td>
		</tr>
		
		<tr>
			<td>ebookPrice</td>
			<td><%=ebook.getEbookPrice()%></td>
			<td>&nbsp;</td>
		</tr>
		
		<tr>
			<td>ebookImg</td>
			<td><img src="<%=request.getContextPath()%>/img/<%=ebook.getEbookImg()%>"></td>
			<td>
				<a href="<%=request.getContextPath()%>/ebook/updateEbookImgForm.jsp?ebookISBN=<%=ebook.getEbookISBN()%>">
					<button type="button">이미지 수정</button>
				</a>
			</td>
		</tr>
		
		
		<tr>
			<td>ebookSummary</td>
			<td><%=ebook.getEbookSummary()%></td>
			<td>
				<a href="<%=request.getContextPath()%>/ebook/updateEbookSummaryForm.jsp?ebookISBN=<%=ebook.getEbookISBN()%>">
					<button type="button">책요약 수정</button>
				</a>
			</td>			
		</tr>
		
		<tr>
			<td>ebookDate</td>
			<td><%=ebook.getEbookDate()%></td>
			<td>&nbsp;</td>
		</tr>
		
	
		<tr>
			<td>ebookState</td>
			<td>
				<input type="hidden" name="ebookISBN" value="<%=ebook.getEbookISBN()%>">
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
			<td><button type="submit">책상태 수정</button></td>
		</tr>
	
	
	</table>
	</form>
	<!-- 수정, 삭제 -->
	<div>
		<a href="<%=request.getContextPath()%>/ebook/updateEbookOneForm.jsp?ebookISBN=<%=ebookISBN%>">
			<button type="button">전체 수정(이미지 제외)</button>
		</a>
		
		<a href="<%=request.getContextPath()%>/ebook/deleteEbookAction.jsp?ebookISBN=<%=ebookISBN%>">
			<button type="button">삭제</button>
		</a>
	</div>

</body>
</html>