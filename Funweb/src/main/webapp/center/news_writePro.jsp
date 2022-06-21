<%@page import="test.TestDAO"%>
<%@page import="test.TestBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

TestBean test = new TestBean();
test.setName(request.getParameter("name"));
test.setPass(request.getParameter("pass"));
test.setSubject(request.getParameter("subject"));
test.setContent(request.getParameter("content"));

TestDAO testDAO = new TestDAO();
int insertCount = testDAO.insertTest(test);

if(insertCount > 0){
	response.sendRedirect("news.jsp");
} else { %>
	<script>
	alert("글쓰기 실패!");
	history.back();
	</script>
	<%
}

%>