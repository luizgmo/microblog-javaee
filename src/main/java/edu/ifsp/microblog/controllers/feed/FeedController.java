package edu.ifsp.microblog.controllers.feed;

import java.io.IOException;
import java.util.List;

import edu.ifsp.microblog.controllers.post.PostDTO;
import edu.ifsp.microblog.modelo.Usuario;
import edu.ifsp.microblog.service.PostService;
import edu.ifsp.microblog.util.ViewHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/feed")
public class FeedController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE = 10;

    private PostService postService = new PostService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String paramPage = request.getParameter("page");
        int page = (paramPage != null) ? Integer.parseInt(paramPage) : 1;
        if (page < 1) page = 1;

        HttpSession session = request.getSession();
        Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");

        List<PostDTO> posts = postService.getFeed(usuarioLogado.getId(), page, PAGE_SIZE);

        request.setAttribute("posts", posts);
        request.setAttribute("paginaAtual", page);

        ViewHelper.forward("feed/feed.jsp", request, response);
    }
}