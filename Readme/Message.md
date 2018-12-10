# User, Admin Message


## Page소개

<hr>

관리자와 사용자간 상호 쪽지 기능



## 구동원리

<hr>
 
 - Ajax를 이용하여 비동기 상태에서 선택한 매장의 session을 가져와 해당 매장의 주인이 받은 쪽지 리스트를 DB에서 불러옴
 - 쪽지를 불러올 때 읽은 쪽지와 읽지 않은 쪽지를 구분, 읽었을 경우만 삭제 가능
 - setInterval함수를 이용해 DB를 확인하여 새로운 메시지가 있는지 확인
 - 관리자가 쪽지를 보낼 경우 사용자 리스트를 select option에 담아 선택 (전체보내기 가능)
 - Ajax를 이용하여 쪽지 보내기 및 답장 기능 구현
 

 
## 화면

<hr>

 - 쪽지 버튼 및 안읽은 쪽지 표시
 
 
<img width = "300px" height = "300px" src = "https://user-images.githubusercontent.com/42988982/49742037-0d8a3980-fcdb-11e8-9052-ddfb4c6fe477.PNG">


 - List화면
 
 
<img width = "300px" height = "300px" src = "https://user-images.githubusercontent.com/42988982/49741980-f64b4c00-fcda-11e8-9f63-03a5e870b870.PNG"> <img width = "300px" height = "300px" src = "https://user-images.githubusercontent.com/42988982/49742043-111dc080-fcdb-11e8-8ab7-f8c5afd3818c.PNG">
 
 
 - 관리자 쪽지보내기, 사용자 쪽지보내기, 답장
 
 
<img width = "280px" height = "300px" src = "https://user-images.githubusercontent.com/42988982/49742048-124eed80-fcdb-11e8-957a-2ce22b79cefe.png"> <img width = "280px" height = "300px" src = "https://user-images.githubusercontent.com/42988982/49742002-ffd4b400-fcda-11e8-941a-b608059ac106.PNG"> <img width = "280px" height = "300px" src = "https://user-images.githubusercontent.com/42988982/49742050-12e78400-fcdb-11e8-9248-4a931ea77089.PNG">

## 사용기술

 - JavaScript : Jquery, Ajax
 - Bootstrap


