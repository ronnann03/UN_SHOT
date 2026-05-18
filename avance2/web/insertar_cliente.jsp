<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <title>UNSHOT - Insertar Cliente</title>
  <style>
    body { font-family: Arial, sans-serif; background: #f4f4f4; padding: 30px; }
    h1 { color: #333; }
    form { background: #fff; padding: 20px; max-width: 500px; border: 1px solid #ccc; }
    label { display: block; margin-top: 12px; font-weight: bold; }
    input { width: 100%; padding: 8px; margin-top: 4px; box-sizing: border-box; }
    button { margin-top: 16px; padding: 10px 24px; background: #4a90d9; color: #fff; border: none; cursor: pointer; font-size: 1rem; }
    button:hover { background: #357abd; }
    .msg-ok  { color: green; font-weight: bold; margin-bottom: 12px; }
    .msg-err { color: red;   font-weight: bold; margin-bottom: 12px; }
    a { display: inline-block; margin-top: 16px; color: #4a90d9; }
  </style>
</head>
<body>

<h1>Insertar Cliente</h1>
<a href="index.jsp">&larr; Volver al inicio</a>

<%
  String mensaje = "";
  String tipoMsg = "";

  if ("POST".equals(request.getMethod())) {
    String nombre   = request.getParameter("nombre");
    String apellido = request.getParameter("apellido");
    String telefono = request.getParameter("telefono");
    String email    = request.getParameter("email");

    String url  = "jdbc:postgresql://db.disufhicxshjudewytwe.supabase.co:5432/postgres?sslmode=require";
    String user = "postgres";
    String pass = "L1m4Utp123..";

    try {
      Class.forName("org.postgresql.Driver");
      Connection cn = DriverManager.getConnection(url, user, pass);
      String sql = "INSERT INTO clientes (nombre, apellido, telefono, email) VALUES (?, ?, ?, ?)";
      PreparedStatement ps = cn.prepareStatement(sql);
      ps.setString(1, nombre);
      ps.setString(2, apellido);
      ps.setString(3, telefono);
      ps.setString(4, email);
      ps.executeUpdate();
      ps.close();
      cn.close();
      mensaje  = "Cliente guardado correctamente.";
      tipoMsg  = "msg-ok";
    } catch (Exception e) {
      mensaje = "Error: " + e.getMessage();
      tipoMsg = "msg-err";
    }
  }
%>

<% if (!mensaje.isEmpty()) { %>
  <p class="<%= tipoMsg %>"><%= mensaje %></p>
<% } %>

<form method="post" action="insertar_cliente.jsp">
  <label>Nombre:</label>
  <input type="text" name="nombre" required/>

  <label>Apellido:</label>
  <input type="text" name="apellido" required/>

  <label>Telefono:</label>
  <input type="text" name="telefono"/>

  <label>Email:</label>
  <input type="email" name="email"/>

  <button type="submit">Guardar Cliente</button>
</form>

<a href="listar_clientes.jsp">Ver lista de clientes</a>

</body>
</html>
