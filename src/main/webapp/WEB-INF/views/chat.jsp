<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <title>채팅</title>
  <%-- sockJS --%>
  <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
  <%-- jquery --%>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <%-- Bootstrap CSS --%>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
</head>

<body>
	<!-- Navbar -->
	<div id="nav">
		<%@ include file="./include/nav.jsp"%>
	</div>
	<div class="container">
		<h4 class="mt-3">채팅</h4>
		<div class="card p-2 my-3">
			<textarea id="messageArea" rows="30" style="resize: none; border: none;" autofocus readonly></textarea>
		</div>
		<div class="input-group mb-3">
			<input type="text" id="message" class="form-control" placeholder="Message">
			<button id="sendBtn" type="submit" value="submit" class="btn btn-outline-secondary">전송</button>
		</div>
	</div>
	<script>
		$("#sendBtn").click(function() {
			sendMessage();
			$('#message').val('')
		});
	
		let sock = new SockJS("http://localhost:8080/echo");
		sock.onopen = onOpen;
		sock.onmessage = onMessage;
		sock.onclose = onClose;
		
		var username = "${member.userName}";
		if(username == ""){
			username = "익명" + Math.floor((Math.random() * 10000));
		}
		
		document.getElementById("message").addEventListener("keyup", function (event) {
			if (event.keyCode === 13) {
				event.preventDefault();
				document.getElementById("sendBtn").click();
		    }
		});
		
		// 채팅 연결
		function onOpen(){
			sock.send(">> " + username + "님이 입장하셨습니다.");
		}
		// 메시지 전송
		function sendMessage() {
			sock.send(username + " : " + $("#message").val());
		}
		// 메시지 수신
		function onMessage(msg) {
			var data = msg.data;
			$("#messageArea").append(data + "\n");
			document.getElementById("messageArea").scrollTop = document.getElementById("messageArea").scrollHeight;
		}
		// 연결 종료
		function onClose(evt) {
			sock.send(username + "님이 퇴장하셨습니다.");
			$("#messageArea").append("연결이 종료되었습니다.");
		}
	</script>
	<%-- Bootstrap Bundle with Popper --%>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
</body>

</html>