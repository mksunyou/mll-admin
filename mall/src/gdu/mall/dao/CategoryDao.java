package gdu.mall.dao;
import gdu.mall.vo.*;
import gdu.mall.util.*;
import java.util.*;
import java.sql.*;
public class CategoryDao {
	//목록 메소드
	public static ArrayList<Category> selectCategoryList() throws Exception{
		//1.sql
		String sql = "SELECT category_no categoryNo, category_name categoryName, category_weight categoryWeight, category_date categoryDate FROM category ORDER BY category_date DESC";
		
		//2.리턴값 초기화
		ArrayList<Category> list = new ArrayList<Category>();
		
		//3. DB처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Category ca = new Category();
			ca.setCategoryNo(rs.getInt("categoryNo"));
			ca.setCategoryName(rs.getString("categoryName"));
			ca.setCategoryWeight(rs.getInt("categoryWeight"));
			ca.setCategoryDate(rs.getString("categoryDate"));
			list.add(ca);
		}
		//4. 리턴
		return list;
		
	}
	
	//수정 메소드
	public static int updateCategoryWeight(int categoryNo, int categoryWeight) throws Exception{
		//1.sql
		String sql="UPDATE category SET category_weight=? WHERE category_no=?";
		
		//2.return값 초기화
		int rowCnt = 0;
		
		//3. DB처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryWeight);
		stmt.setInt(2, categoryNo);
		System.out.println("수정stmt"+stmt);//수정 메소드 디버깅
		rowCnt = stmt.executeUpdate();
		
		//4.리턴
		return rowCnt;	
	}
	
	//삭제 메소드
	public static int deleteCategory(String categoryName) throws Exception{
		//1.sql
		String sql="DELETE FROM category WHERE category_Name=?";
		
		//2.return값 초기화
		int rowCnt = 0;
		
		//3.DB처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,categoryName);
		System.out.println("삭제stmt"+stmt);
		rowCnt = stmt.executeUpdate();
		
		//4.리턴
		return rowCnt;
	}
	//카테고리 추가
	public static int insertCategory(String categoryName) throws Exception{
		//1.sql
		String sql = "INSERT INTO category(category_name, category_weight, category_date) VALUES (?,0,now())";
		
		//2.return값 초기화
		int rowCnt = 0; //입력 성공시 1, 실패시 0
		
		//3.DB처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,categoryName);
		System.out.println("카테고리추가stmt"+stmt);
		rowCnt = stmt.executeUpdate();
		
		//4.리턴
		return rowCnt;
	}
	
	
	//categoryName 중복 여부
	public static String selectCategoryName(String categoryName) throws Exception{
		//1.sql
		String sql="SELECT category_name categoryName from category where category_name=?";
		
		//2.return값 초기화
		String returnCategoryName = null;
		
		//3.DB처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		System.out.println("categoryName중복stmt"+stmt);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {//rs결과값과 rcn값이 같으면, return을 되돌리겠다.
			returnCategoryName = rs.getString("category_name");			
		}
		
		//4.리턴
		return returnCategoryName;
	}
	//카테고리NameList
		public static ArrayList<String> categoryNameList() throws Exception{
			//1.sql
			String sql = "SELECT category_name categoryName FROM category ORDER BY category_date DESC";
			
			//2.리턴값 초기화
			ArrayList<String> list = new ArrayList<>();
			
			//3. DB처리
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				String cn = rs.getString("categoryName"); 
				list.add(cn);
			}
			//4.return값
			return list;
	}	
}
