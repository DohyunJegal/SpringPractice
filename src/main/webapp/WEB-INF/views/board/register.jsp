<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원가입</title>
  <%-- Bootstrap CSS --%>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
</head>
<body>
  <div class="container">
    <div class="">
      <form class="" method="post">
        <div class="form-floating">
          <input class="form-control" type="text" id="userId" name="userId" placeholder="ID" required>
          <label for="userId">아이디</label>
        </div>
        <div class="form-floating">
          <input class="form-control" type="text" id="userPassword" name="userPassword" placeholder="Password" required>
          <label for="userPassword">비밀번호</label>
        </div>
        <div class="form-floating">
          <input class="form-control" type="text" id="userName" name="userName" placeholder="Nickname" required>
          <label for="userName">닉네임</label>
        </div>
      </form>
    </div>
    <div class="">
      <button type="submit" name="submit">가입하기</button>
      <a class="btn btn-primary" href="/" role="button">가입취소</a>
    </div>
  </div>
  <%-- Bootstrap Bundle with Popper --%>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
</body>
</html>
