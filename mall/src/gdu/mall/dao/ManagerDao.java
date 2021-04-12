package gdu.mall.dao;
import gdu.mall.vo.*;
import gdu.mall.util.*;
import java.util.*;
import java.sql.*;
public class ManagerDao {
	//승인 대기중인 매니저 목록
	public static ArrayList<Manager> selectManagerListByZero() throws Exception {
			
		//sql
		String sql="select manager_id managerId, manager_date managerDate from manager where manager_level=0";
		
		//return초기화
		ArrayList<Manager> list = new ArrayList<>();
		
		//DB처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Manager m = new Manager();
			m.setManagerId(rs.getString("managerId"));
			m.setManagerDate(rs.getString("managerDate"));
			list.add(m);
		}
		//4. 리턴
		return list;
	}
		
	
	//수정 메소드
	//public static void updateManagerLevel(int managerNo, int managerLevel) throws Exception
	public static int updateManagerLevel(int managerNo, int managerLevel) throws Exception{//int값을 남김.
		String sql="UPDATE manager SET manager_level=? where manager_no=?";
		//2.return값 초기화
		int rowCnt = 0;
		//코드구현
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, managerLevel);
		stmt.setInt(2, managerNo);
		System.out.println(stmt);//디버깅
		rowCnt = stmt.executeUpdate();
		return rowCnt;
	}
	
	//삭제 메소드
	public static int deleteManager(int managerNo) throws Exception {
		//1. sql
		String sql="DELETE FROM manager WHERE manager_no=?";
		//2.return값 초기화
		int rowCnt = 0;
		//코드구현
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, managerNo);
		System.out.println(stmt);//디버깅
		rowCnt = stmt.executeUpdate();
		return rowCnt;
	}
	
	//전체 행의 수
	public static int managerTotalCount() throws Exception {
								
		//1.sql
		String sql="SELECT COUNT(*) cnt FROM manager";
									
		//2.return값 초기화
		int TotalRow = 0;
									
		//3.DB진행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
		TotalRow = rs.getInt("cnt");
		}
							
		//4.리턴
		return TotalRow;
		}
	
	//목록 메소드
	public static ArrayList<Manager> selectManagerList(int rowPerPage, int beginRow) throws Exception {
		//1. sql
		/*
		 *SELECT 
			 *manager_no managerNo,
			 *manager_id managerPw, 
			 *manager_name managerName, 
			 *manager_date managerDate, 
			 *manager_level managerLevel 
		 *FROM manager 
		 *ORDER BY manager_level DESC, manager_date ASC;
		 */
		String sql="SELECT manager_no managerNo, manager_id managerId, manager_name managerName, manager_date managerDate, manager_level managerLevel FROM manager ORDER BY  manager_date DESC LIMIT ?,?";
		
		//2. 리턴값 초기화
		ArrayList<Manager> list = new ArrayList<>();
		
		//3. 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Manager m = new Manager();
			m.setManagerNo(rs.getInt("managerNo"));
			m.setManagerId(rs.getString("managerId"));
			m.setManagerName(rs.getString("managerName"));
			m.setManagerDate(rs.getString("managerDate"));
			m.setManagerLevel(rs.getInt("managerLevel"));
			list.add(m);
		}
		//4. 리턴
		return list;
	}
	
	//입력메소드
	public static int insertManager(String managerId, String managerPw, String managerName) throws Exception {
		//1.
		String sql="INSERT INTO manager(manager_id, manager_pw, manager_name, manager_date, manager_level) VALUES(?,?,?,now(),0)";
		//2.
		int rowCnt = 0; //입력성공시 1, 실패 0
		//3.
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,managerId);
		stmt.setString(2, managerPw);
		stmt.setString(3, managerName);
		System.out.println(stmt);
		rowCnt = stmt.executeUpdate();
		
		//중복된 부분의 수정을 용이하게 하기 위해서 변수선언. include를 사용.
		return rowCnt;
	}
	
	//ID 사용가능 여부
	public static String selectManagerId(String managerId) throws Exception {
		//1. sql문
		String sql = "SELECT manager_id FROM manager where  manager_id = ?";
		
		//2. return타입 초기화
		String returnManagerId = null;
		
		
		//3. DB 핸들링
		Connection conn = DBUtil.getConnection();
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		ResultSet rs = stmt.executeQuery();		
		if(rs.next()) {
			returnManagerId = rs.getString("manager_id");
		}
		//4.리턴
		return returnManagerId;
	}
	
	//로그인 메소드
	public static Manager login(String managerId, String managerPw) throws Exception{
		//throws Exception은 실행하다가 예외가 발생하면 난 모르겠다 라는 뜻.
		String sql = "SELECT manager_id, manager_name, manager_level FROM manager WHERE manager_id=? AND manager_pw=? AND manager_level>0";
		Manager manager = null;
		
		Connection conn = DBUtil.getConnection();
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		stmt.setString(2, managerPw);
		System.out.println(stmt + " <--login() sql");
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			manager = new Manager();
			manager.setManagerId(rs.getString("manager_id"));
			manager.setManagerName(rs.getString("manager_name"));
			manager.setManagerLevel(rs.getInt("manager_level"));
		}
		return manager;
	}
	
	
	}
	
	
