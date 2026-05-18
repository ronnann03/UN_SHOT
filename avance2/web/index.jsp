<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <title>UNSHOT — Panel Administracion</title>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,700;1,400&family=Cormorant+Garamond:wght@300;400;500&display=swap" rel="stylesheet"/>
  <style>
    *, *::before, *::after { box-sizing: border-box; margin:0; padding:0; }
    :root {
      --gold:    #c9a84c;
      --gold-d:  #a8883c;
      --bg:      #0c0c0c;
      --surface: #141414;
      --card:    #1c1c1c;
      --border:  #2a2a2a;
      --white:   #ffffff;
      --text:    #c8c8c8;
      --muted:   #666;
    }
    body { background:var(--bg); color:var(--text); font-family:'Cormorant Garamond',serif; min-height:100vh; }

    /* NAV */
    nav { background:rgba(12,12,12,.97); border-bottom:1px solid var(--border); padding:18px 40px; display:flex; align-items:center; justify-content:space-between; }
    .brand { font-family:'Playfair Display',serif; font-size:1.6rem; color:var(--white); text-decoration:none; }
    .brand em { color:var(--gold); font-style:normal; }
    .nav-tag { font-size:.65rem; letter-spacing:3px; text-transform:uppercase; color:var(--muted); }

    /* HERO */
    .hero { text-align:center; padding:80px 20px 60px; }
    .eyebrow { font-size:.7rem; letter-spacing:6px; text-transform:uppercase; color:var(--gold); margin-bottom:16px; }
    h1 { font-family:'Playfair Display',serif; font-size:3rem; color:var(--white); font-style:italic; }
    h1 span { color:var(--gold); font-style:normal; }
    .hero p { margin-top:14px; color:var(--muted); font-size:1rem; letter-spacing:1px; }
    .gold-line { width:60px; height:2px; background:var(--gold); margin:20px auto; }

    /* CARDS GRID */
    .grid { display:grid; grid-template-columns:repeat(auto-fit,minmax(240px,1fr)); gap:20px; max-width:900px; margin:0 auto; padding:0 30px 80px; }
    .card { background:var(--card); border:1px solid var(--border); padding:32px 28px; text-decoration:none; color:inherit; transition:border-color .25s, transform .2s; display:block; }
    .card:hover { border-color:var(--gold); transform:translateY(-4px); }
    .card-icon { font-size:2.2rem; margin-bottom:16px; }
    .card-title { font-family:'Playfair Display',serif; font-size:1.25rem; color:var(--white); margin-bottom:8px; }
    .card-desc { font-size:.9rem; color:var(--muted); line-height:1.6; }
    .card-action { margin-top:20px; font-size:.7rem; letter-spacing:3px; text-transform:uppercase; color:var(--gold); }

    footer { border-top:1px solid var(--border); text-align:center; padding:24px; font-size:.75rem; color:var(--muted); letter-spacing:1px; }
  </style>
</head>
<body>

<nav>
  <a class="brand" href="index.jsp"><em>UN</em>SHOT</a>
  <span class="nav-tag">Panel de Administracion</span>
</nav>

<div class="hero">
  <div class="eyebrow">— Sistema de Gestion —</div>
  <h1><em>UN</em><span>SHOT</span> Bar</h1>
  <div class="gold-line"></div>
  <p>Gestiona clientes y bebidas del bar desde este panel.</p>
</div>

<div class="grid">

  <a class="card" href="insertar_cliente.jsp">
    <div class="card-icon">👤</div>
    <div class="card-title">Nuevo Cliente</div>
    <div class="card-desc">Registra un nuevo cliente en la base de datos de Supabase.</div>
    <div class="card-action">Insertar →</div>
  </a>

  <a class="card" href="listar_clientes.jsp">
    <div class="card-icon">📋</div>
    <div class="card-title">Ver Clientes</div>
    <div class="card-desc">Lista todos los clientes registrados en el sistema.</div>
    <div class="card-action">Ver listado →</div>
  </a>

  <a class="card" href="insertar_reserva.jsp">
    <div class="card-icon">📅</div>
    <div class="card-title">Nueva Reserva</div>
    <div class="card-desc">Registra una nueva reserva de mesa.</div>
    <div class="card-action">Insertar →</div>
  </a>

  <a class="card" href="listar_reservas.jsp">
    <div class="card-icon">📋</div>
    <div class="card-title">Ver Reservas</div>
    <div class="card-desc">Lista todas las reservas de mesa registradas.</div>
    <div class="card-action">Ver listado →</div>
  </a>

</div>

<footer>UNSHOT Bar &copy; 2026 &mdash; Avance 2 &mdash; Base de datos: Supabase (PostgreSQL)</footer>

</body>
</html>
