package login;
import java.sql.*;

public class LogonDBBean {
	
	private static LogonDBBean instance = new LogonDBBean();
	
	public static LogonDBBean getInstance() {
		return instance;
	}
	
	private LogonDBBean() {}
	
	private Connection getConnection() throws Exception{
		Connection conn = null;
		
		String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
		String dbId = "root";
		String dbPass = "wjsgpals66";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		return conn;
	}

	public void insertMember(LogonDataBean member) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("insert into 회원 values (?, ?, ?, ?, ?, ?, ?, ?, ?)");
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getJob());
			pstmt.setString(7, member.getBirth());
			pstmt.setString(8, member.getBirth());
			if (member.getId().contains("manager")) {
				pstmt.setString(4, null);
				pstmt.setString(5, null);
				pstmt.setString(6, null);
				pstmt.setString(9, null);
			}
			else if (member.getId().contains("professor")) {
				pstmt.setString(4, null);
				pstmt.setString(5, member.getMajor());
				pstmt.setString(6, null);
				pstmt.setString(9, null);
			}else {
				pstmt.setString(4, "재학");
				pstmt.setString(5, member.getMajor());
				pstmt.setInt(6, 1);
				pstmt.setFloat(9, -1);
			}
			
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

	
	public void updateMember(LogonDataBean member) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		//단순 사용자 정보 업데이트
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("update 회원 set 비밀번호 = ?, 이름 = ?, 생년월일 = ? where 회원아이디 = ?");
			pstmt.setString(1, member.getPasswd());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getBirth());
			pstmt.setString(4, member.getId());
			
			pstmt.executeUpdate();
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	}
	
	public String[] getInfo(String id) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = -1;
		String Info[] = new String[7];
		
		try {
			conn = getConnection();
			int check = -1;
			if(id.contains("manager")) {				
				pstmt = conn.prepareStatement("select * from 회원 where 회원아이디 = ? and 직업 = ?");
				pstmt.setString(1, id);
				pstmt.setString(2, "관리자");
				Info = new String[4];
				check = 1;
			}else if(id.contains("professor")) {
				pstmt = conn.prepareStatement("select * from 회원 where 회원아이디 = ? and 직업 = ?");
				pstmt.setString(1, id);
				pstmt.setString(2, "교수");	
				check = 0;
				Info = new String[5];
			}else {
				pstmt = conn.prepareStatement("select * from 회원 where 회원아이디 = ? and 직업 = ?");
				pstmt.setString(1, id);
				pstmt.setString(2, "관리자");
				Info = new String[4];
				check = 1;
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(check == 1) {
					Info[0] = rs.getString("비밀번호");
					Info[1] = rs.getString("이름");
					Info[2] = rs.getString("직업");
					Info[3] = rs.getString("생년월일");
				}else if(check == 0) {
					Info[0] = rs.getString("비밀번호");
					Info[1] = rs.getString("이름");
					Info[2] = rs.getString("직업");
					Info[3] = rs.getString("학과");
					Info[4] = rs.getString("생년월일");
				}else {
					Info[0] = rs.getString("이름");
					Info[1] = rs.getString("직업");
					Info[2] = rs.getString("학적");
					Info[3] = rs.getString("학과");
					Info[4] = rs.getString("최근학기");
					Info[5] = rs.getString("비밀번호");
					Info[6] = rs.getString("생년월일");
					Info[7] = Float.toString(rs.getFloat("평균학점"));
					}
			
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
	
	public void deleteMember(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select 회원아이디 from 회원 where 회원아이디=?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				String rId = rs.getString("회원아이디");
				if (id.equals(rId)) {
					String sql = "delete from 회원 where 회원아이디 = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.executeUpdate();
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

	public int userCheck(String id, String passwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		int x = -1;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select 비밀번호 from 회원 where 회원아이디 = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dbpasswd = rs.getString("비밀번호");
				if (dbpasswd.equals(passwd))
					x = 1;
				else
					x = 0;
			} else
				x = -1;
		} catch (Exception ex) {
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
		return x;
	}
}
