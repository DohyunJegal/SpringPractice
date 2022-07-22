<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>게시물 작성</title>
	
	<%-- CKEditor --%>
	<script src="/resources/ckeditor5/build/ckeditor.js"></script>​
	<%-- Bootstrap CSS --%>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">

	<style>
		.ck-editor__editable {
			height: 700px;
		}
	</style>
</head>

<body>
	<div id="nav">
		<%@ include file="../include/nav.jsp"%>
	</div>
	<div class="container my-3">
		<h3 class="mb-3">게시글 작성</h3>
		<form method="post" enctype="multipart/form-data">
			<div class="row g-2 mb-3">
				<div class="col-8">
					<div class="form-floating">
						<input type="text" name="title" class="form-control" id="floatingInputTitle" placeholder="title" required>
						<label for="floatingInputTitle">제목</label>
					</div>
				</div>
				<div class="col-4">
					<div class="form-floating">
						<c:if test="${errmsg == null}">
							<input type="text" name="writer" class="form-control" id="floatingInputWriter" placeholder="writer" value="${member.userName}" readonly required>
						</c:if>
						<c:if test="${errmsg == false}">
							<input type="text" name="writer" class="form-control" id="floatingInputWriter" placeholder="writer" value="익명" readonly required>
						</c:if>
						<label for="floatingInputWriter">작성자</label>
					</div>
				</div>
			</div>
			<div>
				<textarea name="content" id="inputContent" placeholder="내용을 입력하세요."></textarea>
				<script>
					ClassicEditor
						.create( document.querySelector( '#inputContent' ), {
							mediaEmbed: {
						        previewsInData: true
						    },
						    removePlugins: ["MediaEmbedToolbar"],
						    simpleUpload: {
			                    uploadUrl: "/upload/image",
			                    withCredentials: true,
			                    headers: {
			                        'X-CSRF-TOKEN': 'CSFR-Token',
			                        Authorization: 'Bearer <JSON Web Token>'
			                    }
						    }
						} )
						.then( editor => {
							console.log( 'Editor was initialized', editor );
						} )
						.catch( error => {
							console.error( error.stack );
						} );
				</script>
			</div>
			<button type="submit" class="btn btn-primary float-end mt-3">제출</button>
		</form>
	</div>
	<%-- Bootstrap Bundle with Popper --%>
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
</body>

</html>