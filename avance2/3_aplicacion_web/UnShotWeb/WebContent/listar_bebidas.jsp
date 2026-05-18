<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <title>UNSHOT - Lista de Bebidas</title>
  <style>
    body { font-family: Arial, sans-serif; background: #f4f4f4; padding: 30px; }
    h1 { color: #333; }
    table { border-collapse: collapse; width: 100%; max-width: 900px; background: #fff; }
    th { background: #4a90d9; color: #fff; padding: 10px 14px; text-align: left; }
    td { padding: 9px 14px; border-bottom: 1px solid #ddd; }
    tr:hover td { background: #f0f7ff; }
    .msg-err { color: red; font-weight: bold; }
    a { display: inline-block; margin-bottom: 16px; color: #4a90d9; }
  </style>
</head>
<body>

<h1>Lista de Bebidas</h1>
<a href="index.jsp">&larr; Volver al inicio</a> &nbsp;
<a href="insertar_bebida.jsp">+ Agregar bebida</a>

<%
  String url  = "jdbc:postgresql://db.disufhicxshjudewytwe.supabase.co:5432/postgres?sslmode=require";
  String user = "postgres";
  String pass = "TU_PASSWORD_SUPABASE";

  try {
    Class.forName("org.postgresql.Driver");
    Connection cn = DriverManager.getConnection(url, user, pass);
    String sql = "SELECT * FROM bebidas ORDER BY categoria, nombre";
    Statement st = cn.createStatement();
    ResultSet rs = st.executeQuery(sql);
%>

<table>
  <tr>
    <th>#</th>
    <th>Nombre</th>
    <th>Categoria</th>
    <th>Descripcion</th>
    <th>Precio (S/)</th>
  </tr>
  <% while (rs.next()) { %>
  <tr>
    <td><%= rs.getInt("id_bebida") %></td>
    <td><%= rs.getString("nombre") %></td>
    <td><%= rs.getString("categoria") %></td>
    <td><%= rs.getString("descripcion") != null ? rs.getString("descripcion") : "-" %></td>
    <td><%= String.format("%.2f", rs.getDouble("precio")) %></td>
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
