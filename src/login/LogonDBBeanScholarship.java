package login;

import java.sql.*;

public class LogonDBBeanScholarship {

	private static LogonDBBeanScholarship instance = new LogonDBBeanScholarship();

	public static LogonDBBeanScholarship getInstance() {
		return instance;
	}

	private LogonDBBeanScholarship() {
	}

	private Connection getConnection() throws Exception {
		Connection conn = null;

		String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
		String dbId = "root";
		String dbPass = "wjsgpals66";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		return conn;
	}

	 public String[][] getInfoAll() throws Exception{
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      String Info[][] = null;
	      int x = -1;
	      
	      try {
	         conn = getConnection();
	         
	         pstmt = conn.prepareStatement("select * from ���� order by ���и� desc");
	         rs = pstmt.executeQuery();
	         rs.last();
	         int count = rs.getRow();
	         rs.beforeFirst();
	         
	         Info = new String[count][5];
	         System.out.println(count+"count:");
	         
	          int r=0; //��
	         while(rs.next()) {
	        	 		Info[r][0] = rs.getString("�����ڵ�");
	                    Info[r][1] = Integer.toString(rs.getInt("�����б�"));
	                    Info[r][2] = rs.getString("ȸ�����̵�");
	                    Info[r][3] = rs.getString("���и�");
	                    Info[r][4] = rs.getString("���бݾ�");
	                    
	                    r+=1;
	            
	         }
	         
	      
	      }catch(Exception ex) {
	         ex.printStackTrace();
	      }finally {
	         if(rs != null) try {rs.close();} catch(SQLException ex) {}
	         if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
	         if(conn != null) try {conn.close();} catch(SQLException ex) {}
	      }
	      return Info;
	   }

}
