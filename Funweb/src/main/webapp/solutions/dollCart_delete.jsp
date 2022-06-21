<%@page import="cart.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String id = (String)session.getAttribute("sId");
String name = request.getParameter("name");

CartDAO cartDAO = new CartDAO();
int deleteCount = cartDAO.deleteCart(id, name);

if(deleteCount > 0){
	response.sendRedirect("dollCart_get.jsp");
} else { %>
	<script>
	alert("글 삭제 실패!");
	history.back();
	</script>
<%}
%>
