package login;

import java.sql.*;

public class LogonDBBeanApplyLecture{

	private static LogonDBBeanApplyLecture instance = new LogonDBBeanApplyLecture();

	public static LogonDBBeanApplyLecture getInstance() {
		return instance;
	}

	private LogonDBBeanApplyLecture() {
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
	public String[][] getInfoAll(String subject_code) throws Exception{
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      String Info[][] = null;
	      int x = -1;
	      
	      try {
	         conn = getConnection();
	         
	         pstmt = conn.prepareStatement("select * from ���� where �����ڵ� = ?");
	         pstmt.setString(1, subject_code);
	         rs = pstmt.executeQuery();
	         rs.last();
	         int count = rs.getRow();
	         rs.beforeFirst();
	         
	         Info = new String[count][8];
	         
	          int r=0; //��
	         while(rs.next()) {
	        	 		Info[r][0] = Float.toString(rs.getFloat("����"));
	                    Info[r][1] = Float.toString(rs.getFloat("�߰����"));
	                    Info[r][2] = Float.toString(rs.getFloat("�⸻���"));
	                    Info[r][3] = Float.toString(rs.getFloat("�⼮"));
	                    Info[r][4] = rs.getString("�л����̵�");
	                    Info[r][5] =  Integer.toString(rs.getInt("�����б�"));
	                    Info[r][6] = rs.getString("�����ڵ�");
	                    Info[r][7] = rs.getString("�������̵�");	                    
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
	public String[] getInfo(String code, String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = -1;
		String Info[] = new String[4];

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from ���� where �����ڵ� = ? and �л����̵� = ?");
			pstmt.setString(1, code);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				Info[0] = rs.getString("����");
				Info[1] = rs.getString("�߰����");
				Info[2] = rs.getString("�⸻���");
				Info[3] = rs.getString("�⼮");
			}
		} catch (

		Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
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
		return Info;
	}
	public void insertApplyLecture(LogonDataBeanApplyLecture lecture) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("insert into ���� values (?, ?, ?, ?, ?, ?, ?, ?)");
			pstmt.setFloat(1, -1);
			pstmt.setFloat(2, -1);
			pstmt.setFloat(3, -1);
			pstmt.setFloat(4, -1);
			pstmt.setString(5, lecture.getStudentID());
			pstmt.setString(6, lecture.getSubjectCode());
			pstmt.setString(7, lecture.getProfessorID());
			pstmt.setInt(8, lecture.getSemester());
			pstmt.executeUpdate();
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	}
	}
