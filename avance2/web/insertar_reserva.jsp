<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="util.Conexion" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <title>UNSHOT - Insertar Reserva</title>
  <style>
    body { font-family: Arial, sans-serif; background: #f4f4f4; padding: 30px; }
    h1 { color: #333; }
    form { background: #fff; padding: 20px; max-width: 500px; border: 1px solid #ccc; }
    label { display: block; margin-top: 12px; font-weight: bold; }
    input, select { width: 100%; padding: 8px; margin-top: 4px; box-sizing: border-box; }
    button { margin-top: 16px; padding: 10px 24px; background: #4a90d9; color: #fff; border: none; cursor: pointer; font-size: 1rem; }
    button:hover { background: #357abd; }
    .msg-ok  { color: green; font-weight: bold; margin-bottom: 12px; }
    .msg-err { color: red;   font-weight: bold; margin-bottom: 12px; }
    a { display: inline-block; margin-top: 16px; color: #4a90d9; }
  </style>
</head>
<body>

<h1>Insertar Reserva de Mesa</h1>
<a href="index.jsp">&larr; Volver al inicio</a>

<%
  String mensaje = "";
  String tipoMsg = "";

  if ("POST".equals(request.getMethod())) {
    String idCliente  = request.getParameter("id_cliente");
    String fecha      = request.getParameter("fecha");
    String hora       = request.getParameter("hora");
    String personas   = request.getParameter("num_personas");
    String ocasion    = request.getParameter("ocasion");
    String estado     = request.getParameter("estado");

    try {
      Connection cn = Conexion.getConexion();
      String sql = "INSERT INTO reservas (id_cliente, fecha, hora, num_personas, ocasion, estado) VALUES (?, ?, ?, ?, ?, ?)";
      PreparedStatement ps = cn.prepareStatement(sql);
      ps.setInt(1, Integer.parseInt(idCliente));
      ps.setDate(2, java.sql.Date.valueOf(fecha));
      ps.setTime(3, java.sql.Time.valueOf(hora + ":00"));
      ps.setInt(4, Integer.parseInt(personas));
      ps.setString(5, ocasion);
      ps.setString(6, estado);
      ps.executeUpdate();
      ps.close();
      cn.close();
      mensaje = "Reserva guardada correctamente.";
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

<form method="post" action="insertar_reserva.jsp">

  <label>ID Cliente:</label>
  <input type="number" name="id_cliente" min="1" required/>

  <label>Fecha:</label>
  <input type="date" name="fecha" required/>

  <label>Hora:</label>
  <input type="time" name="hora" required/>

  <label>Numero de personas:</label>
  <input type="number" name="num_personas" min="1" required/>

  <label>Ocasion:</label>
  <input type="text" name="ocasion" placeholder="Ej: Cumpleanos, Aniversario"/>

  <label>Estado:</label>
  <select name="estado">
    <option value="Pendiente">Pendiente</option>
    <option value="Confirmada">Confirmada</option>
    <option value="Cancelada">Cancelada</option>
  </select>

  <button type="submit">Guardar Reserva</button>
</form>

<a href="listar_reservas.jsp">Ver lista de reservas</a>

</body>
</html>
