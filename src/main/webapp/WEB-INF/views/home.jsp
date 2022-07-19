<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- 문자 인코딩 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>

<head>
	<title>Home</title>
	<%-- Bootstrap CSS --%>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
</head>

<body>
	<div id="nav">
		<%@ include file="./include/nav.jsp"%>
	</div>
	<div class="container">
		<div>
			<h1>Hello world!</h1>
			<P>The time on the server is ${serverTime}.</P>
		</div>
		<div>
			<p><a href="/board/listPageSearch?num=1">게시물 목록</a></p>
			<p><a href="/board/write">게시물 작성</a></p>
		</div>
	</div>
	<%-- Bootstrap Bundle with Popper --%>
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
</body>

</html>
