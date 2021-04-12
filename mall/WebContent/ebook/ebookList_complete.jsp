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
<title>ebookList</title>
</head>
<body>
	<!-- 관리자 화면 메뉴(네비게이션) include -->
	<div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	

	
	
	<!-- rowPerPage별 페이징 -->
	<%
		//현재페이지
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {//현재 페이지에 대한 데이터가 있으면,
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		//페이지당 행의 수
		int rowPerPage = 10;
		if(request.getParameter("rowPerPage") != null) {//rowPerPage에 대한 데이터가 있으면,
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		}
		
		//검색 searchWord 선언
		String byCategoryName = "";//searchWord가 공백이면 검색어가 없고, 공백이 아니면 검색어가 있는것.
		if(request.getParameter("byCategoryName") !=null){
			byCategoryName = request.getParameter("byCategoryName");
		}
		
		//시작 행
		int beginRow = (currentPage-1) * rowPerPage;
		
		//총 행의 수
		int ebookTotalRow = EbookDao.ebookTotalCount(byCategoryName);
		System.out.println("ebook 전체 행의 수:"+ebookTotalRow);
		
		// 보여지는 카테고리 목록	
		ArrayList<Ebook> ebookList = EbookDao.selectEbookList(rowPerPage, beginRow,byCategoryName);
	%>
	
		<!-- 카테고리별 목록을 볼 수 있는 메뉴(네비게이션) -->
	<div>
		<!-- categoryName이 0이면, -->
		<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">[전체]</a>
		<%
			ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
			for(String s : categoryNameList){
		%>
		<form action="<%=request.getContextPath()%>/ebook/ebookList.jsp" method="post">
			<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">
			<div>
				<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?byCategoryName=<%=s%>">[<%=s%>]</a>
			</div>
		</form>
		<%
			}
		%>
	</div>
	
	<a href="<%=request.getContextPath()%>/ebook/insertEbookForm.jsp"><button type="button">ebook 추가</button></a>
	<!-- rowPerPage별 페이징 (목록 5의 배수만큼 보여주기) -->
	<form action="<%=request.getContextPath()%>/ebook/ebookList.jsp" method="post">
	<input type="hidden" name="byCategoryName" value="<%=byCategoryName%>">
		<select name="rowPerPage">
			<%
				for(int i=10;i<31;i+=5){
					if(rowPerPage==i){
			%>
						<option value="<%=i%>" selected="selected"><%=i%></option>
			<%			
					} else {
			%>
						<option value="<%=i%>"><%=i%></option>
			<%			
					}
				}
			%>
		</select>
		<button type="submit">보기</button>
	</form>
	
	<table border="1">
		<thead>
			<tr>
				<th>categoryName</th>
				<th>ebookISBN</th>
				<th>ebookTitle</th><!-- 타이틀 누르면 summary -->
				<th>ebookAuthor</th>
				<th>ebookDate</th>
				<th>ebookPrice</th>
			</tr>
		</thead>
		
		<tbody>
			<%
				for(Ebook e : ebookList){
			%>
				<tr>
					<td><%=e.getCategoryName() %></td>
					<td><%=e.getEbookISBN() %></td>
					<td><a href="<%=request.getContextPath()%>/ebook/ebookOne.jsp?ebookISBN=<%=e.getEbookISBN()%>"><%=e.getEbookTitle() %></a></td>
					<td><%=e.getEbookAuthor() %></td>
					<td><%=e.getEbookDate()%></td>
					<td><%=e.getEbookPrice()%></td>
				</tr>
			<%
			}
			%>
		</tbody>
		
	</table>
	
	<!-- 페이징 -->
		<%
			if(currentPage>1){
		%>
			<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&byCategoryName=<%=byCategoryName%>">이전</a>
		<%
		}
		//마지막 페이지에서 다음버튼 없애기.
		
		int lastPage = ebookTotalRow / rowPerPage;
		
		if(ebookTotalRow % rowPerPage != 0){//ebooktotalrow에서 rowperpage를 나눈 나머지가 0이 아니면
			lastPage +=1;//lastPage = lastPage+1			
		}
		if (currentPage<lastPage){//마지막 페이지가 아니면,
		%>
			<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&byCategoryName=<%=byCategoryName%>">다음</a>
		<%
		}
		%>
</body>
</html>