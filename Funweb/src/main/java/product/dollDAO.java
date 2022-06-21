package product;

import static db.jdbcUtil.close;
import static db.jdbcUtil.getConnection;

import java.sql.*;
import java.util.*;

import board.*;

public class dollDAO {
	
	Connection con;
	PreparedStatement pstmt, pstmt2;
	ResultSet rs;
	
	
	public ArrayList<dollBean> selectDollList(int pageNum, int listLimit) {
		ArrayList<dollBean> dollList = null;
		
		try {
			// 1 & 2단계
			con = getConnection();
			
			// 현재 페이지에서 불러올 목록(레코드)의 첫번째(시작) 행번호 계산
			// => 시작행번호는 (페이지번호 - 1) * 목록갯수 값 사용
			//    ex) 1페이지 = (1 - 1) * 10 = 0
			//        2페이지 = (2 - 1) * 10 = 10
			//        3페이지 = (3 - 1) * 10 = 20
			int startRow = (pageNum - 1) * listLimit;
			
			// 3단계. SQL 구문 작성 및 전달
			// board 테이블의 모든 레코드 조회(글번호(num) 기준으로 내림차순 정렬)
			// => SELECT 컬럼명 FROM 테이블명 ORDER BY 정렬할컬럼명 정렬방식;
			//    (정렬 방식 - 오름차순 : ASC, 내림차순 : DESC)
			// => SELECT 컬럼명 FROM 테이블명 LIMIT 시작행번호,목록갯수;
			String sql = "SELECT * FROM doll ORDER BY name DESC LIMIT ?,?";
			// => 목록갯수는 파라미터로 전달받은 listLimit 값 사용
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, listLimit);
			
			// 4단계. SQL 구문 실행 및 결과 처리
			rs = pstmt.executeQuery();
			
			// 전체 레코드를 저장할 ArrayList<BoardBean> 객체 생성
			// => 주의! 반복문 시작 전에 미리 생성해야함
			dollList = new ArrayList<dollBean>();
			
			// 다음레코드가 존재할 동안 반복하면서
			// 1개 레코드 정보를 BoardBean 객체에 저장 후
			// 다시 BoardBean 객체를 전체 레코드 저장하는 ArrayList<BoardBean> 객체에 추가
			while(rs.next()) {
				// 1개 레코드를 저장할 BoardBean 객체 생성
				dollBean doll = new dollBean();
				// BoardBean 객체에 조회된 1개 레코드 정보를 모두 저장
				doll.setName(rs.getString("name"));
				doll.setPrice(rs.getInt("price"));
				doll.setImage(rs.getString("image"));
				
				// 전체 레코드를 저장하는 ArrayList 객체에 1개 레코드가 저장된 BoardBean 객체 추가
				dollList.add(doll);
			}
			
//			System.out.println(boardList);
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - selectdollList()");
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return dollList;
	}
	
	public dollBean selectDoll(String name) {
		dollBean doll = null;
		
		try {
			con = getConnection();
			
			String sql = "SELECT * FROM doll WHERE name=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				// BoardBean 객체 생성 후 조회된 컬럼 데이터를 저장
				doll = new dollBean();
				doll.setName(rs.getString("name"));
				doll.setPrice(rs.getInt("price"));
				doll.setImage(rs.getString("image"));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - selectDoll()");
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return doll;
		
	}
		
		public int selectListCount() {
			int listCount = 0;
			
			try {
				con = getConnection();
				
				String sql = "SELECT COUNT(name) FROM doll";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				// 조회된 결과값의 첫번째 값(1번 인덱스)을 listCount 변수에 저장
				if(rs.next()) {
					listCount = rs.getInt(1);
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("SQL 구문 오류 - selectListCount()");
			} finally {
				close(rs);
				close(pstmt);
				close(con);
			}
			
			return listCount;
		}
}

