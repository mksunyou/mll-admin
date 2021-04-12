<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.util.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	// 관리자
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager==null || manager.getManagerLevel()<1){
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

<!-- 
    ================================================== -->
<%
	String ebookISBN = request.getParameter("ebookISBN");
	System.out.println(ebookISBN+" <-- param ebookISBN");

	Ebook ebook = EbookDao.selectEbookOne(ebookISBN);
	String[] ebookStateList = EbookDao.ebookStateList();
	
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
                           ebook One
                        </h2>
                    </div>
                </div>
            </div> <!-- / .row -->
            
            
               
           	 <div class="contact-info-block text-center">
				<div class="row justify-content-center">
                  	<div class="footer-widget">
                  		<form action="<%=request.getContextPath()%>/ebook/updateEbookStateAction.jsp" method="post">
                        <table class="table list-unstyled ml-lg-auto  text-center">
                        	<tr>
			<td>ebookNo</td>
			<td><%=ebook.getEbookNo() %></td>
			<td>&nbsp;</td>
		</tr>
		
		<tr>
			<td>ebookISBN</td>
			<td><%=ebook.getEbookISBN() %></td>
			<td>&nbsp;</td>
		</tr>
		
		<tr>
			<td>categoryName</td>
			<td><%=ebook.getCategoryName()%></td>
			<td>&nbsp;</td>
		</tr>
		
		<tr>
			<td>ebookTitle</td>
			<td><%=ebook.getEbookTitle() %></td>
			<td>&nbsp;</td>
		</tr>
		
		<tr>
			<td>ebookAuthor</td>
			<td><%=ebook.getEbookAuthor() %></td>
			<td>&nbsp;</td>
		</tr>
		
		<tr>
			<td>ebookCompany</td>
			<td><%=ebook.getEbookCompany() %></td>
			<td>&nbsp;</td>
		</tr>
		
		<tr>
			<td>ebookPageCount</td>
			<td><%=ebook.getEbookPageCount()%></td>
			<td>&nbsp;</td>
		</tr>
		
		<tr>
			<td>ebookPrice</td>
			<td><%=ebook.getEbookPrice()%></td>
			<td>&nbsp;</td>
		</tr>
		
		<tr>
			<td>ebookImg</td>
			<td><img src="<%=request.getContextPath()%>/img/<%=ebook.getEbookImg()%>"></td>
			<td>
				<a href="<%=request.getContextPath()%>/updateEbookImgForm.jsp?ebookISBN=<%=ebook.getEbookISBN()%>">
					<button type="button" class="btn">이미지 수정</button>
				</a>
			</td>
		</tr>
		
		
		<tr>
			<td>ebookSummary</td>
			<td><%=ebook.getEbookSummary()%></td>
			<td>
				<a href="<%=request.getContextPath()%>/updateEbookSummaryForm.jsp?ebookISBN=<%=ebook.getEbookISBN()%>">
					<button type="button" class="btn">책요약 수정</button>
				</a>
			</td>			
		</tr>
		
		<tr>
			<td>ebookDate</td>
			<td><%=ebook.getEbookDate()%></td>
			<td>&nbsp;</td>
		</tr>
		
	
		<tr>
			<td>ebookState</td>
			<td>
				<input type="hidden" name="ebookISBN" value="<%=ebook.getEbookISBN()%>">
					<select name="ebookState">
						<%
							for(String esl : ebookStateList) {
								if(esl.equals(ebook.getEbookState())) {
						%>
						 			<option value="<%=esl%>" selected="selected"><%=esl%></option>
						<%
								} else { 
						%>
									<option value = "<%=esl%>"><%=esl%></option>
						<%
								}
							}
						%>
					</select>
			</td>	
			<td><button type="submit" class="btn">책상태 수정</button></td>
		</tr>
		
		</table>
		</form>
		<div>
			<a href="<%=request.getContextPath()%>/updateEbookOneForm.jsp?ebookISBN=<%=ebookISBN%>">
				<button type="button" class="btn">전체 수정(이미지 제외)</button>
			</a>
			
			<a href="<%=request.getContextPath()%>/ebook/deleteEbookAction.jsp?ebookISBN=<%=ebookISBN%>">
				<button type="button" class="btn">삭제</button>
			</a>
		</div>
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
   