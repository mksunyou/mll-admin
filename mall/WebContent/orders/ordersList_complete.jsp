<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.util.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	//Manager로그인 세션 추가
	Manager manager = (Manager)(session.getAttribute("sessionManager"));
	if(manager==null) {//로그인이 되어있지 않은 상태.
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

	<div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	
	<%
				
			
				//주문상태 목록 생성
				String[] ordersStateList = OrdersDao.ordersStateList();
				
				//현재페이지
				int currentPage = 1;
				if(request.getParameter("currnetPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
				}
				
				//페이지당 행의 수
				int rowPerPage = 10;
				if(request.getParameter("rowPerPage") != null) {
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
				}
				
				//시작행
				int beginRow = (currentPage-1) * rowPerPage;
				
				
				//총 행의 수
				int totalRow = OrdersDao.totalCount();
				System.out.println("전체 행의 수:"+totalRow);
				
				//list 생성
				ArrayList<OrdersAndEbookAndClient> list = OrdersDao.selectOrdersListByPage(rowPerPage, beginRow);
		%>
	
	<h1> 주문 목록</h1>
	
	<table border="1">
		<thead>
			<tr>
				<th>ordersNo</th>
				<th>ebookNo</th>
				<th>ebookTitle</th>
				<th>clientNo</th>
				<th>clientMail</th>
				<th>ordersDate</th>
				<th>orderState</th>
			</tr>
		</thead>
		
		<tbody>
			<%
				for(OrdersAndEbookAndClient oec : list) {
			%>
				<tr>
					<td><%=oec.getOrders().getOrdersNo()%></td>
					<td><%=oec.getOrders().getEbookNo()%></td>
					<td><%=oec.getEbook().getEbookTitle()%></td>
					<td><%=oec.getOrders().getClientNo()%></td>
					<td><%=oec.getClient().getClientMail()%></td>
					<td><%=oec.getOrders().getOrdersDate()%></td>
					<td>
						<form action="<%=request.getContextPath()%>/orders/updateOrdersStateAction.jsp" method="post">
							<input type="hidden" name="ordersNo" value="<%=oec.getOrders().getOrdersNo()%>">
								<select name="ordersState">
									<%
										for(String osl : ordersStateList){
											if(osl.equals(oec.getOrders().getOrdersState())){
									%>
												<option value="<%=osl%>" selected="selected"><%=osl %></option>
									<%
											} else {
									%>
												<option value="<%=osl%>"><%=osl%></option>
									<%
											}
												
										}
									%>
								</select>
							<button type="submit">수정</button>
						</form>
					</td>				
				</tr>
			<%
			}
			%>
		</tbody>
	</table>	
	
	<!-- 페이지 넘김 -->
	<%
		//첫 페이지는 이전버튼 없게.
		if(currentPage>1) {
	%>
			<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">이전</a>
	<%
	}
		
		int lastPage = totalRow / rowPerPage;
		
		if(totalRow % rowPerPage !=0){
			lastPage = lastPage +1;					
		}
		
		//마지막 페이지는 다음 없게.
		if(currentPage<lastPage) {
	%>
			<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">다음</a>
	<%	
		}
	%>
</body>
</html>