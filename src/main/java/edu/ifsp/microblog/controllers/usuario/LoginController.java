package edu.ifsp.microblog.controllers.usuario;

import java.io.IOException;

import edu.ifsp.microblog.modelo.Usuario;
import edu.ifsp.microblog.service.UsuarioService;
import edu.ifsp.microblog.util.ViewHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ViewHelper.forward("usuario/login.jsp", request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        UsuarioService service = new UsuarioService();
        Usuario usuario = service.login(email, senha);

        if (usuario != null) {
            request.getSession().setAttribute("usuarioLogado", usuario);
            response.sendRedirect(request.getContextPath() + "/feed");
        } else {
            request.setAttribute("erro", "E-mail ou senha inválidos.");
            ViewHelper.forward("usuario/login.jsp", request, response);
        }
    }
}