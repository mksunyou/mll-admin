package gdu.mall.dao;
import gdu.mall.util.*;
import gdu.mall.vo.*;
import java.util.*;
import java.sql.*;
public class OrdersDao {
	//orders리스트X -->orders inner join ebook inner join client
	/*SELECT
		o.orders_no orderNo,
		o.ebook_no ebookNo,
		e.ebook_title ebookTitle,
		o.client_no clientNo,
		c.client_mail clientMail,
		o.orders_date ordersDate,
		o.orders_state ordersState
	FROM orders o INNER JOIN ebook e INNER JOIN client c
	ON o.ebook_no = e.ebook_no AND o.client_no = c.client_no
	ORDER o.orders_no desc
	*/
	public static ArrayList<OrdersAndEbookAndClient> selectOrdersListByPage(int rowPerPage, int beginRow) throws Exception {
		
		String sql = "SELECT o.orders_no ordersNo, o.ebook_no ebookNo, e.ebook_title ebookTitle, o.client_no clientNo, c.client_mail clientMail, o.orders_date ordersDate, o.orders_state ordersState FROM orders o INNER JOIN ebook e INNER JOIN client c ON o.ebook_no = e.ebook_no AND o.client_no = c.client_no ORDER BY orders_date DESC LIMIT ?,?";
		
		//return값 초기화
		ArrayList<OrdersAndEbookAndClient> list = new ArrayList<>();
		
		//DB실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		//디버깅
		System.out.println("주문목록stmt"+stmt);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			//Orders, Ebook, Client 세개 따로도 생성 해야함.
			OrdersAndEbookAndClient oec = new OrdersAndEbookAndClient();
			
			Orders o = new Orders();
			o.setOrdersNo(rs.getInt("ordersNo"));
			o.setEbookNo(rs.getInt("ebookNo"));
			o.setClientNo(rs.getInt("clientNo"));
			o.setOrdersDate(rs.getString("ordersDate"));
			o.setOrdersState(rs.getString("ordersState"));
			oec.setOrders(o);
			
			Ebook e = new Ebook();
			e.setEbookTitle(rs.getString("ebookTitle"));
			oec.setEbook(e);
			
			Client c = new Client();
			c.setClientMail(rs.getString("clientMail"));
			oec.setClient(c);
			
			list.add(oec);
		}
		
		//리턴
		return list;
	}
	
	//주문상태 수정
	public static int updateOrdersState(Orders orders) throws Exception{
		
		//1.sql
		String sql = "UPDATE orders SET orders_state=? WHERE orders_no=?";
		
		//2.return 초기화
		int rowCnt = 0;
		
		//3.DB처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, orders.getOrdersState());
		stmt.setInt(2, orders.getOrdersNo());
		rowCnt = stmt.executeUpdate();
		
		//디버깅
		System.out.println("updateOrderState: "+stmt);
		
		//4.리턴
		return rowCnt;
				
	}
	
	//ordersState list
	public static String[] ordersStateList() throws Exception{
		String[] list = {"주문완료","주문취소"};
		
		return list;
	}
	
	//전체 행의수
	public static int totalCount() throws Exception {
		//1.sql
		String sql = "SELECT COUNT(*) cnt FROM orders";
		
		//2. return값 초기화
		int totalRow = 0;
		
		//3. DB실행
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		System.out.println("totalCount stmt"+stmt);
		while(rs.next()) {
			totalRow = rs.getInt("cnt");
		}
		
		//4.리턴
		return totalRow;
	}
	
}
