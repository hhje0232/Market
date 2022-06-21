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
         <h1 class ="welcom">ABOUT</h1>
         <div class ="ou">
            <table>
               <tr>
                  <td class = "info">상세정보</td>
               </tr>
            </table>
            <table class = "oh">
               <tr>
                  <th>이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름</th>
                  <td>홍정은</td>
               </tr>
               <tr>
                  <th>생&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;일</th>
                  <td>1998.03.27</td>
               </tr>
               <tr>
                  <th>핸 드 폰</th>
                  <td>010-2437-3028</td>
               </tr>
               <tr>
                  <th>이 메 일</th>
                  <td>hong@hong.com</td>
               </tr>
               <tr>
                  <th>블 로 그</th>
                  <td>blog.hong.com/hong</td>
               </tr>
               <tr>
                  <th>주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</th>
                  <td>경상남도 거제시 상동 7길 30</td>
               </tr>
            </table>
         </div>
         <div>
            <table>
               <tr>
                  <td class = "info">자격정보</td>
               </tr>
            </table>
            <table  class = "oh">
               <tr>
                  <th>2021.07</th>
                  <td>CAD실무능력평가 2급</td>
               </tr>
               <tr>
                  <th>2021.08</th>
                  <td>ATC캐드마스터 1급</td>
               </tr>
                  <tr>
                  <th>&nbsp;</th>
                  <td>&nbsp;</td>
               </tr>
               <tr>
                  <th>&nbsp;</th>
                  <td>&nbsp;</td>
               </tr>
               <tr>
                  <th>&nbsp;</th>
                  <td>&nbsp;</td>
               </tr>
               <tr>
                  <th>&nbsp;</th>
                  <td>&nbsp;</td>
               </tr>
            </table>
         </div>
         <div class ="ou">
            <table>
               <tr>
                  <td class = "info">학력사항</td>
               </tr>
            </table>
            <table class = "oh">
               <tr>
                  <th>2017.02</th>
                  <td>해성고등학교 졸업</td>
               </tr>
               <tr>
                  <th>2022.02</th>
                  <td>동의대학교 전자공학과 졸업</td>
               </tr>
               <tr>
                  <th>&nbsp;</th>
                  <td>&nbsp;</td>
               </tr>
               <tr>
                  <th>&nbsp;</th>
                  <td>&nbsp;</td>
               </tr>
               <tr>
                  <th>&nbsp;</th>
                  <td>&nbsp;</td>
               </tr>
               <tr>
                  <th>&nbsp;</th>
                  <td>&nbsp;</td>
               </tr>
            </table>
         </div>
         <div>
            <table>
               <tr>
                  <td class = "info">경력사항</td>
               </tr>
            </table>
            <table  class = "oh">
               <tr>
                  <tr>
                  <th>&nbsp;</th>
                  <td>&nbsp;</td>
               </tr>
               <tr>
                  <th>&nbsp;</th>
                  <td>&nbsp;</td>
               </tr>
               <tr>
                  <th>&nbsp;</th>
                  <td>&nbsp;</td>
               </tr>
               <tr>
                  <th>&nbsp;</th>
                  <td>&nbsp;</td>
               </tr>
               <tr>
                  <th>&nbsp;</th>
                  <td>&nbsp;</td>
               </tr>
               <tr>
                  <th>&nbsp;</th>
                  <td>&nbsp;</td>
               </tr>
            </table>
         </div>
      </article>


		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


