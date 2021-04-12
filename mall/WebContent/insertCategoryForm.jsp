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
 <!-- /LOADER TEMPLATE -->


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


  <!-- SECTIONS
    ================================================== -->
    

    <section class="section" id="contact">
        <div class="container">
            <div class="row mb-4">
                <div class="col-md-8 col-lg-6 ">
                  
                    <!-- Heading -->
                    <h2 class="section-title mb-2 ">
                        Insert category
                    </h2>
					<a href="<%=request.getContextPath()%>/categoryList.jsp">Category list</a>
                </div>
            </div> <!-- / .row -->

            <div class="row">
                <div class="col-lg-6">
                   <!-- form message -->
                    <div class="row">
                        <div class="col-12">
                            <div class="alert alert-success contact__msg" style="display: none" role="alert">
                                Your message was sent successfully.
                            </div>
                        </div>
                    </div>
                    <!-- end message -->
                    <!-- Contacts Form -->
                    <form class="contact_form" action="<%=request.getContextPath()%>/insertCategoryAction.jsp" method="post">
                        <div class="row">
                            <!-- Input -->
                            <div class="col-sm-6 mb-6">
                                <div class="form-group">
                                    <label class="h6 small d-block text-uppercase">
                                        categoryName
                                        <span class="text-danger">*</span>
                                    </label>

                                    <div class="input-group">
                                        <input class="form-control" type="text" name="categoryName">
                                    </div>
                                    <br>
                                    <div>
			                           <input name="submit" type="submit" class="btn btn-primary btn-circled" value="Insert Category">
			                           
			                        </div>
                                </div>
                            </div>
                           
                       </div>
                    </form>
                    <!-- End Contacts Form -->
                </div>
            </div>
        </div>
    </section>
 


    <!--  Page Scroll to Top  -->

    <a class="scroll-to-top js-scroll-trigger" href="#top-header">
        <i class="fa fa-angle-up"></i>
    </a>


   


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
   