<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.unshot.model.Cliente" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <title>UNSHOT — Clientes</title>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,700;1,400&family=Cormorant+Garamond:wght@300;400;500&display=swap" rel="stylesheet"/>
  <style>
    *, *::before, *::after { box-sizing:border-box; margin:0; padding:0; }
    :root {
      --gold:#c9a84c; --gold-d:#a8883c;
      --bg:#0c0c0c; --surface:#141414; --card:#1c1c1c;
      --border:#2a2a2a; --white:#fff; --text:#c8c8c8; --muted:#666;
    }
    body { background:var(--bg); color:var(--text); font-family:'Cormorant Garamond',serif; min-height:100vh; }
    nav { background:rgba(12,12,12,.97); border-bottom:1px solid var(--border); padding:18px 40px; display:flex; align-items:center; justify-content:space-between; flex-wrap:wrap; gap:10px; }
    .brand { font-family:'Playfair Display',serif; font-size:1.6rem; color:var(--white); text-decoration:none; }
    .brand em { color:var(--gold); font-style:normal; }
    .nav-links { display:flex; gap:20px; align-items:center; }
    .nav-links a { font-size:.7rem; letter-spacing:2px; text-transform:uppercase; color:var(--gold); text-decoration:none; }
    .nav-links a:hover { text-decoration:underline; }

    .page-wrap { max-width:1000px; margin:60px auto; padding:0 20px 80px; }
    .page-header { display:flex; align-items:flex-end; justify-content:space-between; flex-wrap:wrap; gap:16px; margin-bottom:30px; }
    .eyebrow { font-size:.7rem; letter-spacing:6px; text-transform:uppercase; color:var(--gold); margin-bottom:8px; }
    h1 { font-family:'Playfair Display',serif; font-size:2.2rem; color:var(--white); font-style:italic; }
    .gold-line { width:50px; height:2px; background:var(--gold); margin-top:14px; }
    .btn-add { background:var(--gold); color:var(--bg); border:none; padding:11px 22px; font-family:'Playfair Display',serif; font-size:.85rem; font-weight:700; letter-spacing:2px; text-transform:uppercase; text-decoration:none; cursor:pointer; transition:background .2s; display:inline-block; }
    .btn-add:hover { background:var(--gold-d); }

    .alert-success { background:#15301c; border:1px solid #2e7d32; color:#81c784; padding:12px 16px; margin-bottom:20px; font-size:.9rem; }
    .alert-error { background:#3a1515; border:1px solid #a83232; color:#ffb4b4; padding:12px 16px; margin-bottom:20px; font-size:.9rem; }

    /* TABLE */
    .table-wrap { overflow-x:auto; }
    table { width:100%; border-collapse:collapse; }
    thead tr { border-bottom:2px solid var(--gold); }
    thead th { font-size:.65rem; letter-spacing:3px; text-transform:uppercase; color:var(--gold); padding:14px 16px; text-align:left; white-space:nowrap; }
    tbody tr { border-bottom:1px solid var(--border); transition:background .15s; }
    tbody tr:hover { background:rgba(201,168,76,.05); }
    tbody td { padding:14px 16px; font-size:.95rem; color:var(--text); }
    .id-cell { color:var(--muted); font-size:.8rem; }
    .empty-state { text-align:center; padding:60px 20px; color:var(--muted); }
    .empty-state p { margin-top:10px; font-size:1rem; }

    .badge { display:inline-block; font-size:.65rem; letter-spacing:1px; text-transform:uppercase; padding:3px 10px; background:rgba(201,168,76,.15); border:1px solid rgba(201,168,76,.3); color:var(--gold); }

    footer { border-top:1px solid var(--border); text-align:center; padding:24px; font-size:.75rem; color:var(--muted); letter-spacing:1px; }
  </style>
</head>
<body>

<nav>
  <a class="brand" href="index.jsp"><em>UN</em>SHOT</a>
  <div class="nav-links">
    <a href="index.jsp">← Panel</a>
    <a href="insertar_cliente.jsp">+ Nuevo cliente</a>
    <a href="ListarBebidas">Ver bebidas</a>
  </div>
</nav>

<div class="page-wrap">

  <div class="page-header">
    <div>
      <div class="eyebrow">— Tabla: clientes —</div>
      <h1>Listado de Clientes</h1>
      <div class="gold-line"></div>
    </div>
    <a href="insertar_cliente.jsp" class="btn-add">+ Agregar Cliente</a>
  </div>

  <%
    if ("ok".equals(request.getParameter("msg"))) {
  %>
    <div class="alert-success">Cliente guardado correctamente en Supabase.</div>
  <%
    }
    if (request.getAttribute("error") != null) {
  %>
    <div class="alert-error"><%= request.getAttribute("error") %></div>
  <%
    }

    List<Cliente> clientes = (List<Cliente>) request.getAttribute("clientes");
    if (clientes == null || clientes.isEmpty()) {
  %>
    <div class="empty-state">
      <div style="font-size:3rem">👤</div>
      <p>No hay clientes registrados aun.</p>
    </div>
  <%
    } else {
  %>
  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>#</th>
          <th>Nombre</th>
          <th>Apellido</th>
          <th>Telefono</th>
          <th>Email</th>
          <th>Registro</th>
        </tr>
      </thead>
      <tbody>
        <% for (Cliente c : clientes) { %>
        <tr>
          <td class="id-cell"><%= c.getIdCliente() %></td>
          <td><strong style="color:#fff"><%= c.getNombre() %></strong></td>
          <td><%= c.getApellido() %></td>
          <td><%= c.getTelefono() != null ? c.getTelefono() : "—" %></td>
          <td><%= c.getEmail() != null ? c.getEmail() : "—" %></td>
          <td><span class="badge"><%= c.getFechaRegistro() %></span></td>
        </tr>
        <% } %>
      </tbody>
    </table>
  </div>
  <%
    }
  %>

</div>

<footer>UNSHOT Bar &copy; 2026 &mdash; Supabase (PostgreSQL) &mdash; Total: <%= clientes != null ? clientes.size() : 0 %> clientes</footer>

</body>
</html>
