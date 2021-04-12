<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.util.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminIndex</title>
</head>
<body>
<h1>adminIndex</h1>
	<!-- 
		2가지 화면을 분기
		-로그인 정보는 세션변수(sessionManager)를 이용
		1)관리자 로그인 몰
		2)관리자 인증 화면 & 몰 메인 페이지
	 -->
<%
	// 로그인이 되어있지 않은 상태
	if(session.getAttribute("sessionManager") == null) {
%>
		<form action="<%=request.getContextPath()%>/manager/loginManagerAction.jsp" method="post">
			<table border="1">
				<tr>
					<td>ID</td>
					<td><input type="text" name="managerId"></td>
				</tr>
				<tr>
					<td>PW</td>
					<td><input type="password" name="managerPw"></td>
				</tr>
			</table>
			<button type="submit">로그인</button>
			<a href="<%=request.getContextPath()%>/manager/insertManagerForm.jsp">매니저 등록</a>
		</form>
		<h1>승인 대기중인 매니저 목록</h1>
			<table border="1">
				<thead>
					<tr>
						<th>managerId</th>
						<th>managerDate</th>
					</tr>
				</thead>
				
				<tbody>
				
				
<%		
					ArrayList<Manager> list = ManagerDao.selectManagerListByZero();
					for(Manager m : list){
%>
						<tr>
							<td><%=m.getManagerId()%></td>
							<td><%=m.getManagerDate().substring(0,10)%></td>
						</tr>
<%
					}
%>
				</tbody>
			</table>
<%
	//로그인이 되어있는 상태
	} else { 
		Manager manager = (Manager)(session.getAttribute("sessionManager"));
%>
		<!-- 관리자화면 메뉴(네비게이션)include, include는 요청의 주체는 브라우저 -->
		<div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
		</div>

		<div>
			<%=manager.getManagerName()%>님 반갑습니다. 당신의 레벨은 <%=manager.getManagerLevel()%> 입니다.
		</div>
		
		<!-- 최근 등록한 공지 5개 -->
		<%
			ArrayList<Notice> noticeList = NoticeDao.selectNoticeListByPage(5, 0);
			//매니저 페이징 리스트
			ArrayList<Manager> managerList = ManagerDao.selectManagerList(5, 0);
			ArrayList<Client> clientList = ClientDao.selectClientListByPage(5, 0, "");
			ArrayList<Ebook> ebookList = EbookDao.selectEbookList(5, 0, "");
			ArrayList<OrdersAndEbookAndClient> oecList = OrdersDao.selectOrdersListByPage(5,0);
		%>
		
		<!-- 최근 등록한 공지 5개 -->
		<div>
			<h2>noticeList</h2><a href="<%=request.getContextPath()%>/notice/noticeList.jsp">more</a>
			<table border="1">
				<%
					for(Notice n : noticeList) {
				%>
					<tr>
						<td><%=n.getNoticeTitle() %></td>
						<td><%=n.getManagerId() %></td>
						<td><%=n.getNoticeDate() %></td>
					</tr>
				<%
					}
				%>
			</table>
		</div>
		
		<!-- 최근 가입한 관리자 5명 -->
		
		<div>
			<h2>managerList</h2><a href="<%=request.getContextPath()%>/manager/managerList.jsp">more</a>
			<table border="1">
				<%
					for(Manager m : managerList) {
				%>
					<tr>
						<td><%=m.getManagerId() %></td>
						<td><%=m.getManagerName() %></td>
						<td><%=m.getManagerLevel() %></td>
					</tr>
				<%
					}
				%>
			</table>
		</div>
		
		<div>
			<h2>clientList</h2><a href="<%=request.getContextPath()%>/client/clientList.jsp">more</a>
			<table border="1">
				<%
					for(Client c : clientList) {
				%>
					<tr>
						<td><%=c.getClientMail() %></td>
						<td><%=c.getClientDate() %></td>
					</tr>
				<%
					}
				%>
			</table>
		</div>
		
		<div>
			<h2>ebookList</h2><a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">more</a>
			<table border="1">
				<%
					for(Ebook e : ebookList) {
				%>
					<tr>
						<td><%=e.getEbookTitle() %></td>
						<td><%=e.getEbookPrice() %></td>
						<td><%=e.getEbookAuthor() %></td>
					</tr>
				<%
					}
				%>
			</table>
		</div>
		
		<!-- 최근 주문 5개 -->
		<div>
			<h2>ordersList</h2><a href="<%=request.getContextPath()%>/notice/noticeList.jsp">more</a>
			<table border="1">
				<%
					for(OrdersAndEbookAndClient oec : oecList) {
				%>
					<tr>
						<td><%=oec.getOrders().getOrdersNo() %></td>
						<td><%=oec.getEbook().getEbookTitle() %></td>
						<td><%=oec.getClient().getClientMail() %></td>
					</tr>
				<%
					}
				%>
			</table>
		</div>
		
	
<%		
	}
%>	
</body>
</html>