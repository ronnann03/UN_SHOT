<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <title>UNSHOT - Lista de Reservas</title>
  <style>
    body { font-family: Arial, sans-serif; background: #f4f4f4; padding: 30px; }
    h1 { color: #333; }
    table { border-collapse: collapse; width: 100%; max-width: 950px; background: #fff; }
    th { background: #4a90d9; color: #fff; padding: 10px 14px; text-align: left; }
    td { padding: 9px 14px; border-bottom: 1px solid #ddd; }
    tr:hover td { background: #f0f7ff; }
    .msg-err { color: red; font-weight: bold; }
    a { display: inline-block; margin-bottom: 16px; color: #4a90d9; }
    .estado-confirmada { color: green; font-weight: bold; }
    .estado-pendiente  { color: orange; font-weight: bold; }
    .estado-cancelada  { color: red;    font-weight: bold; }
  </style>
</head>
<body>

<h1>Lista de Reservas de Mesa</h1>
<a href="index.jsp">&larr; Volver al inicio</a> &nbsp;
<a href="listar_clientes.jsp">Ver clientes</a>

<%
  String url  = "jdbc:postgresql://db.disufhicxshjudewytwe.supabase.co:5432/postgres?sslmode=require";
  String user = "postgres";
  String pass = "L1m4Utp123..";

  try {
    Class.forName("org.postgresql.Driver");
    Connection cn = DriverManager.getConnection(url, user, pass);
    String sql = "SELECT r.id_reserva, c.nombre, c.apellido, r.fecha, r.hora, " +
                 "r.num_personas, r.ocasion, r.estado " +
                 "FROM reservas r " +
                 "JOIN clientes c ON r.id_cliente = c.id_cliente " +
                 "ORDER BY r.fecha DESC, r.hora DESC";
    Statement st = cn.createStatement();
    ResultSet rs = st.executeQuery(sql);
%>

<table>
  <tr>
    <th>#</th>
    <th>Cliente</th>
    <th>Fecha</th>
    <th>Hora</th>
    <th>Personas</th>
    <th>Ocasion</th>
    <th>Estado</th>
  </tr>
  <% while (rs.next()) {
       String estado = rs.getString("estado");
       String claseEstado = "estado-pendiente";
       if ("Confirmada".equals(estado)) claseEstado = "estado-confirmada";
       else if ("Cancelada".equals(estado)) claseEstado = "estado-cancelada";
  %>
  <tr>
    <td><%= rs.getInt("id_reserva") %></td>
    <td><%= rs.getString("nombre") %> <%= rs.getString("apellido") %></td>
    <td><%= rs.getString("fecha") %></td>
    <td><%= rs.getString("hora") %></td>
    <td><%= rs.getInt("num_personas") %></td>
    <td><%= rs.getString("ocasion") != null ? rs.getString("ocasion") : "-" %></td>
    <td><span class="<%= claseEstado %>"><%= estado %></span></td>
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
