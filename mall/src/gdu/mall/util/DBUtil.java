package gdu.mall.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {
	//DB 연결 메소드
		public static Connection getConnection() throws Exception{ //DB 연결 및 사용할 수 있도록 하는 메소드
			Class.forName("org.mariadb.jdbc.Driver");//DB를 사용할 수 있도록 하고
			Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/mall","root","java1004");//DB를 연결
			return conn;
		}
}
