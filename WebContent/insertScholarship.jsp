<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import="java.util.*" %>
    <%@ page import = "login.LogonDBBeanScholarship" %>
    <% request.setCharacterEncoding("UTF-8"); %>
   
    <%
    String id = "";
    try{
       Cookie[] cookies = request.getCookies();
       if(cookies != null){
          for(int i =0; i<cookies.length;i++){
             if(cookies[i].getName().equals("id")){
                id = cookies[i].getValue();
             }
          }
          if(id.equals("")){
             response.sendRedirect("loginForm.jsp");
          }
       }else{
          response.sendRedirect("loginForm.jsp");
       }
    }catch(Exception e){
       
    }

    request.setCharacterEncoding("utf-8");
  	Class.forName("com.mysql.jdbc.Driver");
	String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
	String dbId = "root";
	String dbPass = "wjsgpals66";
	String temp = "";
	try {
		Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		PreparedStatement pstmt = conn.prepareStatement("select m.회원아이디, m.최근학기, s.학생아이디, s.수강학기, s.과목코드  from 회원 m, 수강 s where m.최근학기 = s.수강학기 and m.회원아이디 = s.학생아이디");
		ResultSet rs = pstmt.executeQuery();
        rs.last();
        int count = rs.getRow();
        rs.beforeFirst();
        
        String[][] Info = new String[count][3];
        
         int r=0; //행
        while(rs.next()) {
                   Info[r][0] = rs.getString("학생아이디");
                   Info[r][1] = rs.getString("과목코드");
                   Info[r][2] =  Integer.toString(rs.getInt("수강학기"));
                   r+=1;
           
        }
		for(int i=0; i<Info.length; i++){
			PreparedStatement p = conn.prepareStatement("select 학점,과목코드 from 수강 where 학생아이디=? and 수강학기 = "+Info[i][2]);
			p.setString(1, Info[i][0]);
			ResultSet rs2 = p.executeQuery();
			float total_grade = 0;
			int total_num = 0;
			while(rs2.next()){
				PreparedStatement p2 = conn.prepareStatement("select 학점시수 from 과목 where 과목코드 = ?");
				p2.setString(1,rs2.getString("과목코드"));
				ResultSet rs3 = p2.executeQuery();
				while(rs3.next()){
					total_num = total_num + rs3.getInt("학점시수");
					total_grade = total_grade+(rs2.getFloat("학점"))*rs3.getInt("학점시수");
				}
			}
			float average = total_grade / total_num;
			PreparedStatement p1 = conn.prepareStatement("update 회원 set 평균학점=? where 회원아이디=?");
			p1.setFloat(1, average);
			p1.setString(2, Info[i][0]);
			p1.executeUpdate();
		}
		PreparedStatement p = conn.prepareStatement("select 평균학점, 회원아이디, 최근학기  from 회원 where 직업='학생' and 평균학점 > 0 order by 평균학점 desc");
		ResultSet rs2 = p.executeQuery();
		rs2.last();
		count = rs2.getRow();
		rs2.beforeFirst();
		String[][] scholarship = new String[count][3];
		r=0;
		while(rs2.next()){
				scholarship[r][0] = rs2.getString("평균학점");
				scholarship[r][1] = rs2.getString("회원아이디");
				scholarship[r][2] = rs2.getString("최근학기");
				r++;
		}
		System.out.println(scholarship.length);
		for(int i=0; i<scholarship.length;i++){
			if(scholarship[i][0]!=null){
			String name = "";
			String money = "";
			PreparedStatement p0 = conn.prepareStatement("select * from 장학 where 회원아이디 = ? and 선발학기 = ?");
			p0.setString(1, scholarship[i][1]);
			p0.setString(2, scholarship[i][2]);
			ResultSet r0 = p0.executeQuery();
			r0.last();
			count = r0.getRow();
			if(count<1){
			
			if(i<(scholarship.length*0.03)){
				PreparedStatement p1 = conn.prepareStatement("insert into 장학 values (?, ?, ?, ?, ?)");
				//회원아이디+선발학기+장학명
				p1.setString(1,scholarship[i][1]+"@"+scholarship[i][2]+"@"+"전액장학금");
				p1.setInt(2, Integer.parseInt(scholarship[i][2]));
				p1.setString(3, scholarship[i][1]);
				p1.setString(4, "전액장학금");
				p1.setString(5,"300만원");
				p1.executeUpdate();
			}else if(i<(scholarship.length*0.1)){
				PreparedStatement p1 = conn.prepareStatement("insert into 장학 values (?, ?, ?, ?, ?)");
				//회원아이디+선발학기+장학명
				p1.setString(1,scholarship[i][1]+"@"+scholarship[i][2]+"@"+"반액장학금");
				p1.setInt(2, Integer.parseInt(scholarship[i][2]));
				p1.setString(3, scholarship[i][1]);
				p1.setString(4, "반액장학금");
				p1.setString(5,"150만원");
				System.out.println(scholarship[i][1]);
				p1.executeUpdate();
			}
			}
			}
			
		}
	
	conn.close();
}catch(SQLException e){
	out.println(e.toString());
}
	LogonDBBeanScholarship logon = LogonDBBeanScholarship.getInstance();
	String[][] data = logon.getInfoAll();
	
	
    %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>장학생</title>
</head>
<body>

   <h2>장학생으로 선발된 학생들</h2>
	<%
	if(data.length==0){
		%>
		아직 선발된 학생이 없습니다.<br/>
		<%
	}else{
	
	%>
	 <table border="1" style="border-collapse:collapse">
	   <tr>
	   <th width="100">학번</th>
	   <th width="100">장학금명</th>
	   <th width="100">장학금액</th>
	   </tr>
	   <%
	   for(int i=0; i<data.length; i++){
		   %>
		   <tr>
		   <td><%=data[i][2] %></td>
		   <td><%=data[i][3] %></td>
		   <td><%=data[i][4] %></td>
		   </tr>
		   <%
	   }
	}
	   %>
	   
	  </table>
   <input type="button" value="메인으로 돌아가기" onclick="main()">
   <script type="text/javascript">
    function main(){
       location.href="CookieManager.jsp";
    }
    </script>
   
   <br/>
   <br/>
</body>
</html>