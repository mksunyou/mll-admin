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
                           List of Order
                        </h2>
                    </div>
                </div>
            </div> <!-- / .row -->

           	 <div class="text-center">
				<div class="row justify-content-center">
                  	<div class="footer-widget">
                        <table class="table list-unstyled ml-lg-auto  text-center">
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
							<button type="submit" class="btn">수정</button>
						</form>
					</td>				
				</tr>
			<%
			}
			%>
		</tbody>
		</table>
		
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
