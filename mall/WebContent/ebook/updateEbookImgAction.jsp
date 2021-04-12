<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.util.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
//관리자 인증 코드
Manager manager = (Manager)session.getAttribute("sessionManager");
if(manager==null || manager.getManagerLevel()<1){
	response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
	return;
}

	//request~ 이런거 사용X.
	/* why null? enctype으로 넘겼기 때문에 null값이 나옴. com.의 메소드를 사용해야함.
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookImg = request.getParameter("ebookImg");
	System.out.println("updateEbookImgAction ->ebookISBN"+ebookISBN);
	System.out.println("updateEbookImgAction ->ebookImg"+ebookImg);
	*/
	
	//파일을 다운로드 받을 위치 찾아주도록
	//새로고침 바로 확인 가능하나 폴더에서는 확인X
	//String path = application.getRealPath("img");//application은 프로젝트 톰캣, img 파일을 알아서 찾음.// img라는 폴더의 OS상의 실제 폴더
	//새로고침하면 확인 가능 하고 폴더에서도 확인 가능
	String path = "C:/goodee/mall/WebContent/img";
	System.out.println(path);
	int size = 1024 * 1024 * 100; //100MB
	
	//3번째는 파일 크기 최대값 지정, 4번째는 인코딩 방식, 5번째는 중복된 방식이 있으면 처리하지 않음.
	MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8",new DefaultFileRenamePolicy());//multipartrequest는 우리가 해석하지 못하는 매개변서를 해석하도록 보내버림.
	String ebookISBN = multi.getParameter("ebookISBN");
	String ebookImg = multi.getFilesystemName("ebookImg");//DefaultFileRenamePolicy()으로 변형된 이름을 받아야 하기 때문에 getFilesystemName
	System.out.println(ebookISBN);
	System.out.println(ebookImg);
	
	Ebook ebook = new Ebook();
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookImg(ebookImg);
	EbookDao.updateEbookImg(ebook);
	response.sendRedirect(request.getContextPath()+"/ebookOne.jsp?ebookISBN="+ebookISBN);
	
%>