<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.util.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	//관리자만 접근할 수 있게 하는 메소드 
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}
%>
<!doctype html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="it">
  <meta name="keywords" content="Rapoo,creative, agency, startup,onepage, clean, modern,business, company,it">
  
  <meta name="author" content="themefisher.com">

  <title>Rapoo- It solutions &amp; Corporate template</title>

  <!-- bootstrap.min css -->
  <link rel="stylesheet" href="plugins/bootstrap/css/bootstrap.min.css">
  <!-- Animate Css -->
  <link rel="stylesheet" href="plugins/animate-css/animate.css">
  <!-- Icon Font css -->
  <link rel="stylesheet" href="plugins/fontawesome/css/all.css">
  <link rel="stylesheet" href="plugins/fonts/Pe-icon-7-stroke.css">
  <!-- Themify icon Css -->
  <link rel="stylesheet" href="plugins/themify/css/themify-icons.css">
  <!-- Slick Carousel CSS -->
  <link rel="stylesheet" href="plugins/slick-carousel/slick/slick.css">
  <link rel="stylesheet" href="plugins/slick-carousel/slick/slick-theme.css">

  <!-- Main Stylesheet -->
  <link rel="stylesheet" href="css/style.css">

</head>


<body id="top-header">
<!-- LOADER TEMPLATE -->
<div id="page-loader">
    <div class="loader-icon fa fa-spin colored-border"></div>
</div>

<%
		// 현재 페이지
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage")); // 받아온 값 정수로 변환
		}
		
		// 페이지 당 행의 수
		int rowPerPage = 10;
		if(request.getParameter("rowPerPage") != null) {
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage")); // 받아온 값 정수로 변환
		}
		
		// 시작 행
		int beginRow = (currentPage - 1) * rowPerPage;
		
		// 전체 행의 개수
		int totalRow = NoticeDao.totalCount();
		System.out.println(totalRow+"<-- NoticeDao의 totalRow"); // 디버깅
		
		// list 생성	
		ArrayList<Notice> list = NoticeDao.selectNoticeListByPage(rowPerPage, beginRow);
%>

    <!-- NAVBAR
    ================================================= -->
    <div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
    

   <!-- HERO
    ================================================== -->
    <section class="page-banner-area page-service">
        <div class="overlay"></div>
        <!-- Content -->
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-9 col-md-12 col-12 text-center">
                    <div class="page-banner-content">
                        <h1 class="display-4 font-weight-bold">
                       	 	<%=manager.getManagerName()%>님 반갑습니다. <br> 당신의 레벨은 <%=manager.getManagerLevel()%> 입니다.</h1>
                    </div>
                </div>
            </div> <!-- / .row -->
        </div> <!-- / .container -->
    </section>



<section class="section">
        <!-- Content -->
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6 text-center">
                    <div class="section-heading">
                        <!-- Heading -->
                        <h2 class="section-title">
                           List of Notice
                        </h2>
                    </div>
                </div>
            </div> <!-- / .row -->
            	<a href="<%=request.getContextPath()%>/insertNoticeForm.jsp"><button type="button" class="btn">공지 추가</button></a>

			<!-- 한 페이지당 몇 개씩 볼건지 선택하는 기능 -->
			<form action="<%=request.getContextPath()%>/noticeList.jsp" method="post">
				<select name="rowPerPage">
					<%
						for(int i=10; i<31; i+=5) {
							if(rowPerPage == i) {
					%>
							<!-- 옵션에서 선택한 개수만큼의 행이 보이게 함 -->
							<option value=<%=i%> selected="selected"><%=i%></option> 
					<%
							} else {
					%>
							<!-- 옵션 선택이 되어 있지 않으면 rowPerPage 설정 값으로 보이게 함 -->
							<option value=<%=i%>><%=i%>개씩</option>
					<%	
							}
						}
					%>
				</select>
				<button type="submit" class="btn">개씩 보기</button>
			</form>

           	 <div class="text-center">
				<div class="row justify-content-center">
                  	<div class="footer-widget">
                        <table class="table list-unstyled ml-lg-auto  text-center">
                        	<thead>
			<tr>
				<th>noticeNo</th>
				<th>noticeTitle</th>
				<th>managerId</th>
				<th>noticeDate</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Notice n : list) { // for each문
			%>
					<tr>
						<td><%=n.getNoticeNo()%></td>
						<!-- noticeTitle을 클릭하면 상세보기(noticeOne)으로 넘어감 -->
						<td><a href="<%=request.getContextPath()%>/noticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle()%></a></td>
						<td><%=n.getManagerId()%></td>
						<td><%=n.getNoticeDate().substring(0,11)%></td>
					</tr>
			<%
				}
			%>
		</tbody>
		</table>
		
		<!-- 페이징 (이전, 다음) 버튼 만들기 -->
	<% 
		// 맨 첫 페이지에서 이전 버튼이 나오지 않게 함
		if(currentPage > 1) {
	%>
				<a href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>"><button type="button" class="btn">이전</button></a>
	<%
		}
	
		// 맨 마지막 페이지에서 다음 버튼이 보이지 않도록 함
		int lastPage = totalRow / rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage += 1; // lastPage = lastPage+1; lastPage++;
		}
		
		if(currentPage < lastPage) {
	%>
			<a href="<%=request.getContextPath()%>/noticeList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>"><button type="button" class="btn">다음</button></a>
	<%
		}
	%>
		
</div>
</div>
</div>
</div>
</section>


    <!-- 
    Essential Scripts
    =====================================-->

    
    <!-- Main jQuery -->
    <script src="plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 3.1 -->
    <script src="plugins/bootstrap/js/popper.min.js"></script>
    <script src="plugins/bootstrap/js/bootstrap.min.js"></script>
    <!-- Slick Slider -->
    <script src="plugins/slick-carousel/slick/slick.min.js"></script>
    <script src="js/jquery.easing.1.3.js"></script>
    <!-- Map Js -->
    <script src="plugins/google-map/gmap3.min.js"></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDwIQh7LGryQdDDi-A603lR8NqiF3R_ycA"></script>

    <script src="js/form/contact.js"></script>
    <script src="js/theme.js"></script>

  </body>
  </html>
