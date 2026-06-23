<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="edu.ifsp.microblog.controllers.post.PostDTO" %>
<%@ page import="edu.ifsp.microblog.modelo.Usuario" %>
<%@ page import="java.util.List" %>

<%
List<PostDTO> posts = (List<PostDTO>) request.getAttribute("posts");
int paginaAtual = (Integer) request.getAttribute("paginaAtual");
Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Microblog - Feed</title>
<script>
function gotoPage(page) {
	if (page < 1) return;
	window.location.href = "<%= request.getContextPath() %>/feed?page=" + page;
}
</script>
</head>
<body>
	<h1>Feed</h1>

	<p>
		Logado como <strong><%= usuarioLogado.getNomeExibicao() %></strong>
		(<a href="<%= request.getContextPath() %>/perfil?username=<%= usuarioLogado.getUsername() %>">meu perfil</a>) |
		<a href="<%= request.getContextPath() %>/logout">sair</a>
	</p>

	<a href="<%= request.getContextPath() %>/post/novo">+ Novo Post</a>

	<br><br>

	<% if (posts.isEmpty()) { %>
	<p>Nenhum post no seu feed ainda. Siga outros usuários para ver posts aqui!</p>
	<% } else { %>

	<% for (PostDTO p : posts) { %>
	<div style="border:1px solid #ccc; padding:10px; margin-bottom:10px;">
		<strong>
			<a href="<%= request.getContextPath() %>/perfil?username=<%= p.autorUsername() %>">
				<%= p.autorNomeExibicao() %> (@<%= p.autorUsername() %>)
			</a>
		</strong>
		<br>
		<small><%= p.dataHora() %></small>
		<p><%= p.conteudo() %></p>
		<% if (p.fotoUrl() != null) { %>
		<img src="<%= request.getContextPath() %>/<%= p.fotoUrl() %>" width="300">
		<% } %>
	</div>
	<% } %>

	<a href="#" onclick="gotoPage(<%= paginaAtual - 1 %>)">Anterior</a>
	<a href="#" onclick="gotoPage(<%= paginaAtual + 1 %>)">Próxima</a>

	<% } %>
</body>
</html>
