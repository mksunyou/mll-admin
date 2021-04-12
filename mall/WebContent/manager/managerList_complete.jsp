<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	//로그인이 되어있지 않거나 매니저 레벨이 2 이하일때 return.
	Manager manager =(Manager)(session.getAttribute("sessionManager"));
	if(manager==null) {
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
	<!-- 관리자 화면 메뉴(네비게이션) include -->
	<div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
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
			
			//시작 행
			int beginRow = (currentPage-1) * rowPerPage;
			
			//총 행의 수
			int managerTotalRow = ManagerDao.managerTotalCount();
			System.out.println("manager 전체 행의 수:"+managerTotalRow);	
	
		//목록
		ArrayList<Manager> list = ManagerDao.selectManagerList(rowPerPage, beginRow);	
	%>
	
	<h1>managerList</h1>
	<table border="1">
		<thead>
			<tr>
				<th>managerNo</th>
				<th>managerId</th>
				<th>managerName</th>
				<th>managerDate</th>
				<th>managerLevel</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
		<%
			for(Manager m : list){
		%>
			<tr>
				<td><%=m.getManagerNo() %></td>
				<td><%=m.getManagerId() %></td>
				<td><%=m.getManagerName() %></td>
				<td><%=m.getManagerDate() %></td>
				<td>
					<form action="<%=request.getContextPath()%>/manager/updateManagerLevelAction.jsp" method="post">
						<input type="hidden" name="managerNo" value="<%=m.getManagerNo()%>">
						<select name="managerLevel">
							<%
								for(int i=0; i<3; i++){
									if(m.getManagerLevel()==i){	
							%>	
								<option value="<%=i%>" selected="selected"><%=i %></option>
							<%			
									} else {
							%>	
								<option value="<%=i%>"><%=i %></option>
							<%
									}
								}
							%>
						</select>
						<button>수정</button>
					</form></td>
				<td><a type="button" href="<%=request.getContextPath()%>/manager/deleteManagerAction.jsp?managerNo=<%=m.getManagerNo()%>">
				<button>삭제</button>
				</a></td>
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
					<a href="<%=request.getContextPath()%>/manager/managerList.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<%
				}
			
				int lastPage = managerTotalRow / rowPerPage;
				
				if(managerTotalRow % rowPerPage != 0) { //모든 줄에서 10을 나눈 나머지가 0이 아니면 페이지 하나를 추가 하겠다. 
					lastPage += 1; // lastPage = lastPage+1; lastPage++;
				}
			%>
			<%
				if(currentPage<lastPage) {
			%>
					<a href="<%=request.getContextPath()%>/manager/managerList.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<%
				}
			%>
</body>
</html>