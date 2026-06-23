package edu.ifsp.microblog.controllers.usuario;

import java.io.IOException;
import java.util.List;

import edu.ifsp.microblog.controllers.post.PostDTO;
import edu.ifsp.microblog.modelo.Usuario;
import edu.ifsp.microblog.service.PerfilDTO;
import edu.ifsp.microblog.service.PostService;
import edu.ifsp.microblog.service.UsuarioService;
import edu.ifsp.microblog.util.ViewHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/perfil")
public class PerfilController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE = 10;

    private UsuarioService usuarioService = new UsuarioService();
    private PostService postService = new PostService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String paramPage = request.getParameter("page");
        int page = (paramPage != null) ? Integer.parseInt(paramPage) : 1;
        if (page < 1) page = 1;

        HttpSession session = request.getSession();
        Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");

        PerfilDTO perfil = usuarioService.getPerfil(username, usuarioLogado.getId());
        if (perfil == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Usuário não encontrado.");
            return;
        }

        List<PostDTO> posts = postService.getPostsDoPerfil(perfil.usuario().getId(), page, PAGE_SIZE);
        int totalPaginas = postService.totalPaginas(perfil.usuario().getId(), PAGE_SIZE);

        request.setAttribute("perfil", perfil);
        request.setAttribute("posts", posts);
        request.setAttribute("paginaAtual", page);
        request.setAttribute("totalPaginas", totalPaginas);
        request.setAttribute("ehPerfilProprio", usuarioLogado.getId() == perfil.usuario().getId());

        ViewHelper.forward("usuario/perfil.jsp", request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /* Acao de seguir / deixar de seguir */
        HttpSession session = request.getSession();
        Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");

        int seguidoId = Integer.parseInt(request.getParameter("usuarioId"));
        usuarioService.toggleFollow(usuarioLogado.getId(), seguidoId);

        String username = request.getParameter("username");
        response.sendRedirect(request.getContextPath() + "/perfil?username=" + username);
    }
}