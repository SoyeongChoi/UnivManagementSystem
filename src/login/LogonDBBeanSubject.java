package login;
import java.sql.*;
import java.util.Comparator;

public class LogonDBBeanSubject {
   
   private static LogonDBBeanSubject instance = new LogonDBBeanSubject();
   
   public static LogonDBBeanSubject getInstance() {
      return instance;
   }
   
   private LogonDBBeanSubject() {}
   
   private Connection getConnection() throws Exception{
      Connection conn = null;
      
      String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
      String dbId = "root";
      String dbPass = "wjsgpals66";
      
      Class.forName("com.mysql.jdbc.Driver");
      conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
      return conn;
   }

	public void insertMember(LogonDataBeanSubject subject) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("insert into 과목 values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
			pstmt.setString(1, subject.getSubject_code());
			pstmt.setString(2, subject.getSubject_name());
			pstmt.setInt(3, subject.getYear());
			pstmt.setInt(4, subject.getCreditnum());
			pstmt.setString(5, subject.getMajor());
			pstmt.setString(6, subject.getCourse());
			pstmt.setString(7, subject.getSemester());
			pstmt.setInt(8, subject.getPeople_num());
			pstmt.setString(9, subject.getClass_num());
			pstmt.setString(10, subject.getProfessor_id());
			pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
	}

	public void findProfessor(LogonDataBeanSubject subject) throws Exception {

	}

	
   
   public String[][] getInfoAll(String id) throws Exception{
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      String Info[][] = null;
	      int x = -1;
	      
	      try {
	         conn = getConnection();
	         
	         pstmt = conn.prepareStatement("select * from 과목 where 교수아이디 = '"+id+"'");
	         rs = pstmt.executeQuery();
	         rs.last();
	         int count = rs.getRow();
	         rs.beforeFirst();
	         
	         Info = new String[count][9];
	         System.out.println(count+"count:");
	         
	          int r=0; //행
	         while(rs.next()) {
	        	 		Info[r][0] = rs.getString("과목코드");
	        	 		System.out.print(Info[r][0]);
	                    Info[r][1] = rs.getString("과목명");
	                    Info[r][2] = Integer.toString(rs.getInt("학년"));
	                    Info[r][3] = Integer.toString(rs.getInt("학점시수"));
	                    Info[r][4] = rs.getString("학과");
	                    Info[r][5] = rs.getString("이수분야");
	                    Info[r][6] = rs.getString("학기");
	                    Info[r][7] = Integer.toString(rs.getInt("인원"));
	                    Info[r][8] = rs.getString("분반");
	                    
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
  
   public void deleteSubject(String subjectCode) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		Statement stmt = conn.createStatement();
		try {
			conn = getConnection();
			String checking = "select count(*) 강의일정 from 과목 where 과목코드 =?";
			rs = stmt.executeQuery(checking);
			rs.first();
			int count = rs.getInt(1);
			if (count > 0) {

			} else {
				pstmt = conn.prepareStatement("select 과목코드 from 과목 where 과목코드=?");
				pstmt.setString(1, subjectCode);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					String rId = rs.getString("과목코드");
					System.out.println(rId);
					if (subjectCode.equals(rId)) {
						pstmt = conn.prepareStatement("SET FOREIGN_KEY_CHECKS=0");
						pstmt.executeQuery();
						pstmt2 = conn.prepareStatement("delete from 과목 where 과목코드 = ?");
						pstmt2.setString(1, subjectCode);
						pstmt2.executeUpdate();
						pstmt = conn.prepareStatement("SET FOREIGN_KEY_CHECKS=1");
						pstmt.executeQuery();
					}
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
	}
  
}