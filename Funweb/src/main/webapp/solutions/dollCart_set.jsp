<%@page import="cart.CartDAO"%>
<%@page import="cart.CartBean"%>
<%@page import="product.dollBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
dollBean doll = new dollBean();

String id = (String)session.getAttribute("sId");
// String name = (String)session.getAttribute("name");
// int qty = (int)session.getAttribute("qty");
// int price = (int)session.getAttribute("price");

// String id = request.getParameter("id");
String name = request.getParameter("name");
int qty = Integer.parseInt(request.getParameter("qty"));
int price = Integer.parseInt(request.getParameter("price"));

if(qty > 0) {
	   price *= qty;
	}

// session.setAttribute("sid", id);
session.setAttribute("name", name);
session.setAttribute("qty", qty);
session.setAttribute("price", price);

CartBean cart = new CartBean();
cart.setId(id);
cart.setName(name);
cart.setQty(qty);
cart.setPrice(price);


CartDAO cartDAO = new CartDAO();
cartDAO.insertCart(cart, name, id);


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<!-- 	<h1>장바구니 추가가 완료되었습니다.</h1> -->
	<h3>장바구니 추가가 완료되었습니다.</h3>
	<table>
		<tr>
			<td>상품명</td>
			<td><%=name %></td>
		</tr>
		<tr>
			<td>수량</td>
			<td><%=qty %></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="button" value="장바구니목록" onclick="location.href='dollCart_get.jsp'">
			</td>
		</tr>
	</table>
	</article>
		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>











