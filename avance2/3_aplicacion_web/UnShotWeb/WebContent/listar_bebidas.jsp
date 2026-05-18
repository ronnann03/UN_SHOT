<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.unshot.model.Bebida" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <title>UNSHOT — Bebidas</title>
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
    .desc-cell { max-width:300px; font-size:.85rem; color:var(--muted); }
    .price-cell { color:var(--gold); font-family:'Playfair Display',serif; font-size:1.1rem; white-space:nowrap; }
    .empty-state { text-align:center; padding:60px 20px; color:var(--muted); }
    .empty-state p { margin-top:10px; font-size:1rem; }

    /* categoria badges */
    .cat { display:inline-block; font-size:.62rem; letter-spacing:1px; text-transform:uppercase; padding:3px 10px; border:1px solid; }
    .cat-clasico   { color:#c8a04a; border-color:#c8a04a; background:rgba(200,160,74,.1); }
    .cat-signature { color:#82c8a0; border-color:#82c8a0; background:rgba(130,200,160,.1); }
    .cat-premium   { color:#a082c8; border-color:#a082c8; background:rgba(160,130,200,.1); }
    .cat-sinalcohol{ color:#82b4c8; border-color:#82b4c8; background:rgba(130,180,200,.1); }

    footer { border-top:1px solid var(--border); text-align:center; padding:24px; font-size:.75rem; color:var(--muted); letter-spacing:1px; }
  </style>
</head>
<body>

<nav>
  <a class="brand" href="index.jsp"><em>UN</em>SHOT</a>
  <div class="nav-links">
    <a href="index.jsp">← Panel</a>
    <a href="insertar_bebida.jsp">+ Nueva bebida</a>
    <a href="ListarClientes">Ver clientes</a>
  </div>
</nav>

<div class="page-wrap">

  <div class="page-header">
    <div>
      <div class="eyebrow">— Tabla: bebidas —</div>
      <h1>Carta de Bebidas</h1>
      <div class="gold-line"></div>
    </div>
    <a href="insertar_bebida.jsp" class="btn-add">+ Agregar Bebida</a>
  </div>

  <%
    if ("ok".equals(request.getParameter("msg"))) {
  %>
    <div class="alert-success">Bebida guardada correctamente en Supabase.</div>
  <%
    }
    if (request.getAttribute("error") != null) {
  %>
    <div class="alert-error"><%= request.getAttribute("error") %></div>
  <%
    }

    List<Bebida> bebidas = (List<Bebida>) request.getAttribute("bebidas");
    if (bebidas == null || bebidas.isEmpty()) {
  %>
    <div class="empty-state">
      <div style="font-size:3rem">🍹</div>
      <p>No hay bebidas registradas aun.</p>
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
          <th>Categoria</th>
          <th>Descripcion</th>
          <th>Precio</th>
        </tr>
      </thead>
      <tbody>
        <% for (Bebida b : bebidas) {
            String catClass = "cat-clasico";
            if ("Signature".equals(b.getCategoria()))   catClass = "cat-signature";
            else if ("Premium".equals(b.getCategoria())) catClass = "cat-premium";
            else if ("Sin Alcohol".equals(b.getCategoria())) catClass = "cat-sinalcohol";
        %>
        <tr>
          <td class="id-cell"><%= b.getIdBebida() %></td>
          <td><strong style="color:#fff"><%= b.getNombre() %></strong></td>
          <td><span class="cat <%= catClass %>"><%= b.getCategoria() %></span></td>
          <td class="desc-cell"><%= b.getDescripcion() != null ? b.getDescripcion() : "—" %></td>
          <td class="price-cell">S/ <%= String.format("%.2f", b.getPrecio()) %></td>
        </tr>
        <% } %>
      </tbody>
    </table>
  </div>
  <%
    }
  %>

</div>

<footer>UNSHOT Bar &copy; 2026 &mdash; Supabase (PostgreSQL) &mdash; Total: <%= bebidas != null ? bebidas.size() : 0 %> bebidas</footer>

</body>
</html>
