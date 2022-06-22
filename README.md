# ⭐️ Portfolio - Market

# 📝 개요
+ 프로젝트 명 : Market

+ 일정 : 2022년 04월

+ 개발 목적 : 중고 인형 상품 판매 사이트 제작

+ 개발 환경
  + O/S : Windows 10
  + Server : Apache-tomcat-8.5
  + Java EE IDE : Eclipse
  + Database : Oracle SQL Developer
  + Programming Language : JAVA, CSS, JavaScript, JSP, SQL
  + API : Google map, kakao address

# 📝 내용
+ 구현 기능
  + 공지사항 게시판 CRUD
  + 스토어 게시판 
  + 회원 게시판

# 📝 구현 기능
## 공지사항 게시판
 ### 1. 공지사항 조회
 
 #### 사이트 내 공지사항 게시판 페이지
 + 구현 기능 설명
    + 공지사항 게시판 글 목록 조회
    + 페이징을 통해 게시글 목록 넘기기
    + 게시판 글 쓰기
    + 게시물 조회
    + 메인페이지에서 최근 게시물 목록 표시 기능
   + 목록으로 이동

![image](https://user-images.githubusercontent.com/104810523/174934577-942c5998-dfeb-4dfc-ae40-e8b88f125333.png)

![image](https://user-images.githubusercontent.com/104810523/174934683-7358d681-c6fe-4f7b-a5ac-8abdd238e0c4.png)

![image](https://user-images.githubusercontent.com/104810523/174934702-306c8fdb-20d8-4c06-8eab-0bfd254637bc.png)

![image](https://user-images.githubusercontent.com/104810523/174934755-b4dbecdd-85c4-4787-9e80-94a613ec313d.png)

![image](https://user-images.githubusercontent.com/104810523/174934765-776d0ea1-8d89-433b-903b-b705660420a9.png)

![image](https://user-images.githubusercontent.com/104810523/174934775-1b812c10-608f-4a0d-bd01-e6b95e16e12d.png)

 ### 2. 공지사항 수정
 #### 공지사항 게시글 수정 페이지
 + 구현 기능 설명
    + 게시글 수정 시, DB에 등록된 게시글 제목, 내용 불러옴.
    + 수정 버튼 클릭 시 수정한 게시글 상세조회로 이동하게 됩니다.
   
![image](https://user-images.githubusercontent.com/104810523/174935520-31cfbe52-b04b-40fa-ac06-27e7c46ef237.png)

![image](https://user-images.githubusercontent.com/104810523/174935527-a39a7247-22e3-4af8-b7c7-831ddb8ad077.png)

![image](https://user-images.githubusercontent.com/104810523/174935539-c610b2ea-2c15-4928-b1c3-ff5708baa128.png)


 ### 3. 공지사항 삭제
 #### 공지사항 게시글 삭제 페이지
 + 구현 기능 설명
    + 삭제 버튼 클릭 시 비밀번호 판별을 하여 삭제 성공 및 실패 확인

![image](https://user-images.githubusercontent.com/104810523/174935881-69d32d5d-5beb-4444-9ccd-331dca127ce1.png)

![image](https://user-images.githubusercontent.com/104810523/174935905-ce2b8a09-30a4-4d34-bf12-1d0ffa620871.png)

![image](https://user-images.githubusercontent.com/104810523/174935853-afdc7d84-a873-468d-916c-d74901844fc0.png)

![image](https://user-images.githubusercontent.com/104810523/174935860-c2c41049-ed62-4401-adc8-1291f46563f2.png)

-------------------------------------
## 스토어 게시판 
### 1. 스토어 상품 조회
 #### 사이트 내 스토어 게시판 페이지
 + 구현 기능 설명
    + 마켓 제품 목록 페이지 구현
    + 수량에 따른 구매 페이지

![image](https://user-images.githubusercontent.com/104810523/174937033-437bce97-76dc-4543-87cd-40f3b1d1634e.png)

![image](https://user-images.githubusercontent.com/104810523/174937040-c876affc-5f14-46fd-a2a8-083071d9e406.png)




### 2. 스토어 장바구니 
#### 장바구니 담기, 삭제 페이지
 + 구현 기능 설명
    + 장바구니 목록 페이지
    + 장바구니 담기 기능
    + 장바구니 삭제 기능
    + 로그아웃 상태에서 장바구니/주문하기 버튼 누르면 로그인 페이지로 이동

![image](https://user-images.githubusercontent.com/104810523/174937044-0e2bbd6c-9cde-435c-a553-57a0a0f97656.png)

![image](https://user-images.githubusercontent.com/104810523/174937056-36b2ab4c-b960-4696-9873-bb33bebc5eab.png)

![image](https://user-images.githubusercontent.com/104810523/174937062-81407353-cb46-499c-bc4b-d90fda2c1a44.png)

![image](https://user-images.githubusercontent.com/104810523/174937069-fa53c112-8ee8-407e-a4cf-424744d5ea5a.png)

## 회원관리 게시판
 ### 1. 회원가입
 
 #### 사이트 내 회원가입 페이지
 + 구현 기능 설명
    + 아이디 중복 확인
    + 우편번호 찾기
    + 비밀번호 보안 단계별 확인
    + 비밀번호 일치 여부 판별


![image](https://user-images.githubusercontent.com/104810523/174937912-83ac9b6d-b4a2-4b10-869e-150315310a49.png)

![image](https://user-images.githubusercontent.com/104810523/174937921-3885fac6-3078-48e8-ae0a-e90cb79dc767.png)

![image](https://user-images.githubusercontent.com/104810523/174937930-5bf661ae-f20e-4ae8-8210-ac95eec0deaf.png)

![image](https://user-images.githubusercontent.com/104810523/174937935-2f0a6160-d3a5-4246-839b-9e509da0852b.png)

![image](https://user-images.githubusercontent.com/104810523/174937943-6f67a80c-081a-4a28-875a-8b8e4e3af5e5.png)

### 2. 로그인
 
 #### 사이트 내 로그인 페이지
 + 구현 기능 설명
    + 로그인 
