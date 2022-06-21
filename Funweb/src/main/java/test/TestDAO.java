package test;

import java.sql.*;
import java.util.*;

import board.*;

import static db.jdbcUtil.*;
public class TestDAO {
	
	Connection con;
	PreparedStatement pstmt, pstmt2;
	ResultSet rs;
	
	public int insertTest(TestBean test) {
		int insertCount = 0;
		int num = 1;
		
		con = getConnection();
		
		try {
			String sql = "SELECT MAX(num) FROM test";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				num = rs.getInt(1) + 1;
			}
			
			sql = "INSERT INTO test VALUES (?,?,?,?,?,now(),0)";
			pstmt2 = con.prepareStatement(sql);
			pstmt2.setInt(1, num);
			pstmt2.setString(2, test.getName());
			pstmt2.setString(3, test.getPass());
			pstmt2.setString(4, test.getSubject());
			pstmt2.setString(5, test.getContent());
			
			insertCount = pstmt2.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - insertTest()");
		} finally {
			close(rs);
			close(pstmt);
			close(pstmt2);
			close(con);
		}
		
		
		return insertCount;
		
	}
	
	public ArrayList<TestBean> selectTestList(int pageNum, int listLimit){
		ArrayList<TestBean> testList = null;
		
		con = getConnection();
		int startRow = (pageNum - 1) * listLimit;
		
		try {
			
			String sql = "SELECT * FROM test ORDER BY num DESC LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, listLimit);
			
			rs = pstmt.executeQuery();
			
			testList = new ArrayList<TestBean>();
			
			while(rs.next()) {
				TestBean test = new TestBean();
				test.setNum(rs.getInt("num"));
				test.setName(rs.getString("name"));
				test.setPass(rs.getString("pass"));
				test.setSubject(rs.getString("subject"));
				test.setContent(rs.getString("content"));
				test.setDate(rs.getDate("date"));
				test.setReadcount(rs.getInt("readcount"));
				
				testList.add(test);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - selectTestList()");
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return testList;
	}
	
	public int selectListCount() {
		int listCount = 0;
		
		con = getConnection();
		
		try {
			String sql = "SELECT count(num) FROM test";
			pstmt = con.prepareStatement(sql);
	
			rs = pstmt.executeQuery();
			
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
	
	public TestBean selectTest(int num) {
		TestBean test = null;
		
		con = getConnection();
		try {
			String sql = "SELECT * FROM test WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				test = new TestBean();
				test.setNum(rs.getInt("num"));
				test.setName(rs.getString("name"));
				test.setPass(rs.getString("pass"));
				test.setSubject(rs.getString("subject"));
				test.setContent(rs.getString("content"));
				test.setDate(rs.getDate("date"));
				test.setReadcount(rs.getInt("readcount"));
				
			}
		
		
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - selectTest()");
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		
		
		return test;
	}
	
	public void updateCount(int num) {
		con = getConnection();
		try {
			String sql = "UPDATE test SET readcount=readcount+1 WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - updateCount()");
		} finally {
			close(pstmt);
		}
		
	}
	
	public int updateTest(TestBean test) {
		int updateCount = 0;
		
		con = getConnection();
		
		try {
			String sql = "SELECT * FROM test WHERE num=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, test.getNum());
			pstmt.setString(2, test.getPass());

			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				sql = "UPDATE test SET name=?,subject=?,content=? WHERE num=?";
				pstmt2 = con.prepareStatement(sql);
				pstmt2.setString(1, test.getName());
				pstmt2.setString(2, test.getSubject());
				pstmt2.setString(3, test.getContent());
				pstmt2.setInt(4, test.getNum());
				
				updateCount = pstmt2.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - updateTest()");
		} finally {
			close(rs);
			close(pstmt2);
			close(pstmt);
			close(con);
		}
		
		return updateCount;
	}
	
	public int deleteTest(int num, String pass) {
		int deleteCount = 0;
		
		con = getConnection();
		
		try {
			String sql = "SELECT * FROM test WHERE num=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, pass);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				sql = "DELETE FROM test WHERE num=?";
				pstmt2 = con.prepareStatement(sql);
				pstmt2.setInt(1, num);
				
				deleteCount = pstmt2.executeUpdate();
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - deleteTest()");
		} finally {
			close(rs);
			close(pstmt2);
			close(pstmt);
			close(con);
		}
		
		return deleteCount;
	}
	
	public ArrayList<TestBean> selectRecentTestList(){
		ArrayList<TestBean> testList = null;
		
		con = getConnection();
		
		try {
			String sql = "SELECT * FROM test ORDER BY num DESC LIMIT ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, 5);
			rs = pstmt.executeQuery();
			
			testList = new ArrayList<TestBean>();
			
			while(rs.next()) {
				TestBean test = new TestBean();
				test.setNum(rs.getInt("num"));
				test.setName(rs.getString("name"));
				test.setPass(rs.getString("pass"));
				test.setSubject(rs.getString("subject"));
				test.setContent(rs.getString("content"));
				test.setDate(rs.getDate("date"));
				test.setReadcount(rs.getInt("readcount"));
				
				testList.add(test);
				
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - selectRecentTestList()");
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return testList;
		
		
	}
	
	public int selectSearchListCount(String search, String searchType) {
		int listCount = 0;
		
		try {
			con = getConnection();
			
			String sql = "SELECT COUNT(num) FROM test WHERE " + searchType + " LIKE ?";
			pstmt = con.prepareStatement(sql);
			// 검색어 생성을 위해서는 검색 키워드 앞뒤로 "%" 문자열 결합 필요
			pstmt.setString(1, "%" + search + "%");
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
	
	
	// 검색어에 해당하는 게시물 목록 조회작업을 수행하는 selectSearchBoardList()
	// => 파라미터 : 현재 페이지 번호(pageNum), 표시할 목록 갯수(listLimit), 검색어(search)
	//  리턴타입 : java.util.ArrayList<BoardBean>(boardList)
	public ArrayList<TestBean> selectSearchTestList(int pageNum, int listLimit, String search, String searchType) {
		ArrayList<TestBean> testList = null;
		
		try {
			// 1 & 2단계
			con = getConnection();
			
			// 현재 페이지에서 불러올 목록(레코드)의 첫번째(시작) 행번호 계산
			int startRow = (pageNum - 1) * listLimit;
			
			// 3단계. SQL 구문 작성 및 전달
			// 검색어에 해당하는 board 테이블의 모든 레코드 조회(글번호(num) 기준으로 내림차순 정렬)
			String sql = "SELECT * FROM test "
					+ "WHERE " + searchType + " LIKE ? "
					+ "ORDER BY num DESC LIMIT ?,?";
			// => 목록갯수는 파라미터로 전달받은 listLimit 값 사용
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, listLimit);
			
			// 4단계. SQL 구문 실행 및 결과 처리
			rs = pstmt.executeQuery();
			
			// 전체 레코드를 저장할 ArrayList<BoardBean> 객체 생성
			// => 주의! 반복문 시작 전에 미리 생성해야함
			testList = new ArrayList<TestBean>();
			
			// 다음레코드가 존재할 동안 반복하면서
			// 1개 레코드 정보를 BoardBean 객체에 저장 후
			// 다시 BoardBean 객체를 전체 레코드 저장하는 ArrayList<BoardBean> 객체에 추가
			while(rs.next()) {
				// 1개 레코드를 저장할 BoardBean 객체 생성
				TestBean test = new TestBean();
				// BoardBean 객체에 조회된 1개 레코드 정보를 모두 저장
				test.setNum(rs.getInt("num"));
				test.setName(rs.getString("name"));
				test.setPass(rs.getString("pass"));
				test.setSubject(rs.getString("subject"));
				test.setContent(rs.getString("content"));
				test.setDate(rs.getDate("date"));
				test.setReadcount(rs.getInt("readcount"));
				
				// 전체 레코드를 저장하는 ArrayList 객체에 1개 레코드가 저장된 BoardBean 객체 추가
				testList.add(test);
			}
			
//				System.out.println(boardList);
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - selectBoardList()");
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return testList;
	}
}
