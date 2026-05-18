<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="util.Conexion" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <title>UNSHOT - Demo Conexion Supabase</title>
  <style>
    body     { font-family: Arial, sans-serif; background: #0c0c0c; color: #e0d5c1; padding: 40px; }
    h1       { color: #c9a84c; font-size: 1.6rem; margin-bottom: 4px; }
    h2       { color: #c9a84c; font-size: 1.1rem; margin: 28px 0 10px; border-bottom: 1px solid #333; padding-bottom: 6px; }
    .ok      { color: #4ade80; font-weight: bold; }
    .err     { color: #f87171; font-weight: bold; }
    table    { border-collapse: collapse; width: 100%; max-width: 700px; margin-top: 10px; }
    th       { background: #1a1a1a; color: #c9a84c; padding: 10px 14px; text-align: left; font-size: .8rem; letter-spacing: 1px; }
    td       { padding: 9px 14px; border-bottom: 1px solid #2a2a2a; font-size: .9rem; }
    .badge   { font-size: .75rem; padding: 2px 8px; border: 1px solid; }
    .verde   { color: #4ade80; border-color: #4ade80; }
    .amarillo{ color: #facc15; border-color: #facc15; }
    .rojo    { color: #f87171; border-color: #f87171; }
    a        { color: #c9a84c; margin-right: 16px; }
  </style>
</head>
<body>

<h1>UNSHOT Bar — Demo de Conexion a Supabase</h1>
<p style="color:#888;font-size:.9rem">Verifica que la conexion JDBC funciona correctamente.</p>

<a href="listar_clientes.jsp">Ver Clientes</a>
<a href="listar_reservas.jsp">Ver Reservas</a>
<a href="insertar_cliente.jsp">+ Insertar Cliente</a>

<%
  Connection cn = null;

  try {
    cn = Conexion.getConexion();
%>
  <p class="ok"><i>Conexion exitosa a Supabase PostgreSQL</i></p>

  <!-- Conteos -->
  <h2>Resumen de la base de datos</h2>
  <table>
    <tr><th>Tabla</th><th>Registros</th></tr>
<%
    String[] tablas = {"clientes", "reservas", "bebidas", "eventos", "pedidos"};
    for (String tabla : tablas) {
      Statement st = cn.createStatement();
      ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM " + tabla);
      rs.next();
      int count = rs.getInt(1);
      rs.close(); st.close();
%>
    <tr><td><%= tabla %></td><td><%= count %></td></tr>
<%  } %>
  </table>

  <!-- Ultimos clientes -->
  <h2>Ultimos 5 clientes registrados</h2>
  <table>
    <tr><th>#</th><th>Nombre</th><th>Email</th><th>Fecha</th></tr>
<%
    Statement st2 = cn.createStatement();
    ResultSet rs2 = st2.executeQuery("SELECT id_cliente, nombre, apellido, email, fecha_registro FROM clientes ORDER BY id_cliente DESC LIMIT 5");
    while (rs2.next()) {
%>
    <tr>
      <td><%= rs2.getInt("id_cliente") %></td>
      <td><%= rs2.getString("nombre") %> <%= rs2.getString("apellido") %></td>
      <td><%= rs2.getString("email") != null ? rs2.getString("email") : "-" %></td>
      <td><%= rs2.getString("fecha_registro") %></td>
    </tr>
<%  }
    rs2.close(); st2.close(); %>
  </table>

  <!-- Proximas reservas -->
  <h2>Proximas reservas</h2>
  <table>
    <tr><th>#</th><th>Cliente</th><th>Fecha</th><th>Hora</th><th>Estado</th></tr>
<%
    Statement st3 = cn.createStatement();
    ResultSet rs3 = st3.executeQuery(
      "SELECT r.id_reserva, c.nombre, c.apellido, r.fecha, r.hora, r.estado " +
      "FROM reservas r JOIN clientes c ON r.id_cliente = c.id_cliente " +
      "ORDER BY r.fecha DESC LIMIT 5"
    );
    while (rs3.next()) {
      String estado = rs3.getString("estado");
      String cls    = "Confirmada".equals(estado) ? "verde" : "Cancelada".equals(estado) ? "rojo" : "amarillo";
%>
    <tr>
      <td><%= rs3.getInt("id_reserva") %></td>
      <td><%= rs3.getString("nombre") %> <%= rs3.getString("apellido") %></td>
      <td><%= rs3.getString("fecha") %></td>
      <td><%= rs3.getString("hora") %></td>
      <td><span class="badge <%= cls %>"><%= estado %></span></td>
    </tr>
<%  }
    rs3.close(); st3.close();

    cn.close();
  } catch (Exception e) { %>
  <p class="err">Error de conexion: <%= e.getMessage() %></p>
  <p style="color:#888;font-size:.85rem">Verifica que el proyecto de Supabase este activo (plan gratuito se pausa tras inactividad).</p>
<% } %>

</body>
</html>
