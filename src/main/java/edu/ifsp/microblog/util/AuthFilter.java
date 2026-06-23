package edu.ifsp.microblog.util;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/*")
public class AuthFilter implements Filter {

    /* Rotas que nao exigem autenticacao */
    private static final String[] ROTAS_PUBLICAS = { "/login", "/cadastro" };

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String path = req.getRequestURI().substring(req.getContextPath().length());

        if (isRotaPublica(path) || isRecurso(path)) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        boolean autenticado = (session != null && session.getAttribute("usuarioLogado") != null);

        if (autenticado) {
            chain.doFilter(request, response);
        } else {
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }

    private boolean isRotaPublica(String path) {
        for (String rota : ROTAS_PUBLICAS) {
            if (path.equals(rota)) {
                return true;
            }
        }
        return false;
    }

    /* Libera acesso a arquivos estaticos (css, js, uploads) */
    private boolean isRecurso(String path) {
        return path.startsWith("/css/") || path.startsWith("/js/") || path.startsWith("/uploads/");
    }
}