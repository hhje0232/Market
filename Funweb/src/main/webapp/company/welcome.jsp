<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>company/welcome.jsp</title>
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
				<li><a href="welcome.jsp">Welcome</a></li>
				<li><a href="history.jsp">History</a></li>
<!-- 				<li><a href="#">Newsroom</a></li> -->
<!-- 				<li><a href="#">Public Policy</a></li> -->
			</ul>
		</nav>
		<!-- 본문 내용 -->
		<article id = "ab">
         <h1 class ="welcom">WELCOME</h1>
         <div class ="wel">
                  마켓에 오신 걸 환영합니다!
            
         </div>
      </article>


		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


