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
    <form role="form" method="post" autocomplete="off">
      <div class="card mb-4 p-3">
      	<h4 class="mb-3">회원정보</h4>
      	<div class="row mb-2">
      	  <div class="form-floating col">
            <input class="form-control" type="text" id="userId" name="userId" placeholder="ID" value="${member.userId}" readonly>
            <label for="userId" class="ms-2">아이디</label>
          </div>
          <div class="form-floating col">
            <input class="form-control" type="text" id="userName" name="userName" placeholder="Nickname" value="${member.userName}" readonly>
            <label for="userName" class="ms-2">닉네임</label>
          </div>
      	</div>
      </div>
      <div class="card mb-4 p-3">
        <h5 class="mb-3">비밀번호 수정</h5>
        <div class="mb-2">
          <div class="form-floating mb-2">
            <input class="form-control" type="password" id="userPassword" name="userPassword" placeholder="Password" required>
            <label for="userPassword">비밀번호</label>
            <p id="pwdCheckRes" class="ms-2">비밀번호는 8자 이상, 특수문자를 포함해야합니다.</p>
          </div>
          <div class="form-floating">
            <input class="form-control" type="password" id="userpwdVal" placeholder="Validate Password" required>
            <label for="userpwdVal">비밀번호 확인</label>
            <p id="pwvalCheckRes" class="ms-2">비밀번호를 다시 입력해주세요.</p>
          </div>
        </div>
        <div align="right">
          <button id="submitBtn" class="btn btn-primary" type="submit" name="submit" disabled="disabled">수정하기</button>
        </div>
      </div>
      <div class="card mb-4 p-3">
        <h5 class="mb-3">회원탈퇴</h5>
        <div class="form-check form-switch">
  		  <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault">
  		  <label class="form-check-label" for="flexSwitchCheckDefault">회원탈퇴 버튼 클릭 시 확인 페이지로 이동되며, 탈퇴 시 절대 취소할 수 없음을 인지하였습니다.</label>
		</div>
        <div align="right">
      	  <a id="withdrawBtn" class="btn btn-primary disabled" href="/member/withdrawal" role="button">회원탈퇴</a>
        </div>
      </div>
      <div>
      	<a class="btn btn-primary" href="/" role="button">처음으로</a>
      </div>
    </form>
  </div>
  
  <script>
    var pwCheck = false; var pwvalCheck = false;
    
    function setPwCheck(b){ pwCheck = b; }
	function setPwvalCheck(b){ pwvalCheck = b; }
	
    $("#userPassword, #userpwdVal").on("propertychange change keyup paste input", function(){
	  var val = $("#userPassword").val();
	  var cmp = $("#userpwdVal").val();
		
	  if(val.length < 8 || val.search(/\W|\s/g) <= -1) {
		$("#pwdCheckRes").text("비밀번호는 8자 이상, 특수문자를 포함해야합니다.");
		$("#pwdCheckRes").attr("style", "color:#f00");
		setPwCheck(false);
	  } else {
		$("#pwdCheckRes").text("사용 가능한 비밀번호입니다.");
		$("#pwdCheckRes").attr("style", "color:#00f");
		setPwCheck(true);
	  }
		
	  if(cmp != val) {
		$("#pwvalCheckRes").text("비밀번호가 일치하지 않습니다.");
		$("#pwvalCheckRes").attr("style", "color:#f00");
		setPwvalCheck(false);
	  } else {
		$("#pwvalCheckRes").text("비밀번호가 일치합니다.");
		$("#pwvalCheckRes").attr("style", "color:#00f");
		setPwvalCheck(true);
	  }
	  
	  if(pwCheck == true && pwvalCheck == true){
		$("#submitBtn").removeAttr("disabled");
	  } else {
		$("#submitBtn").attr("disabled", "disabled");
	  }
	});
    
    $('#flexSwitchCheckDefault').click(function(){
		var checked = $('#flexSwitchCheckDefault').is(':checked');
		
		if(checked){
			$('#withdrawBtn').removeClass('disabled');
		} else {
			$('#withdrawBtn').addClass('disabled');
		}
	});
  </script>
  <%-- Bootstrap Bundle with Popper --%>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
</body>
</html>
