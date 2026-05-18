<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="util.Conexion" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <title>UNSHOT - Lista de Clientes</title>
  <style>
    body { font-family: Arial, sans-serif; background: #f4f4f4; padding: 30px; }
    h1 { color: #333; }
    table { border-collapse: collapse; width: 100%; max-width: 800px; background: #fff; }
    th { background: #4a90d9; color: #fff; padding: 10px 14px; text-align: left; }
    td { padding: 9px 14px; border-bottom: 1px solid #ddd; }
    tr:hover td { background: #f0f7ff; }
    .msg-err { color: red; font-weight: bold; }
    a { display: inline-block; margin-bottom: 16px; color: #4a90d9; }
  </style>
</head>
<body>

<h1>Lista de Clientes</h1>
<a href="index.jsp">&larr; Volver al inicio</a> &nbsp;
<a href="insertar_cliente.jsp">+ Agregar cliente</a>

<%
  try {
    Connection cn = Conexion.getConexion();
    String sql = "SELECT * FROM clientes ORDER BY id_cliente DESC";
    Statement st = cn.createStatement();
    ResultSet rs = st.executeQuery(sql);
%>

<table>
  <tr>
    <th>#</th>
    <th>Nombre</th>
    <th>Apellido</th>
    <th>Telefono</th>
    <th>Email</th>
    <th>Fecha Registro</th>
  </tr>
  <% while (rs.next()) { %>
  <tr>
    <td><%= rs.getInt("id_cliente") %></td>
    <td><%= rs.getString("nombre") %></td>
    <td><%= rs.getString("apellido") %></td>
    <td><%= rs.getString("telefono") != null ? rs.getString("telefono") : "-" %></td>
    <td><%= rs.getString("email") != null ? rs.getString("email") : "-" %></td>
    <td><%= rs.getString("fecha_registro") %></td>
  </tr>
  <% } %>
</table>

<%
    rs.close();
    st.close();
    cn.close();
  } catch (Exception e) {
%>
  <p class="msg-err">Error al conectar: <%= e.getMessage() %></p>
<%
  }
%>

</body>
</html>
