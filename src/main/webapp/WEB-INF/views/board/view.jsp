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
  			<div class="card-body"><div>${view.content}</div></div>
  		</div>
   		<!-- Reply -->
   		<div class="card mt-3 mb-3">
   			<h4 class="p-3">댓글</h4>
   			<c:forEach items="${reply}" var="reply">
   				<c:choose>
   					<c:when test="${reply.depth != 0}">
   						<div id="reply${reply.rno}" class="card" style="margin-left:50px;">
   					</c:when>
   					<c:otherwise>
   						<div id="reply${reply.rno}" class="card">
   					</c:otherwise>
   				</c:choose>
         			<div class="card-header">
         				<h4 class="d-inline me-5">${reply.writer}</h4>
         				<div class="d-inline float-end">
         					<span class="me-3"><fmt:formatDate value="${reply.regDate}" pattern="yy.MM.dd HH:mm" /></span>
         					<c:if test="${reply.depth == 0}">
         						<a class="btn btn-primary btn-sm" onclick="reReplyWrite(${reply.rno})" id="reReplyBtn${reply.rno}">답글</a>
         					</c:if>
         					<c:if test="${reply.writer == member.userName}">
         						<a class="btn btn-warning btn-sm" onclick="replyModify(${reply.rno})" id="replyModifyBtn${reply.rno}">수정</a>				
         						<!-- Button trigger modal -->
								<button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#staticBackdrop${reply.rno}">
								  삭제
								</button>
								<!-- Modal -->
								<div class="modal fade" id="staticBackdrop${reply.rno}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel${reply.rno}" aria-hidden="true">
									<div class="modal-dialog modal-dialog-centered">
										<div class="modal-content">
								    		<div class="modal-header">
								        		<h5 class="modal-title" id="staticBackdropLabel${reply.rno}">댓글 삭제</h5>
								        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								      		</div>
								      		<div class="modal-body" align="left">
								      			정말 삭제하시겠습니까? 삭제 후 복구할 수 없습니다.
								      		</div>
								      		<div class="modal-footer">
								        		<button type="button" class="btn btn-warning" data-bs-dismiss="modal">취소</button>
								        		<a class="btn btn-danger" href="/reply/delete?bno=${reply.bno}&rno=${reply.rno}">삭제</a>
								      		</div>
								    	</div>
									</div>
								</div>
         					</c:if>
         				</div>
         			</div>
         			<div class="card-body">${reply.content}</div>
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
					<input type="hidden" name="depth" value="0">
      				<button type="submit" class="btn btn-primary float-end mt-3">작성</button>
      			</div>
			</form>
   		</div>
		<!-- buttons -->
		<div class="mb-3" align="right">
  			<a class="btn btn-secondary" href="/board/listPage?num=1">목록</a>
			<c:if test="${view.writer == member.userName}">
     	 		<a class="btn btn-warning" href="/board/modify?bno=${view.bno}" role="button">수정</a>
    	  		<!-- Button trigger modal -->
				<button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#staticBackdrop2">
				  삭제
				</button>
				<!-- Modal -->
				<div class="modal fade" id="staticBackdrop2" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel2" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
				    		<div class="modal-header">
				        		<h5 class="modal-title" id="staticBackdropLabel2">게시글 삭제</h5>
				        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      		</div>
				      		<div class="modal-body" align="left">
				      			정말 삭제하시겠습니까? 삭제 후 복구할 수 없습니다.
				      		</div>
				      		<div class="modal-footer">
				        		<button type="button" class="btn btn-warning" data-bs-dismiss="modal">취소</button>
				        		<a class="btn btn-danger" href="/board/delete?bno=${view.bno}">삭제</a>
				      		</div>
				    	</div>
					</div>
				</div>
			</c:if>
    	</div>
  	</div>
  	<script>
  		function resize(obj) {
  	 		obj.style.height = "1px";
  	  		obj.style.height = (12 + obj.scrollHeight)+"px";
  		}
  		
  		function replyModify(n) {
  			reReplyWriteCancle(n);
  			
  			var btnCode = '<a class="btn btn-warning btn-sm" onclick="replyModifyCancle(' + n + ')" id="replyModifyCancleBtn' + n + '">취소</a>';
  			$('#replyModifyBtn' + n).replaceWith(btnCode);
  			
  			var code = "";
  			code += '<form method="post" action="/reply/modify" class="p-3 card" id="replyModify' + n + '">';
  			code += '	<div class="ms-2 mb-2">'
  	  		code += '		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-return-right" viewBox="0 0 16 16">'
  	  		code += '			<path fill-rule="evenodd" d="M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z"/>'
  	  		code += '		</svg>'
  	  		code += '		<h4 class="ms-1 d-inline-flex">댓글 수정</h4>'
  	  		code += '	</div>'
  			code += '	<div class="form-floating mb-2">';
  			code += '		<input name="writer" type="text" class="form-control" id="floatingInput" placeholder="name" value="${member.userName}" readonly required>';
  			code += '		<label for="floatingInput">이름</label>';
  			code += '	</div>';
  			code += '	<div class="form-floating">';
  			code += '		<textarea name="content" class="form-control" placeholder="Leave a comment here" id="floatingTextarea2" style="min-height: 100px; resize: none;" onkeydown="resize(this)" onkeyup="resize(this)" autofocus required></textarea>';
  			code += '		<label for="floatingTextarea2">내용</label>';
  			code += '		<input type="hidden" name="bno" value="${view.bno}">';
  			code += '		<input type="hidden" name="rno" value="' + Number(n) + '">';
  			code += '		<button type="submit" class="btn btn-warning float-end mt-3">수정</button>';
  			code += '	</div>';
  			code += '</form>';
  			$('#reply'+n).after(code);
  		}
  		function replyModifyCancle(n){
  			var btnCode = '<a class="btn btn-warning btn-sm" onclick="replyModify(' + n + ')" id="replyModifyBtn' + n + '">수정</a>';
  			$('#replyModifyCancleBtn'+ n).replaceWith(btnCode);
  			$('#replyModify' + n).remove();
  		}
  		
  		function reReplyWrite(n) {
  			replyModifyCancle(n);
  			 
  			var btnCode = '<a class="btn btn-primary btn-sm" onclick="reReplyWriteCancle(' + n + ')" id="reReplyCancleBtn' + n + '">취소</a>';
  			$('#reReplyBtn' + n).replaceWith(btnCode);
  			
  			var code = "";
  			code += '<form method="post" action="/reply/write" class="p-3 card" id="reReplyWrite' + n + '">';
  			code += '	<div class="ms-2 mb-2">'
  			code += '		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-return-right" viewBox="0 0 16 16">'
  			code += '			<path fill-rule="evenodd" d="M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z"/>'
  			code += '		</svg>'
  			code += '		<h4 class="ms-1 d-inline-flex">답글 작성</h4>'
  			code += '	</div>'
  			code += '	<div class="form-floating mb-2">'
  			code += '		<c:if test="${errmsg == null}">'
  			code += '			<input name="writer" type="text" class="form-control" id="floatingInput" placeholder="name" value="${member.userName}" readonly required>'
  			code += '		</c:if>'
  			code += '		<c:if test="${errmsg == false}">'
  			code += '			<input name="writer" type="text" class="form-control" id="floatingInput" placeholder="name" value="익명" readonly required>'	
  			code += '		</c:if>'
  			code += '		<label for="floatingInput">이름</label>'
  			code += '	</div>'
  			code += '	<div class="form-floating">';
  			code += '		<textarea name="content" class="form-control" placeholder="Leave a comment here" id="floatingTextarea2" style="min-height: 100px; resize: none;" onkeydown="resize(this)" onkeyup="resize(this)" autofocus required></textarea>';
  			code += '		<label for="floatingTextarea2">내용</label>';
  			code += '		<input type="hidden" name="bno" value="${view.bno}">';
  			code += '		<input type="hidden" name="depth" value="1">';
  			code += '		<input type="hidden" name="parent" value="' + n + '">';
  			code += '		<button type="submit" class="btn btn-primary float-end mt-3">작성</button>';
  			code += '	</div>';
  			code += '</form>';
  			$('#reply'+n).after(code);
  		}
  		function reReplyWriteCancle(n) {
  			var btnCode = '<a class="btn btn-primary btn-sm" onclick="reReplyWrite(' + n + ')" id="reReplyBtn' + n + '">답글</a>';
  			$('#reReplyCancleBtn'+ n).replaceWith(btnCode);
  			$('#reReplyWrite' + n).remove();
  		}
  	</script>
  	<%-- Bootstrap Bundle with Popper --%>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
</body>

</html>
