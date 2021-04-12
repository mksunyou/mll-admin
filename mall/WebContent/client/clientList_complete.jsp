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
<title>clientList</title>
</head>
<body>
	<!-- 관리자 화면 메뉴(네비게이션) include -->
	<div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<h1>clientList</h1>
	<%
	
		// 현재페이지
		int currentPage=10;
		if(request.getParameter("currentPage") != null){//만약 현재 페이지의 데이터를 받아오면 그대로 실행.
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		//페이지당 행의 수
		int rowPerPage=10;
		if(request.getParameter("rowPerPage") != null){//만약 rowPerPage의 값을 받아오면 그대로 실행.
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		}
		
		//검색 searchWord 선언
		String searchWord = "";//searchWord가 공백이면 검색어가 없고, 공백이 아니면 검색어가 있는것.
		if(request.getParameter("searchWord") !=null){
			searchWord = request.getParameter("searchWord");
		}
		
		
		//시작 행
		int beginRow= (currentPage-1) * rowPerPage;
		
		//총 행의 수
		int totalRow = ClientDao.totalCount(searchWord);//ClientDao에서 선언한 totalCount 가져옴.
		System.out.println("전체 행의수:"+totalRow);//totalRow의 디버깅. 
		
		//list 생성
		ArrayList<Client> list = ClientDao.selectClientListByPage(rowPerPage, beginRow, searchWord);
	%>
	
	<!-- rowPerPage를 변경할수 있도록 만듦, 변경 후에 다시 client로 가져옴 -->
	<form action="<%=request.getContextPath()%>/client/clientList.jsp" method="post">
		<input type="hidden" name="searchWord" value="<%=searchWord%>">
		<select name="rowPerPage">
			<%
				for(int i=10; i<31; i=i+5) {
					if(rowPerPage==i){
										
			%>
						<!-- rowPerPage가  -->
						<option value="<%=i%>" selected="selected"><%=i %></option>
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
	
	<!-- 테이블 -->
		<table border="1">
			<thead>
				<tr>
					<th>clientMail</th>
					<th>clientDate</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(Client c : list) {
				%>
					<tr>
						<td><%=c.getClientMail()%></td>
						<!-- clientDate를 11자리까지 끊음 -->
						<td><%=c.getClientDate().substring(0,11)%></td>
						<!-- update는 수정하는 폼이 있어야 하므로 form -->
						<td><a href="<%=request.getContextPath()%>/client/updateClientForm.jsp?clientMail=<%=c.getClientMail()%>"><button type="button">수정</button></a></td>
						<!-- delete는 바로 삭제 되므로 바로 action -->
						<td><a href="<%=request.getContextPath()%>/client/deleteClientAction.jsp?clientMail=<%=c.getClientMail()%>"><button type="button">삭제</button></a></td>
					</tr>
				<%			
					}				
				%>
			</tbody>
		</table>
		
	<!-- 페이지 넘김 -->
			
			<%
				if(currentPage>1) {
			%>
					<a href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">이전</a>
			<%
				}
			
				int lastPage = totalRow / rowPerPage;
				
				if(totalRow % rowPerPage != 0) { //모든 줄에서 10을 나눈 나머지가 0이 아니면 페이지 하나를 추가 하겠다. 
					lastPage += 1; // lastPage = lastPage+1; lastPage++;
				}
			%>
			<%
				if(currentPage<lastPage) {
			%>
					<a href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">다음</a>
			<%
				}
			%>
			
			<!-- 검색, 검색어를 넘길때 rowPerPage가 빠져있었기때문에 hidden으로  -->
			<form action="<%=request.getContextPath()%>/client/clientList.jsp" method="post">
				<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">
				<div>
					client Mail :
					<input type="text" name="searchWord">
					<button type="submit">검색</button>
				</div>
						
			</form>

</body>
</html>