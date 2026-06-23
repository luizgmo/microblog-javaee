<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> [cite: 17]
<%@ page import="edu.ifsp.microblog.controllers.post.PostDTO" %> [cite: 17]
<%@ page import="edu.ifsp.microblog.modelo.Usuario" %> [cite: 17]
<%@ page import="java.util.List" %> [cite: 17]

<%
List<PostDTO> posts = (List<PostDTO>) request.getAttribute("posts"); [cite: 17]
int paginaAtual = (Integer) request.getAttribute("paginaAtual"); [cite: 18]
Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado"); [cite: 18]
%> [cite: 19]
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Microblog - Feed</title> [cite: 19]
<script>
function gotoPage(page) {
	if (page < 1) return;
	window.location.href = "<%= request.getContextPath() %>/feed?page=" + page; [cite: 19]
} [cite: 20]
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
    .container {
        width: 100%;
        max-width: 600px;
        box-sizing: border-box;
    }
    .user-panel {
        background: var(--branco);
        padding: 15px;
        border-radius: 8px;
        border: 1px solid var(--borda);
        margin-bottom: 15px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .btn-novo-post {
        background-color: var(--azul-escuro);
        color: var(--branco) !important;
        padding: 8px 15px;
        border-radius: 5px;
        font-weight: bold;
    }
    .btn-novo-post:hover { background-color: var(--azul-medio); color: var(--amarelo) !important; }
    a {
        color: var(--azul-medio);
        text-decoration: none;
        font-weight: 600;
        transition: color 0.2s;
    }
    a:hover { color: var(--amarelo-hover); }
    .post-card {
        background: var(--branco);
        border: 1px solid var(--borda);
        border-left: 5px solid var(--azul-escuro);
        border-radius: 8px;
        padding: 15px;
        margin-bottom: 15px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.02);
    }
    .post-card small { color: #777; display: block; margin-top: 5px; }
    .post-card img { border-radius: 6px; margin-top: 10px; max-width: 100%; height: auto; }
    .paginacao { margin-top: 20px; display: flex; gap: 15px; align-items: center; }
</style>
</head>
<body>
	<h1>Feed</h1> [cite: 20]

	<div class="container">
		<div class="user-panel">
			<span>
				Logado como <strong><%= usuarioLogado.getNomeExibicao() %></strong> [cite: 20]
				(<a href="<%= request.getContextPath() %>/perfil?username=<%= usuarioLogado.getUsername() %>">meu perfil</a>) [cite: 20]
			</span>
			<a href="<%= request.getContextPath() %>/logout">sair</a> [cite: 21]
		</div>

		<a href="<%= request.getContextPath() %>/post/novo" class="btn-novo-post">+ Novo Post</a> [cite: 21]

		<br><br>

		<% if (posts.isEmpty()) { %>
		<p>Nenhum post no seu feed ainda. Siga outros usuários para ver posts aqui!</p> [cite: 22]
		<% } else { %>

		<% for (PostDTO p : posts) { %>
		<div class="post-card">
			<strong>
				<a href="<%= request.getContextPath() %>/perfil?username=<%= p.autorUsername() %>"> [cite: 22]
					<%= p.autorNomeExibicao() %> (@<%= p.autorUsername() %>) [cite: 22]
				</a>
			</strong>
			<br>
			<small><%= p.dataHora() %></small> [cite: 22]
			<p><%= p.conteudo() %></p> [cite: 22]
			<% if (p.fotoUrl() != null) { %>
			<img src="<%= request.getContextPath() %>/<%= p.fotoUrl() %>" width="300"> [cite: 22]
			<% } %>
		</div>
		<% } %>

		<div class="paginacao">
			<a href="#" onclick="gotoPage(<%= paginaAtual - 1 %>)">Anterior</a> [cite: 22]
			<a href="#" onclick="gotoPage(<%= paginaAtual + 1 %>)">Próxima</a> [cite: 22]
		</div>

		<% } %>
	</div>
</body>
</html>