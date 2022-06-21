<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/join.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	var checkIdResult = false, checkRetypePassResult = false;
	var checkPassResult = false;

function checkRetypePass(pass2){
	// 패스워드 일치 시 checkRetypePassResult 를 true, 아니면 false 로 변경
	var pass = document.fr.pass.value;
	
	var spanElem = document.getElementById("CheckRetypePassResult");
	if(pass == pass2){
		spanElem.innerHTML = "비밀번호 일치";
		spanElem.style.color = "GREEN";
		
		checkRetypePassResult = true;
	}  else { // 일치하지 않을 경우
		spanElem.innerHTML = "비밀번호 불일치";
		spanElem.style.color = "RED";
		
		checkRetypePassResult = false;
	}
}
	
function openCheckIdWindow(){  
    window.open("check_id.jsp", "", "width=400, height=250" );  
}  


function checkPass(pass) {
	// 패스워드 검사를 위한 정규표현식 패턴 작성 및 검사 결과에 따른 변수값 변경
	var spanElem = document.getElementById("checkPassResult");
	var lengthRegex = /^[A-Za-z0-9!@#$%]{8,16}$/;
	var engUpperRegex = /[A-Z]/;
	var engLowerRegex = /[a-z]/;
	var numRegex = /[0-9]/;
	var specRegex = /[!@#$%]/;
	
	var count = 0;
	
	if(lengthRegex.exec(pass)) { // 패스워드 규칙 통과 시
// 		spanElem.innerHTML = "사용 가능한 패스워드";
// 		spanElem.style.color = "GREEN";
// 		checkPassResult = true;

	if(engUpperRegex.exec(pass)) count++;
	if(engLowerRegex.exec(pass)) count++;
	if(numRegex.exec(pass)) count++;
	if(specRegex.exec(pass)) count++;
	
	switch (count) {
	
		case 4 :
			spanElem.innerHTML = "사용 가능한 패스워드(안전)";
			spanElem.style.color = "GREEN";
			checkPassResult = true;
			break;
		case 3 :
			spanElem.innerHTML = "사용 가능한 패스워드(보통)";
			spanElem.style.color = "YELLOW";
			checkPassResult = true;
			break;
		case 2 :
			spanElem.innerHTML = "사용 가능한 패스워드(위험)";
			spanElem.style.color = "ORANGE";
			checkPassResult = true;
			break;
			
		default:
			spanElem.innerHTML = "영문자,숫자,특수문자 중 2가지 이상 조합 필수!";
			spanElem.style.color = "RED";
			checkPassResult = true;
	}
	
// 	alert(count);
	
	} else {
//			spanElem.innerHTML = "사용 불가능한 패스워드";
		spanElem.innerHTML = "영문자,숫자,특수문자 조합 8 ~ 16자리 필수";
		spanElem.style.color = "RED";
		checkPassResult = false;
	}
	
}


function checkSubmit() {
	// 아이디 중복 확인 작업을 통해 아이디를 입력받았고,
	// 패스워드 확인을 통해 두 패스워드가 동일하면 true 리턴, 아니면 false 리턴
	// => 아이디 중복 확인 작업과 패스워드 비교 작업 시 성공 여부를 저장할 변수 필요
	//    (이 변수는 다른 메서드에서도 접근해야하므로 함수 외부에 전역변수로 선언해야함)
	
	   if(checkIdResult == false) { 
		   // 아이디 중복확인을 수행하지 않은 경우(또는 중복인 경우)
	       // alert() 함수를 통해 중복 확인 필수! 메세지 출력 후 아이디 창에 포커스 요청   
		   alert("아이디 중복확인 필수");
	       document.fr.id.focus();
	       // 더 이상 작업이 진행되지 않고, submit 동작을 취소하기 위해 false 값 리턴
	       return false; // 리턴값이 폼태그의 onsubmit = "return checkForm()" 부분으로 전달되어
	       // false 일 때 return false 가 되어 submit 동작이 취소됨(생략 시 true 리턴됨)
	    } else if(checkPassResult == false){
	    	alert("올바른 패스워드 입력 필수");
	    	document.fr.pass.focus();
	    	return false;
	    } else if(checkRetypePassResult == false) {
	       alert("패스워드 확인 필수");
	       document.fr.pass2.focus();
	       return false;
	    }


}

// function checkSubmit() {
//       if(checkIdResult  == false) {
//          alert("아이디 중복확인 필수입니다!");
//          document.fr.id.focus();
//          return false;
//       } else if(checkPassResult == false){
//          alert("사용 불가능한 비밀번호 입니다!");
//          document.fr.pass.focus();
//          return false;
//       } else if(isRetypePassCheck == false){
//          alert("비밀번호가 불일치 합니다!");
//          document.fr.pass2.focus();
//          return false;
//       } else {
//          return true;
//       }
//    }

function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('post_code').value = data.zonecode;
            document.getElementById("address1").value = roadAddr;
            document.getElementById("address1").value = data.jibunAddress;
            
        }
    }).open();
}

</script>
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더 들어가는곳 -->
		  
		<!-- 본문들어가는 곳 -->
		  <!-- 본문 메인 이미지 -->
		  <div id="sub_img_member"></div>
		  <!-- 왼쪽 메뉴 -->
		  <nav id="sub_menu">
		  	<ul>
		  		<li><a href="#">Join us</a></li>
		  		<li><a href="#">Privacy policy</a></li>
		  	</ul>
		  </nav>
		  <!-- 본문 내용 -->
		  <article>
		  	<h1>Join Us</h1>
		  	<form action="joinPro.jsp" method="post" id="join" name="fr" onsubmit="return checkSubmit()">
		  		<fieldset>
		  			<legend>Basic Info</legend>
		  			<label>User Id</label>
		  			<input type="text" name="id" class="id" id="id" required="required" readonly="readonly" placeholder="중복체크 버튼 클릭">
		  			<input type="button" value="dup. check" class="dup" id="btn" onclick="openCheckIdWindow()"><br>
		  			
		  			
		  			<label>Password</label>
		  			<input type="password" name="pass" id="pass" required="required" placeholder="영문,숫자,특수문자 8~16글자" onkeyup="checkPass(this.value)">		
		  			<span id="checkPassResult"></span><br>
		  			
		  			<label>Retype Password</label>
		  			<input type="password" name="pass2" onkeyup="checkRetypePass(this.value)" required="required">
		  			<span id="CheckRetypePassResult"></span><br>
		  			
		  			<label>Name</label>
		  			<input type="text" name="name" id="name" required="required"><br>
		  			
		  			<label>E-Mail</label>
		  			<input type="email" name="email" id="email" required="required"><br>
		  			
		  		</fieldset>
		  		
		  		<fieldset>
		  			<legend>Optional</legend>
		  			<label>Post code</label>
		  			<input type="text" name="post_code" id="post_code" readonly="readonly"  placeholder="검색 버튼 클릭">
		  			<input type="button" value="search"  onclick="execDaumPostcode()" class="dup"><br>
		  			<label>Address</label>
		  			<input type="text" name="address1" id="address1" readonly="readonly">
		  			<input type="text" name="address2" id="address2" placeholder="상세주소 입력"><br>
		  			<label>Phone Number</label>
		  			<input type="text" name="phone" ><br>
		  			<label>Mobile Phone Number</label>
		  			<input type="text" name="mobile" ><br>
		  		</fieldset>

		  		<div class="clear"></div>
		  		<div id="buttons">
		  			<input type="submit" value="Submit" class="submit">
		  			<input type="reset" value="Cancel" class="cancel">
		  		</div>
		  	</form>
		  </article>
		  
		  
		<div class="clear"></div>  
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


