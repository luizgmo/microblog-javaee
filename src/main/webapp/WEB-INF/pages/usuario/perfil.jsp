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
</head>
<body>
	<a href="<%= request.getContextPath() %>/feed">&larr; Voltar ao feed</a>

	<h1><%= perfil.usuario().getNomeExibicao() %> (@<%= perfil.usuario().getUsername() %>)</h1>

	<% if (perfil.usuario().getFotoPerfil() != null) { %>
	<img src="<%= request.getContextPath() %>/<%= perfil.usuario().getFotoPerfil() %>" width="100">
	<% } %>

	<p><%= perfil.usuario().getBio() != null ? perfil.usuario().getBio() : "" %></p>

	<p>
		<strong><%= perfil.seguidores() %></strong> seguidores |
		<strong><%= perfil.seguindo() %></strong> seguindo
	</p>

	<% if (!ehPerfilProprio) { %>
	<form method="post" action="<%= request.getContextPath() %>/perfil">
		<input type="hidden" name="username" value="<%= perfil.usuario().getUsername() %>">
		<input type="hidden" name="usuarioId" value="<%= perfil.usuario().getId() %>">
		<button type="submit"><%= perfil.jaSeguindo() ? "Deixar de seguir" : "Seguir" %></button>
	</form>
	<% } %>

	<hr>

	<h2>Posts</h2>

	<% if (posts.isEmpty()) { %>
	<p>Este usuário ainda não fez nenhum post.</p>
	<% } else { %>

	<% for (PostDTO p : posts) { %>
	<div style="border:1px solid #ccc; padding:10px; margin-bottom:10px;">
		<small><%= p.dataHora() %></small>
		<p><%= p.conteudo() %></p>
		<% if (p.fotoUrl() != null) { %>
		<img src="<%= request.getContextPath() %>/<%= p.fotoUrl() %>" width="300">
		<% } %>
	</div>
	<% } %>

	<a href="#" onclick="gotoPage(<%= paginaAtual - 1 %>)">Anterior</a>
	<a href="#" onclick="gotoPage(<%= paginaAtual + 1 %>)">Próxima</a>
	<p>Página <%= paginaAtual %> de <%= totalPaginas %></p>

	<% } %>
</body>
</html>
