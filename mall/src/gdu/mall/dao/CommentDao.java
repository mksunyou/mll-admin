package gdu.mall.dao;
import gdu.mall.vo.*;
import gdu.mall.util.*;
import java.util.*;
import java.sql.*;
public class CommentDao {
	//댓글이 있는지 확인
	public static int selectCommentCnt(int noticeNo) throws Exception {
		
		//1.sql
		String sql = "select count(*) cnt FROM comment where notice_no=?";
		
		int rowCnt=0;

		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		
		System.out.println("selectCommentCnt: "+stmt);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			rowCnt = rs.getInt("Cnt");
		}
		
		return rowCnt;
	}
	
	
	public static int insertComment(Comment comment) throws Exception {
		//1. sql
		String sql = "INSERT INTO comment(comment_no, notice_no, manager_id,comment_content, comment_date) VALUES(?,?,?,?,now()) ";
		
		//2.return값 초기화
		int rowCnt=0;
		
		//3.DB처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, comment.getCommentNo());
		stmt.setInt(2, comment.getNoticeNo());
		stmt.setString(3,comment.getManagerId());
		stmt.setString(4,comment.getCommentContent());
		rowCnt = stmt.executeUpdate();
		
		//디버깅
		System.out.println("insertComment : "+stmt);
		
		//리턴
		return rowCnt;
	}
	
	public static ArrayList<Comment> selectCommentListByNoticeNo(int noticeNo) throws Exception {
		//select * from comment where notice_no=? (limit ?,? 페이징 하지말자.)
		
		//1.sql
		String sql = "select comment_no commentNo, notice_no noticeNo, manager_id managerId, comment_content commentContent, comment_date commentDate FROM comment where notice_no=? ORDER BY comment_date DESC";
		
		//2.리터값 초기화
		ArrayList<Comment> list = new ArrayList<Comment>();
		
		//3.DB처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Comment c = new Comment();
			c.setCommentNo(rs.getInt("commentNo"));
			c.setNoticeNo(rs.getInt("noticeNo"));
			c.setManagerId(rs.getString("managerId"));
			c.setCommentContent(rs.getString("commentContent"));
			c.setCommentDate(rs.getString("commentDate"));
			list.add(c);
		}
		
		//디버깅
		System.out.println("selectCommentListByNoticeNo"+stmt);
		
		//4. 리턴
		return list;
		
	}
	
	public static int deleteComment(int commentNo) throws Exception {//comment No만 입력받아 삭제
		//delete from comment where comment_no=? and managerId=?
		
		//1.sql
		String sql="DELETE FROM comment WHERE comment_no=?";
		
		//2.return값 초기화		
		int rowCnt=0;
		
		//3.DB처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		rowCnt = stmt.executeUpdate();
		
		//디버깅
		System.out.println("deleteComment(int commentNo): "+stmt);
		
		//4.리턴
		return rowCnt;
	}
	//오버로딩: 메소드 이름은 같지만 매개변수가 다른것.
	//오버라이딩: ?
	public static int deleteComment(int commentNo, String managerId) throws Exception {//comment No와 managerId 입력받아 삭제,//자바에서 매개변수가 다르면 이름이 다른 메소드를 만들 수 있다.
		//delete from comment where comment_no=? and managerId=?
		//1.sql
		String sql="DELETE FROM comment WHERE comment_no=? and manager_id=?";
		
		//2.return값 초기화
		int rowCnt=0;
		
		//3.DB처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		stmt.setString(2, managerId);
		rowCnt = stmt.executeUpdate();
		
		//디버깅
		System.out.println("deleteComment(int commentNo, String managerId):"+stmt);
		
		//4.리턴
		return rowCnt;
	}
	
}

