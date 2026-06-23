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
    textarea {
        width: 100%;
        padding: 10px;
        border: 1px solid var(--borda);
        border-radius: 5px;
        box-sizing: border-box;
        font-size: 1.1rem;
        background-color: #fafafa;
        transition: border-color 0.2s;
        resize: vertical;
    }
    textarea:focus {
        outline: none;
        border-color: var(--azul-medio);
        background-color: var(--branco);
    }
    #contador {
        display: block;
        text-align: right;
        font-size: 0.85rem;
        color: #777;
        margin-top: 5px;
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
	<h1>Novo post</h1>

	<% if (request.getAttribute("erro") != null) { %>
	<p style="color:red;"><%= request.getAttribute("erro") %></p>
	<% } %>

	<form method="post" action="<%= request.getContextPath() %>/post/novo" enctype="multipart/form-data">
		<textarea name="conteudo" id="conteudo" maxlength="280" rows="4" oninput="atualizarContador()" required></textarea>
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