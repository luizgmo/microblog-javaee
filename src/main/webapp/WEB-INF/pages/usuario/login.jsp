<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Microblog - Login</title>
</head>
<body>
	<h1>Entrar</h1>

	<% if (request.getAttribute("erro") != null) { %>
	<p style="color:red;"><%= request.getAttribute("erro") %></p>
	<% } %>

	<% if ("true".equals(request.getParameter("cadastroOk"))) { %>
	<p style="color:green;">Cadastro realizado com sucesso! Faça login.</p>
	<% } %>

	<form method="post" action="<%= request.getContextPath() %>/login">
		<label for="email">E-mail: </label>
		<input type="email" name="email" id="email" required>
		<br>

		<label for="senha">Senha: </label>
		<input type="password" name="senha" id="senha" required>
		<br>

		<button type="submit">Entrar</button>
	</form>

	<p>Não tem conta? <a href="<%= request.getContextPath() %>/cadastro">Cadastre-se</a></p>
</body>
</html>
