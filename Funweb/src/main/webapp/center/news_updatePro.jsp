<%@page import="test.TestDAO"%>
<%@page import="test.TestBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// POST 방식 한글 처리
request.setCharacterEncoding("UTF-8");

// 폼 파라미터 데이터 가져오기
String pageNum = request.getParameter("page");
int num = Integer.parseInt(request.getParameter("num"));
String name = request.getParameter("name");
String pass = request.getParameter("pass");
String subject = request.getParameter("subject");
String content = request.getParameter("content");

// BoardBean 객체 생성하여 폼 파라미터 데이터(페이지번호 제외) 저장
TestBean test = new TestBean();
test.setNum(num);
test.setName(name);
test.setPass(pass);
test.setSubject(subject);
test.setContent(content);


// BoardDAO 객체의 updateBoard() 메서드를 호출하여 게시물 수정 작업 요청
// => 파라미터 : BoardBean 객체(board), 리턴타입 : int(updateCount)
// => 단, UPDATE 구문 수행 전 SELECT 구문을 사용하여 패스워드 일치 여부 판별 후
//    패스워드가 일치할 경우에만 UPDATE 구문 실행(UPDATE 대상에서 패스워드는 제외)
TestDAO testDAO = new TestDAO();
int updateCount = testDAO.updateTest(test);


// 수정 작업 결과 판별 및 처리
// updateCount > 0 일 경우 "notice_content.jsp" 페이지로 이동하고
// 아니면, 자바스크립트를 사용하여 "글 수정 실패!" 출력 후 이전 페이지로 돌아가기
if(updateCount > 0){
	response.sendRedirect("news_content.jsp?num=" + num + "&page=" + pageNum);
} else { %>
	<script>
	alert("글 수정 실패!");
	history.back();
	</script>
<%
}
%>








