<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Microblog - Novo Post</title>
<script>
function atualizarContador() {
	const textarea = document.querySelector('#conteudo');
	const contador = document.querySelector('#contador');
	contador.textContent = textarea.value.length + "/280";
}
</script>
</head>
<body>
	<h1>Novo post</h1>

	<% if (request.getAttribute("erro") != null) { %>
	<p style="color:red;"><%= request.getAttribute("erro") %></p>
	<% } %>

	<form method="post" action="<%= request.getContextPath() %>/post/novo" enctype="multipart/form-data">
		<textarea name="conteudo" id="conteudo" maxlength="280" rows="4" cols="50" oninput="atualizarContador()" required></textarea>
		<br>
		<span id="contador">0/280</span>
		<br>

		<label for="foto">Foto (opcional): </label>
		<input type="file" name="foto" id="foto" accept="image/png,image/jpeg,image/gif">
		<br>

		<button type="submit">Publicar</button>
	</form>

	<a href="<%= request.getContextPath() %>/feed">Voltar ao feed</a>
</body>
</html>
