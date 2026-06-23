<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> [cite: 13]
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Microblog - Cadastro</title> [cite: 13]
<style>
    :root {
        --azul-escuro: #0a192f;
        --azul-medio: #172a45;
        --amarelo: #ffc107;
        --amarelo-hover: #ffb300;
        --branco: #ffffff;
        --fundo: #f4f6f9;
        --texto: #333333;
        --borda: #e0e0e0;
    }
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: var(--fundo);
        color: var(--texto);
        margin: 0;
        padding: 20px;
        display: flex;
        flex-direction: column;
        align-items: center;
        min-height: 100vh;
    }
    h1 {
        color: var(--azul-escuro);
        margin-bottom: 20px;
        border-bottom: 3px solid var(--amarelo);
        padding-bottom: 10px;
        font-size: 1.8rem;
        width: 100%;
        max-width: 600px;
        box-sizing: border-box;
    }
    form {
        width: 100%;
        max-width: 600px;
        box-sizing: border-box;
        background: var(--branco);
        padding: 25px;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        border: 1px solid var(--borda);
        margin-bottom: 20px;
    }
    label {
        display: block;
        font-weight: 600;
        margin-top: 15px;
        margin-bottom: 5px;
        color: var(--azul-escuro);
    }
    input[type="text"], input[type="email"], input[type="password"], textarea {
        width: 100%;
        padding: 10px;
        border: 1px solid var(--borda);
        border-radius: 5px;
        box-sizing: border-box;
        font-size: 1rem;
        background-color: #fafafa;
        transition: border-color 0.2s;
    }
    input:focus, textarea:focus {
        outline: none;
        border-color: var(--azul-medio);
        background-color: var(--branco);
    }
    input[type="file"] { margin-top: 5px; }
    button {
        background-color: var(--azul-escuro);
        color: var(--branco);
        border: none;
        padding: 10px 20px;
        font-size: 1rem;
        font-weight: bold;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.2s, transform 0.1s;
        margin-top: 20px;
        width: 100%;
    }
    button:hover {
        background-color: var(--azul-medio);
        color: var(--amarelo);
    }
    button:active { transform: scale(0.98); }
    a {
        color: var(--azul-medio);
        text-decoration: none;
        font-weight: 600;
        transition: color 0.2s;
    }
    a:hover { color: var(--amarelo-hover); }
    p[style*="color:red"] {
        background: #ffebee;
        color: #c62828 !important;
        padding: 10px;
        border-radius: 5px;
        border-left: 4px solid #c62828;
        font-weight: 500;
        width: 100%;
        max-width: 600px;
        box-sizing: border-box;
    }
</style>
</head>
<body>
	<h1>Criar conta</h1> [cite: 13]

	<% if (request.getAttribute("erro") != null) { %>
	<p style="color:red;"><%= request.getAttribute("erro") %></p> [cite: 13]
	<% } %>

	<form method="post" action="<%= request.getContextPath() %>/cadastro" enctype="multipart/form-data"> [cite: 13]
		<label for="username">Username: </label> [cite: 13]
		<input type="text" name="username" id="username" required> [cite: 13]
		<br>

		<label for="email">E-mail: </label> [cite: 13]
		<input type="email" name="email" id="email" required> [cite: 13]
		<br>

		<label for="senha">Senha: </label> [cite: 13]
		<input type="password" name="senha" id="senha" required minlength="6"> [cite: 13]
		<br>

		<label for="nomeExibicao">Nome de exibição: </label> [cite: 13]
		<input type="text" name="nomeExibicao" id="nomeExibicao" required> [cite: 13]
		<br>

		<label for="bio">Bio: </label> [cite: 13]
		<textarea name="bio" id="bio" maxlength="160"></textarea> [cite: 13]
		<br>

		<label for="fotoPerfil">Foto de perfil: </label> [cite: 13]
		<input type="file" name="fotoPerfil" id="fotoPerfil" accept="image/png,image/jpeg,image/gif"> [cite: 13]
		<br>

		<button type="submit">Cadastrar</button> [cite: 13]
	</form>

	<p>Já tem conta? <a href="<%= request.getContextPath() %>/login">Entrar</a></p> [cite: 14]
</body>
</html>