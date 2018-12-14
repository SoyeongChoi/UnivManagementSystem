package login;

import java.sql.*;

public class LogonDBBeanPlan {

	private static LogonDBBeanPlan instance = new LogonDBBeanPlan();

	public static LogonDBBeanPlan getInstance() {
		return instance;
	}

	private LogonDBBeanPlan() {
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

	public void insertMember(LogonDataBeanPlan plan) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("insert into 강의계획서 values (?, ?, ?, ?)");
			pstmt.setString(1, plan.getContent());
			pstmt.setString(2, plan.getEvaluation_method());
			pstmt.setString(3, plan.getSubject_code());
			pstmt.setString(4, plan.getProfessor_id());
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

	public void updatePlan(LogonDataBeanPlan plan) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		// 단순 사용자 정보 업데이트
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("update 강의계획서 set 세부강의내용 = ?, 평가방법 = ? where 과목코드 = ?");
			pstmt.setString(1, plan.getContent());
			pstmt.setString(2, plan.getEvaluation_method());
			pstmt.setString(3, plan.getSubject_code());

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

	public String[] getInfo(String code) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = -1;
		String Info[] = new String[4];

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from 강의계획서 where 과목코드 = ?");
			pstmt.setString(1, code);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				Info[0] = rs.getString("세부강의내용");
				Info[1] = rs.getString("평가방법");
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
