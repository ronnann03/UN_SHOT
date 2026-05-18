<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <title>UNSHOT - Insertar Bebida</title>
  <style>
    body { font-family: Arial, sans-serif; background: #f4f4f4; padding: 30px; }
    h1 { color: #333; }
    form { background: #fff; padding: 20px; max-width: 500px; border: 1px solid #ccc; }
    label { display: block; margin-top: 12px; font-weight: bold; }
    input, select, textarea { width: 100%; padding: 8px; margin-top: 4px; box-sizing: border-box; }
    textarea { height: 80px; }
    button { margin-top: 16px; padding: 10px 24px; background: #4a90d9; color: #fff; border: none; cursor: pointer; font-size: 1rem; }
    button:hover { background: #357abd; }
    .msg-ok  { color: green; font-weight: bold; margin-bottom: 12px; }
    .msg-err { color: red;   font-weight: bold; margin-bottom: 12px; }
    a { display: inline-block; margin-top: 16px; color: #4a90d9; }
  </style>
</head>
<body>

<h1>Insertar Bebida</h1>
<a href="index.jsp">&larr; Volver al inicio</a>

<%
  String mensaje = "";
  String tipoMsg = "";

  if ("POST".equals(request.getMethod())) {
    String nombre      = request.getParameter("nombre");
    String categoria   = request.getParameter("categoria");
    String descripcion = request.getParameter("descripcion");
    String precioStr   = request.getParameter("precio");

    String url  = "jdbc:postgresql://db.disufhicxshjudewytwe.supabase.co:5432/postgres?sslmode=require";
    String user = "postgres";
    String pass = "TU_PASSWORD_SUPABASE";

    try {
      Class.forName("org.postgresql.Driver");
      Connection cn = DriverManager.getConnection(url, user, pass);
      String sql = "INSERT INTO bebidas (nombre, categoria, descripcion, precio) VALUES (?, ?, ?, ?)";
      PreparedStatement ps = cn.prepareStatement(sql);
      ps.setString(1, nombre);
      ps.setString(2, categoria);
      ps.setString(3, descripcion);
      ps.setDouble(4, Double.parseDouble(precioStr));
      ps.executeUpdate();
      ps.close();
      cn.close();
      mensaje = "Bebida guardada correctamente.";
      tipoMsg = "msg-ok";
    } catch (Exception e) {
      mensaje = "Error: " + e.getMessage();
      tipoMsg = "msg-err";
    }
  }
%>

<% if (!mensaje.isEmpty()) { %>
  <p class="<%= tipoMsg %>"><%= mensaje %></p>
<% } %>

<form method="post" action="insertar_bebida.jsp">
  <label>Nombre:</label>
  <input type="text" name="nombre" required/>

  <label>Categoria:</label>
  <select name="categoria" required>
    <option value="" disabled selected>Selecciona...</option>
    <option value="Clasico">Clasico</option>
    <option value="Signature">Signature</option>
    <option value="Premium">Premium</option>
    <option value="Sin Alcohol">Sin Alcohol</option>
  </select>

  <label>Descripcion:</label>
  <textarea name="descripcion"></textarea>

  <label>Precio (S/):</label>
  <input type="number" name="precio" step="0.50" min="0" required/>

  <button type="submit">Guardar Bebida</button>
</form>

<a href="listar_bebidas.jsp">Ver lista de bebidas</a>

</body>
</html>
