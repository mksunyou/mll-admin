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
<title>categoryList</title>
</head>
<body>
	<!-- 페이징X, 검색어X -->
	<!-- 관리자 화면 메뉴(네비게이션) include -->
	<div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	
	<%//list 생성
		ArrayList<Category> list = CategoryDao.selectCategoryList();
	%>
	
	<h1>카테고리 목록</h1>
	<a href="<%=request.getContextPath()%>/category/insertCategoryForm.jsp"><button type="button">카테고리 추가</button></a>
	<table border="1">
		<thead>
			<tr>
				<th>categoryName</th>
				<th>categoryWeight(수정가능)</th>
				<th>삭제</th>				
			</tr>
		</thead>
		<tbody>
			<%
				for(Category ca : list) {
			%>
				<tr>
					<td><%=ca.getCategoryName() %></td>
					<td>
						<form action="<%=request.getContextPath()%>/category/updateCategoryAction.jsp" method="post">
							<input type="hidden" name="categoryNo" value="<%=ca.getCategoryNo() %>">
								<select name="categoryWeight">
									<%
									for(int i=0; i<3; i++){
										if(ca.getCategoryWeight()==i){				
									
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
								<button>수정</button>
						</form>
					</td>
					<td><a type="button" href="<%=request.getContextPath()%>/category/deleteCategoryAction.jsp?categoryName=<%=ca.getCategoryName()%>"><button type="button">삭제</button></a></td>
				</tr>
			<%
				}
			%>
		</tbody>
	</table>
</body>
</html>