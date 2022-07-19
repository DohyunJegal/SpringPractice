<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>게시물 목록</title>
	<%-- Bootstrap CSS --%>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
</head>

<body>
	<div id="nav">
		<%@ include file="../include/nav.jsp"%>
	</div>
	<div class="container">
		<table class="table table-striped table-hover">
			<thead>
	  		<tr>
	   			<th>번호</th>
	   			<th>제목</th>
	   			<th>작성일</th>
	   			<th>작성자</th>
	   			<th>조회수</th>
	  		</tr>
	 		</thead>
	 		<tbody class="table-group-divider">
	  		<c:forEach items="${list}" var="list">
				<tr>
	  			<th scope="row">${list.bno}</th>
	  			<td><a href="/board/view?bno=${list.bno}">${list.title}</a></td>
	  			<td><fmt:formatDate value="${list.regDate}" pattern="yy.MM.dd HH:mm" /></td>
	  			<td>${list.writer}</td>
	  			<td>${list.viewCnt}</td>
	 			</tr>
				</c:forEach>
	 		</tbody>
		</table>
		<nav aria-label="Page navigation">
			<ul class="justify-content-center pagination">
				<c:if test="${page.prev}">
					<li class="page-item">
      					<a class="page-link" href="/board/listPage?num=${page.startPageNum - 1}" aria-label="Previous">
        					<span aria-hidden="true">&laquo;</span>
      					</a>
    				</li>
				</c:if>
    			<c:forEach begin="${page.startPageNum}" end="${page.endPageNum}" var="num">
    				<c:if test="${select != num}">
		   				<li class="page-item">
    						<a class="page-link" href="/board/listPage?num=${num}">${num}</a>
    					</li>
  					</c:if>    
    				<c:if test="${select == num}">
    					<li class="page-item active" aria-current="page">
      						<span class="page-link">${num}</span>
    					</li>
  					</c:if>
    			</c:forEach>
    			<c:if test="${page.next}">
    				<li class="page-item">
      					<a class="page-link" href="/board/listPage?num=${page.endPageNum + 1}" aria-label="Next">
        					<span aria-hidden="true">&raquo;</span>
      					</a>
    				</li>
				</c:if>
			</ul>
		</nav>
	</div>
	<%-- Bootstrap Bundle with Popper --%>
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
</body>

</html>
