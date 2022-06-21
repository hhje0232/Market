<%@page import="test.TestBean"%>
<%@page import="product.dollBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="product.dollDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String id = "";

if(session.getAttribute("sId") != null) {
   id = (String)session.getAttribute("sId");
}
int pageNum = 1; // 현재 페이지 번호를 저장할 변수 선언. 기본값 1 설정

//현재 페이지 번호가 저장된 page 파라미터에서 값을 가져와서 pageNum 변수에 저장
//=> 단, page 파라미터가 존재할 경우에만 가져오기
if(request.getParameter("page") != null) {
	pageNum = Integer.parseInt(request.getParameter("page")); // String -> int 형변환 필요
}

int listLimit = 10; // 한 페이지 당 표시할 목록(게시물) 갯수
int pageLimit = 10; // 한 페이지 당 표시할 페이지 갯수

//BoardDAO 객체의 selectListCount() 메서드를 호출하여 게시물 전체 목록 갯수 조회 작업 요청
//=> 파라미터 : 없음, 리턴타입 : int(listCount)
dollDAO dollDAO = new dollDAO();
int listCount = dollDAO.selectListCount();

//페이징 처리를 위한 계산 작업
//1. 현재 페이지에서 표시할 전체 페이지 수 계산
//=> 총 게시물 수 / 페이지 당 표시할 게시물 수 + 0.9
//=> 주의! 총 게시물 수(int) / 페이지 당 표시할 게시물 수(int) 연산 시 double 타입 연산 필요
//=> 계산된 결과값을 다시 int 타입으로 변환 필요
//int maxPage = (int)((double)listCount / listLimit + 0.9);

//java.lang.Math 클래스의 ceil() 메서드를 사용하여 반올림 가능
int maxPage = (int)Math.ceil((double)listCount / listLimit);

//2. 현재 페이지에서 보여줄 시작 페이지 번호(1, 11, 21 등의 시작 번호) 계산
int startPage = ((int)((double)pageNum / pageLimit + 0.9) - 1) * pageLimit + 1;

//3. 현재 페이지에서 보여줄 끝 페이지 번호(10, 20, 30 등의 끝 번호) 계산
int endPage = startPage + pageLimit - 1;

//4. 만약, 끝 페이지(endPage)가 현재 페이지에서 표시할 총 페이지 수(maxPage)보다 클 경우
// 끝 페이지 번호를 총 페이지 수로 대체
if(endPage > maxPage) {
	endPage = maxPage;
}

//----------------------------------------------------------------------------------------
//BoardDAO 객체의 selectBoardList() 메서드를 호출하여 게시물 목록 조회 작업 요청
//=> 파라미터 : 현재 페이지 번호(pageNum), 표시할 목록 갯수(listLimit)
// 리턴타입 : java.util.ArrayList<BoardBean>(boardList)
ArrayList<dollBean> dollList = dollDAO.selectDollList(pageNum, listLimit);
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>solutions/solutions.jsp</title>

<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더 들어가는곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문 메인 이미지 -->
		<div id="sub_img"></div>
		<!-- 왼쪽 메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="dollList.jsp">product</a></li>
				<li><%if(!id.equals("")) { %> <a href="dollCart_get.jsp">Mycart</a><%} else { %> <a href="../member/login.jsp">Mycart</a> <%} %></li>
			</ul>
		</nav>
		<!-- 본문 내용 -->
		<article>
			<h1>product</h1>
<!-- 	<form action="#" name="fr"> -->
			<%
				for(dollBean doll : dollList) {
				%>
				<table id="list">
					<tr onclick="location.href='dollView.jsp?name=<%=doll.getName() %>&page=<%=pageNum %>'">
						<td id=name><img src="<%=doll.getImage() %>" width="200" height="200"></td>
					<tr onclick="location.href='dollView.jsp?name=<%=doll.getName() %>&page=<%=pageNum %>'">
						<td id=name><%=doll.getName() %></td>
					</tr>
					<tr onclick="location.href='dollView.jsp?name=<%=doll.getName() %>&page=<%=pageNum %>'">
						<td id=name><%=doll.getPrice() %>원</td>
					</tr>
				<%	
				}
				%>
		</table>
<!-- 	</form> -->
			<div class="clear"></div>
			<div id="page_control">
				<!-- 
				현재 페이지 번호(pageNum)가 1보다 클 경우에만 Prev 링크 동작
				=> 클릭 시 notice.jsp 로 이동하면서 
				   현재 페이지 번호(pageNum) - 1 값을 page 파라미터로 전달
				-->
				<%if(pageNum > 1) { // 이전페이지가 존재할 경우 %>
					<a href="dollList.jsp?page=<%=pageNum - 1%>">Prev</a>
				<%} else { // 이전페이지가 존재하지 않을 경우 %>
					Prev&nbsp;
				<%} %>
				<!-- 페이지 번호 목록은 시작 페이지(startPage)부터 끝 페이지(endPage) 까지 표시 -->
				<%for(int i = startPage; i <= endPage; i++) { %>
					<!-- 단, 현재 페이지 번호는 링크 없이 표시 -->
					<%if(pageNum == i) { %>
						&nbsp;&nbsp;<%=i %>&nbsp;&nbsp;
					<%} else { %>
						<a href="dollList.jsp?page=<%=i%>"><%=i %></a>
					<%} %>
				<%} %>
				<!-- 
				현재 페이지 번호(pageNum)가 총 페이지 수보다 작을 때만 Next 링크 동작
				=> 클릭 시 notice.jsp 로 이동하면서 
				   현재 페이지 번호(pageNum) + 1 값을 page 파라미터로 전달
				-->
				<%if(pageNum < maxPage) { // 다음페이지가 존재할 경우 %>
					<a href="notice.jsp?page=<%=pageNum + 1%>">Next</a>
				<%} else { // 이전페이지가 존재하지 않을 경우 %>
					&nbsp;Next
				<%} %>
			</div>
		</article>

		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>