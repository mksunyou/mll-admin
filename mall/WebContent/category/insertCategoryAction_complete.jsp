<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%
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
 <!-- /LOADER TEMPLATE -->


<%
	//1.수집
	request.setCharacterEncoding("UTF-8");
	String categoryName = request.getParameter("categoryName");
	System.out.println("추가될 categoryName: "+categoryName);	
	
	//2-1. 중복된 categoryName이 있으면 다시 추가폼.
	String returnCategoryName = CategoryDao.selectCategoryName(categoryName);
	if(returnCategoryName !=null){//이미 존재하는 카테고리라면,
		System.out.println("이미 존재하는 카테고리입니다.");
		response.sendRedirect(request.getContextPath()+"/insertCategoryForm.jsp");
		return;
	}
	//2-2. 중복된 아이디가 없으면 입력
	
	CategoryDao.insertCategory(categoryName);
	
	//3. 출력
%>
<div class="row">
                <div class="col-lg-6">
                   <!-- form message -->
                    <div class="row">
                        <div class="col-12">
                            <div class="alert alert-success contact__msg" style="display: none" role="alert">
                                You have successfully registered successfully registered a category.
                                <a href="<%=request.getContextPath()%>/categoryList.jsp">카테고리 리스트</a>
                            </div>
                        </div>
                    </div>
				</div>
</div>

</body>
</html>