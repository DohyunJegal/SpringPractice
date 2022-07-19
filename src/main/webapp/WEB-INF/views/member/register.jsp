<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원가입</title>
  <%-- jquery --%>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <%-- Bootstrap CSS --%>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
</head>
<body>
  <div id="nav">
	<%@ include file="../include/nav.jsp"%>
  </div>
  <div class="container mt-3">
    <div class="">
      <form class="" role="form" method="post" autocomplete="off">
      	<!-- 아이디 -->
      	<div>
      	  <div class="form-floating mb-2">
            <input class="form-control" type="text" id="newuserId" name="newuserId" placeholder="ID" required>
            <label for="newuserId">아이디</label>
          </div>
          <div class="d-flex ms-2">
            <p id="idCheckRes" class="">아이디는 영문, 숫자만 입력 가능합니다.</p>
          </div>
      	</div>
      	<!-- 비밀번호 -->
      	<div>
      	  <div>
      	    <div class="form-floating mb-2">
              <input class="form-control" type="password" id="newuserPassword" name="newuserPassword" placeholder="Password" required>
              <label for="newuserPassword">비밀번호</label>
            </div>
            <div class="d-flex ms-2">
              <p id="passwordCheckRes" class="">비밀번호는 8자 이상, 특수문자를 포함해야합니다.</p>
            </div>
      	  </div>
      	  <div>
      	    <div class="form-floating mb-2">
              <input class="form-control" type="password" id="passwordValidate" placeholder="Validate Password" required>
              <label for="passwordValidate">비밀번호 확인</label>
            </div>
            <div class="d-flex ms-2">
              <p id="pvCheckRes" class="">비밀번호를 다시 입력해주세요.</p>
            </div>
      	  </div>
      	</div>
      	<!-- 닉네임 -->
      	<div>
      	  <div class="form-floating mb-2">
            <input class="form-control" type="text" id="newuserName" name="newuserName" placeholder="Nickname" required>
            <label for="newuserName">닉네임</label>
          </div>
          <div class="d-flex ms-2">
            <p id="nameCheckRes" class="">중복된 닉네임은 사용할 수 없습니다.</p>
          </div>
      	</div>
        <!-- 버튼 -->
        <div align="right">
      	  <button class="btn btn-primary me-2" id="submitBtn" type="submit" name="submit" disabled="disabled">가입하기</button>
      	  <a class="btn btn-primary" href="/" role="button">가입취소</a>
    	</div>
      </form>
    </div>
  </div>

  <script>
  	var idCheck = false; var pwCheck = false; var pwvalCheck = false; var nameCheck = false;
  	
  	function setIdCheck(b){ idCheck = b; }
	function setPwCheck(b){ pwCheck = b; }
	function setPwvalCheck(b){ pwvalCheck = b; }
	function setNameCheck(b){ nameCheck = b; }
  	
	$("#newuserId").on("propertychange change keyup paste input", function(){
	  var query = {userId : $("#newuserId").val()};

	  $.ajax({
	  	url : "/member/idCheck",
	   	type : "post",
	   	data : query,
	   	success : function(data) {
	      if(data == 1 || $("#newuserId").val().search(/\W|\s/g) > -1) {
	        $("#idCheckRes").text("사용할 수 없는 아이디입니다.");
	        $("#idCheckRes").attr("style", "color:#f00");
	        setIdCheck(false);
	      } else if($("#newuserId").val() == ""){
	    	$("#idCheckRes").text("아이디는 영문, 숫자만 입력 가능합니다.");
		    $("#idCheckRes").attr("style", "color:#000");
		    setIdCheck(false);
	      } else {
	        $("#idCheckRes").text("사용 가능한 아이디입니다.");
	        $("#idCheckRes").attr("style", "color:#00f");
	        setIdCheck(true);
	      }
	    }
	  });
    });
	
	$("#newuserName").on("propertychange change keyup paste input", function(){
	  var query = {userName : $("#newuserName").val()};

	  $.ajax({
		url : "/member/nameCheck",
		type : "post",
		data : query,
		success : function(data) {
		  if(data == 1) {
		    $("#nameCheckRes").text("사용할 수 없는 닉네임입니다.");
		    $("#nameCheckRes").attr("style", "color:#f00");
		    setNameCheck(false);
		  } else if($("#newuserName").val() == ""){
		   	$("#nameCheckRes").text("중복된 닉네임은 사용할 수 없습니다.");
			$("#nameCheckRes").attr("style", "color:#000");
			setNameCheck(false);
		  } else {
		    $("#nameCheckRes").text("사용 가능한 닉네임입니다.");
		    $("#nameCheckRes").attr("style", "color:#00f");
		    setNameCheck(true);
		  }
		}
	  });
	});
	
	$("#newuserPassword, #passwordValidate").on("propertychange change keyup paste input", function(){
		var val = $("#newuserPassword").val();
		var cmp = $("#passwordValidate").val();
		
		if(val.length < 8 || val.search(/\W|\s/g) <= -1) {
			$("#passwordCheckRes").text("비밀번호는 8자 이상, 특수문자를 포함해야합니다.");
		    $("#passwordCheckRes").attr("style", "color:#f00");
		    setPwCheck(false);
		} else {
		    $("#passwordCheckRes").text("사용 가능한 비밀번호입니다.");
		    $("#passwordCheckRes").attr("style", "color:#00f");
		    setPwCheck(true);
		}
		
		if(cmp != val) {
			$("#pvCheckRes").text("비밀번호가 일치하지 않습니다.");
		    $("#pvCheckRes").attr("style", "color:#f00");
		    setPwvalCheck(false);
		} else {
		    $("#pvCheckRes").text("비밀번호가 일치합니다.");
		    $("#pvCheckRes").attr("style", "color:#00f");
		    setPwvalCheck(true);
		}
	});
	
	$(".form-control").on("propertychange change keyup paste input", function(){
		if(idCheck == true && pwCheck == true && pwvalCheck == true && nameCheck == true){
			$("#submitBtn").removeAttr("disabled");
		} else {
			$("#submitBtn").attr("disabled", "disabled");
		}
	});
  </script>
  <%-- Bootstrap Bundle with Popper --%>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
</body>
</html>
