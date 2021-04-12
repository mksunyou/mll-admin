<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.util.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	//로그인이 되어있지 않거나 매니저 레벨이 1 미만일때 return.
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
<!-- rowPerPage별 페이징 -->
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
		
		//검색 searchWord 선언
		String byCategoryName = "";//searchWord가 공백이면 검색어가 없고, 공백이 아니면 검색어가 있는것.
		if(request.getParameter("byCategoryName") !=null){
			byCategoryName = request.getParameter("byCategoryName");
		}
		
		//시작 행
		int beginRow = (currentPage-1) * rowPerPage;
		
		//총 행의 수
		int ebookTotalRow = EbookDao.ebookTotalCount(byCategoryName);
		System.out.println("ebook 전체 행의 수:"+ebookTotalRow);
		
		// 보여지는 카테고리 목록	
		ArrayList<Ebook> ebookList = EbookDao.selectEbookList(rowPerPage, beginRow,byCategoryName);
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
                           List of Ebook
                        </h2>
                    </div>
                </div>
            </div> <!-- / .row -->
           
<ul class="nav list-inline ml-auto">       
  		
		<!-- categoryName이 0이면, -->
				<li>View by Category</li>
					<li><a href="<%=request.getContextPath()%>/ebookList.jsp"><button type="button" class="btn">[ALL]</button></a></li>
						<%
							ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
							for(String s : categoryNameList){
						%>
						
							<li>
								<form action="<%=request.getContextPath()%>/ebookList.jsp" method="post">
									<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">
									<a href="<%=request.getContextPath()%>/ebookList.jsp?byCategoryName=<%=s%>"><button type="button" class="btn">[<%=s%>]</button></a>
								</form>
							</li>
						
				
						<%
							}
						%>
	
	<li><a href="<%=request.getContextPath()%>/insertEbookForm.jsp"><button type="button" class="btn">ebook 추가</button></a></li>
</ul> 
	<!-- rowPerPage별 페이징 (목록 5의 배수만큼 보여주기) -->
	<form action="<%=request.getContextPath()%>/ebookList.jsp" method="post">
	<input type="hidden" name="byCategoryName" value="<%=byCategoryName%>">
		<select name="rowPerPage">
			<%
				for(int i=10;i<31;i+=5){
					if(rowPerPage==i){
			%>
						<option value="<%=i%>" selected="selected"><%=i%></option>
			<%			
					} else {
			%>
						<option value="<%=i%>"><%=i%></option>
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
				<th>categoryName</th>
				<th>ebookISBN</th>
				<th>ebookTitle</th><!-- 타이틀 누르면 summary -->
				<th>ebookAuthor</th>
				<th>ebookDate</th>
				<th>ebookPrice</th>
			</tr>
		</thead>
		<tbody>
		<%
				for(Ebook e : ebookList){
			%>
				<tr>
					<td><%=e.getCategoryName() %></td>
					<td><%=e.getEbookISBN() %></td>
					<td><a href="<%=request.getContextPath()%>/ebookOne.jsp?ebookISBN=<%=e.getEbookISBN()%>"><%=e.getEbookTitle() %></a></td>
					<td><%=e.getEbookAuthor() %></td>
					<td><%=e.getEbookDate()%></td>
					<td><%=e.getEbookPrice()%></td>
				</tr>
			<%
			}
			%>
		</tbody>
		</table>
		
		<!-- 페이징 -->
		<%
			if(currentPage>1){
		%>
			<a href="<%=request.getContextPath()%>/ebookList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&byCategoryName=<%=byCategoryName%>"><button type="button" class="btn">이전</button></a>
		<%
		}
		//마지막 페이지에서 다음버튼 없애기.
		
		int lastPage = ebookTotalRow / rowPerPage;
		
		if(ebookTotalRow % rowPerPage != 0){//ebooktotalrow에서 rowperpage를 나눈 나머지가 0이 아니면
			lastPage +=1;//lastPage = lastPage+1			
		}
		if (currentPage<lastPage){//마지막 페이지가 아니면,
		%>
			<a href="<%=request.getContextPath()%>/ebookList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&byCategoryName=<%=byCategoryName%>"><button type="button" class="btn">다음</button></a>
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
   