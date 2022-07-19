<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="/">webPage</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto">
      	<li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            글 목록
          </a>
          <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="navbarDropdownMenuLink">
            <li><a class="dropdown-item" href="/board/listPageSearch?num=1">글 목록 + 페이징 + 검색</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="/board/listPage?num=1">글 목록 + 페이징</a></li>
            <li><a class="dropdown-item" href="/board/list">글 목록</a></li>
          </ul>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/board/write">글 작성</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/chat">채팅</a>
        </li>
      </ul>
      <!-- login -->
      <c:if test="${member == null}">
    	<c:if test="${msg == false}">
    	  <p class="me-3" style="color: gray;" id="errMsg">로그인 실패! 아이디 혹은 비밀번호를 확인해주세요.</p>
    	</c:if>
      	<div class="d-flex">
  		  <button type="button" class="btn btn-outline-light dropdown-toggle"data-bs-toggle="dropdown" aria-expanded="false" data-bs-auto-close="outside">
    	    로그인
  		  </button>
  		  <form class="dropdown-menu dropdown-menu-dark dropdown-menu-end p-4" method="post" action="/member/login" style="min-width: 300px;">
    	    <div class="mb-3">
      	  	  <label for="userId" class="form-label">아이디</label>
      		  <input type="text" class="form-control" id="userId" name="userId" placeholder="ID" required>
    	    </div>
    	    <div class="mb-4">
      		  <label for="userPassword" class="form-label">비밀번호</label>
      		  <input type="password" class="form-control" id="userPassword" name="userPassword" placeholder="Password" required>
    	    </div>
    	    <div class="row px-3">
    	  	  <button type="submit" class="btn btn-outline-light col me-3">로그인</button>
    	  	  <a class="btn btn-outline-light col" role="button" href="/member/register">회원가입</a>
    	    </div>
  	      </form>
	    </div>
      </c:if>
      <c:if test="${member != null}">
      	<div class="d-flex">
      		<span class="navbar-text">${member.userName}님</span>
      		<a class="btn btn-outline-light ms-3" role="button" href="/member/modify">정보수정</a>
      		<a class="btn btn-outline-light ms-3" role="button" href="/member/logout">로그아웃</a>
      	</div>
      </c:if>
    </div>
  </div>
</nav>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $( document ).ready( function() {
      $('#errMsg').fadeOut( 4000, 'swing' );
  } );
</script>
