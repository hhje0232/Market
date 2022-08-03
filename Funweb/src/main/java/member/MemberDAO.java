package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.jdbcUtil;

public class MemberDAO {
	// 데이터베이스 작업에 필요한 변수 선언
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// 회원 추가 작업(수정)
	public int insertMember(MemberBean member) {
		int insertCount = 0;
		
		con = jdbcUtil.getConnection();
		
		try {
			String sql = "INSERT INTO member VALUES(?,?,?,?,now(),?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPass());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getAddress());
			pstmt.setString(6, member.getPhone());
			pstmt.setString(7, member.getMobile());
			
			insertCount = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - insertMember()");
		} finally {
			// 자원 반환
			jdbcUtil.close(pstmt);
			jdbcUtil.close(con);
		}
		
		
		
		return insertCount;
	}
	
	public boolean checkUser(MemberBean member) {
		// 로그인
		boolean isLoginSuccess = false;
		
		// JdbcUtil 클래스의 getConnection() 메서드를 호출하여 Connection 객체 가져오기
		con = jdbcUtil.getConnection();
		
		try {
			// 3단계. SQL 구문 작성 및 전달
			// id 와 pass 가 일치하는 레코드 조회
			String sql = "SELECT * FROM member WHERE id=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPass());
			
			// 4단계. SQL 구문 실행 및 결과 처리
			rs = pstmt.executeQuery();
			
			// ResultSet 객체의 다음 레코드가 존재할 경우 로그인 성공
			while(rs.next()) {
				isLoginSuccess = true;
			} 
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - checkUser()");
		} finally {
			jdbcUtil.close(rs);
			jdbcUtil.close(pstmt);
			jdbcUtil.close(con);
			
		}
		
		
		return isLoginSuccess;
	}
	
	public MemberBean selectMemberInfo(String id) {
		MemberBean member = null;
		
		con = jdbcUtil.getConnection();
		
		try {
			String sql = "SELECT * FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			// ResultSet 객체의 다음 레코드가 존재할 경우
			// 모든 컬럼 데이터를 MemberBean 객체에 저장
			while(rs.next()) {
				// MemberBean 객체 생성
				member = new MemberBean();
				// 데이터 저장
				member.setId(id);
				member.setPass(rs.getString("pass"));
				member.setName(rs.getString("name"));
				member.setEmail(rs.getString("email"));
				member.setDate(rs.getDate("date"));
				member.setAddress(rs.getString("address"));
				member.setPhone(rs.getString("phone"));
				member.setMobile(rs.getString("mobile"));
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			jdbcUtil.close(rs);
			jdbcUtil.close(pstmt);
			jdbcUtil.close(con);
			
		}
		
		
		return member;
	}
	
	public int updateMember(MemberBean member) {
		int updateCount = 0;
		
		con = jdbcUtil.getConnection();
		
		try {
			// member 테이블의 아이디가 일치하는 레코드 수정
			// 단, pass 값(패스워드)이 없을(="") 경우 이름, 이메일, 주소, 전화번호, 폰번호만 수정
			// 아니면 패스워드, 이름, 이메일, 주소, 전화번호, 폰번호만 수정
			if(member.getPass().equals("")) {
				String sql = "UPDATE member SET name=?,email=?,address=?, phone=?, mobile=? WHERE id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, member.getName());
				pstmt.setString(2, member.getEmail());
				pstmt.setString(3, member.getAddress());
				pstmt.setString(4, member.getPhone());
				pstmt.setString(5, member.getMobile());
				pstmt.setString(6, member.getId());
			} else { // 패스워드 입력했을 경우
				String sql = "UPDATE member SET pass=?, name=?,email=?,address=?, phone=?, mobile=? WHERE id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, member.getPass());
				pstmt.setString(2, member.getName());
				pstmt.setString(3, member.getEmail());
				pstmt.setString(4, member.getAddress());
				pstmt.setString(5, member.getPhone());
				pstmt.setString(6, member.getMobile());
				pstmt.setString(7, member.getId());
			}
			updateCount = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - updateMember()");
		} finally {
			jdbcUtil.close(pstmt);
			jdbcUtil.close(con);
		}
		
		return updateCount;
	}
	
	public boolean checkId(String id) {
		boolean isDuplicate = false;
		
				
				try {
					con = jdbcUtil.getConnection();
					
					String sql = "SELECT * FROM member WHERE id=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, id);
					
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						isDuplicate = true;
					}
					
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					jdbcUtil.close(rs);
					jdbcUtil.close(pstmt);
					jdbcUtil.close(con);
				}
		
		return isDuplicate;
	}
}
