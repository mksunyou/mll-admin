<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.util.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
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

<!-- 
    ================================================== -->
<%
	// 로그인이 되어있지 않은 상태
	if(session.getAttribute("sessionManager") == null) {
%>

    <section class="banner-area py-5" id="banner">
       <div class="overlay"></div>
        <!-- Content -->
        <div class="container">
            <div class="row  align-items-center justify-content-center">
                <div class="col-md-12 col-lg-8">
                   <div class="banner-content text-center text-lg-left">
                        <!-- Heading -->
                        <h1 class="display-4 mb-5 ">
                           	Manager Hompage
                        </h1>

                        <!-- Subheading -->
                        <p class="lead mb-5">
                            
                        </p>

                    </div>
                </div>
                
                <div class="col-lg-4 ">
                    <div class="banner-contact-form bg-white">
                       <form action="<%=request.getContextPath()%>/manager/loginManagerAction.jsp" method="post">
                            <div class="form-group">
                                id : <input type="text" name="managerId" class="form-control" placeholder="your ID">
                            </div>
                            <div class="form-group">
                                password : <input type="password" name="managerPw" class="form-control" placeholder="your password">
                            </div>
                            <button type="submit" class="btn btn-dark btn-block btn-circled">Login</button>
                            <a href="<%=request.getContextPath()%>/insertManagerForm.jsp">Manager register</a>
                        </form>
                    </div>
                </div>
                
					
            </div> <!-- / .row -->
        </div> <!-- / .container -->
    </section>

<footer class="section " id="footer">
        <div class="overlay footer-overlay"></div>
        <!--Content -->
        <div class="container">
            <div class="row justify-content-start">
                <div class="col-lg-4 col-sm-12">
                    <div class="footer-widget">
                        <!-- Brand -->
                        <p class="footer-brand text-white">
                            List of managers awaiting approval
                        </p>
                    </div>
                </div>

                <div class="col-lg-3 ml-lg-auto col-sm-12">
                    <div class="footer-widget">
                        <h3>managerId</h3>
                        <!-- Links -->
<%		
					ArrayList<Manager> list = ManagerDao.selectManagerListByZero();
					for(Manager m : list){
%>
                        <ul class="footer-links ">
                            <li>
                                <p>
                                    <%=m.getManagerId()%>
                                </p>
                            </li>
                        </ul>
<%
}
%>
                    </div>
                </div>
                
                <div class="col-lg-3 ml-lg-auto col-sm-12">
                    <div class="footer-widget">
                        <h3>managerDate</h3>
                        <!-- Links -->
<%		
					
					for(Manager m : list){
%>
                        <ul class="footer-links ">
                            <li>
                                <p>
                                    <%=m.getManagerDate()%>
                                </p>
                            </li>
                        </ul>
<%
}
%>
 					 </div>
                </div>
   	 </div>
</footer>
<%

	//로그인이 되어있는 상태
	} else { 
		Manager manager = (Manager)(session.getAttribute("sessionManager"));
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
                       	 	<%=manager.getManagerName()%>님 반갑습니다.<br> 당신의 레벨은 <%=manager.getManagerLevel()%> 입니다.</h1>
                    </div>
                </div>
            </div> <!-- / .row -->
        </div> <!-- / .container -->
    </section>



<section class="section" id="service">
        <div class="container">
            <div class="row justify-content-center mb-5">
                <div class="col-lg-7 pl-4 text-center">
                    <div class="service-heading">
                        <h1>Update List</h1>
                    </div>
                </div>
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
		
            <div class="row justify-content-center">
                <div class="col-lg-4 col-md-6">
                    <div class="service-block media">
                        <div class="service-inner-content media-body">
                            <h4>noticeList</h4><a href="<%=request.getContextPath()%>/noticeList.jsp">more</a>
                            <table class="table">
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
                    </div>
                </div>
                
                <div class="col-lg-4 mb-3 col-md-6">
                    <div class="service-block media">
                        <div class="service-inner-content media-body">
                            <h4>managerList</h4><a href="<%=request.getContextPath()%>/managerList.jsp">more</a>
                            <table class="table">
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
                    </div>
                </div>
                
                <div class="col-lg-4 mb-3 col-md-6">
                    <div class="service-block media ">
                        <div class="service-inner-content media-body">
                            <h4>clientList</h4><a href="<%=request.getContextPath()%>/clientList.jsp">more</a>
                            <table class="table">
                            <%
                            	for(Client c : clientList) {
							%>
                            <tr>
								<td><%=c.getClientMail() %></td>
								<td><%=c.getClientDate().substring(0,11) %></td>
							</tr>
							<%
								}
							%>
							</table>
						</div>
                    </div>
                </div>
                
                <div class="col-lg-4 mb-3 col-md-6">
                    <div class="service-block media ">
                        <div class="service-inner-content media-body">
                            <h4>ebookList</h4><a href="<%=request.getContextPath()%>/ebookList.jsp">more</a>
								<table class="table">
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
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="service-block media">
                        <div class="service-inner-content media-body">
                            <h4>ordersList</h4><a href="<%=request.getContextPath()%>/noticeList.jsp">more</a>
								<table class="table">
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
                    </div>
                </div>
             </div>
    </section>


    <!--  Page Scroll to Top  -->

    <a class="scroll-to-top js-scroll-trigger" href="#top-header">
        <i class="fa fa-angle-up"></i>
    </a>
<%		
	}
%>	

   


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
   