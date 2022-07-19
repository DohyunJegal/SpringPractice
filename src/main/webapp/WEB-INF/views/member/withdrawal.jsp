<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원탈퇴</title>
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
            <input class="form-control" type="text" id="userId" name="userId" placeholder="ID"  value="${member.userId}" readonly>
            <label for="userId" class="ms-2">아이디</label>
          </div>
          <div class="form-floating col">
            <input class="form-control" type="text" id="userName" name="userName" placeholder="Nickname" value="${member.userName}" readonly>
            <label for="userName" class="ms-2">닉네임</label>
          </div>
        </div>
      </div>
      <div class="card mb-4 p-3">
        <p class="mb-3">탈퇴할 회원의 정보가 맞는지 확인 후 비밀번호를 입력해주세요.</p>
        <div class="form-floating mb-3">
          <input class="form-control" type="password" id="userPassword" name="userPassword" placeholder="Password" required>
          <label for="userPassword">비밀번호</label>
        </div>
        <c:if test="${errmsg == false}">
          <p class="ms-2">입력한 비밀번호가 일치하지 않습니다.</p>
        </c:if>
        <div align="right">
          <button class="btn btn-primary" type="submit">탈퇴하기</button>
        </div>
      </div>
      
      <div>
    	
      	<a class="btn btn-primary" href="/" role="button">탈퇴취소</a>
      </div>
    </form>
  </div>
  <%-- Bootstrap Bundle with Popper --%>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
</body>
</html>
