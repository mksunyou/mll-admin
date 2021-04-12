package gdu.mall.dao;
import gdu.mall.util.*;
import gdu.mall.vo.*;
import java.util.*;
import java.sql.*;
public class EbookDao {
	//삭제 메소드
	public static int deleteEbook(String ebookISBN) throws Exception  {
		//1.sql
		String sql = "DELETE FROM ebook WHERE ebook_isbn=?";
		
		//2.return값 초기화
		int rowCnt = 0;
		
		//3.DB실행 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebookISBN);
		System.out.println("삭제stmt"+stmt);
		rowCnt = stmt.executeUpdate();
		
		//return
		return rowCnt;
	}
	
	//전체수정 메소드
	public static int updateEbookOne(Ebook ebook) throws Exception {
		
		//1.sql
		String sql="UPDATE ebook SET ebook_state=?, ebook_ISBN=?, ebook_Title=?, category_name=?, ebook_author=?, ebook_company=?, ebook_page_count=?, ebook_price=?, ebook_summary=? WHERE ebook_isbn=?";
		
		//2.return값 초기화
		int rowCnt = 0;
		
		//3.DB처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookState());
		stmt.setString(2, ebook.getEbookISBN());
		stmt.setString(3, ebook.getEbookTitle());
		stmt.setString(4, ebook.getCategoryName());
		stmt.setString(5, ebook.getEbookAuthor());
		stmt.setString(6, ebook.getEbookCompany());
		stmt.setInt(7, ebook.getEbookPageCount());
		stmt.setInt(8, ebook.getEbookPrice());
		stmt.setString(9, ebook.getEbookSummary());
		stmt.setString(10, ebook.getEbookISBN());
		rowCnt = stmt.executeUpdate();
		
		//디버깅
		System.out.println(stmt + "<-- ebookOne수정stmt");
		
		// 4. 리턴
		return rowCnt;
		
	}
	
	//개별수정 메소드		
		//책 요약 수정
	public static int updateEbookSummary(Ebook ebook) throws Exception{
		
		//1.sql
		String sql = "UPDATE ebook SET ebook_summary=? WHERE ebook_isbn=?";
		
		//2.return값 초기화
		int rowCnt = 0;
		
		//3.DB처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,ebook.getEbookSummary());
		stmt.setString(2,ebook.getEbookISBN());
		
		//디버깅
		System.out.println("ebookSummary수정stmt"+stmt);
		
		rowCnt = stmt.executeUpdate();
		
		//4.리턴
		return rowCnt;	
	}
	
		//ebookState수정
	public static int updateEbookState(Ebook ebook) throws Exception{
		
		//1.sql
		String sql = "UPDATE ebook SET ebook_state=? WHERE ebook_isbn=?";
		
		//2.return값 초기화
		int rowCnt = 0;
		
		//3.DB처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,ebook.getEbookState());
		stmt.setString(2,ebook.getEbookISBN());
		
		//디버깅
		System.out.println("ebookState수정stmt"+stmt);
		
		rowCnt = stmt.executeUpdate();
		
		//4.리턴S
		return rowCnt;	
	}
		
		//ebookState list
	
		public static String[] ebookStateList() throws Exception{
			//
			String[] list = {"판매중", "품절", "구편절판", "절판"};
			
			return list;
		}

	
		//ebookImg수정
	public static int updateEbookImg(Ebook ebook) throws Exception {
		
		//1.sql
		String sql = "UPDATE ebook SET ebook_img=? WHERE ebook_isbn=?";
		 
		//2.return값 초기화
		int rowCnt=0;
		 //3.DB 실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,ebook.getEbookImg());
		stmt.setString(2,ebook.getEbookISBN());
		System.out.println("ebookImg수정stmt"+stmt);
		rowCnt = stmt.executeUpdate();
		
		//4.리턴
		return rowCnt;
	}
	
	//ISBN 중복제거
	public static String selectEbookISBN(String ebookISBN) throws Exception {
		
		//1.sql
		String sql = "SELECT ebook_isbn ebookISBN from ebook where ebook_isbn = ?";
		
		//2.return타입 초기화
		String returnEbookISBN = null;
		
		//3.DB 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,ebookISBN);
		System.out.println("ISBN중복stmt"+stmt);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			returnEbookISBN = rs.getString("ebook_isbn");
		}
		
		//4.리턴
		return returnEbookISBN;
	}
			
	//상세보기
	public static Ebook selectEbookOne(String ebookISBN) throws Exception {
		//1.sql
		String sql = "SELECT ebook_no ebookNo, ebook_isbn ebookISBN, category_name categoryName, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_company ebookCompany, ebook_page_count ebookPageCount, ebook_price ebookPrice, ebook_summary ebookSummary, ebook_img ebookImg, ebook_date ebookDate, ebook_state ebookState FROM ebook WHERE ebook_isbn = ?";
		
		//2.return값 초기화
		Ebook ebook = new Ebook();
		
		//3.DB실행 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebookISBN);
		System.out.println("ebookOne stmt"+stmt);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			ebook.setEbookNo(rs.getInt("ebookNo"));
			ebook.setEbookISBN(rs.getString("ebookISBN"));
			ebook.setCategoryName(rs.getString("categoryName"));
			ebook.setEbookTitle(rs.getString("ebookTitle"));
			ebook.setEbookAuthor(rs.getString("ebookAuthor"));
			ebook.setEbookCompany(rs.getString("ebookCompany"));
			ebook.setEbookPageCount(rs.getInt("ebookPageCount"));
			ebook.setEbookPrice(rs.getInt("ebookPrice"));
			ebook.setEbookImg(rs.getString("ebookImg"));
			ebook.setEbookSummary(rs.getString("ebookSummary"));
			ebook.setEbookDate(rs.getString("ebookDate"));
			ebook.setEbookState(rs.getString("ebookState"));
		}
		
		//return
		return ebook;
	}
	
	
	//입력 (매개변수가 많을때 dao를 따로 만들어 관리. column이 추가 되거나 관리하기 용이 ex)insertEbookAction)
	public static int insertEbook(Ebook ebook) throws Exception {
		
		//1. sql
		String sql="INSERT INTO ebook(ebook_isbn, category_name, ebook_title, ebook_author, ebook_company, ebook_page_count, ebook_price, ebook_summary, ebook_img, ebook_date, ebook_state) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'default.jpg', NOW(), '판매중')";
		
		//2. return값 초기화
		int rowCnt = 0;
		
		//3.DB처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookISBN());
		stmt.setString(2, ebook.getCategoryName());
		stmt.setString(3, ebook.getEbookTitle());
		stmt.setString(4, ebook.getEbookAuthor());
		stmt.setString(5, ebook.getEbookCompany());
		stmt.setInt(6, ebook.getEbookPageCount());
		stmt.setInt(7, ebook.getEbookPrice());
		stmt.setString(8, ebook.getEbookSummary());
		System.out.println("입력stmt"+stmt);
		
		rowCnt = stmt.executeUpdate();
		
		//4.return
		return rowCnt;
				
	}
	
	//전체 행의 수
	public static int ebookTotalCount(String byCategoryName) throws Exception {
	
		//2.return값 초기화
		int ebookTotalRow = 0;
		
		//3.DB진행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		String sql="";
		if(byCategoryName.equals("")) {
			sql="SELECT COUNT(*) cnt FROM ebook";
			stmt = conn.prepareStatement(sql);
			
		} else {
			sql="SELECT COUNT(*) cnt FROM ebook WHERE category_name LIKE ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+byCategoryName+"%");
		}
		
		System.out.println("카테고리 전체행의수"+stmt);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			ebookTotalRow = rs.getInt("cnt");
		}
		
		//4.리턴
		return ebookTotalRow;
	}
	
	//목록
	public static ArrayList<Ebook> selectEbookList(int rowPerPage, int beginRow, String byCategoryName) throws Exception {
				
		//2.return값 초기화
		ArrayList<Ebook> list = new ArrayList<>();
		
		//3.DB진행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		String sql = "";
		
		if(byCategoryName.equals("")) {
			sql = "SELECT category_name categoryName, ebook_isbn ebookISBN, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_date ebookDate, ebook_price ebookPrice FROM ebook ORDER BY ebook_date DESC LIMIT ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
		
		} else {
			sql = "SELECT category_name categoryName, ebook_isbn ebookISBN, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_date ebookDate, ebook_price ebookPrice FROM ebook where category_name LIKE ? ORDER BY ebook_date DESC LIMIT ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1,byCategoryName);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
		}
		
		
		//디버깅
		System.out.println("목록 stmt"+stmt);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Ebook e = new Ebook();
			e.setCategoryName(rs.getString("categoryName"));
			e.setEbookISBN(rs.getString("ebookISBN"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookAuthor(rs.getString("ebookAuthor"));
			e.setEbookDate(rs.getString("ebookDate"));
			e.setEbookPrice(rs.getInt("ebookPrice"));
			list.add(e);			
		}
		//4. 리턴
		return list;
	}
}
