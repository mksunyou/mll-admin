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
<title>Insert title here</title>
</head>
<body>
	<%
		String ebookISBN = request.getParameter("ebookISBN");
	%>
	<h1>updateEbookImgForm</h1>
	<!-- 이미지 파일은 무조건 post방식으로 넘겨야 한다. -->
	<!-- enctype="multipart/form-data 은 데이터형식으로 넘어감. 파일이나 이미지를 보낼때 사용. enctype는 세가지 종류. 구글링 ㄱㄱ -->
	<form action="<%=request.getContextPath()%>/ebook/updateEbookImgAction.jsp" method="post" enctype="multipart/form-data">
		<input type="hidden" name="ebookISBN" value="<%=ebookISBN%>">
		<!-- request.getParameter은 문자만 받을 수 있기 때문에 받을 수 없음. -->
		<input type="file" name="ebookImg">
		<button type="submit">이미지 수정</button>
	</form>	
</body>
</html>