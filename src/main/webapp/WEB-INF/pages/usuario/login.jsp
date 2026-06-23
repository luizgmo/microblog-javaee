<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Microblog - Login</title>
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
    input[type="email"], input[type="password"] {
        width: 100%;
        padding: 10px;
        border: 1px solid var(--borda);
        border-radius: 5px;
        box-sizing: border-box;
        font-size: 1rem;
        background-color: #fafafa;
        transition: border-color 0.2s;
    }
    input:focus {
        outline: none;
        border-color: var(--azul-medio);
        background-color: var(--branco);
    }
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
    p[style*="color:green"] {
        background: #e8f5e9;
        color: #2e7d32 !important;
        padding: 10px;
        border-radius: 5px;
        border-left: 4px solid #2e7d32;
        font-weight: 500;
        width: 100%;
        max-width: 600px;
        box-sizing: border-box;
    }
</style>
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