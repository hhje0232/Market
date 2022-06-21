<%@page import="java.util.ArrayList"%>
<%@page import="test.TestDAO"%>
<%@page import="test.TestBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
int pageNum = 1;

if(request.getParameter("page") != null){
	pageNum = Integer.parseInt(request.getParameter("page"));
}

int listLimit = 10;
int pageLimit = 10;

TestDAO testDAO = new TestDAO();
int listCount = testDAO.selectListCount(); 

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

ArrayList<TestBean> testList = testDAO.selectTestList(pageNum, listLimit);


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice.jsp</title>
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
		<div id="sub_img_center"></div>
		<!-- 왼쪽 메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="notice.jsp">Notice</a></li>
				<li><a href="news.jsp">Public News</a></li>
				<li><a href="#">Driver Download</a></li>
				<li><a href="#">Service Policy</a></li>
			</ul>
		</nav>
		<!-- 본문 내용 -->
		<article>
			<h1>Public News</h1>
			<table id="notice">
				<tr>
					<th class="tno">No.</th>
					<th class="ttitle">Title</th>
					<th class="twrite">Write</th>
					<th class="tdate">Date</th>
					<th class="tread">Read</th>
				</tr>
					<!-- 게시물 행 클릭 시 news_content.jsp 페이지로 이동 -->
					<!-- URL 파라미터로 글번호와 페이지번호 전달 -->
					<%
					for(TestBean test : testList){
					%>
					<tr onclick="location.href='news_content.jsp?num=<%=test.getNum()%>&page=<%=pageNum%>'">
						<td><%=test.getNum() %></td>
						<td class="left"><%=test.getSubject() %></td>
						<td><%=test.getName() %></td>
						<td><%=test.getDate() %></td>
						<td><%=test.getReadcount() %></td>
					</tr>
					<%} %>
			</table>
			<div id="table_search">
				<input type="button" value="글쓰기" class="btn" onclick="location.href='news_write.jsp'">
			</div>
			<div id="table_search">
				<form action="news_search.jsp" method="post">
				<select name="searchType">
					<option value="subject">제목</option>
					<option value="name">작성자</option>
				</select>
					<input type="text" name="search" class="input_box">
					<input type="submit" value="Search" class="btn">
				</form>
			</div>
			<!-- 페이징 처리 -->
			<div class="clear"></div>
			<div id="page_control">
				<!-- 
				현재 페이지 번호(pageNum)가 1보다 클 경우에만 Prev 링크 동작
				=> 클릭 시 notice.jsp 로 이동하면서 
				   현재 페이지 번호(pageNum) - 1 값을 page 파라미터로 전달
				-->
				<%if(pageNum > 1){%>
					<a href="news.jsp?page<%=pageNum - 1%>">Prev</a>
				<%} else {%>
					Prev&nbsp;
				<%} %>
				<!-- 페이지 번호 목록은 시작 페이지(startPage)부터 끝 페이지(endPage) 까지 표시 -->
					<!-- 단, 현재 페이지 번호는 링크 없이 표시 -->
				<%for(int i = startPage; i <= endPage; i++){ %>
					<%if(pageNum == i){ %>
						&nbsp;&nbsp;<%=i %>&nbsp;&nbsp;
					<%} else { %>
						<a href="news.jsp?page=<%=i%>"><%=i %></a>
					<%} %>
				<%} %>
				<!-- 
				현재 페이지 번호(pageNum)가 총 페이지 수보다 작을 때만 Next 링크 동작
				=> 클릭 시 notice.jsp 로 이동하면서 
				   현재 페이지 번호(pageNum) + 1 값을 page 파라미터로 전달
				-->
					<%if(pageNum < maxPage) { // 다음페이지가 존재할 경우 %>
					<a href="news.jsp?page=<%=pageNum + 1%>">Next</a>
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
