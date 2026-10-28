<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ofi.modelo.Usuario" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Lista de usuarios MVC</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        table { border-collapse: collapse; width: min(100%, 600px); }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #4CAF50; color: white; }
        tr:nth-child(even) { background-color: #f7f7f7; }
    </style>
</head>
<body>
    <h2>Usuarios del sistema (patrón MVC)</h2>
    <table>
        <thead><tr><th>ID</th><th>Nombre</th></tr></thead>
        <tbody>
        <%
            List<Usuario> usuarios = (List<Usuario>) request.getAttribute("lista");
            if (usuarios != null && !usuarios.isEmpty()) {
                for (Usuario u : usuarios) {
        %>
            <tr><td><%= u.getId() %></td><td><%= u.getNombre() %></td></tr>
        <%
                }
            } else {
        %>
            <tr><td colspan="2">No hay datos. Ingresa desde /usuarios</td></tr>
        <% } %>
        </tbody>
    </table>
</body>
</html>
