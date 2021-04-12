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
<%
	
		// 현재페이지
		int currentPage=10;
		if(request.getParameter("currentPage") != null){//만약 현재 페이지의 데이터를 받아오면 그대로 실행.
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		//페이지당 행의 수
		int rowPerPage=10;
		if(request.getParameter("rowPerPage") != null){//만약 rowPerPage의 값을 받아오면 그대로 실행.
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		}
		
		//검색 searchWord 선언
		String searchWord = "";//searchWord가 공백이면 검색어가 없고, 공백이 아니면 검색어가 있는것.
		if(request.getParameter("searchWord") !=null){
			searchWord = request.getParameter("searchWord");
		}
		
		
		//시작 행
		int beginRow= (currentPage-1) * rowPerPage;
		
		//총 행의 수
		int totalRow = ClientDao.totalCount(searchWord);//ClientDao에서 선언한 totalCount 가져옴.
		System.out.println("전체 행의수:"+totalRow);//totalRow의 디버깅. 
		
		//list 생성
		ArrayList<Client> list = ClientDao.selectClientListByPage(rowPerPage, beginRow, searchWord);
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
                           List of Client
                        </h2>
                    </div>
                </div>
            </div> <!-- / .row -->
            
            
  	<form action="<%=request.getContextPath()%>/clientList.jsp" method="post">
		<input type="hidden" name="searchWord" value="<%=searchWord%>">
		<select name="rowPerPage">
			<%
				for(int i=10; i<31; i=i+5) {
					if(rowPerPage==i){
										
			%>
						<!-- rowPerPage가  -->
						<option value="<%=i%>" selected="selected"><%=i %></option>
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
				<th>managerNo</th>
				<th>managerId</th>
				<th>Update</th>
				<th>Delete</th>
			</tr>
		</thead>
		<tbody>
		<%
					for(Client c : list) {
		%>
			<tr>
						<td><%=c.getClientMail()%></td>
						<!-- clientDate를 11자리까지 끊음 -->
						<td><%=c.getClientDate().substring(0,11)%></td>
						<!-- update는 수정하는 폼이 있어야 하므로 form -->
						<td><a href="<%=request.getContextPath()%>/updateClientForm.jsp?clientMail=<%=c.getClientMail()%>"><button type="button" class="btn btn-outline-success btn-circled">수정</button></a></td>
						<!-- delete는 바로 삭제 되므로 바로 action -->
						<td><a href="<%=request.getContextPath()%>/client/deleteClientAction.jsp?clientMail=<%=c.getClientMail()%>"><button type="button" class="btn btn-outline-success btn-circled">삭제</button></a></td>
					</tr>
				<%			
					}				
				%>
		</tbody>
		</table>
		<!-- 페이지 넘김 -->
			
			<%
				if(currentPage>1) {
			%>
					<a href="<%=request.getContextPath()%>/clientList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">이전</a>
			<%
				}
			
				int lastPage = totalRow / rowPerPage;
				
				if(totalRow % rowPerPage != 0) { //모든 줄에서 10을 나눈 나머지가 0이 아니면 페이지 하나를 추가 하겠다. 
					lastPage += 1; // lastPage = lastPage+1; lastPage++;
				}
			%>
			<%
				if(currentPage<lastPage) {
			%>
					<a href="<%=request.getContextPath()%>/clientList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">다음</a>
			<%
				}
			%>
			
			<!-- 검색, 검색어를 넘길때 rowPerPage가 빠져있었기때문에 hidden으로  -->
			<form action="<%=request.getContextPath()%>/clientList.jsp" method="post">
				<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">
				<div>
					client Mail :
					<input type="text" name="searchWord">
					<button type="submit" class="btn">검색</button>
				</div>
						
			</form>
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
   