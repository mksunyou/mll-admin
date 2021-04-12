package gdu.mall.dao;
import gdu.mall.util.*;
import gdu.mall.vo.*;
import java.util.*;
import java.sql.*;
public class ClientDao {
	
	//전체 행의 수
	public static int totalCount(String searchWord) throws Exception { //예외를 처리하지 않겠다.
		

		int totalRow = 0;
		
		Connection conn = DBUtil.getConnection();//DBUtil에 class for name 작성.  
		PreparedStatement stmt= null;
		String sql = "";
		if(searchWord.equals("") ) {
			sql="SELECT COUNT(*) cnt FROM client";
			stmt = conn.prepareStatement(sql);
		} else {
			sql="SELECT COUNT(*) cnt FROM client WHERE client_mail LIKE ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
		}
		
		//2. return값 초기화
		
		System.out.println("전체행의수 stmt :"+stmt);//전체 행의수의 디버깅
		ResultSet rs = stmt.executeQuery();//쿼리문 실행 결과가 rs
		
		while(rs.next()) {// 모든 데이터를 출력.
			totalRow = rs.getInt("cnt");
			//전체행은 rs.getInt에서 나온 데이터의 총 개수, count(*)를 cnt로 받아 진행
		}
		//4. 리턴
		return totalRow;//총데이터 개수 반환 
	}
	
	// 목록
	public static ArrayList<Client> selectClientListByPage(int rowPerPage, int beginRow, String searchWord) throws Exception {
		
		//2.return타입 초기화
		ArrayList<Client> list = new ArrayList<>();
		
		//3. 처리
		Connection conn = DBUtil.getConnection();
		
		PreparedStatement stmt = null;
		String sql="";
		
		if(searchWord.equals("")) {//검색어가 없으면, if(!searchWord.equals("") 와 같다.
			sql="SELECT client_mail clientMail, client_date clientDate FROM client ORDER BY client_date DESC LIMIT ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
		} else {//검색어가 있으면
			sql="SELECT client_mail clientMail, client_date clientDate FROM client WHERE client_mail LIKE ? ORDER BY client_date DESC LIMIT ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1,"%"+searchWord+"%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
		}
		System.out.println("목록 stmt :"+stmt);//목록 stmt의 디버깅
		
		ResultSet rs = stmt.executeQuery();//쿼리문 실행과가 rs
		
		//1.sql
				/*
				 * SELECT client_mail clientMail,client_date clientDate
				 * FROM client
				 * ORDER BY client_date DESC
				 * LIMIT ?,? //물음표는 selectClientListByPage()에서 받아와야한다.
				 */
		
		//4. 리턴
		while(rs.next()) { //rs의 모든 데이터를 출력, 없을때까지...
			Client c = new Client();
			c.setClientMail(rs.getString("clientMail"));
			c.setClientDate(rs.getString("clientDate"));
			list.add(c); //계속해서 데이터 추가.
			
		}
		return list;
	}
	//삭제 메소드
	public static int deleteClient(String clientMail) throws Exception {
		//1.sql
		String sql="DELETE FROM client WHERE client_mail=?";
		
		//2.return값 초기화
		int rowCnt = 0;
		
		//3.DB실행 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, clientMail);
		System.out.println("삭제 stmt"+stmt);//디버깅
		rowCnt = stmt.executeUpdate();
				
		//return
		return rowCnt;
	}
	
	//수정메소드
	public static int updateClientPw(String clientPw) throws Exception{
		//1.sql
		String sql = "UPDATE client SET client_pw=? where client_no=?";
		
		//2.return값 초기화
		int rowCnt = 0;
		
		//3.코드구현
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, clientPw);
		System.out.println("수정 stmt"+stmt);//디버깅
		rowCnt = stmt.executeUpdate();
		
		//return
		return rowCnt;		
	}
	//update 목록 메소드
	
	public static ArrayList<Client> updateClientList(String clientMail) throws Exception{
		//1.sql
		String sql = "SELECT client_no clientNo, client_mail clientMail, client_pw clientPw, client_date clientDate FROM client";
		
		//2.return값 초기화
		ArrayList<Client> list = new ArrayList<>();
		
		//3.처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			Client c = new Client();
			c.setClientNo(rs.getInt("clientNo"));
			c.setClientMail(rs.getString("clientMail"));
			c.setClientPw(rs.getString("clientPw"));
			c.setClientDate(rs.getString("clientDate"));
			list.add(c);
		}
		//4. 리턴
		return list;
				
		
	}
}

