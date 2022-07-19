<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <title>게시물 조회</title>
  <%-- Bootstrap CSS --%>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
</head>

<body>
	<!-- Navbar -->
	<div id="nav">
		<%@ include file="../include/nav.jsp"%>
	</div>
	<div class="container">
    	<!-- Content -->
    	<div class="card mt-3">
  			<div class="card-header">
  				<div class="row">
  					<h2 class="col-auto me-auto">${view.title}</h2>
  					<span class="col-auto me-2">${view.writer}</span>
  				</div>
  				<div align="right">
  					<span class="me-2">조회수 : ${view.viewCnt}</span>
  					<span class="me-2"><fmt:formatDate value="${view.regDate}" pattern="yy.MM.dd HH:mm" /></span>
  				</div>
  			</div>
  			<div class="card-body" style="white-space: pre-wrap;">${view.content}</div>
  		</div>
   		<!-- Reply -->
   		<div class="card mt-3 mb-3">
   			<h4 class="p-3">댓글</h4>
   			<c:forEach items="${reply}" var="reply">
        		<div id="reply${reply.rno}" class="card">
         			<div class="card-header">
         				<h4 class="d-inline me-5">${reply.writer}</h4>
         				<div class="d-inline float-end">
         					<span class="me-3"><fmt:formatDate value="${reply.regDate}" pattern="yy.MM.dd HH:mm" /></span>
         					<c:if test="${reply.writer == member.userName}">
         						<a class="btn btn-warning btn-sm" onclick="replyModify(${reply.rno})">수정</a>
         						<a class="btn btn-danger btn-sm" href="/reply/delete?bno=${reply.bno}&rno=${reply.rno}">삭제</a>
         					</c:if>
         				</div>
         			</div>
         			<div class="card-body" style="white-space: pre-wrap;">${reply.content}</div>
          		</div>
        	</c:forEach>
      		<form method="post" action="/reply/write" class="p-3 card">
      			<div class="form-floating mb-2">
      				<c:if test="${errmsg == null}">
      					<input name="writer" type="text" class="form-control" id="floatingInput" placeholder="name" value="${member.userName}" readonly required>
      				</c:if>
      				<c:if test="${errmsg == false}">
      					<input name="writer" type="text" class="form-control" id="floatingInput" placeholder="name" value="익명" readonly required>
      				</c:if>
  					<label for="floatingInput">이름</label>
      			</div>
      			<div class="form-floating">
					<textarea name="content" class="form-control" placeholder="Leave a comment here" id="floatingTextarea2" style="min-height: 100px; resize: none;" onkeydown="resize(this)" onkeyup="resize(this)" required></textarea>
  					<label for="floatingTextarea2">내용</label>
					<input type="hidden" name="bno" value="${view.bno}">
      				<button type="submit" class="btn btn-primary float-end mt-3">작성</button>
      			</div>
			</form>
   		</div>
		<!-- buttons -->
		<div class="mb-3" align="right">
  			<a class="btn btn-secondary" href="/board/listPage?num=1">목록</a>
			<c:if test="${view.writer == member.userName}">
     	 		<a class="btn btn-warning" href="/board/modify?bno=${view.bno}" role="button">수정</a>
    	  		<a class="btn btn-danger" href="/board/delete?bno=${view.bno}">삭제</a>
			</c:if>
    	</div>
  	</div>
  	<script>
  		function resize(obj) {
  	 		obj.style.height = "1px";
  	  		obj.style.height = (12 + obj.scrollHeight)+"px";
  		}
  		function replyModify(n) {
  			var code = "";
  			
  			code += '<form method="post" action="/reply/modify" class="p-3 card">';
  			code += '	<h4 class="mb-2">댓글 수정</h4>'
  			code += '	<div class="form-floating mb-2">';
  			code += '		<input name="writer" type="text" class="form-control" id="floatingInput" placeholder="name" value="${member.userName}" readonly required>';
  			code += '		<label for="floatingInput">이름</label>';
  			code += '	</div>';
  			code += '	<div class="form-floating">';
  			code += '		<textarea name="content" class="form-control" placeholder="Leave a comment here" id="floatingTextarea2" style="min-height: 100px; resize: none;" onkeydown="resize(this)" onkeyup="resize(this)" autofocus required></textarea>';
  			code += '		<label for="floatingTextarea2">내용</label>';
  			code += '		<input type="hidden" name="bno" value="${view.bno}">';
  			code += '		<input type="hidden" name="rno" value="' + Number(n) + '">';
  			code += '		<button type="submit" class="btn btn-primary float-end mt-3">수정</button>';
  			code += '	</div>';
  			code += '</form>';

  			$('#reply'+n).replaceWith(code);
  		}
	</script>
	<%-- Bootstrap Bundle with Popper --%>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
</body>

</html>
