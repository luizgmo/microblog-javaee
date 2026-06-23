package edu.ifsp.microblog.controllers.post;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

import edu.ifsp.microblog.modelo.Usuario;
import edu.ifsp.microblog.service.PostService;
import edu.ifsp.microblog.util.ViewHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/post/novo")
@MultipartConfig
public class NovoPostController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private PostService postService = new PostService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ViewHelper.forward("post/novoPost.jsp", request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String conteudo = request.getParameter("conteudo");

        String fotoUrl = null;
        Part fotoPart = request.getPart("foto");
        if (fotoPart != null && fotoPart.getSize() > 0) {
            fotoUrl = salvarFoto(fotoPart, request);
        }

        HttpSession session = request.getSession();
        Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");

        try {
            NovoPostForm form = new NovoPostForm(conteudo, fotoUrl);
            postService.publicar(form, usuarioLogado.getId());
            response.sendRedirect(request.getContextPath() + "/feed");
        } catch (IllegalArgumentException e) {
            request.setAttribute("erro", e.getMessage());
            ViewHelper.forward("post/novoPost.jsp", request, response);
        }
    }

    private String salvarFoto(Part part, HttpServletRequest request) throws IOException {
        String uploadDir = request.getServletContext().getRealPath("/uploads");
        Files.createDirectories(Paths.get(uploadDir));

        String extensao = obterExtensao(part.getSubmittedFileName());
        String nomeArquivo = UUID.randomUUID().toString() + extensao;
        Path destino = Paths.get(uploadDir, nomeArquivo);

        try (InputStream in = part.getInputStream()) {
            Files.copy(in, destino);
        }

        return "uploads/" + nomeArquivo;
    }

    private String obterExtensao(String nomeOriginal) {
        if (nomeOriginal == null) return "";
        int dot = nomeOriginal.lastIndexOf('.');
        return dot >= 0 ? nomeOriginal.substring(dot) : "";
    }
}