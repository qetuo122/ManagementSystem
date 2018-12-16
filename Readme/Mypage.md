# User, Admin Mypage

<br>

## 페이지 소개

<hr>

관리자와 사용자의 정보 수정 및 매장 추가

<br>

## 구동원리

<hr>
 
 - 로그인한 아이디의 session을 이용하여 admin or user의 정보를 DB에서 가져옴
 - 관리자의 경우 자신이 갖고 있는 모든 매장을 리스트에 담아 가져온 후 forEach문으로 구현
 - mouseover기능을 이용하여 Ajax를 통해 각각의 매장정보를 보여줌
 - Ajax를 이용하여 비동기 처리로 각각의 정보를 유효성검사를 통해 수정
 - 매장삭제를 누르면 모달창을 띄운 후 로그아웃 처리
 - 매장추가를 누르면 매장추가 페이지로 이동, 각각의 유효성 검사 후 우편주소는 daum 우편 API를 사용
 - 사용자 탈퇴를 누르면 id값을 조건으로 DB에서 데이터 삭제
 
<br>
 
## 화면

<hr>

 - 쪽지 버튼 및 안읽은 쪽지 표시
 
 
<img width = "300px" height = "300px" src = "https://user-images.githubusercontent.com/42988982/49742037-0d8a3980-fcdb-11e8-9052-ddfb4c6fe477.PNG">


 - List화면
 
 
<img width = "300px" height = "300px" src = "https://user-images.githubusercontent.com/42988982/49741980-f64b4c00-fcda-11e8-9f63-03a5e870b870.PNG"> <img width = "300px" height = "300px" src = "https://user-images.githubusercontent.com/42988982/49742043-111dc080-fcdb-11e8-8ab7-f8c5afd3818c.PNG">
 
 
 - 관리자 쪽지보내기, 사용자 쪽지보내기, 답장
 
 
<img width = "280px" height = "300px" src = "https://user-images.githubusercontent.com/42988982/49742048-124eed80-fcdb-11e8-957a-2ce22b79cefe.png"> <img width = "280px" height = "300px" src = "https://user-images.githubusercontent.com/42988982/49742002-ffd4b400-fcda-11e8-941a-b608059ac106.PNG"> <img width = "280px" height = "300px" src = "https://user-images.githubusercontent.com/42988982/49742050-12e78400-fcdb-11e8-9248-4a931ea77089.PNG">

<br>

## 사용기술

<hr>

 - JavaScript : Jquery, Ajax
 - Bootstrap

## [Management System (돌아가기)](../README.md) <br>

