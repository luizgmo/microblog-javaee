<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="edu.ifsp.microblog.controllers.post.PostDTO" %>
<%@ page import="edu.ifsp.microblog.service.PerfilDTO" %>
<%@ page import="java.util.List" %>

<%
PerfilDTO perfil = (PerfilDTO) request.getAttribute("perfil");
List<PostDTO> posts = (List<PostDTO>) request.getAttribute("posts");
int paginaAtual = (Integer) request.getAttribute("paginaAtual");
int totalPaginas = (Integer) request.getAttribute("totalPaginas");
boolean ehPerfilProprio = (Boolean) request.getAttribute("ehPerfilProprio");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Microblog - Perfil de <%= perfil.usuario().getUsername() %></title>
<script>
function gotoPage(page) {
	if (page < 1) return;
	window.location.href = "<%= request.getContextPath() %>/perfil?username=<%= perfil.usuario().getUsername() %>&page=" + page;
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
    h1, h2 { color: var(--azul-escuro); }
    h1 {
        border-bottom: 3px solid var(--amarelo);
        padding-bottom: 10px;
        font-size: 1.8rem;
        margin-top: 10px;
    }
    .container { width: 100%; max-width: 600px; box-sizing: border-box; }
    a {
        color: var(--azul-medio);
        text-decoration: none;
        font-weight: 600;
        transition: color 0.2s;
    }
    a:hover { color: var(--amarelo-hover); }
    .avatar {
        border: 3px solid var(--azul-escuro);
        border-radius: 50%;
        object-fit: cover;
        margin-bottom: 15px;
    }
    .stats {
        background: var(--azul-escuro);
        color: var(--branco);
        padding: 10px 15px;
        border-radius: 20px;
        display: inline-block;
        font-size: 0.9rem;
        margin-bottom: 20px;
    }
    .stats strong { color: var(--amarelo); }
    button {
        background-color: var(--azul-escuro);
        color: var(--branco);
        border: none;
        padding: 8px 15px;
        font-size: 0.9rem;
        font-weight: bold;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.2s;
    }
    button:hover { background-color: var(--azul-medio); color: var(--amarelo); }
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
    form { background: transparent; border: none; padding: 0; box-shadow: none; margin-bottom: 20px; }
</style>
</head>
<body>
	<div class="container">
		<a href="<%= request.getContextPath() %>/feed">&larr; Voltar ao feed</a>

		<h1><%= perfil.usuario().getNomeExibicao() %> (@<%= perfil.usuario().getUsername() %>)</h1>

		<% if (perfil.usuario().getFotoPerfil() != null) { %>
		<img src="<%= request.getContextPath() %>/<%= perfil.usuario().getFotoPerfil() %>" width="100" height="100" class="avatar">
		<% } %>

		<p><%= perfil.usuario().getBio() != null ? perfil.usuario().getBio() : "" %></p>

		<div class="stats">
			<strong><%= perfil.seguidores() %></strong> seguidores |
			<strong><%= perfil.seguindo() %></strong> seguindo
		</div>

		<% if (!ehPerfilProprio) { %>
		<form method="post" action="<%= request.getContextPath() %>/perfil">
			<input type="hidden" name="username" value="<%= perfil.usuario().getUsername() %>">
			<input type="hidden" name="usuarioId" value="<%= perfil.usuario().getId() %>">
			<button type="submit"><%= perfil.jaSeguindo() ? "Deixar de seguir" : "Seguir" %></button>
		</form>
		<% } %>

		<hr style="border: 0; border-top: 1px solid var(--borda); margin: 20px 0;">

		<h2>Posts</h2>

		<% if (posts.isEmpty()) { %>
		<p>Este usuário ainda não fez nenhum post.</p>
		<% } else { %>

		<% for (PostDTO p : posts) { %>
		<div class="post-card">
			<small><%= p.dataHora() %></small>
			<p><%= p.conteudo() %></p>
			<% if (p.fotoUrl() != null) { %>
			<img src="<%= request.getContextPath() %>/<%= p.fotoUrl() %>" width="300">
			<% } %>
		</div>
		<% } %>

		<div class="paginacao">
			<a href="#" onclick="gotoPage(<%= paginaAtual - 1 %>)">Anterior</a>
			<a href="#" onclick="gotoPage(<%= paginaAtual + 1 %>)">Próxima</a>
			<p>Página <%= paginaAtual %> de <%= totalPaginas %></p>
		</div>

		<% } %>
	</div>
</body>
</html>