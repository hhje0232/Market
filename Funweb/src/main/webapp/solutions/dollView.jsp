<%@page import="product.dollDAO"%>
<%@page import="product.dollBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String name = request.getParameter("name");
String pageNum = request.getParameter("page");

dollDAO dollDAO = new dollDAO();

//BoardDAO 객체의 selectBoard() 메서드를 호출하여 게시물 상세 내용 조회
//=> 파라미터 : 글번호(num), 리턴타입 : BoardBean(board)
dollBean doll = dollDAO.selectDoll(name);


String id = "";

if(session.getAttribute("sId") != null) {
   id = (String)session.getAttribute("sId");
}
%>	



<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>solutions/solutions.jsp</title>
<script type="text/javascript">
	function plusQty() {
// 		var qty = document.fr.qty.value;
		
		var qtyElem = document.fr.qty;
		var qty = qtyElem.value;
		// 폼 데이터 접근하여 value 값 가져오면 string 타입이므로 연산 시 정수형으로 변환 필요
		qtyElem.value = Number(qty) + 1; // 1만큼 증가시킨 값을 다시 표시
	}
	
	function minusQty() {
		var qtyElem = document.fr.qty;
		var qty = qtyElem.value;
		
		// 현재 수량이 1보다 클 경우에만 감소
		if(qty > 1) {
			qtyElem.value = Number(qty) - 1; // 1만큼 감소시킨 값을 다시 표시
		}
	}
	
	function checkLogin(){
		<% if(id.equals("")){ %>
		location.href = "../member/login.jsp";
		return false;
		<%} %>
		
	}
</script>

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
	<form action="dollCart_set.jsp" name="fr" onsubmit="return checkLogin()">
	<input type="hidden" name="name" value="<%=doll.getName() %>">
	<input type="hidden" name="price" value="<%=doll.getPrice() %>">
		<table>
			<tr>
				<td><img src="<%=doll.getImage() %>"  width="380" height="380"></td>
				<td><%=doll.getName() %><br>
				<hr>
				판매가격 : <%=doll.getPrice() %>원<br>
				<hr>
				구매수량 : <input type="text" name="qty" value="1" class="id">
					<input type="button" value="▲" onclick="plusQty()">
					<input type="button" value="▼" onclick="minusQty()"><br>
					<hr>
					<input type="submit" value="장바구니담기">
					<input type="button" value="즉시주문" onclick="checkLogin()">
				
				</td>
			</tr>
		</table>
	</form>
	</article>
		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>