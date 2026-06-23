<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if (session.getAttribute("usuarioLogado") != null) {
	response.sendRedirect(request.getContextPath() + "/feed");
} else {
	response.sendRedirect(request.getContextPath() + "/login");
}
%>