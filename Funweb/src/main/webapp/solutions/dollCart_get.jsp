<%@page import="product.dollDAO"%>
<%@page import="cart.CartDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cart.CartBean"%>
<%@page import="product.dollBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
dollBean doll = new dollBean();

// String id = (String)session.getAttribute("id");
// String name = (String)session.getAttribute("name");
// int price = (int)session.getAttribute("price");
// int qty = (int)session.getAttribute("qty");

String id = "";

if(session.getAttribute("sId") != null) {
   id = (String)session.getAttribute("sId");
   
}



CartDAO cartDAO = new CartDAO();
ArrayList<CartBean> cartList = cartDAO.selectCartList(id);



int allPrice = 0;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
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
	<article>
	<h1>Cart</h1>
	<hr>
	
	<table class="cart">
		<tr class="line">
			<th></th>
			<th>상품명</th>
			<th>수량</th>
			<th>판매가</th>
		</tr>
		
		<%
		for(CartBean cart : cartList){
		 int price = (int)cart.getPrice();
        allPrice += price;
        
        ArrayList<CartBean> imageList = cartDAO.selectImageList(cart.getName());
        
        for(CartBean image : imageList){
        	
		%>
		<tr class="line">
			<td class="im"><img src="<%=image.getImage() %>" width="100" height="100"></td>
			<td class="name"><%=cart.getName() %></td>
			<td class="qty"><%=cart.getQty() %>개</td>
			<td class="pr"><%=cart.getPrice() %>원</td>
			<td><input type="button" value="삭제" onclick="location.href='dollCart_delete.jsp?name=<%=cart.getName()%>'"></td>
		</tr>
		<%

        }
		
		} %>
<!-- 		<tr> -->
<!-- 			<td colspan="3"> -->
<!-- 			</td> -->
<!-- 		</tr> -->
	</table>
		<hr>
	<table class="ch">
		  <tr>
				<td class="cc"><input type="button" value="상품목록" onclick="location.href='dollList.jsp'">
				<input type="button" value="즉시주문" onclick="checkLogin()"></td>
               <td rowspan="2">총 금액 &nbsp;
               <%=allPrice %>원&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td> 
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