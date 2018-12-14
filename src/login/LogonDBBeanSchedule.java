package login;

import java.sql.*;

public class LogonDBBeanSchedule {

	private static LogonDBBeanSchedule instance = new LogonDBBeanSchedule();

	public static LogonDBBeanSchedule getInstance() {
		return instance;
	}

	private LogonDBBeanSchedule() {
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

	public String[][] getInfoAll(String id) throws Exception{
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      String Info[][] = null;
	      int x = -1;
	      
	      try {
	         conn = getConnection();
	         
	         pstmt = conn.prepareStatement("select * from �������� where �������̵� = '"+id+"'");
	         rs = pstmt.executeQuery();
	         rs.last();
	         int count = rs.getRow();
	         rs.beforeFirst();
	         
	         Info = new String[count][7];
	         
	          int r=0; //��
	         while(rs.next()) {
	        	 		Info[r][0] = rs.getString("���������ڵ�");
	                    Info[r][1] = String.valueOf(rs.getInt("���۽ð�"));
	                    Info[r][2] = String.valueOf(rs.getInt("����ð�"));
	                    Info[r][3] = String.valueOf(rs.getInt("����"));
	                    Info[r][4] = rs.getString("�����ڵ�");
	                    Info[r][5] = rs.getString("���ǽǾ��̵�");
	                    
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
	public String[][] getInfoRoom(String id) throws Exception{
	       Connection conn = null;
	       PreparedStatement pstmt = null;
	       ResultSet rs = null;
	       String Info[][] = null;
	       int x = -1;
	       
	       try {
	          conn = getConnection();
	          
	          pstmt = conn.prepareStatement("select * from �������� where ���ǽǾ��̵� = '"+id+"'");
	          rs = pstmt.executeQuery();
	          rs.last();
	          int count = rs.getRow();
	          rs.beforeFirst();
	          
	          Info = new String[count][7];
	          
	           int r=0; //��
	          while(rs.next()) {
	                   Info[r][0] = rs.getString("���������ڵ�");
	                     Info[r][1] = rs.getString("���۽ð�");
	                     Info[r][2] = rs.getString("����ð�");
	                     Info[r][3] = String.valueOf(rs.getInt("����"));
	                     Info[r][4] = rs.getString("�����ڵ�");
	                     Info[r][5] = rs.getString("���ǽǾ��̵�");
	                     
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
