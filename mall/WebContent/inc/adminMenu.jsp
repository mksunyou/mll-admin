<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<nav class="navbar navbar-expand-lg navbar-dark trans-navigation fixed-top navbar-togglable">
        <div class="container">
            <a class="navbar-brand" href="<%=request.getContextPath()%>/adminIndex.jsp">
                <h3>Manager Home Page</h3>
            </a>
            <!-- Toggler -->
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                <span class="fa fa-bars"></span>
            </button>

            <!-- Collapse -->
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <!-- Links -->
<ul class="navbar-nav ml-auto">
		
	<li class="nav-link js-scroll-trigger ">
		<a href="<%=request.getContextPath()%>/managerList.jsp"class="nav-link js-scroll-trigger"> 
			Manager management
		</a>
	</li>
	
	<li class="nav-link js-scroll-trigger">
		<a href="<%=request.getContextPath()%>/clientList.jsp"class="nav-link js-scroll-trigger"> 
			Client management
		</a>
	</li>
	
	<li class="nav-link js-scroll-trigger">
		<a href="<%=request.getContextPath()%>/categoryList.jsp"class="nav-link js-scroll-trigger"> 
			Category management
		</a>
	</li>
	
	<li class="nav-item ">
		<a href="<%=request.getContextPath()%>/ebookList.jsp"class="nav-link js-scroll-trigger"> 
			Ebook management
		</a>
	</li>
	
	<!-- order by 때문에 order을 입력할 수 없음. -->
	<li class="nav-item ">
		<a href="<%=request.getContextPath()%>/ordersList.jsp"class="nav-link js-scroll-trigger"> 
			Order management
		</a>
	</li>
	
	<!-- 목록출력 R(level 1이상) CUD(level 2이상) -->
	<li class="nav-item ">
		<a href="<%=request.getContextPath()%>/noticeList.jsp"class="nav-link js-scroll-trigger"> 
			Notice management
		</a>
	</li>
	
	<li class="nav-item ">
		<a href="<%=request.getContextPath()%>/manager/logoutManagerAction.jsp"class="nav-link js-scroll-trigger"> 
			Logout
		</a>
	</li>
</ul>
</div> <!-- / .navbar-collapse -->
        </div> <!-- / .container -->
    </nav>
