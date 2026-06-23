package edu.ifsp.microblog.controllers.usuario;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

import edu.ifsp.microblog.service.UsuarioService;
import edu.ifsp.microblog.util.ViewHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/cadastro")
@MultipartConfig
public class CadastroController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ViewHelper.forward("usuario/cadastro.jsp", request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username    = request.getParameter("username");
        String email       = request.getParameter("email");
        String senha       = request.getParameter("senha");
        String nomeExibicao = request.getParameter("nomeExibicao");
        String bio         = request.getParameter("bio");

        String fotoPerfil = null;
        Part fotoPart = request.getPart("fotoPerfil");
        if (fotoPart != null && fotoPart.getSize() > 0) {
            fotoPerfil = salvarFoto(fotoPart, request);
        }

        try {
            CadastroForm form = new CadastroForm(username, email, senha, nomeExibicao, bio, fotoPerfil);
            new UsuarioService().cadastrar(form);
            response.sendRedirect(request.getContextPath() + "/login?cadastroOk=true");
        } catch (IllegalArgumentException e) {
            request.setAttribute("erro", e.getMessage());
            ViewHelper.forward("usuario/cadastro.jsp", request, response);
        }
    }

    /* Salva o arquivo no diretório uploads e retorna o caminho relativo */
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