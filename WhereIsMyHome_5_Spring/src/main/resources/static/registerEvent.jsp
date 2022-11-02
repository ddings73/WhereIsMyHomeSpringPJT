<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="home.dto.*" %>
<%@ page import="java.util.*" %>
<%
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
	
	<!-- JavaScript -->
	<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
	
	<!-- CSS -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/alertify.min.css"/>
	<!-- Default theme -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/default.min.css"/>
	<!-- Semantic UI theme -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/semantic.min.css"/>
	<!-- Bootstrap theme -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/bootstrap.min.css"/>
<title>Insert title here</title>
</head>
<body>
	<div class="container-fluid" style="width: 50%; padding-top: 10rem">
        <form class="row g-3">
            
            <div class="col-12">
              <label for="eventName" class="form-label">이벤트 제목</label>
              <input type="text" class="form-control" id="eventName">
               <div class="valid-feedback">잘했다.</div>  
           	   <div class="invalid-feedback">다시</div> 
            </div>
            
            <div class="col-md-6">
              <label for="eventFrom" class="form-label">이벤트 시작일시</label>
              <input type="text" class="form-control" id="eventFrom" placeholder="2022-09-01 00:00:00">
              <div class="valid-feedback">잘했다.</div>  
              <div class="invalid-feedback">형식 확인하고 다시</div>  
            </div>
            
            <div class="col-md-6">
              <label for="eventTo" class="form-label">이벤트 종료일시</label>
              <input type="text" class="form-control" id="eventTo" placeholder="2022-09-01 00:00:00">
			   <div class="valid-feedback">잘했다.</div>  
          	   <div class="invalid-feedback">형식 확인하고 다시</div>  
            </div>
            
			<br>
            
            <div class="col-12">
              <button type="submit" id="btnRegisterEvent" class="btn btn-primary">이벤트 등록</button>
            </div>
          </form>    
    </div>
    <script>
    	window.onload = function() {
    		document.querySelector("#btnRegisterEvent").onclick = function(e) {
    			
     		   e.preventDefault();

     		   if( document.querySelectorAll("form .is-invalid").length > 0 ){
     			 alert("입력이 올바르지 않습니다.");
     		   } else{
     			   registerEvent();
     		   }
     	 	}
    	};
    	
    	document.querySelector("#eventName").focus();
    	
    	// 유효성 검사 처리
    	document.querySelector("#eventName").onblur = function() {
    		if( validateEventName( this.value ) ){ // 유효
                this.classList.remove('is-invalid');
                this.classList.add('is-valid');
            }else { // 유효 x
                this.classList.remove('is-valid');
                this.classList.add('is-invalid');
            }
    	}
    	
    	document.querySelector("#eventFrom").onblur = function() {
            if( validateEventFrom( this.value ) ){ // 유효
                this.classList.remove('is-invalid');
                this.classList.add('is-valid');
            }else { // 유효 x
                this.classList.remove('is-valid');
                this.classList.add('is-invalid');
            }
        }
    	
    	document.querySelector("#eventTo").onblur = function() {
            if( validateEventTo( this.value ) ){ // 유효
                this.classList.remove('is-invalid');
                this.classList.add('is-valid');
            }else { // 유효 x
                this.classList.remove('is-valid');
                this.classList.add('is-invalid');
            }
        }
    	
    	// 길이가 1이상이면 valid
        function validateEventName( eventName ){
               if( eventName.length >= 1 ) return true;
               else return false;
        }
    	
     // 날짜가 패턴에 맞으면 valid
        function validateEventFrom( eventFrom ){
            var patternEventFrom = new RegExp(/[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1]) (2[0-3]|[01][0-9]):[0-5][0-9]/);

               if( patternEventFrom.test(eventFrom)) return true;
               else return false;
        }
     
        // 날짜가 패턴에 맞으면 valid
        function validateEventTo( eventTo ){
            var patternEventTo = new RegExp(/[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1]) (2[0-3]|[01][0-9]):[0-5][0-9]/);

               if( patternEventTo.test(eventTo)) return true;
               else return false;
        }
    	
		async function registerEvent() {
            
       		let eventName = document.querySelector("#eventName").value;
            let eventFrom = document.querySelector("#eventFrom").value;
            let eventTo = document.querySelector("#eventTo").value;
			
            // parameter
            let urlParams = new URLSearchParams({
            	eventName: eventName,
            	eventFrom: eventFrom,
            	eventTo: eventTo,
             
            });
            
            // fetch options
            let fetchOptions = {
                method: "POST",
                body: urlParams
            }

            let response = await fetch( "<%= contextPath%>/event/register", fetchOptions );
            let data = await response.json();
            
            if( data.result == "success" ){
            	
            	alertify.alert("이벤트 등록 완료", function(){
                	window.location.href = "<%= contextPath%>/jsp/index.jsp";
          		  });
            	
            }else if( data.result == "fail" ){
                alert('서버 오류!');
            }
        };
    </script>
</body>
</html>