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
	// 수집 (noticeList에서 클릭한 공지 noticeNo)
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));

	//디버깅
	System.out.println(noticeNo+"<-- noticeOne의 noticeNo"); 
	
	// dao연결
	Notice notice = NoticeDao.selectNoticeOne(noticeNo);
	System.out.println(notice); // 디버깅
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
                           noticeOne
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
			<th>noticeNo</th>
			<td><%=notice.getNoticeNo()%></td>
		</tr>
		<tr>
			<th>noticeTitle</th>
			<td><%=notice.getNoticeTitle()%></td>
		</tr>
		<tr>
			<th>noticeContent</th>
			<td><%=notice.getNoticeContent()%></td>
		</tr>
		<tr>
			<th>managerId</th>
			<td><%=notice.getManagerId()%></td>
		</tr>
		<tr>
			<th>noticeDate</th>
			<td><%=notice.getNoticeDate().substring(0,11)%></td>
		</tr>
		</table>
		</form>
		<div>
			<a href="<%=request.getContextPath()%>/updateNoticeForm.jsp?noticeNo=<%=notice.getNoticeNo()%>">
				<button type="button" class="btn">Modify</button>
			</a>
			
			<a href="<%=request.getContextPath()%>/notice/deleteNoticeAction.jsp?noticeNo=<%=notice.getNoticeNo()%>">
				<button type="button" class="btn">Delete</button>
			</a>
		</div>
</div>
		</div>
        </div>
        <!-- 댓글 입력 폼 -->
	<form action="<%=request.getContextPath()%>/notice/insertCommentAction.jsp" method="post">
		<!-- 현재 공지글 넘버 사용 -->
		<input type="hidden" name="noticeNo" value="<%=notice.getNoticeNo()%>">
		
		<div>
			<!-- 세션 값 사용 -->
			manager id : 
			<input type = "text" name = "managerId" value="<%=manager.getManagerId() %>" readonly="readonly">
		</div>
		
		<div>
			<textarea name="commentContent" rows="2" cols="80"></textarea>
		</div>
		<button type="submit" class="btn">Enter comment</button>
	</form>
	
	<div class="contact-info-block text-center">
				<div class="row justify-content-center">
                  	<div class="footer-widget">
                        
	<!-- 댓글 리스트 -->
	<%
		ArrayList<Comment> commentList = CommentDao.selectCommentListByNoticeNo(noticeNo);
		for(Comment c : commentList) {
	%>
		<table class="table list-unstyled ml-lg-auto  text-center">
			<tr>
				<td><%=c.getCommentContent() %></td>
				<td><%=c.getCommentDate() %></td>
				<td><%=c.getManagerId() %></td>
				<td><a href="<%=request.getContextPath()%>/notice/deleteCommentAction.jsp?commentNo=<%=c.getCommentNo()%>&noticeNo=<%=noticeNo%>"><button type="button" class="btn">삭제</button></a></td>
			</tr>		
		</table>
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
   