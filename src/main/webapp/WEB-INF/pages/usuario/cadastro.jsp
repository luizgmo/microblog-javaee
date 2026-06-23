<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Microblog - Cadastro</title>
</head>
<body>
	<h1>Criar conta</h1>

	<% if (request.getAttribute("erro") != null) { %>
	<p style="color:red;"><%= request.getAttribute("erro") %></p>
	<% } %>

	<form method="post" action="<%= request.getContextPath() %>/cadastro" enctype="multipart/form-data">
		<label for="username">Username: </label>
		<input type="text" name="username" id="username" required>
		<br>

		<label for="email">E-mail: </label>
		<input type="email" name="email" id="email" required>
		<br>

		<label for="senha">Senha: </label>
		<input type="password" name="senha" id="senha" required minlength="6">
		<br>

		<label for="nomeExibicao">Nome de exibição: </label>
		<input type="text" name="nomeExibicao" id="nomeExibicao" required>
		<br>

		<label for="bio">Bio: </label>
		<textarea name="bio" id="bio" maxlength="160"></textarea>
		<br>

		<label for="fotoPerfil">Foto de perfil: </label>
		<input type="file" name="fotoPerfil" id="fotoPerfil" accept="image/png,image/jpeg,image/gif">
		<br>

		<button type="submit">Cadastrar</button>
	</form>

	<p>Já tem conta? <a href="<%= request.getContextPath() %>/login">Entrar</a></p>
</body>
</html>
